;; Program design:
; draw rectangle in term
; exit 0

;; Register usage in program
; On syscall
; rax = syscall number
; rdi = first parameter of syscall
; rsi = second parameter of syscall
; rdx = third parameter of syscall
;
; Program start
; rcx = argc
; rsi = pop argv parameter
; rax = tmp integer
;
; Program loops
; r12-r15 = loop counters

;; constant datas initialization
section .data
	SYS_WRITE	equ 1
	STD_OUT		equ 1
	SYS_EXIT	equ 60
	EXIT_CODE	equ 0
	NEW_LINE	db 0xa
	WRONG_ARGC	db "Must be two command line argument: ./rect [width] [height]", 0xa
	RECT_S	db " ", 1
	RECT_U	db "-", 1
	RECT_EOL db 0xa, 1

section .text
	global _start

;; main program
; read parameters and convert to int
; draw_line / draw_col instructions
_start:
	;; rcx - argc
	pop	rcx

	;;
	;; Check argc
	;;
	cmp	rcx, 3
	jne	argc_error

	;;
	;; start to sum arguments
	;;

	;; skip argv[0] - program name
	add	rsp, 8

	;; get argv[1]
	pop	rsi
	;; convert argv[1] str to int
	call	str_to_int
	;; put width to r12
	mov	r13, rax

	;; get argv[2]
	pop	rsi
	;; convert argv[2] str to int
	call	str_to_int
	;; put height to r12
	mov	r12, rax
	mov	r15, r12

;; draw_line subroutine
; print a line in term
; loop while counter is not null
draw_line:
        mov	r14, r13

;; draw_col subroutine
; print a column char
; loop while counter is not null
draw_col:
	cmp	r12, r15
	je	write_trait
	cmp	r12, 1
	je	write_trait
	cmp	r14, r13
	je	write_trait
	cmp	r14, 1
	je	write_trait
	jmp	write_space

;; goto used after print char
after_trait:
	sub	r14, 1
	cmp	r14, 0
	jne	draw_col
	call	write_eol
        sub	r12, 1
	cmp	r12, 0
	jne	draw_line

	call	exit

;; write_trait
; Print "-" thanks to a syscall with 4 parameters
; Parameters rax = 1, syscall number, so sys_write
; rdi = 1, first parameter to sys_write, stdout
; rsi = "-", second pareter to sys_write, string to print
; rdx = 1, third parameter to sys_write, size of the string
; jump to after_trait after
write_trait:
	mov	rax, SYS_WRITE
	mov	rdi, STD_OUT
	mov	rsi, RECT_U
	mov	rdx, 1
	syscall
        jmp	after_trait

;; write_space
; Print " " thanks to a syscall with 4 parameters
; Parameters rax = 1, syscall number, so sys_write
; rdi = 1, first parameter to sys_write, stdout
; rsi = " ", second pareter to sys_write, string to print
; rdx = 1, third parameter to sys_write, size of the string
; jump to after_trait after
write_space:
	mov	rax, SYS_WRITE
	mov	rdi, STD_OUT
	mov	rsi, RECT_S
	mov	rdx, 1
	syscall
        jmp	after_trait

;; write_eol
; Print "\n" thanks to a syscall with 4 parameters
; Parameters rax = 1, syscall number, so sys_write
; rdi = 1, first parameter to sys_write, stdout
; rsi = "\n", second pareter to sys_write, string to print
; rdx = 1, third parameter to sys_write, size of the string
; return nothing
write_eol:
	mov	rax, SYS_WRITE
	mov	rdi, STD_OUT
	mov	rsi, RECT_EOL
	mov	rdx, 1
	syscall
        ret

;; str_to_int
; Convert string to int
; Parameters rsi, targetting string
; Compute integer into rax register
; return nothing
str_to_int:
	xor rax, rax
	mov rcx,  10
; goto used for loop into decimal numbers
next:
	cmp [rsi], byte 0
	je return_str
	mov bl, [rsi]
	sub bl, 48
	mul rcx
	add rax, rbx
	inc rsi
	jmp next
; goto for str_to_int return instruction
return_str:
	ret

;; argc_error
; print parameters error sentence
argc_error:
	mov	rax, SYS_WRITE
	mov	rdi, STD_OUT
	mov	rsi, WRONG_ARGC
	mov	rdx, 59
	syscall
        jmp exit

;; exit subroutine
; Exit program thanks to a syscall with 2 parameters
; Parameters rax = 60, syscall number, so sys_exit
; rdi = 0, first parameter of sys_exit, success exit code
exit:
	mov	rax, SYS_EXIT
	mov	rdi, EXIT_CODE
	syscall
