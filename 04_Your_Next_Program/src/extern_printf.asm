extern      printf      ; function name as external

section .data
    msg     db  "Hello, World!", 0
    fmtstr  db  "This is our string: %s", 10, 0

section .bss
section .text
    global main

main:
    push    rbp
    mov     rbp, rsp

    mov     rax, 0      ; no xmm register involved
    xor     rax, rax    ; Assertion to make rax empty? ;xor rax rax

    mov     rdi, fmtstr ; dest: This is our string: %s,10,0 
    mov     rsi, msg    ; src:  Hello, World!, 0
    call    printf

    mov     rsp, rbp    ; clear stack
    pop     rbp         ; restore stack

    mov     rax, 60     ; exitsyscall
    mov     rdi, 0      ; exit with 0
    syscall
