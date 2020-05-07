
INCLUDE Irvine32.inc
.data
	arr dd -3, 4, 55, 46, 73, 81, 9, 10   
	num dd ($ - arr) / 4             
	
.code										  									
main PROC			
	lea edx, arr
	mov ecx, num
	call insertsort
	mov ebx, num
	call print_arr
	exit
main ENDP

insertsort proc
;edx:arr
;ecx:num
;eax:i
;ebx:a[i]
;esi:j
;edi:x
	pushad
	mov eax, 1
	
again:
	cmp eax, ecx						;外层循环，到final_1
	jae final_1	
	mov ebx, [edx + 4 * eax]
	cmp ebx, [edx + 4 * eax - 4]		;if循环，到final_2
	jge final_2
	mov esi, eax
	dec esi
	mov edi, [edx + eax * 4]
	push eax
	mov eax, [edx + 4 * eax - 4]
	mov [edx + 4 * eax], eax
	pop eax
	
again_2:
	cmp edi, [edx + esi * 4]			;while循环，到final
	jge final
	push eax
	mov eax, [edx + esi * 4]
	mov [edx + esi * 4 + 4], eax
	pop eax
	dec esi
	jmp again_2
	
final:
	mov [edx + 4 * esi + 4], edi
final_2:
	inc eax
	jmp again
final_1:
	popad
	ret
insertsort endp




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


END main


