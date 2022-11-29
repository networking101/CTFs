from ctypes import *

so_file = "./random_solve.so"
my_functions = CDLL(so_file)

my_input = b"\x84\x25\x36\x2c"

seed = int.from_bytes(my_input, "little")
seed = 0x0459c262
my_functions.seed_solve(seed)

i = 10
while i < 1000000000:
    rand_num = my_functions.random_solve()
    print((rand_num % i) + 1)
    i = i * 10