section .data
    bNum    db 123
    wNum    dw 12345
    dNum    dd 1234567890
    qNum1   dq 1234567890123456789
    qNum2   dq 123456
    qNum3   dq 3.14

section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rax, -1             ; fill rax with all 1 bits for 8bytes.
    mov     al, byte [bNum]     ; Wrong value

    xor     rax, rax
    mov     al, byte [bNum]     ; now correct 1byte value

    mov     rax, -1             ; rax is quadword size.
    mov     ax, word [wNum]     ; Wrong value

    xor     rax, rax
    mov     ax, word [wNum]     ; now correct 2bytes value

    mov     rax, -1
    mov     eax, dword [dNum]   ; does clear the upper bits

    mov     rax, -1
    mov     rax, qword [qNum1]  ; does clear
    
    ; save register addr to qNums's value
    mov     qword [qNum2], rax  ; one operand always a register

    ; dest based size value storing
    mov     rax, 123456         ; source operand an immediate value

    movq    xmm0, [qNum3]       ; instrunction for float points
end:
    mov     rsp, rbp
    pop     rbp
    ret
