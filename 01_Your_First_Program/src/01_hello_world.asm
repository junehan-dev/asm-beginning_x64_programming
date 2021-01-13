section .data
    SYS_WRITE       EQU 1
    STDOUT_FILENO   EQU 1
    msg             DB  "hello, world", 0
    msg_len         EQU $-msg

section .bss
section .text
    global main

main:
    mov     RAX, SYS_WRITE
    mov     RDI, STDOUT_FILENO
    mov     RSI, msg
    mov     RDX, 12
    syscall    

    mov     RAX, 60
    mov     RDI, 0
    syscall
