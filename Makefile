# Makefile for asm files
# -------------------

"hello" : hello

hello :
	nasm -f elf64 -o hello.o hello.asm
	ld -o bin/hello hello.o 

clean :
	rm -f *.o bin/* 2>/dev/null
