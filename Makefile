# Makefile for asm files
# -------------------

"hello" : hello

hello :
	nasm -f elf64 -o hello.o hello.asm
	ld -o bin/hello hello.o

rect :
	nasm -f elf64 -o rect.o rect.asm
	ld -o bin/rect rect.o

clean :
	rm -f *.o bin/* 2>/dev/null
