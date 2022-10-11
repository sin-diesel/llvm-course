
SOURCES=$(wildcard *.c)

all: $(SOURCES)
	gcc $^ -o gol
