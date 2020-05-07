;bubblesort
include irvine32.inc
.data
	arr dd 1, 3, 5, 7, 9, 2, 4, 6, 8, 0
	num dd ($ - arr) / 4
.code
main proc
	lea edx, arr
	mov ecx, num
	call bubblesort
	mov ebx, num
	call print_arr
	exit
main endp
bubblesort proc
;edx:arr
;ecx:num-1
;edi:n-i-1
;eax:j
;esi:i
;edi:n-i-1
;receive:edx 数组地址
;		 ecx 数组元素
;return:nothing
	pushad
	dec ecx
	mov esi, 0
again:
	cmp esi, ecx								;外层循环，到final
	jae final

	mov eax, 0
	mov edi, ecx
	sub edi, esi								;内层循环的准备工作
	
next:											;内层循环，到final_2
	cmp eax, edi							
	jae final_2
	mov ebx, [edx + 4 * eax]
	cmp ebx, [edx + 4 * eax + 4]
	jle next_2
	push esi									;没有寄存器用，只能临时放进栈中保存
	mov esi, [edx + 4 * eax + 4]
	mov [edx + 4 * eax + 4], ebx
	mov [edx + 4 * eax], esi
	pop esi										;恢复临时使用寄存器的值
	
next_2:
	inc eax
	jmp next
	
final_2:
	inc esi
	jmp again
final:
	
	
	popad
	ret
	
bubblesort endp

print_arr proc
;num需要外面传进来给ecx
;数组地址也同样需要外面传进来给edx
	pushad
	mov esi, 0
	
again:	
	
	mov eax, [edx + esi * 4]
	call writeint
	mov al, ','
	call writechar
	
	inc esi
	loop again
	
	popad
	ret
print_arr endp

end main

