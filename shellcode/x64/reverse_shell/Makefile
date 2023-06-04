reverse_tcp_64: reverse_tcp_64.asm
	yasm -g dwarf2 -f elf64 reverse_tcp_64.asm -l reverse_tcp_64.lst
	ld -g -o reverse_tcp_64 reverse_tcp_64.o
clean:
	rm -f reverse_tcp_64 reverse_tcp_64.o reverse_tcp_64.lst
