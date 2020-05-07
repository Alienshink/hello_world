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
	mov ecx, num
	call heapsort
	
	mov edx, offset msg2
	call writestring
	
	mov ecx, num
	mov edx, offset arr
	call print_arr
	
	exit
main ENDP

heapsort proc
;edx:array address
;ecx:length
;eax:i
	pushad
	call buildheap
	mov eax, ecx
	dec eax
	
again:
	cmp eax, 0
	jle final
	mov esi, [edx + eax * 4]
	mov edi, [edx]
	mov [edx], esi
	mov [edx + eax * 4], edi
	mov ebx, 0								;heapadjust(edx, ebx, ecx) 
	mov ecx, eax
	call heapadjust
	dec eax
	jmp again
final:
		
	popad
	ret
heapsort endp

buildheap proc
.data
	two dd 2
.code
;ecx:length
;edx:array address
;eax:i
	pushad
	mov esi, edx
	mov eax, ecx
	dec eax
	mov edx, 0
	div two
	
again:
	cmp eax, 0
	jl final
	mov edx, esi
	mov ebx, eax
	call heapadjust
	
	dec eax
	jmp again
final:
	popad
	ret
buildheap endp

heapadjust proc 						;headadjust(edx, ebx, ecx)
;edx:array address
;ecx:length
;ebx:s
;eax:tmp
;edi:child
	pushad
	mov eax, [edx + ebx * 4]
	mov edi, ebx
	add edi, ebx
	add edi, 1
	
again:
	cmp edi, ecx
	jge final
	mov esi, edi			
	inc esi
	push eax
	cmp esi, ecx							;第一个if语句
	jge next_1								;第一个if条件
	
	mov eax, [edx + edi * 4]
	cmp eax, [edx + esi * 4]				;第二个条件
	jge next_1
	inc edi
	
next_1:
	pop eax
	mov esi, [edx + ebx * 4]
	cmp esi, [edx + edi * 4]				;第二个if
	jge next_2
	mov esi, [edx + edi * 4]
	mov [edx + ebx * 4], esi
	mov esi, edi
	mov ebx, esi
	mov edi, ebx
	add edi, edi
	inc edi
	 jmp L1						
next_2:
	jmp final								;break语句
L1:								
	mov esi, eax
	mov [edx + ebx * 4], esi
	jmp again
final:

	call print_arr
	popad
	ret
heapadjust endp

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
