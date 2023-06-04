section .text
    global _start

_start:
    xor eax, eax
    xor ecx, ecx
    xor edx, edx
    push eax
    push 0x64726f77     ; push password
    push 0x73736170
    mov ebx, esp
    mov al, 0x5
    int 0x80            ; call open
    
    sub esp, 0x20       ; adjust stack for buffer

    mov ebx, eax
    mov ecx, esp        ; set buffer on stack
    mov dl, 0x20
    mov al, 3
    int 0x80            ; call read

    mov bl, 0x1
    mov dl, 0x20
    mov al, 4
    int 0x80            ; call write to stdout

    add esp, 0x20       ; re adjust stack

    mov al, 1
    int 0x80            ; exit cleanly