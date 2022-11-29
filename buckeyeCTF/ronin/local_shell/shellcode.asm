global _start

section .text
_start:
	sub rsp, 0x100
	xor rax, rax
    xor rdx, rdx
    xor rsi, rsi
    push rax
    mov rbx,'/bin//sh'
    push rbx
    push rsp
    pop rdi
    mov al, 59
    syscall