add_library(LoopCountIterations MODULE
    # List your source files here.
    LoopCountIterations.cpp
)

# Use C++11 to compile our pass (i.e., supply -std=c++11).
target_compile_features(LoopCountIterations PRIVATE cxx_range_for cxx_auto_type)

# LLVM is (typically) built with no C++ RTTI. We need to match that;
# otherwise, we'll get linker errors about missing RTTI data.
set_target_properties(LoopCountIterations PROPERTIES
    COMPILE_FLAGS "-fno-rtti"
)
