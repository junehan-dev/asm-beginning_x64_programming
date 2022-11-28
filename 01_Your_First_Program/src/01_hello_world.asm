SECTION .data
	SYS_WRITE	EQU	1
	STDOUT_FILENO	EQU	1
	msg	DB	"hello, world", 0
	msg_len	EQU $-msg

SECTION .bss
SECTION .text
	global main

main:
	MOV	RAX, SYS_WRITE
	MOV	RDI, STDOUT_FILENO
	MOV	RSI, msg

	MOV	RDX, msg_len
	SYSCALL

	MOV	RAX, 60
	MOV	RDI, 0
	SYSCALL
