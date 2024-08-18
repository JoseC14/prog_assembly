%include "bibliotecaE.inc"

section .data
	tit     db LF,"+----------------+", LF, "| Calculadora |", LF, "+--------------+", NULL
	obVal1  db LF, "Valor 1:", NULL
	obVal2  db LF, "Valor 2", NULL
	opc1    db LF, "1. Adicionar", NULL
	opc2    db LF, "2. Subtrair", NULL
	opc3    db LF, "3. Multiplicar", NULL
	opc4    db LF, "4. Dividir", NULL
	msgOpc  db LF, "Deseja Realizar? ", NULL
	msgErro	db LF, "Valor da Opcao INvalido", NULL
	p1	db LF, "Processo Adicionar", NULL
	p2	db LF, "Processo Subtrair", NULL
	p3	db LF, "Processo Multiplicar", NULL
	p4	db LF, "Processo Dividir", NULL
	msgfim  db LF, "Terminei", LF, NULL

section .bss
	opc resb 1
	num1 resb 1
	num2 resb 1

section .text
global _start

_start:
	mov ecx, tit
	call mst_saida
	mov ecx, opc1
	call mst_saida
	mov ecx, opc2
	call mst_saida
	mov ecx, opc3
	call mst_saida
	mov ecx, opc4
	call mst_saida

	mov ecx, msgOpc 
	call mst_saida
	mov eax, SYS_READ
	mov ebx, STD_IN
	mov ecx, opc
	mov edx, 0x2
	int SYS_CALL
	mov ah, [opc]
	sub ah, "0"

	cmp ah, 4
	jg msterro

	cmp ah, 1
	jl msterro

	mov ecx, obVal1
	call mst_saida
	mov eax, SYS_READ
	mov ebx, STD_IN
	mov ecx, num1
	mov edx, 0x3
	int SYS_CALL

	mov ecx, obVal2
	call mst_saida
	mov eax, SYS_READ
	mov ebx, STD_IN
	mov ecx, num2
	mov edx, 0x3
	int SYS_CALL

	mov ah, [opc]
	sub ah, "0"

	cmp ah, 1
	je adicionar
	cmp ah, 2
	je subtrair
	cmp ah, 3
	je multiplicar
	je dividir

saida:
	mov ecx, msgfim
	call mst_saida
	mov eax, SYS_EXIT
	mov ebx, RET_EXIT
	int SYS_CALL

adicionar:
	mov ecx, p1
	call mst_saida
	call string_to_int
	add ecx, ebx
	call mst_saida
	jmp saida

subtrair:
	mov ecx, p2
	call mst_saida
	call string_to_int
	sub ecx, ebx
	call mst_saida
	jmp saida

multiplicar:
	mov ecx, p3
	call mst_saida
	call string_to_int
	imul ecx, ebx
	call mst_saida
	jmp saida

dividir:
	mov ecx, p4
	call mst_saida
	call string_to_int
	idiv ebx
	mov ecx, eax
	call mst_saida
	jmp saida

msterro:
	mov ecx, msgErro
	call mst_saida
	jmp saida

string_to_int:
	mov ecx, [num1]
	mov ebx, [num2]
	sub ecx, "0"
	sub ebx, "0"
	ret
