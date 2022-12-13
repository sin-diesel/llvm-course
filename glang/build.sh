#!/bin/bash

lex lex.l
bison -d grammar.y
cmake ./
make
cat main.sigma | ./compile > main.ll
