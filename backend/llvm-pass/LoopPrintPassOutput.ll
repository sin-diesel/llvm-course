; ModuleID = 'CRC.cpp'
source_filename = "CRC.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable mustprogress
define dso_local i32 @_Z13crc32_bitwisePKvmj(i8* %0, i64 %1, i32 %2) #0 {
  %4 = alloca i8*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i8*, align 8
  %9 = alloca i32, align 4
  store i8* %0, i8** %4, align 8
  store i64 %1, i64* %5, align 8
  store i32 %2, i32* %6, align 4
  %10 = load i32, i32* %6, align 4
  %11 = xor i32 %10, -1
  store i32 %11, i32* %7, align 4
  %12 = load i8*, i8** %4, align 8
  store i8* %12, i8** %8, align 8
  br label %13

13:                                               ; preds = %42, %3
  %14 = load i64, i64* %5, align 8
  %15 = add i64 %14, -1
  store i64 %15, i64* %5, align 8
  %16 = icmp ne i64 %14, 0
  br i1 %16, label %17, label %43

17:                                               ; preds = %13
  %18 = load i8*, i8** %8, align 8
  %19 = getelementptr inbounds i8, i8* %18, i32 1
  store i8* %19, i8** %8, align 8
  %20 = load i8, i8* %18, align 1
  %21 = zext i8 %20 to i32
  %22 = load i32, i32* %7, align 4
  %23 = xor i32 %22, %21
  store i32 %23, i32* %7, align 4
  store i32 0, i32* %9, align 4
  br label %24

24:                                               ; preds = %39, %17
  %25 = load i32, i32* %9, align 4
  %26 = icmp ult i32 %25, 8
  br i1 %26, label %27, label %42

27:                                               ; preds = %24
  %28 = load i32, i32* %7, align 4
  %29 = and i32 %28, 1
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %31, label %35

31:                                               ; preds = %27
  %32 = load i32, i32* %7, align 4
  %33 = lshr i32 %32, 1
  %34 = xor i32 %33, -306674912
  store i32 %34, i32* %7, align 4
  br label %38

35:                                               ; preds = %27
  %36 = load i32, i32* %7, align 4
  %37 = lshr i32 %36, 1
  store i32 %37, i32* %7, align 4
  br label %38

38:                                               ; preds = %35, %31
  br label %39

39:                                               ; preds = %38
  %40 = load i32, i32* %9, align 4
  %41 = add i32 %40, 1
  store i32 %41, i32* %9, align 4
  br label %24, !llvm.loop !2

42:                                               ; preds = %24
  br label %13, !llvm.loop !4

43:                                               ; preds = %13
  %44 = load i32, i32* %7, align 4
  %45 = xor i32 %44, -1
  ret i32 %45
}

attributes #0 = { noinline nounwind optnone uwtable mustprogress "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
