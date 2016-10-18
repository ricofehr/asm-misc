# asm-misc 
Some miscellaneous assembly programs

## Compile

Requirements
- Linux operating system
- nasm package

For hello program
```
$ make hello
nasm -f elf64 -o hello.o hello.asm
ld -o bin/hello hello.o 
```

## Folders
```
/		Asm Sources are on the root of Repository
+--bin/		Binary folder where executables are written
```

## Run

Hello example
```
$ ./bin/./hello 
hello world!
```
