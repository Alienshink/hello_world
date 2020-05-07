 
INCLUDE Irvine32.inc

.data
	arr dd 49, 38, 65, 67, 762, 816, 983, 11
	num dd ($ - arr) / 4                      
	msg1 db "初始值：", 0dh, 0ah, 0
	msg2 db "结果：", 0dh, 0ah, 0
.code										  									
main PROC				
	mov edx, offset msg1
	call writestring
	
	mov edx, offset arr
	mov ecx, num
	call print_arr
	
	mov edx, offset arr
	mov esi, 0
	mov edi, 7
	call quicksort
	
	mov edx, offset msg2
	call writestring
	
	mov ecx, num
	mov edx, offset arr
	call print_arr
	
	
	exit
main ENDP

quicksort proc
;edx:address of array
;eax:privotloc
;esi:low
;edi:high
;return:nothing
	push esi
	push edi
	push edx
	push eax
	
	cmp esi, edi
	jge final
	call partition
	
	push edi
	mov edi, eax
	dec edi
	call quicksort
	
	pop edi
	mov esi, eax
	inc esi
	call quicksort
	
final:
	pop  eax
	pop  edx
	pop  edi
	pop  esi
	ret 
quicksort endp

partition proc						 ;无问题
;edx:address of array
;esi:low
;edi:high
;ebx:privotkey
;return:eax:low
	push ebx
	push ecx
	push edx
	push esi
	push edi
	
	mov ebx, [edx + esi * 4] 
again:
	cmp esi, edi				;while(low < high),again到final
	jae final

again_1:
	cmp esi, edi				;while 中的一个判断
	jae next_1				
	cmp [edx + edi * 4], ebx	;第二个判断
	jl next_1
	dec edi
	jmp again_1
	
next_1:

	push ebx					;swap
	push eax
	mov eax, [edx + esi * 4]
	mov ebx, [edx + edi * 4]
	mov [edx + esi * 4], ebx
	mov [edx + edi * 4], eax
	pop eax
	pop ebx
	
again_2:
	cmp esi, edi
	jae next_2
	cmp [edx + esi * 4], ebx
	jg next_2
	inc esi
	jmp again_2
	
next_2:
	push ebx					;swap
	push eax
	mov eax, [edx + esi * 4]
	mov ebx, [edx + edi * 4]
	mov [edx + esi * 4], ebx
	mov [edx + edi * 4], eax
	pop eax
	pop ebx

	jmp again
final:

	mov eax, esi
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	
	ret
partition endp


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
	call crlf
	popad
	ret
print_arr endp

END main



