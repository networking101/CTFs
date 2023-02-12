shellcode: shellcode.asm
	yasm -g dwarf2 -f elf64 shellcode.asm -l shellcode.lst
	ld -g -o shellcode shellcode.o

clean:
	rm -f shellcode shellcode.o shellcode.lst

.PHONY: raw
raw:
	printf '\\x'
	printf '\\x' && objdump -d shellcode | grep "^ " | cut -f2 | tr -d ' ' | tr -d '\n' | sed 's/.\{2\}/&\\x /g' | head -c-3 | tr -d ' ' && echo ' '