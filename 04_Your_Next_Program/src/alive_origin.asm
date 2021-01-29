section .data
    SYS_WRITE       equ 1
    STDOUT_FILENO   equ 1

    msg1            db  "Hello, World!", 10, 0
    msg1Len         equ $-msg1 - 1  ; excepts 0 termination.
    msg2            db  "Alive and Kicking!", 10, 0
    msg2Len         equ $-msg2
    radius          dq  357 ; 8bytes
    pi              dq  3.14

section .bss
section .text
    global main

main:
    push    rbp         ; save origin base pointer
    mov     rbp, rsp    ; bp as sp
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, msg1
    mov     rdx, msg1Len
    syscall

    mov     rax, 1
    mov     rdi, 1
    mov     rsi, msg2
    mov     rdx, msg2Len
    syscall

    mov     rsp, rbp    ; remove stacks
    pop     rbp         ; restore bp
    mov     rax, 60     ; exit syscall
    mov     rdi, 0      ; exit success
    syscall

