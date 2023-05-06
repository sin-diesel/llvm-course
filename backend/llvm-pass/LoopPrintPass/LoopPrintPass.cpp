
#include "llvm/Pass.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"


using namespace llvm;


namespace {
  struct LoopPrintPass: public LoopPass {
    static char ID;
    LoopPrintPass(): LoopPass(ID) {}

    virtual bool runOnLoop(Loop *L, LPPassManager &LPM) {
      outs() << "Printing Loop:" << "\n";
      outs() << *L;
    
      outs() << "Loop basic blocks: " << "\n";
      for (BasicBlock *BB: L->getBlocks()) {
        outs() << *BB << "\n";
      }

      return false;
    }

  };

} // end anonymous namespace

char LoopPrintPass::ID = 0;

// Automatically enable the pass.
// http://adriansampson.net/blog/clangpass.html
static void registerLoopPrintPass(const PassManagerBuilder &,
                                  legacy::PassManagerBase &PM) {
  PM.add(new LoopPrintPass());
}

static RegisterStandardPasses
  RegisterMyPass(PassManagerBuilder::EP_EarlyAsPossible,
                 registerLoopPrintPass);
