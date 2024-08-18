%include  "bibliotecaE.inc" ;Inclusao da biblioteca

section .data
	vl dw "110", 0xa ;Define uma double word para o valor em string 105

section .text
global _start

_start:
	call converter_valor ; Chama a função converter valor
	call mostrar_valor ; Move o valor
	mov eax, SYS_EXIT ; Encerra o programa
	mov ebx, RET_EXIT ; Retorna o código 0
	int SYS_CALL ; Envia para o SO 

converter_valor:
	lea esi, [vl] ; Move o valor 105 para vl
	mov ecx, 0x3 ; Move o tamanho 3
	call string_to_int ; Chama a funcao string_to_int
	add eax, 0x2 ; adiciona 2 apenas para fins de teste
	ret ; volta ao fluxo do programa

mostrar_valor:
	call int_to_string ; Chama a funcao int_to_string
	call saidaResultado ; Chama a saida do resultado
	ret ; volta ao fluxo do programa

string_to_int:
	xor ebx, ebx ; Zera o registrador ebx

.prox_digito:
	movzx eax, byte[esi] ; Move com os bits superiores preenchidos para eax o que esta em esi
	inc esi ; incrementa esi
	sub al, "0" ; Converte o caractere em AL, iso corresponde entre um numero de 0 a 9
	imul ebx, 0xa ; Multiplica o que está em ebx por 10
	add ebx, eax ; Adiciona o que há em eax para ebx
	loop .prox_digito ; Salta para o proximo caractere
	mov eax, ebx ; move o que esta em ebx para eax
	ret ; Volta ao fluxo do programa

int_to_string:
	lea esi, [BUFFER] ;Associa o valor de esi ao buffer
	add esi, 0x9 ; Adiciona 9 ao registrador esi
	mov byte[esi], 0xa ; Adiciona um Line Feed no final do registrador
	mov ebx, 0xa ; Move 10 ao ebx

.prox_digito:
	xor edx, edx ; Zera o edx
	div ebx ; Dividimos ebx por edx
	add dl, "0" ; Transforma o caractere correspondete na tabela ASCII
	dec esi ; Decrementa o registrador esi
	mov [esi], dl
	test eax, eax
	jnz .prox_digito
	ret
