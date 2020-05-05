INCLUDE Irvine32.inc

.data
	number dd 6
.code										  									
main PROC
	mov ecx, 0
again:
	cmp ecx, 4
	jae final
	mov ebx, number
	call sum_factor
	cmp eax, number
	jnz next
	inc ecx
	call writedec
	call crlf
next:
	inc number
	jmp again
final:

	exit
main ENDP	

sum_factor proc
;****************************************
;计算一个数所有因数（除本身）之和
;ebx传进数
;eax传出所有因数之和
;****************************************
	push ecx
	push edx
	push esi
	push edi
	
	mov ecx, 2
	mov edi, 1
	
again:
	cmp ecx, ebx
	jae final
	mov edx, 0
	mov eax, ebx
	div ecx
	cmp edx, 0
	jnz process
	add edi, ecx
process:
	inc ecx
	jmp again
	
final:
	mov eax, edi
		
	pop edi
	pop esi
	pop edx
	pop ecx
	ret
sum_factor endp

END main

