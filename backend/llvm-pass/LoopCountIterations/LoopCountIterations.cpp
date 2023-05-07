
#include "llvm/Pass.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"


using namespace llvm;


namespace {
  struct LoopPrintPass: public LoopPass {
    static char ID;
    LoopPrintPass(): LoopPass(ID) {}

    void getAnalysisUsage(AnalysisUsage &AU) const override {
      AU.addRequired<LoopInfoWrapperPass>();
      AU.addPreserved<LoopInfoWrapperPass>();
      AU.addRequired<ScalarEvolutionWrapperPass>();
      AU.addPreserved<ScalarEvolutionWrapperPass>();
      AU.setPreservesAll();
    }

    virtual bool runOnLoop(Loop *L, LPPassManager &LPM) {
      outs() << "Loop summary:" << "\n";
      outs() << *L << "\n";
      outs() << "Loop depth: " << L->getLoopDepth() << "\n";
      outs() << "Is innermost: " << L->isInnermost() << "\n";
      outs() << "Number of blocks: " << L->getNumBlocks() << "\n";
      outs() << "Is guarded: " << L->isGuarded() << "\n";

      bool Countable = getAnalysis<ScalarEvolutionWrapperPass>().getSE().hasLoopInvariantBackedgeTakenCount(L);
      if (!Countable) {
        outs() << "Loop iterations number is unknown." << "\n";
      } else {
        auto LoopIterNum = getAnalysis<ScalarEvolutionWrapperPass>().getSE().getBackedgeTakenCount(L);
        outs() << "Loop iterations number: " << LoopIterNum;
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
