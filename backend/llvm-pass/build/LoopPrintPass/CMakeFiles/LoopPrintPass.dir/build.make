# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.26

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/stanislav/Study/llvm-course/backend/llvm-pass

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/stanislav/Study/llvm-course/backend/llvm-pass/build

# Include any dependencies generated for this target.
include LoopPrintPass/CMakeFiles/LoopPrintPass.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include LoopPrintPass/CMakeFiles/LoopPrintPass.dir/compiler_depend.make

# Include the progress variables for this target.
include LoopPrintPass/CMakeFiles/LoopPrintPass.dir/progress.make

# Include the compile flags for this target's objects.
include LoopPrintPass/CMakeFiles/LoopPrintPass.dir/flags.make

LoopPrintPass/CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.o: LoopPrintPass/CMakeFiles/LoopPrintPass.dir/flags.make
LoopPrintPass/CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.o: /home/stanislav/Study/llvm-course/backend/llvm-pass/LoopPrintPass/LoopPrintPass.cpp
LoopPrintPass/CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.o: LoopPrintPass/CMakeFiles/LoopPrintPass.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/stanislav/Study/llvm-course/backend/llvm-pass/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object LoopPrintPass/CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.o"
	cd /home/stanislav/Study/llvm-course/backend/llvm-pass/build/LoopPrintPass && /usr/bin/clang++-12 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT LoopPrintPass/CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.o -MF CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.o.d -o CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.o -c /home/stanislav/Study/llvm-course/backend/llvm-pass/LoopPrintPass/LoopPrintPass.cpp

LoopPrintPass/CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.i"
	cd /home/stanislav/Study/llvm-course/backend/llvm-pass/build/LoopPrintPass && /usr/bin/clang++-12 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/stanislav/Study/llvm-course/backend/llvm-pass/LoopPrintPass/LoopPrintPass.cpp > CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.i

LoopPrintPass/CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.s"
	cd /home/stanislav/Study/llvm-course/backend/llvm-pass/build/LoopPrintPass && /usr/bin/clang++-12 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/stanislav/Study/llvm-course/backend/llvm-pass/LoopPrintPass/LoopPrintPass.cpp -o CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.s

# Object files for target LoopPrintPass
LoopPrintPass_OBJECTS = \
"CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.o"

# External object files for target LoopPrintPass
LoopPrintPass_EXTERNAL_OBJECTS =

LoopPrintPass/libLoopPrintPass.so: LoopPrintPass/CMakeFiles/LoopPrintPass.dir/LoopPrintPass.cpp.o
LoopPrintPass/libLoopPrintPass.so: LoopPrintPass/CMakeFiles/LoopPrintPass.dir/build.make
LoopPrintPass/libLoopPrintPass.so: LoopPrintPass/CMakeFiles/LoopPrintPass.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/stanislav/Study/llvm-course/backend/llvm-pass/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared module libLoopPrintPass.so"
	cd /home/stanislav/Study/llvm-course/backend/llvm-pass/build/LoopPrintPass && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/LoopPrintPass.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
LoopPrintPass/CMakeFiles/LoopPrintPass.dir/build: LoopPrintPass/libLoopPrintPass.so
.PHONY : LoopPrintPass/CMakeFiles/LoopPrintPass.dir/build

LoopPrintPass/CMakeFiles/LoopPrintPass.dir/clean:
	cd /home/stanislav/Study/llvm-course/backend/llvm-pass/build/LoopPrintPass && $(CMAKE_COMMAND) -P CMakeFiles/LoopPrintPass.dir/cmake_clean.cmake
.PHONY : LoopPrintPass/CMakeFiles/LoopPrintPass.dir/clean

LoopPrintPass/CMakeFiles/LoopPrintPass.dir/depend:
	cd /home/stanislav/Study/llvm-course/backend/llvm-pass/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/stanislav/Study/llvm-course/backend/llvm-pass /home/stanislav/Study/llvm-course/backend/llvm-pass/LoopPrintPass /home/stanislav/Study/llvm-course/backend/llvm-pass/build /home/stanislav/Study/llvm-course/backend/llvm-pass/build/LoopPrintPass /home/stanislav/Study/llvm-course/backend/llvm-pass/build/LoopPrintPass/CMakeFiles/LoopPrintPass.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : LoopPrintPass/CMakeFiles/LoopPrintPass.dir/depend

