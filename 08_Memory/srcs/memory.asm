section .data
	bNum	db 123
	wNum	dw 12345
	text1	db "abc", 0
	qNum2	dq 3.141582654
	text2	db "cde", 0

section .bss
	bvar	resb 1
	dvar	resd 1
	wvar	resw 10
	qvar	resq 3

section .text
	global	main

main:
preface:
	push	rbp
	mov		rbp, rsp
start:
	lea		rax, [bNum]		; load Effective address of bNum in rax operand size determine by dest operand
	mov		rax, bNum
	mov		rax, [bNum]		; mov value in bNum to rax
	mov		[bvar], rax		; mov address of rax -> bvar
	lea		rax, [bvar]		; load address of bvar in rax
	lea		rax, [wNum]		; load address of wNum in rax
	mov		rax, [wNum]		; load content of wNum in rax
	lea		rax, [text1]	; load address of text1 in rax
	mov		rax, text1		; load content text1 to rax
	mov		rax, text1+1	; load second char in rax
	lea		rax, [text1+1]	; load second char in rax
	mov		rax, [text1]	; load starting at text1 in rax
	mov		rax, [text1+1]	; load starting at text1+1 in rax
end:
	mov		rsp, rbp
	pop		rbp
	ret
