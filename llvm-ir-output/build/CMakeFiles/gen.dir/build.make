# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/stanislav/llvm-course/llvm-practice/llvm-ir-output

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/stanislav/llvm-course/llvm-practice/llvm-ir-output/build

# Include any dependencies generated for this target.
include CMakeFiles/gen.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/gen.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/gen.dir/flags.make

CMakeFiles/gen.dir/gen.o: CMakeFiles/gen.dir/flags.make
CMakeFiles/gen.dir/gen.o: ../gen.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/stanislav/llvm-course/llvm-practice/llvm-ir-output/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/gen.dir/gen.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/gen.dir/gen.o -c /home/stanislav/llvm-course/llvm-practice/llvm-ir-output/gen.cc

CMakeFiles/gen.dir/gen.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gen.dir/gen.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/stanislav/llvm-course/llvm-practice/llvm-ir-output/gen.cc > CMakeFiles/gen.dir/gen.i

CMakeFiles/gen.dir/gen.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gen.dir/gen.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/stanislav/llvm-course/llvm-practice/llvm-ir-output/gen.cc -o CMakeFiles/gen.dir/gen.s

# Object files for target gen
gen_OBJECTS = \
"CMakeFiles/gen.dir/gen.o"

# External object files for target gen
gen_EXTERNAL_OBJECTS =

bin/gen: CMakeFiles/gen.dir/gen.o
bin/gen: CMakeFiles/gen.dir/build.make
bin/gen: CMakeFiles/gen.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/stanislav/llvm-course/llvm-practice/llvm-ir-output/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable bin/gen"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/gen.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/gen.dir/build: bin/gen

.PHONY : CMakeFiles/gen.dir/build

CMakeFiles/gen.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/gen.dir/cmake_clean.cmake
.PHONY : CMakeFiles/gen.dir/clean

CMakeFiles/gen.dir/depend:
	cd /home/stanislav/llvm-course/llvm-practice/llvm-ir-output/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/stanislav/llvm-course/llvm-practice/llvm-ir-output /home/stanislav/llvm-course/llvm-practice/llvm-ir-output /home/stanislav/llvm-course/llvm-practice/llvm-ir-output/build /home/stanislav/llvm-course/llvm-practice/llvm-ir-output/build /home/stanislav/llvm-course/llvm-practice/llvm-ir-output/build/CMakeFiles/gen.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/gen.dir/depend

