global _start

section .text
_start:

	sub rsp, 0x40
	
	; execve("/bin//sh", 0, 0)
	xor rax, rax
	push rax
	xor rsi, rsi
	xor rdx, rdx
	mov rbx, '/bin//sh'
	push rbx
	push rsp
	pop rdi
	mov al, 59
	syscall