INCLUDE Irvine32.inc

.data
	arr1 dd 3, 4, 55, 46, 73, 81, 9, 10   
	num1 dd ($ - arr1) / 4
	arr2 dd 3, 4, 234, 246, 73, 81, 49, 10, 21, 12
	num2 dd ($ - arr2) / 4
	arr3 dd 3, 4, 55, 46, 273, 381, 9, 110, 123, 123, 1244, 2432
	num3 dd ($ - arr3) / 4
	max dd -3F3F3F3Fh                          
	i dd 0d
	position1 dd ?
	position2 dd ?
	position3 dd ?
	
.code										  									
main PROC			

	mov edx, offset arr1		;函数的参数通过寄存器进入
	mov ebx, num1
	call maxi
	
	mov edx, offset arr2
	mov ebx, num2
	call maxi
	
	mov edx, offset arr3
	mov ebx, num3
	call maxi
	
	exit
main ENDP

maxi proc
	mov eax, dword ptr[edx]
	mov esi, 0
	mov ecx, 0
	
again:
	cmp ecx, ebx				;无符号数比较jb,je,ja
	jae final
	cmp eax, [edx + ecx * 4]	;有符号数比较jl,je,jg
	jge next
	mov eax, [edx + ecx * 4]
	mov esi, ecx
	
next:
	add ecx, 1
	jmp again

final:
	call writeint
	call crlf
	add esi, 1
	mov position1, esi
	mov eax, position1
	call writeint
	call crlf
	ret
maxi endp

END main


