segment .data
	LF equ 0xA        ; Line Feed
	NULL equ 0xD      ; Final da String
	SYS_EXIT equ 0x1  ; Codigo de chamada para finalizar
	RET_EXIT equ 0x0  ; Operacao com Sucesso
	STD_IN equ 0x0    ; Entrada padrao
	STD_OUT equ 0x1   ; Saida padrao
	SYS_READ equ 0x3  ; Operacao de Leitura
	SYS_WRITE equ 0x4 ; Operacao de Escrita
	SYS_CALL equ 0x80 ; Envia informacao ao SO

section .data
	x dd 100
	y dd 50
	msg1 db "X maior que Y", LF, NULL
	tam1 equ $ - msg1
	msg2 db "Y maior que X", LF, NULL
	tam2 equ $ - msg2

section .text

global _start

_start:
	mov eax, DWORD [x] ; Conversão relativa da double word
	mov ebx, DWORD [y] ; Conversão relativa da double word
	cmp eax, ebx	   ; Compara os registrador
	jge _maior	   ; Salta para a etiqueta  _maior se for maior ou igual
	mov ecx, msg2	   ; Move a msg2 para o ecx
	mov edx, tam2	   ; Move tam2 para o edx
	jmp _final	   ; Salto incondicional para a etiqueta _final
_maior:
	mov ecx, msg1	   ; Move o que está na msg1 para o registrador
	mov edx, tam1	   ; Move o tam1 para edx
_final:
	mov eax, SYS_WRITE ; Modo de escrita
	mov ebx, STD_OUT   ; Saida padrao
	int SYS_CALL	   ; Envia para o SO

	mov eax, SYS_EXIT  ; Saida
	mov ebx, RET_EXIT  ; Saida
	int SYS_CALL       ; Envia para o SO
