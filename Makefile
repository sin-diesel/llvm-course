
SOURCES=$(wildcard *.c)
GL=-lglut -lGL -lGLU

all: $(SOURCES)
	gcc $^ -o gol $(GL)
