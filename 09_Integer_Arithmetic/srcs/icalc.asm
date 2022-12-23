extern printf
SECTION .data
	number1	dq	128
	number2	dq	19
	neg_num	dq	-12
	fmt		db	"The numbers are %ld and %ld", 10, 0
	fmtint	db	"%s %ld", 10 ,0
	sumi	db	"The sum is", 0
	difi	db	"The difference is", 0
	inci	db	"Number 1 Incremented:", 0
	deci	db	"Number 1 Decremented:", 0
	sali	db	"Number 1 Shift left 2 (x4):", 0
	sari	db	"Number 1 Shift right 2 (/4):", 0
	sariex	db	"Number 1 Shift right 2 (/4) with ", "sign extension:", 0
	multi	db	"The product is", 0
	divi	db	"The integer quotient is", 0
	remi	db	"The modulo is", 0
SECTION .bss
	resulti	resq	1
	modulo	resq	1
SECTION .text
	global main

main:
preface:
	PUSH	rbp
	MOV		rbp, rsp
start:
;	print int
	MOV 	rdi, fmt
	MOV		rsi, [number1]
	MOV		rdx, [number2]
	MOV		rax, 0
	CALL	printf
;	adding
	MOV		rax, [number1]
	ADD		rax, [number2]
	MOV		[resulti], rax
	MOV 	rdi, fmtint
	MOV		rsi, sumi
	MOV		rdx, [resulti]
	MOV		rax, 0
	CALL	printf
;	subtracting
	MOV		rax, [number1]
	SUB		rax, [number2]
	MOV		[resulti], rax
	MOV		rdi, fmtint
	MOV		rsi, difi
	MOV		rdx, [resulti]
	MOV		rax, 0
	CALL	printf
;	incrementing
	MOV		rax, [number1]
	INC		rax
	MOV		[resulti], rax
	MOV		rdi, fmtint
	MOV		rsi, inci
	MOV		rdx, [resulti]
	MOV		rax, 0
	CALL	printf
;	decremeting
	MOV		rax, [number1]
	DEC		rax
	MOV		[resulti], rax
	MOV		rdi, fmtint
	MOV		rsi, deci
	MOV		rdx, [resulti]
	MOV		rax, 0
	CALL	printf
;	shift arithmetic left
	MOV		rax, [number1]
	SAL		rax, 2
	MOV		[resulti], rax
	MOV		rdi, fmtint
	MOV		rsi, sali
	MOV		rdx, [resulti]
	MOV		rax, 0
	CALL	printf
;	shift arithmetic right
	MOV		rax, [number1]
	SAR		rax, 2
	MOV		[resulti], rax
	MOV		rdi, fmtint
	MOV		rsi, sari
	MOV		rdx, [resulti]
	MOV		rax, 0
	CALL	printf
;	shift arithmetic right with sign extension
	MOV		rax, [neg_num] ; -12 10100
	SAR		rax, 2 ; -3 11101
	MOV		[resulti], rax
	MOV 	rdi, fmtint
	MOV		rsi, sariex
	MOV		rdx, [resulti]
	MOV		rax, 0
	CALL	printf
;	multiply
	MOV		rax, [number1]
	IMUL	qword [number2]
	MOV		[resulti], rax
	MOV		rdi, fmtint
	MOV		rsi, multi
	MOV		rdx, [resulti]
	CALL	printf
;	divide
	MOV		rax, [number1]
	MOV		rdx, 0	; result saves modulo to rdx
	IDIV	qword [number2]
	MOV		[resulti], rax	;result saves interger part to rax
	MOV		[modulo], rdx
	MOV		rdi, fmtint
	MOV		rsi, divi
	MOV		rdx, [resulti]
	MOV		rax, 0
	CALL	printf
	MOV		rdi, fmtint
	MOV		rsi, remi
	MOV		rdx, [modulo]
	MOV		rax, 0
	CALL	printf
fin:
	MOV		rsp, rbp
	POP		rbp
	ret

