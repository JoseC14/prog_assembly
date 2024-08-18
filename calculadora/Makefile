NOME = calculadora

all: $(NOME).o
	ld -s -o $(NOME) $(NOME).o
	rm -rf *.0

%.o: %.asm
	nasm -f elf64 $<
