segment .data
	LF equ 0xA ; Line Feed
	NULL equ 0x0 ; Final da String
	SYS_EXIT equ 0x1 ; Codigo de chamada para finalizar
	RET_EXIT equ 0x0 ; Operacao com Sucesso
	STD_IN equ 0x0 ; Entrada padrao
	STD_OUT	equ 0x1 ; Saida padrao
	SYS_READ equ 0x3 ; Operacao de Leitura
	SYS_WRITE equ 0x4 ; Operacao de Escrita
	SYS_CALL equ 0x80 ; Envia informacao ao SO
	TAM_BUFFER equ 0xA ; Tamanho do buffer e 10

segment .bss
	BUFFER resb 0x1	;Reserva um byte para o buffer

segment .text
	
saidaResultado:
	mov eax, SYS_WRITE
	mov ebx, STD_OUT
	mov ecx, BUFFER	
	mov edx, TAM_BUFFER
	int SYS_CALL
	ret

; ----------------------------------
; Calcular o tamanho da String
; ---------------------------------
; Entrada: valor String em ECX
; Saida : tamanho da String em EDX
; --------------------------------

tamStr:
	mov edx, ecx ; Move o conteudo de ecx para edx
proxchar:
	cmp byte[edx], NULL ; Compara o caractere se ele e NULL
	jz terminei ; Se for igual salta para a label terminei
	inc edx ; incrementa o edx
	jmp proxchar ; salta e agora ira para o proximo caractere
terminei:
	sub edx, ecx
	ret

mst_saida:
	call tamStr
	mov eax, SYS_WRITE
	mov ebx, STD_OUT
	int SYS_CALL
	ret
