INCLUDE Irvine32.inc
;���ڵĺ����ڿ�ʼ��λ��д��Ҫʲô�����������������ĸ��Ĵ���
;ÿ���������üĴ�����ʱ��Ҫ�ǵ����¸�ֵ���������
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
	mov edx, offset arr		;�����Ĳ���ͨ���Ĵ�������
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
;esi����Ϊ��������±�
;ebx����Ϊѭ���Ĵ���
	mov eax, dword ptr[edx]
	mov esi, 0
	mov ecx, 0
	
again:
	cmp ecx, ebx				;�޷������Ƚ�jb,je,ja
	jae final
	cmp eax, [edx + ecx * 4]	;�з������Ƚ�jl,je,jg
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
;num��Ҫ���洫������ecx
;�����ַҲͬ����Ҫ���洫������edx
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


