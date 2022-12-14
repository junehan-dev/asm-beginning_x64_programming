SECTION .data
	bNum	db	123
	wNum	dw	12345
	wArray	times	5 dw 0 ; 0 0 0 0 0
	dNum	dd	12345
	qNum1	dq	12345
	qNum2	dq	3.141592654
	text1	db	"abc", 0
	text2	db	"cde", 0

SECTION .bss
	bVar	resb	1
	dVar	resd	1
	wVar	resw	10
	qVar	resq	3

SECTION .text
	global main

main:
    mov rbp, rsp; for correct debugging
preface:
	PUSH	rbp
	MOV		rbp, rsp
start:
	LEA		rax, [bNum]		; load Effective address of bNum in rax operand size determine by dest operand
	MOV		rax, bNum		; load address of bNum to rax

	MOV		rax, [bNum]		; mov value in bNum to rax
	MOV		[bVar], rax		; mov address of rax -> bvar
	LEA		rax, [bVar]		; load address of bvar in rax
	LEA		rax, [wNum]		; load address of wNum in rax
	MOV		rax, [wNum]		; load content of wNum in rax
	LEA		rax, [text1]	; load address of text1 in rax
	MOV		rax, text1		; load Address of text1 to rax
	MOV		rax, text1+1	; load second char in rax
	LEA		rax, [text1+1]	; load second char in rax
	MOV		rax, [text1]	; load starting at text1 in rax
	MOV		rax, [text1+1]	; load starting at text1+1 in rax
end:
	MOV		rsp, rbp
	POP		rbp
	RET
