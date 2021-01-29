extern  printf      ; function name as external

section .data
    fmtall  db  "Sample %s", 10, 0
    msg     db  "test", 0
    radius  dd  314
    pi      dq  3.14
    fmtint  db  "radius: %d", 10, 0
    fmtflt  db  "pi: %lf", 10, 0

section .bss
section .text
    global  main

main:
    push    rbp
    mov     rbp, rsp

    xor     rax, rax
    mov     rdi, fmtall
    mov     rsi, msg
    call    printf

    mov     rdi, fmtint
    mov     rsi, [radius]
    call    printf

    mov     rax, 1
    movq    xmm0, [pi]
    mov     rdi, fmtflt
    mov     rsi, pi
    call    printf

    mov     rsp, rbp    ; clear stack
    pop     rbp         ; restore stack

    mov     rax, 60     ; exit syscall
    mov     rdi, 0      ; exit with 0
    syscall
