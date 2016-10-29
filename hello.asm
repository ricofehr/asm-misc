;; Program design:
; print "hello world!"
; exit 0

;; Register usage in program
; rax = syscall number
; rdi = first parameter of syscall
; rsi = second parameter of syscall
; rdx = third parameter of syscall

;; constant datas initialization
section .data
	SYS_WRITE	equ 1
	STD_OUT		equ 1
	SYS_EXIT	equ 60
	EXIT_CODE	equ 0
	HELLO_LENGTH	equ 12
	HELLO_STR	db "hello world!", 12

section .text
	global _start

;; main program
; exec hello subroutine
; exec exit subroutine
_start:
	call	.hello
	call	.exit

;; hello subroutine
; Print "hello work" thanks to a syscall with 4 parameters
; Parameters rax = 1, syscall number, so sys_write
; rdi = 1, first parameter to sys_write, stdout
; rsi = "hello world!", second pareter to sys_write, string to print
; rdx = 12, third parameter to sys_write, size of the string
; return nothing
.hello:
	mov	rax, SYS_WRITE
	mov	rdi, STD_OUT
	mov	rsi, HELLO_STR
	mov	rdx, HELLO_LENGTH
	syscall
        ret

;; exit subroutine
; Exit program thanks to a syscall with 2 parameters
; Parameters rax = 60, syscall number, so sys_exit
; rdi = 0, first parameter of sys_exit, success exit code
.exit:
	mov	rax, SYS_EXIT
	mov	rdi, EXIT_CODE
	syscall
