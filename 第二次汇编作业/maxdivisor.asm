INCLUDE Irvine32.inc

.data
	m dd 16
	n dd 32
	r dd ?
.code
main PROC
	mov eax, m
	mov ebx, n
	call maxdivisor
	call writeint
	exit
main ENDP

;*********************************************
;计算两个数的最大公约数
;receive: eax, ebx
;return: rax is the greatest divisor
;*********************************************
maxdivisor proc
	push ebx
	push ecx
	push edx
	push edi
	push esi
	mov edx, 0
	
again:
	mov edx, 0
	div ebx
	cmp edx, 0
	jz final
	mov ebx, edx
	mov eax, ebx
	mov edx, 0
	jmp again
	
final:
	mov eax, ebx
	pop esi
	pop edi
	pop edx
	pop ecx
	pop ebx
	ret
maxdivisor endp

END main
