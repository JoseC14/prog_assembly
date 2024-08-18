section .data
	msg db 'Hello World!', 0xA  ; Define 1 byte para a messagem hello world!
	tam equ $- msg  ; Calcula o tamanho da msg


section .text ; Seção do programa

global _start

; Marcador inicial
_start:
	mov eax, 0x04 ; Informa que é uma operação de saída
	mov ebx, 0x01 ; Informa onde essa operação sera feita no caso, no terminal
	mov ecx, msg  ; Conteúdo da saída
	mov edx, tam  ; Quantidade de caracteres
	int 0x80      ; Envia a informação ao sistema operacional

saida:
	mov eax, 0x1 ; Informa que terminamos as operações
	mov ebx, 0x0 ; Retorna código 0 ou seja que tudo ocorreu bem
	int 0x80 ; envia a informação ao sistema operacional
