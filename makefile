all: assembly-sort

assembly-sort: assembly-sort.o asm_io.o driver.c
	gcc -m32 -o assembly-sort assembly-sort.o driver.c asm_io.o
asm_io.o: asm_io.asm
	nasm -f elf32 -d ELF_TYPE asm_io.asm
assembly-sort.o: assembly-sort.asm
	nasm -f elf32 -o assembly-sort.o assembly-sort.asm
clean:
	rm *.o assembly-sort
