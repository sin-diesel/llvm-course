#include <fstream>
#include <iostream>
#include <memory>
#include <sstream>
#include <string_view>

#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>

#include <llvm/ExecutionEngine/ExecutionEngine.h>
#include <llvm/ExecutionEngine/GenericValue.h>
#include <llvm/ExecutionEngine/Interpreter.h>

#include <llvm/Support/TargetSelect.h>

#include "game-of-life/graphics.h"
#include "game-of-life/logic.h"

constexpr size_t HxW = H * W;

struct gen_objs {
  llvm::LLVMContext *context;
  llvm::IRBuilder<> *builder;
  llvm::Module *llvmModule;
};

auto getGlobalVariable(llvm::Module *llvmModule, std::string_view name) {
  auto *gv = llvmModule->getGlobalVariable(name);
  if (gv != nullptr)
    return gv;

  std::stringstream ss{};
  ss << "Cannot find global variable: " << name;
  throw std::runtime_error{ss.str()};
}

auto getFunction(llvm::Module *llvmModule, std::string_view name) {
  auto *fn = llvmModule->getFunction(name);
  if (fn != nullptr)
    return fn;

  std::stringstream ss{};
  ss << "Cannot find function: " << name;
  throw std::runtime_error{ss.str()};
}

auto genInit(gen_objs &gen_objs) {
  auto &builder = *gen_objs.builder;

  auto *funcType = llvm::FunctionType::get(
      builder.getVoidTy(), {builder.getInt64Ty(), builder.getInt64Ty()}, false);
  auto *func = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage,
                                      "init", gen_objs.llvmModule);
  return func;
}

auto genGetZeroOrOne(gen_objs &gen_objs) {
  auto *funcType = llvm::FunctionType::get(gen_objs.builder->getInt8Ty(), false);
  auto *func = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage,
                                      "getZeroOrOne", gen_objs.llvmModule);
  return func;
}

auto genFinished(gen_objs &gen_objs) {
  auto *funcType = llvm::FunctionType::get(gen_objs.builder->getInt8Ty(), false);
  auto *func = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage,
                                      "finished", gen_objs.llvmModule);
  return func;
}

auto genFlush(gen_objs &gen_objs) {
  auto *funcType = llvm::FunctionType::get(gen_objs.builder->getVoidTy(), false);
  auto *func = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage,
                                      "flush", gen_objs.llvmModule);
  return func;
}

auto genPutPixel(gen_objs &gen_objs) {
  auto &builder = *gen_objs.builder;
  auto *funcType = llvm::FunctionType::get(
      builder.getVoidTy(),
      {builder.getInt64Ty(), builder.getInt64Ty(), builder.getInt8Ty()}, false);
  auto *func = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage,
                                      "putPixel", gen_objs.llvmModule);
  return func;
}

auto genSwap(gen_objs &gen_objs) {
  auto &context = *gen_objs.context;
  auto &builder = *gen_objs.builder;
  auto *llvmModule = gen_objs.llvmModule;

  auto *funcType = llvm::FunctionType::get(builder.getVoidTy(), false);
  auto *func = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage,
                                      "swap", llvmModule);

  auto *bb0 = llvm::BasicBlock::Create(context, "", func);
  builder.SetInsertPoint(bb0);

  // %1 = alloca i8*, align 8
  auto *a1 = builder.CreateAlloca(builder.getInt8PtrTy());
  // %2 = load i8*, i8** @SURF_NEXT, align 8
  auto *a2 = builder.CreateLoad(builder.getInt8PtrTy(),
                                getGlobalVariable(llvmModule, "SURF_NEXT"));
  // store i8* %2, i8** %1, align 8
  builder.CreateStore(a2, a1);
  // %3 = load i8*, i8** @SURF_CUR, align 8
  auto *a3 = builder.CreateLoad(builder.getInt8PtrTy(),
                                getGlobalVariable(llvmModule, "SURF_CUR"));
  // store i8* %3, i8** @SURF_NEXT, align 8
  builder.CreateStore(a3, getGlobalVariable(llvmModule, "SURF_NEXT"));
  // %4 = load i8*, i8** %1, align 8
  auto *a4 = builder.CreateLoad(builder.getInt8PtrTy(), a1);
  // store i8* %4, i8** @SURF_CUR, align 8
  builder.CreateStore(a4, getGlobalVariable(llvmModule, "SURF_CUR"));
  // ret void
  builder.CreateRetVoid();

  return func;
}

auto genDraw(gen_objs &gen_objs) {
  auto &context = *gen_objs.context;
  auto &builder = *gen_objs.builder;
  auto *llvmModule = gen_objs.llvmModule;

  auto *funcType = llvm::FunctionType::get(builder.getVoidTy(), false);
  auto *func = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage,
                                      "draw", llvmModule);

  auto *bb0 = llvm::BasicBlock::Create(context, "", func);
  auto *bb3 = llvm::BasicBlock::Create(context, "", func);
  auto *bb6 = llvm::BasicBlock::Create(context, "", func);
  auto *bb7 = llvm::BasicBlock::Create(context, "", func);
  auto *bb10 = llvm::BasicBlock::Create(context, "", func);
  auto *bb19 = llvm::BasicBlock::Create(context, "", func);
  auto *bb22 = llvm::BasicBlock::Create(context, "", func);
  auto *bb23 = llvm::BasicBlock::Create(context, "", func);
  auto *bb26 = llvm::BasicBlock::Create(context, "", func);

  builder.SetInsertPoint(bb0);

  // %1 = alloca i64, align 8
  auto *a1 = builder.CreateAlloca(builder.getInt64Ty());
  // %2 = alloca i64, align 8
  auto *a2 = builder.CreateAlloca(builder.getInt64Ty());
  // store i64 0, i64* %1, align 8
  builder.CreateStore(builder.getInt64(0), a1);
  // br label %3
  builder.CreateBr(bb3);

  // 3:                                                ; preds = %23, %0
  builder.SetInsertPoint(bb3);
  // %4 = load i64, i64* %1, align 8
  auto *a4 = builder.CreateLoad(builder.getInt64Ty(), a1);
  // %5 = icmp ult i64 %4, 360
  auto *a5 = builder.CreateICmpULT(a4, builder.getInt64(H));
  // br i1 %5, label %6, label %26
  builder.CreateCondBr(a5, bb6, bb26);

  // 6:                                                ; preds = %3
  builder.SetInsertPoint(bb6);
  // store i64 0, i64* %2, align 8
  builder.CreateStore(builder.getInt64(0), a2);
  // br label %7
  builder.CreateBr(bb7);

  // 7:                                                ; preds = %19, %6
  builder.SetInsertPoint(bb7);
  // %8 = load i64, i64* %2, align 8
  auto *a8 = builder.CreateLoad(builder.getInt64Ty(), a2);
  // %9 = icmp ult i64 %8, 640
  auto *a9 = builder.CreateICmpULT(a8, builder.getInt64(W));
  // br i1 %9, label %10, label %22
  builder.CreateCondBr(a9, bb10, bb22);

  // 10:                                               ; preds = %7
  builder.SetInsertPoint(bb10);
  // %11 = load i64, i64* %1, align 8
  auto *a11 = builder.CreateLoad(builder.getInt64Ty(), a1);
  // %12 = load i64, i64* %2, align 8
  auto *a12 = builder.CreateLoad(builder.getInt64Ty(), a2);
  // %13 = load i8*, i8** @SURF_CUR, align 8
  auto *a13 = builder.CreateLoad(builder.getInt8PtrTy(),
                                 getGlobalVariable(llvmModule, "SURF_CUR"));
  // %14 = load i64, i64* %2, align 8
  auto *a14 = builder.CreateLoad(builder.getInt64Ty(), a2);
  // %15 = load i64, i64* %1, align 8
  auto *a15 = builder.CreateLoad(builder.getInt64Ty(), a1);
  // %16 = call i64 @idx(i64 noundef %14, i64 noundef %15)
  auto *a16 = builder.CreateCall(getFunction(llvmModule, "idx"), {a14, a15});
  // %17 = getelementptr inbounds i8, i8* %13, i64 %16
  auto *a17 = builder.CreateGEP(builder.getInt8Ty(), a13, a16);
  // %18 = load i8, i8* %17, align 1
  auto *a18 = builder.CreateLoad(builder.getInt8Ty(), a17);
  // call void @putPixel(i64 noundef %11, i64 noundef %12, i8 noundef zeroext
  // %18)
  builder.CreateCall(getFunction(llvmModule, "putPixel"), {a11, a12, a18});
  // br label %19
  builder.CreateBr(bb19);

  // 19:                                               ; preds = %10
  builder.SetInsertPoint(bb19);
  // %20 = load i64, i64* %2, align 8
  auto *a20 = builder.CreateLoad(builder.getInt64Ty(), a2);
  // %21 = add i64 %20, 1
  auto *a21 = builder.CreateAdd(a20, builder.getInt64(1));
  // store i64 %21, i64* %2, align 8
  builder.CreateStore(a21, a2);
  // br label %7, !llvm.loop !11
  builder.CreateBr(bb7);

  // 22:                                               ; preds = %7
  builder.SetInsertPoint(bb22);
  // br label %23
  builder.CreateBr(bb23);

  // 23:                                               ; preds = %22
  builder.SetInsertPoint(bb23);
  // %24 = load i64, i64* %1, align 8
  auto *a24 = builder.CreateLoad(builder.getInt64Ty(), a1);
  // %25 = add i64 %24, 1
  auto *a25 = builder.CreateAdd(a24, builder.getInt64(1));
  // store i64 %25, i64* %1, align 8
  builder.CreateStore(a25, a1);
  // br label %3, !llvm.loop !12
  builder.CreateBr(bb3);

  // 26:                                               ; preds = %3
  builder.SetInsertPoint(bb26);
  // call void @flush()
  builder.CreateCall(getFunction(llvmModule, "flush"));
  // ret void
  builder.CreateRetVoid();

  return func;
}

auto genFillRand(gen_objs &gen_objs) {
  auto &context = *gen_objs.context;
  auto &builder = *gen_objs.builder;
  auto *llvmModule = gen_objs.llvmModule;

  auto *funcType = llvm::FunctionType::get(builder.getVoidTy(), false);
  auto *func = llvm::Function::Create(funcType, llvm::Function::InternalLinkage,
                                      "fillRand", llvmModule);

  auto *bb0 = llvm::BasicBlock::Create(context, "", func);
  auto *bb1 = llvm::BasicBlock::Create(context, "", func);
  auto *bb2 = llvm::BasicBlock::Create(context, "", func);

  builder.SetInsertPoint(bb0);
  //   br label %2
  builder.CreateBr(bb2);

  // 1:                                                ; preds = %2
  builder.SetInsertPoint(bb1);
  // ret void
  builder.CreateRetVoid();

  // 2:                                                ; preds = %0, %2
  builder.SetInsertPoint(bb2);
  // %3 = phi i64 [ 0, %0 ], [ %7, %2 ]
  auto *a3 = builder.CreatePHI(builder.getInt64Ty(), 2);
  // %4 = tail call zeroext i8 @getZeroOrOne() #7
  auto *a4 = builder.CreateCall(getFunction(llvmModule, "getZeroOrOne"));
  // %5 = load i8*, i8** @SURF_CUR, align 8, !tbaa !5
  auto *a5 = builder.CreateLoad(builder.getInt8PtrTy(),
                                getGlobalVariable(llvmModule, "SURF_CUR"));
  // %6 = getelementptr inbounds i8, i8* %5, i64 %3
  auto *a6 = builder.CreateGEP(builder.getInt8Ty(), a5, a3);
  // store i8 %4, i8* %6, align 1, !tbaa !9
  builder.CreateStore(a4, a6);
  // %7 = add nuw nsw i64 %3, 1
  auto *a7 = builder.CreateAdd(a3, builder.getInt64(1), "", true, true);
  // %8 = icmp eq i64 %7, 230400
  auto *a8 = builder.CreateICmpEQ(a7, builder.getInt64(HxW));
  // br i1 %8, label %1, label %2, !llvm.loop !13
  builder.CreateCondBr(a8, bb1, bb2);

  a3->addIncoming(builder.getInt64(0), bb0);
  a3->addIncoming(a7, bb2);

  return func;
}

auto genCountNeighboursCommon(gen_objs &gen_objs) {
  auto &context = *gen_objs.context;
  auto &builder = *gen_objs.builder;
  auto *llvmModule = gen_objs.llvmModule;

  auto *funcType = llvm::FunctionType::get(
      builder.getInt64Ty(), {builder.getInt64Ty(), builder.getInt64Ty()},
      false);
  auto *func = llvm::Function::Create(funcType, llvm::Function::InternalLinkage,
                                      "countNeighboursCommon", llvmModule);

  auto *entryBB = llvm::BasicBlock::Create(context, "", func);
  builder.SetInsertPoint(entryBB);

  auto *a0 = func->getArg(0);
  auto *a1 = func->getArg(1);
  auto *a3 = builder.CreateLoad(builder.getInt8PtrTy(),
                                getGlobalVariable(llvmModule, "SURF_CUR"));
  auto *a4 = builder.CreateAdd(a0, builder.getInt64(-1));
  auto *a5 = builder.CreateMul(a1, builder.getInt64(640));
  auto *a6 = builder.CreateAdd(a5, builder.getInt64(-640));
  auto *a7 = builder.CreateAdd(a6, a4);
  auto *a8 = builder.CreateGEP(builder.getInt8Ty(), a3, a7);
  auto *a9 = builder.CreateLoad(builder.getInt8Ty(), a8);
  auto *a10 = builder.CreateICmpNE(a9, builder.getInt8(0));
  auto *a11 = builder.CreateZExt(a10, builder.getInt64Ty());
  auto *a12 = builder.CreateAdd(a5, a4);
  auto *a13 = builder.CreateGEP(builder.getInt8Ty(), a3, a12);
  auto *a14 = builder.CreateLoad(builder.getInt8Ty(), a13);
  auto *a15 = builder.CreateICmpNE(a14, builder.getInt8(0));
  auto *a16 = builder.CreateZExt(a15, builder.getInt64Ty());
  auto *a17 = builder.CreateAdd(a16, a11, "", true, true);
  auto *a18 = builder.CreateAdd(a5, builder.getInt64(640));
  auto *a19 = builder.CreateAdd(a18, a4);
  auto *a20 = builder.CreateGEP(builder.getInt8Ty(), a3, a19);
  auto *a21 = builder.CreateLoad(builder.getInt8Ty(), a20);
  auto *a22 = builder.CreateICmpNE(a21, builder.getInt8(0));
  auto *a23 = builder.CreateZExt(a22, builder.getInt64Ty());
  auto *a24 = builder.CreateAdd(a17, a23, "", true, true);
  auto *a25 = builder.CreateAdd(a6, a0);
  auto *a26 = builder.CreateGEP(builder.getInt8Ty(), a3, a25);
  auto *a27 = builder.CreateLoad(builder.getInt8Ty(), a26);
  auto *a28 = builder.CreateICmpNE(a27, builder.getInt8(0));
  auto *a29 = builder.CreateZExt(a28, builder.getInt64Ty());
  auto *a30 = builder.CreateAdd(a24, a29, "", true, true);
  auto *a31 = builder.CreateAdd(a18, a0);
  auto *a32 = builder.CreateGEP(builder.getInt8Ty(), a3, a31);
  auto *a33 = builder.CreateLoad(builder.getInt8Ty(), a32);
  auto *a34 = builder.CreateICmpNE(a33, builder.getInt8(0));
  auto *a35 = builder.CreateZExt(a34, builder.getInt64Ty());
  auto *a36 = builder.CreateAdd(a30, a35, "", true, true);
  auto *a37 = builder.CreateAdd(a0, builder.getInt64(1));
  auto *a38 = builder.CreateAdd(a6, a37);
  auto *a39 = builder.CreateGEP(builder.getInt8Ty(), a3, a38);
  auto *a40 = builder.CreateLoad(builder.getInt8Ty(), a39);
  auto *a41 = builder.CreateICmpNE(a40, builder.getInt8(0));
  auto *a42 = builder.CreateZExt(a41, builder.getInt64Ty());
  auto *a43 = builder.CreateAdd(a36, a42, "", true, true);
  auto *a44 = builder.CreateAdd(a5, a37);
  auto *a45 = builder.CreateGEP(builder.getInt8Ty(), a3, a44);
  auto *a46 = builder.CreateLoad(builder.getInt8Ty(), a45);
  auto *a47 = builder.CreateICmpNE(a46, builder.getInt8(0));
  auto *a48 = builder.CreateZExt(a47, builder.getInt64Ty());
  auto *a49 = builder.CreateAdd(a43, a48, "", true, true);
  auto *a50 = builder.CreateAdd(a18, a37);
  auto *a51 = builder.CreateGEP(builder.getInt8Ty(), a3, a50);
  auto *a52 = builder.CreateLoad(builder.getInt8Ty(), a51);
  auto *a53 = builder.CreateICmpNE(a52, builder.getInt8(0));
  auto *a54 = builder.CreateZExt(a53, builder.getInt64Ty());
  auto *a55 = builder.CreateAdd(a49, a54, "", true, true);

  builder.CreateRet(a55);
  return func;
}

auto genCountNeighbours(gen_objs &gen_objs) {
  auto &context = *gen_objs.context;
  auto &builder = *gen_objs.builder;
  auto *llvmModule = gen_objs.llvmModule;

  auto *funcType = llvm::FunctionType::get(
      builder.getInt64Ty(), {builder.getInt64Ty(), builder.getInt64Ty()},
      false);
  auto *func = llvm::Function::Create(funcType, llvm::Function::InternalLinkage,
                                      "countNeighbours", llvmModule);

  auto *bb2 = llvm::BasicBlock::Create(context, "", func);
  auto *bb8 = llvm::BasicBlock::Create(context, "", func);
  auto *bb11 = llvm::BasicBlock::Create(context, "", func);
  auto *bb14 = llvm::BasicBlock::Create(context, "", func);
  auto *bb17 = llvm::BasicBlock::Create(context, "", func);
  auto *bb21 = llvm::BasicBlock::Create(context, "", func);
  auto *bb22 = llvm::BasicBlock::Create(context, "", func);

  builder.SetInsertPoint(bb2);

  auto *a0 = func->getArg(0);
  auto *a1 = func->getArg(1);

  // %3 = alloca i64, align 8
  auto *a3 = builder.CreateAlloca(builder.getInt64Ty());
  // %4 = alloca i64, align 8
  auto *a4 = builder.CreateAlloca(builder.getInt64Ty());
  // %5 = alloca i64, align 8
  auto *a5 = builder.CreateAlloca(builder.getInt64Ty());
  // store i64 %0, i64* %4, align 8
  builder.CreateStore(a0, a4);
  // store i64 %1, i64* %5, align 8
  builder.CreateStore(a1, a5);
  // %6 = load i64, i64* %4, align 8
  auto *a6 = builder.CreateLoad(builder.getInt64Ty(), a4);
  // %7 = icmp ugt i64 %6, 0
  auto *a7 = builder.CreateICmpUGT(a6, builder.getInt64(0));
  // br i1 %7, label %8, label %21
  builder.CreateCondBr(a7, bb8, bb21);

  // 8:                                                ; preds = %2
  builder.SetInsertPoint(bb8);
  // %9 = load i64, i64* %5, align 8
  auto *a9 = builder.CreateLoad(builder.getInt64Ty(), a5);
  // %10 = icmp ugt i64 %9, 0
  auto *a10 = builder.CreateICmpUGT(a9, builder.getInt64(0));
  // br i1 %10, label %11, label %21
  builder.CreateCondBr(a10, bb11, bb21);

  // 11:                                               ; preds = %8
  builder.SetInsertPoint(bb11);
  // %12 = load i64, i64* %4, align 8
  auto *a12 = builder.CreateLoad(builder.getInt64Ty(), a4);
  // %13 = icmp ult i64 %12, 639
  auto *a13 = builder.CreateICmpULT(a12, builder.getInt64(W - 1));
  // br i1 %13, label %14, label %21
  builder.CreateCondBr(a13, bb14, bb21);

  // 14:                                               ; preds = %11
  builder.SetInsertPoint(bb14);
  // %15 = load i64, i64* %5, align 8
  auto *a15 = builder.CreateLoad(builder.getInt64Ty(), a5);
  // %16 = icmp ult i64 %15, 359
  auto *a16 = builder.CreateICmpULT(a15, builder.getInt64(359));
  // br i1 %16, label %17, label %21
  builder.CreateCondBr(a16, bb17, bb21);

  // 17:                                               ; preds = %14
  builder.SetInsertPoint(bb17);
  // %18 = load i64, i64* %4, align 8
  auto *a18 = builder.CreateLoad(builder.getInt64Ty(), a4);
  // %19 = load i64, i64* %5, align 8
  auto *a19 = builder.CreateLoad(builder.getInt64Ty(), a5);
  // %20 = call i64 @countNeighboursCommon(i64 noundef %18, i64 noundef %19)
  auto *a20 = builder.CreateCall(
      getFunction(llvmModule, "countNeighboursCommon"), {a18, a19});
  // store i64 %20, i64* %3, align 8
  builder.CreateStore(a20, a3);
  // br label %22
  builder.CreateBr(bb22);

  // 21:                                               ; preds = %14, %11, %8,
  // %2
  builder.SetInsertPoint(bb21);
  // store i64 0, i64* %3, align 8
  builder.CreateStore(builder.getInt64(0), a3);
  // br label %22
  builder.CreateBr(bb22);

  // 22:                                               ; preds = %21, %17
  builder.SetInsertPoint(bb22);
  // %23 = load i64, i64* %3, align 8
  auto *a23 = builder.CreateLoad(builder.getInt64Ty(), a3);
  // ret i64 %23
  builder.CreateRet(a23);

  return func;
}

auto genCalcSurf(gen_objs &gen_objs) {
  auto &context = *gen_objs.context;
  auto &builder = *gen_objs.builder;
  auto *llvmModule = gen_objs.llvmModule;

  auto *funcType = llvm::FunctionType::get(builder.getVoidTy(), false);
  auto *func = llvm::Function::Create(funcType, llvm::Function::InternalLinkage,
                                      "calcSurf", llvmModule);

  auto *bb0 = llvm::BasicBlock::Create(context, "", func);
  auto *bb1 = llvm::BasicBlock::Create(context, "", func);
  auto *bb4 = llvm::BasicBlock::Create(context, "", func);
  auto *bb5 = llvm::BasicBlock::Create(context, "", func);
  auto *bb8 = llvm::BasicBlock::Create(context, "", func);

  builder.SetInsertPoint(bb0);

  // br label %1
  builder.CreateBr(bb1);

  // 1:                                                ; preds = %0, %5
  builder.SetInsertPoint(bb1);
  // %2 = phi i64 [ 0, %0 ], [ %6, %5 ]
  auto *a2 = builder.CreatePHI(builder.getInt64Ty(), 2);
  // %3 = mul nuw nsw i64 %2, 640
  auto *a3 = builder.CreateMul(a2, builder.getInt64(W), "", true, true);
  // br label %8
  builder.CreateBr(bb8);

  // 4:                                                ; preds = %5
  builder.SetInsertPoint(bb4);
  // ret void
  builder.CreateRetVoid();

  // 5:                                                ; preds = %8
  builder.SetInsertPoint(bb5);
  // %6 = add nuw nsw i64 %2, 1
  auto *a6 = builder.CreateAdd(a2, builder.getInt64(1), "", true, true);
  // %7 = icmp eq i64 %6, 360
  auto *a7 = builder.CreateICmpEQ(a6, builder.getInt64(H));
  // br i1 %7, label %4, label %1, !llvm.loop !10
  builder.CreateCondBr(a7, bb4, bb1);

  // 8:                                                ; preds = %1, %8
  builder.SetInsertPoint(bb8);
  // %9 = phi i64 [ 0, %1 ], [ %14, %8 ]
  auto *a9 = builder.CreatePHI(builder.getInt64Ty(), 2);
  // %10 = tail call zeroext i8 @calcState(i64 noundef %9, i64 noundef %2)
  auto *a10 =
      builder.CreateCall(getFunction(llvmModule, "calcState"), {a9, a2});
  // %11 = load i8*, i8** @SURF_NEXT, align 8, !tbaa !5
  auto *a11 = builder.CreateLoad(builder.getInt8PtrTy(),
                                 getGlobalVariable(llvmModule, "SURF_NEXT"));
  // %12 = add nuw nsw i64 %9, %3
  auto *a12 = builder.CreateAdd(a9, a3, "", true, true);
  // %13 = getelementptr inbounds i8, i8* %11, i64 %12
  auto *a13 = builder.CreateGEP(builder.getInt8Ty(), a11, a12);
  // store i8 %10, i8* %13, align 1, !tbaa !9
  builder.CreateStore(a10, a13);
  // %14 = add nuw nsw i64 %9, 1
  auto *a14 = builder.CreateAdd(a9, builder.getInt64(1), "", true, true);
  // %15 = icmp eq i64 %14, 640
  auto *a15 = builder.CreateICmpEQ(a14, builder.getInt64(W));
  // br i1 %15, label %5, label %8, !llvm.loop !12
  builder.CreateCondBr(a15, bb5, bb8);

  a2->addIncoming(builder.getInt64(0), bb0);
  a2->addIncoming(a6, bb5);

  a9->addIncoming(builder.getInt64(0), bb1);
  a9->addIncoming(a14, bb8);

  return func;
}

#if 0
auto genMain1(gen_objs &gen_objs) {
  auto &context = *gen_objs.context;
  auto &builder = *gen_objs.builder;
  auto *llvmModule = gen_objs.llvmModule;

  auto *funcType = llvm::FunctionType::get(builder.getInt32Ty(), false);
  auto *mainFunc = llvm::Function::Create(
      funcType, llvm::Function::ExternalLinkage, "main", llvmModule);

  auto *entryBB = llvm::BasicBlock::Create(context, "entry", mainFunc);
  auto *condBB = llvm::BasicBlock::Create(context, "loop.cond", mainFunc);
  auto *bodyBB = llvm::BasicBlock::Create(context, "loop.body", mainFunc);
  auto *returnBB = llvm::BasicBlock::Create(context, "return", mainFunc);

  { /* entry */
    builder.SetInsertPoint(entryBB);

    auto arrayTy = llvm::ArrayType::get(builder.getInt8Ty(), HxW);
    auto *bufCur = builder.CreateAlloca(arrayTy);
    auto *bufNext = builder.CreateAlloca(arrayTy);

    auto *gepCur = builder.CreateConstGEP2_64(arrayTy, bufCur, 0, 0);
    builder.CreateStore(gepCur, getGlobalVariable(llvmModule, "SURF_CUR"));
    builder.CreateCall(getFunction(llvmModule, "fillRand"));

    auto *gepNext = builder.CreateConstGEP2_64(arrayTy, bufNext, 0, 0);
    builder.CreateStore(gepNext, getGlobalVariable(llvmModule, "SURF_NEXT"));
    builder.CreateCall(getFunction(llvmModule, "init"),
                       {builder.getInt64(H), builder.getInt64(W)});
    builder.CreateBr(condBB);
  }

  { /* loop.cond */
    builder.SetInsertPoint(condBB);
    auto *call = builder.CreateCall(getFunction(llvmModule, "finished"));
    auto *icmp = builder.CreateICmpEQ(call, builder.getInt8(0));
    builder.CreateCondBr(icmp, bodyBB, returnBB);
  }

  /* loop.body */
  builder.SetInsertPoint(bodyBB);
  builder.CreateCall(getFunction(llvmModule, "calcSurf"));
  builder.CreateCall(getFunction(llvmModule, "swap"));
  builder.CreateCall(getFunction(llvmModule, "draw"));
  builder.CreateBr(condBB);

  /* return */
  builder.SetInsertPoint(returnBB);
  builder.CreateRet(builder.getInt32(0));

  return mainFunc;
}
#endif

auto genCalcState(gen_objs &gen_objs) {
  auto &context = *gen_objs.context;
  auto &builder = *gen_objs.builder;
  auto *llvmModule = gen_objs.llvmModule;

  auto *funcType = llvm::FunctionType::get(
      builder.getInt8Ty(), {builder.getInt64Ty(), builder.getInt64Ty()}, false);
  auto *func = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage,
                                      "calcState", llvmModule);

  auto *bb2 = llvm::BasicBlock::Create(context, "", func);
  auto *bb24 = llvm::BasicBlock::Create(context, "", func);
  auto *bb27 = llvm::BasicBlock::Create(context, "", func);
  auto *bb29 = llvm::BasicBlock::Create(context, "", func);
  auto *bb35 = llvm::BasicBlock::Create(context, "", func);
  auto *bb38 = llvm::BasicBlock::Create(context, "", func);
  auto *bb41 = llvm::BasicBlock::Create(context, "", func);
  auto *bb43 = llvm::BasicBlock::Create(context, "", func);
  auto *bb45 = llvm::BasicBlock::Create(context, "", func);

  auto *a0 = func->getArg(0);
  auto *a1 = func->getArg(1);

  builder.SetInsertPoint(bb2);

  // %3 = alloca i8, align 1
  auto *a3 = builder.CreateAlloca(builder.getInt8Ty());
  // %4 = alloca i64, align 8
  auto *a4 = builder.CreateAlloca(builder.getInt64Ty());
  // %5 = alloca i64, align 8
  auto *a5 = builder.CreateAlloca(builder.getInt64Ty());
  // %6 = alloca i8, align 1
  auto *a6 = builder.CreateAlloca(builder.getInt8Ty());
  // %7 = alloca i8, align 1
  auto *a7 = builder.CreateAlloca(builder.getInt8Ty());
  // %8 = alloca i64, align 8
  auto *a8 = builder.CreateAlloca(builder.getInt64Ty());
  // %9 = alloca i8, align 1
  auto *a9 = builder.CreateAlloca(builder.getInt8Ty());
  // store i64 %0, i64* %4, align 8
  builder.CreateStore(a0, a4);
  // store i64 %1, i64* %5, align 8
  builder.CreateStore(a1, a5);
  // store i8 0, i8* %6, align 1
  builder.CreateStore(builder.getInt8(0), a6);
  // store i8 1, i8* %7, align 1
  builder.CreateStore(builder.getInt8(1), a7);
  // %10 = load i64, i64* %4, align 8
  auto *a10 = builder.CreateLoad(builder.getInt64Ty(), a4);
  // %11 = load i64, i64* %5, align 8
  auto *a11 = builder.CreateLoad(builder.getInt64Ty(), a5);
  // %12 = call i64 @countNeighbours(i64 noundef %10, i64 noundef %11)
  auto *a12 = builder.CreateCall(getFunction(llvmModule, "countNeighbours"),
                                 {a10, a11});
  // store i64 %12, i64* %8, align 8
  builder.CreateStore(a12, a8);
  // %13 = load i8*, i8** @SURF_CUR, align 8
  auto *a13 = builder.CreateLoad(builder.getInt8PtrTy(),
                                 getGlobalVariable(llvmModule, "SURF_CUR"));
  // %14 = load i64, i64* %4, align 8
  auto *a14 = builder.CreateLoad(builder.getInt64Ty(), a4);
  // %15 = load i64, i64* %5, align 8
  auto *a15 = builder.CreateLoad(builder.getInt64Ty(), a5);
  // %16 = call i64 @idx(i64 noundef %14, i64 noundef %15)
  auto *a16 = builder.CreateCall(getFunction(llvmModule, "idx"), {a14, a15});
  // %17 = getelementptr inbounds i8, i8* %13, i64 %16
  auto *a17 = builder.CreateGEP(builder.getInt8Ty(), a13, a16);
  // %18 = load i8, i8* %17, align 1
  auto *a18 = builder.CreateLoad(builder.getInt8Ty(), a17);
  // store i8 %18, i8* %9, align 1
  builder.CreateStore(a18, a9);
  // %19 = load i8, i8* %9, align 1
  auto *a19 = builder.CreateLoad(builder.getInt8Ty(), a9);
  // %20 = zext i8 %19 to i32
  auto *a20 = builder.CreateZExt(a19, builder.getInt32Ty());
  // %21 = load i8, i8* %6, align 1
  auto *a21 = builder.CreateLoad(builder.getInt8Ty(), a6);
  // %22 = zext i8 %21 to i32
  auto *a22 = builder.CreateZExt(a21, builder.getInt32Ty());
  // %23 = icmp eq i32 %20, %22
  auto *a23 = builder.CreateICmpEQ(a20, a22);
  // br i1 %23, label %24, label %29
  builder.CreateCondBr(a23, bb24, bb29);

  // 24:                                               ; preds = %2
  builder.SetInsertPoint(bb24);
  // %25 = load i64, i64* %8, align 8
  auto *a25 = builder.CreateLoad(builder.getInt64Ty(), a8);
  // %26 = icmp eq i64 %25, 3
  auto *a26 = builder.CreateICmpEQ(a25, builder.getInt64(3));
  // br i1 %26, label %27, label %29
  builder.CreateCondBr(a26, bb27, bb29);

  // 27:                                               ; preds = %24
  builder.SetInsertPoint(bb27);
  // %28 = load i8, i8* %7, align 1
  auto *a28 = builder.CreateLoad(builder.getInt8Ty(), a7);
  // store i8 %28, i8* %3, align 1
  builder.CreateStore(a28, a3);
  // br label %45
  builder.CreateBr(bb45);

  // 29:                                               ; preds = %24, %2
  builder.SetInsertPoint(bb29);
  // %30 = load i8, i8* %9, align 1
  auto *a30 = builder.CreateLoad(builder.getInt8Ty(), a9);
  // %31 = zext i8 %30 to i32
  auto *a31 = builder.CreateZExt(a30, builder.getInt32Ty());
  // %32 = load i8, i8* %7, align 1
  auto *a32 = builder.CreateLoad(builder.getInt8Ty(), a7);
  // %33 = zext i8 %32 to i32
  auto *a33 = builder.CreateZExt(a32, builder.getInt32Ty());
  // %34 = icmp eq i32 %31, %33
  auto *a34 = builder.CreateICmpEQ(a31, a33);
  // br i1 %34, label %35, label %43
  builder.CreateCondBr(a34, bb35, bb43);

  // 35:                                               ; preds = %29
  builder.SetInsertPoint(bb35);
  // %36 = load i64, i64* %8, align 8
  auto *a36 = builder.CreateLoad(builder.getInt64Ty(), a8);
  // %37 = icmp ult i64 %36, 4
  auto *a37 = builder.CreateICmpULT(a36, builder.getInt64(4));
  // br i1 %37, label %38, label %43
  builder.CreateCondBr(a37, bb38, bb43);

  // 38:                                               ; preds = %35
  builder.SetInsertPoint(bb38);
  // %39 = load i64, i64* %8, align 8
  auto *a39 = builder.CreateLoad(builder.getInt64Ty(), a8);
  // %40 = icmp ugt i64 %39, 1
  auto *a40 = builder.CreateICmpUGT(a39, builder.getInt64(1));
  // br i1 %40, label %41, label %43
  builder.CreateCondBr(a40, bb41, bb43);

  // 41:                                               ; preds = %38
  builder.SetInsertPoint(bb41);
  // %42 = load i8, i8* %7, align 1
  auto *a42 = builder.CreateLoad(builder.getInt8Ty(), a7);
  // store i8 %42, i8* %3, align 1
  builder.CreateStore(a42, a3);
  // br label %45
  builder.CreateBr(bb45);

  // 43:                                               ; preds = %38, %35, %29
  builder.SetInsertPoint(bb43);
  // %44 = load i8, i8* %6, align 1
  auto *a44 = builder.CreateLoad(builder.getInt8Ty(), a6);
  // store i8 %44, i8* %3, align 1
  builder.CreateStore(a44, a3);
  // br label %45
  builder.CreateBr(bb45);

  // 45:                                               ; preds = %43, %41, %27
  builder.SetInsertPoint(bb45);
  // %46 = load i8, i8* %3, align 1
  auto *a46 = builder.CreateLoad(builder.getInt8Ty(), a3);
  // ret i8 %46
  builder.CreateRet(a46);

  return func;
}

auto genIdx(gen_objs &gen_objs) {
  auto &context = *gen_objs.context;
  auto &builder = *gen_objs.builder;
  auto *llvmModule = gen_objs.llvmModule;

  auto *funcType = llvm::FunctionType::get(
      builder.getInt64Ty(), {builder.getInt64Ty(), builder.getInt64Ty()},
      false);
  auto *func = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage,
                                      "idx", llvmModule);

  auto *a0 = func->getArg(0);
  auto *a1 = func->getArg(1);

  auto *bb2 = llvm::BasicBlock::Create(context, "", func);
  builder.SetInsertPoint(bb2);

  // %3 = alloca i64, align 8
  auto *a3 = builder.CreateAlloca(builder.getInt64Ty());
  // %4 = alloca i64, align 8
  auto *a4 = builder.CreateAlloca(builder.getInt64Ty());
  // store i64 %0, i64* %3, align 8
  builder.CreateStore(a0, a3);
  // store i64 %1, i64* %4, align 8
  builder.CreateStore(a1, a4);
  // %5 = load i64, i64* %4, align 8
  auto *a5 = builder.CreateLoad(builder.getInt64Ty(), a4);
  // %6 = mul i64 %5, 640
  auto *a6 = builder.CreateMul(a5, builder.getInt64(W));
  // %7 = load i64, i64* %3, align 8
  auto *a7 = builder.CreateLoad(builder.getInt64Ty(), a3);
  // %8 = add i64 %6, %7
  auto *a8 = builder.CreateAdd(a6, a7);
  // ret i64 %8
  builder.CreateRet(a8);

  return func;
}

auto genMain(gen_objs &gen_objs) {
  auto &context = *gen_objs.context;
  auto &builder = *gen_objs.builder;
  auto *llvmModule = gen_objs.llvmModule;

  auto *funcType = llvm::FunctionType::get(builder.getInt32Ty(), false);
  auto *mainFunc = llvm::Function::Create(
      funcType, llvm::Function::ExternalLinkage, "main", llvmModule);

  auto *bb0 = llvm::BasicBlock::Create(context, "", mainFunc);
  auto *bb6 = llvm::BasicBlock::Create(context, "", mainFunc);
  auto *bb10 = llvm::BasicBlock::Create(context, "", mainFunc);
  auto *bb11 = llvm::BasicBlock::Create(context, "", mainFunc);

  builder.SetInsertPoint(bb0);

  auto *arrayType = llvm::ArrayType::get(builder.getInt8Ty(), 230400);

  // %1 = alloca i32, align 4
  auto *a1 = builder.CreateAlloca(builder.getInt32Ty());
  // %2 = alloca [230400 x i8], align 16
  auto *a2 = builder.CreateAlloca(arrayType);
  // %3 = alloca [230400 x i8], align 16
  auto *a3 = builder.CreateAlloca(arrayType);
  // store i32 0, i32* %1, align 4
  builder.CreateStore(builder.getInt32(0), a1);
  // %4 = getelementptr inbounds [230400 x i8], [230400 x i8]* %2, i64 0, i64 0
  auto *a4 = builder.CreateConstGEP2_64(arrayType, a2, 0, 0);
  // store i8* %4, i8** @SURF_CUR, align 8
  builder.CreateStore(a4, getGlobalVariable(llvmModule, "SURF_CUR"));
  // call void @fillRand()
  builder.CreateCall(getFunction(llvmModule, "fillRand"));
  // %5 = getelementptr inbounds [230400 x i8], [230400 x i8]* %3, i64 0, i64 0
  auto *a5 = builder.CreateConstGEP2_64(arrayType, a3, 0, 0);
  // store i8* %5, i8** @SURF_NEXT, align 8
  builder.CreateStore(a5, getGlobalVariable(llvmModule, "SURF_NEXT"));
  // call void @init(i64 noundef 360, i64 noundef 640)
  builder.CreateCall(getFunction(llvmModule, "init"),
                     {builder.getInt64(360), builder.getInt64(640)});
  // br label %6
  builder.CreateBr(bb6);

  // 6:                                                ; preds = %10, %0
  builder.SetInsertPoint(bb6);
  // %7 = call zeroext i8 @finished()
  auto *a7 = builder.CreateCall(getFunction(llvmModule, "finished"));
  // %8 = icmp ne i8 %7, 0
  auto *a8 = builder.CreateICmpNE(a7, builder.getInt8(0));
  // %9 = xor i1 %8, true
  auto *a9 = builder.CreateXor(a8, builder.getInt1(true));
  // br i1 %9, label %10, label %11
  builder.CreateCondBr(a9, bb10, bb11);

  // 10:                                               ; preds = %6
  builder.SetInsertPoint(bb10);
  // call void @calcSurf()
  builder.CreateCall(getFunction(llvmModule, "calcSurf"));
  // call void @swap()
  builder.CreateCall(getFunction(llvmModule, "swap"));
  // call void @draw()
  builder.CreateCall(getFunction(llvmModule, "draw"));
  // br label %6, !llvm.loop !6
  builder.CreateBr(bb6);

  // 11:                                               ; preds = %6
  builder.SetInsertPoint(bb11);
  // ret i32 0
  builder.CreateRet(builder.getInt32(0));

  return mainFunc;
}

auto *createGlobalSurf(gen_objs &gen_objs, llvm::Constant *val, std::string_view name) {
  auto &context = *gen_objs.context;
  auto &builder = *gen_objs.builder;
  auto *llvmModule = gen_objs.llvmModule;

  auto *surf =
      new llvm::GlobalVariable(*llvmModule, builder.getInt8PtrTy(), false,
                               llvm::GlobalVariable::CommonLinkage, val, name);
  surf->setAlignment(llvm::MaybeAlign(8));
  return surf;
}

int main() {
  llvm::InitializeNativeTarget();
  llvm::InitializeNativeTargetAsmPrinter();

  llvm::LLVMContext context{};
  llvm::IRBuilder builder{context};
  auto llvmModule = std::make_unique<llvm::Module>("top", context);
  gen_objs gen_objs{&context, &builder, llvmModule.get()};

  auto *nullVal = llvm::ConstantPointerNull::get(builder.getInt8PtrTy());
  auto *surfCur = createGlobalSurf(gen_objs, nullVal, "SURF_CUR");
  auto *surfNext = createGlobalSurf(gen_objs, nullVal, "SURF_NEXT");

  int i = 0;
  genInit(gen_objs);
  genGetZeroOrOne(gen_objs);
  genFinished(gen_objs);
  genFillRand(gen_objs);
  genCountNeighboursCommon(gen_objs);
  genCountNeighbours(gen_objs);
  genIdx(gen_objs);
  genCalcState(gen_objs);
  genCalcSurf(gen_objs);
  genSwap(gen_objs);
  genPutPixel(gen_objs);
  genFlush(gen_objs);
  genDraw(gen_objs);

  auto *mainFunc = genMain(gen_objs);

  llvmModule->dump();

  auto *ee = llvm::EngineBuilder(std::move(llvmModule)).create();

  std::unordered_map<std::string, void *> externalFunctions{
      {"getZeroOrOne", reinterpret_cast<void *>(getZeroOrOne)},
      {"init", reinterpret_cast<void *>(init)},
      {"putPixel", reinterpret_cast<void *>(putPixel)},
      {"flush", reinterpret_cast<void *>(flush)},
      {"finished", reinterpret_cast<void *>(finished)}};

  ee->InstallLazyFunctionCreator([&](const std::string &fnName) -> void * {
    auto it = externalFunctions.find(fnName);
    if (it == externalFunctions.end())
      return nullptr;
    return it->second;
  });

  ee->finalizeObject();
  std::vector<llvm::GenericValue> noargs{};
  ee->runFunction(mainFunc, noargs);

  std::cout << ee->getErrorMessage() << std::endl;
  return 0;
}
