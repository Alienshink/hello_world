
INCLUDE Irvine32.inc
;��������������ֽ�ʽ
.data
	number dd 9
	prime dd 2
	flag dd 1
	e dd ?
	msg1 db "������һ����������", 0Dh, 0Ah, 0
.code
main PROC 	
	lea edx, msg1
	call writestring
	call readint
	
	mov number, eax
	mov ebx, prime
	lea esi, number
	
again:
	cmp ebx, number
	ja final
	call find_e
	cmp eax, 0
	jz next
	mov e, eax
	cmp flag, 0
	jz display
	
return_back:
	mov eax, ebx
	call writedec
	mov al, '^'
	call writechar
	mov eax, e
	call writedec
	call next_prime
	mov ebx, eax
	mov flag, 0
	jmp again

next:	
	call next_prime
	mov ebx, eax
	jmp again
	
display:
	mov al, '*'
	call writechar
	jmp return_back
	
final:
	
	exit
main ENDP
find_e proc
;************************
;Ѱ��������������ָ��
;û��eax����0
;prime��ebx
;number�ĵ�ַ��esi
;ָ��ͨ��eax����
;************************
	push ecx
	push edx
	push esi
	push edi
	push ebx
	
	mov ecx, 0
	mov eax, dword ptr[esi]
	
again:	
	mov edx, 0
	div ebx
	cmp edx, 0
	jnz final
	inc ecx
	mov dword ptr[esi], eax
	jmp again
	
final:
	mov eax, ecx
	pop ebx
	pop edi
	pop esi
	pop edx
	pop ecx
	ret
find_e endp

next_prime proc
;****************************
;Ѱ����һ������
;ebx�ǽ���������
;eax����һ������
;****************************
	push ecx
	push edx
	push esi
	push edi
	mov esi, 2
	mov ecx, ebx
	inc ecx
	
again:
	cmp esi, ecx
	jae final
	mov edx, 0
	mov eax, ecx
	div esi
	cmp edx, 0
	jnz next
	inc ecx
	mov esi, 2
next:
	inc esi
	jmp again
	
final:
	mov eax, ecx
	pop edi
	pop esi
	pop edx
	pop ecx
	ret
next_prime endp

END main
