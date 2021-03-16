extern printf
section .data
	number	dq 5
	fmt		db "The sum from 0 to %ld is %ld", 10, 0
	
section .bss
section .text
	global main

main:
	push	rbp
	mov		rbp, rsp
	mov		rbx, 0			; counter
	mov		rax, 0			; sum will be in rax
jloop:
	add		rax, rbx
	inc		rbx
	cmp		rbx, [number]
	jle		jloop
print:
	mov		rdi, fmt
	mov		rsi, [number]
	mov		rdx, rax
	mov		rax, 0
	call	printf
exit:
	mov		rsp, rbp
	pop		rbp
	ret
