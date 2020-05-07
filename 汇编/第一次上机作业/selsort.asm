INCLUDE Irvine32.inc
;现在的函数在开始的位置写出要什么东西传过来，传给哪个寄存器
;每次在外面用寄存器的时候要记得重新赋值，以免错误
.data
	arr dd 3, 4, 55, 46, 73, 81, 9, 10   
	num dd ($ - arr) / 4             
	i dd 0d
	tlast dd ?
	position dd ?
	
.code										  									
main PROC			
	mov ebx, num
	mov edx, offset arr
	call print_arr
	call crlf
	mov eax, num
	mov tlast, eax
	mov edx, offset arr		;函数的参数通过寄存器进入
again:
	cmp tlast, 2
	jl final
	mov ebx, tlast
	call maxi
	mov edi, tlast
	mov eax, arr[4 * edi - 4]
	mov ecx, arr[4 * esi]
	mov arr[4 * edi - 4], ecx
	mov arr[4 * esi], eax
	sub tlast, 1
	jmp again
final:
	mov ebx, num
	mov edx, offset arr
	call print_arr
	exit
main ENDP

maxi proc
;esi保存为最大数的下标
;ebx保存为循环的次数
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
	ret
maxi endp

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


