
SOURCES=$(wildcard *.c)
GL=-lglut -lGL -lGLU

all: $(SOURCES)
	gcc $^ -o gol $(GL)

llvm: logic.c
	clang $^  -S -emit-llvm -o logic.ll
