#!/bin/bash

clang++ graphics.cpp $1 -o $1.out -lsfml-graphics -lsfml-window -lsfml-system