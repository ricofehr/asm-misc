# asm-misc
Some miscellaneous assembly programs
- hello: print "Hello world" message
- rect: draw a rectangle in terminal

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

For rect program
```
$ make rect
nasm -f elf64 -o rect.o rect.asm
ld -o bin/rect rect.o
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

Rect example
```
$ ./bin/./rect 40 20
----------------------------------------
-                                      -
-                                      -
-                                      -
-                                      -
-                                      -
-                                      -
-                                      -
-                                      -
-                                      -
-                                      -
-                                      -
-                                      -
-                                      -
-                                      -
-                                      -
-                                      -
-                                      -
-                                      -
----------------------------------------
```

