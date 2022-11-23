find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

execute_process(COMMAND llvm-config-14 --libs all
                OUTPUT_VARIABLE LLVMLIBS
                OUTPUT_STRIP_TRAILING_WHITESPACE)

add_executable(gen gen.cc)
target_compile_features(gen PRIVATE cxx_std_20)

target_include_directories(gen PRIVATE ${CMAKE_SOURCE_DIR})
target_link_libraries(gen PRIVATE GOLlib DRAW)

target_include_directories(gen PRIVATE ${LLVM_INCLUDE_DIRS})
target_link_libraries(gen PRIVATE ${LLVMLIBS})
separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
target_compile_definitions(gen PRIVATE ${LLVM_DEFINITIONS_LIST})

set_target_properties(gen
  PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)
