extern printf
section .data
	number	dq	5
	fmt		db	"The sum from 0 to %ld is %ld", 10, 0
section .bss
section .text
	global main

main:
intro:
	push	rbp
	mov		rbp, rsp
	mov		rcx, [number]	; init counter reigster
	mov		rax, 0
bloop:
	add		rax, rcx
	loop	bloop			; loop while decreasing rcx with 1 until rcx = 0
	mov		rdi, fmt		; rcx = 0, continue here
	mov		rsi, [number]
	mov		rdx, rax
	call	printf
exit:
	mov		rsp, rbp
	pop		rbp
	ret
