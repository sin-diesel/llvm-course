
all:
	bison -d -o parser.cpp parser.y
	lex -o tokens.cpp tokens.l
	g++ -o frontend `llvm-config-15 --libs all --cxxflags --ldflags` parser.cpp tokens.cpp main.cpp
