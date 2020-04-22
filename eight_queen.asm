INCLUDE Irvine32.inc

.data      
	chess dd 64 dup(0)             
	arr1 dd 8 dup(1)
	arr2 dd 15 dup(1)
	arr3 dd 15 dup(1)
	sum  dd 0
	msg1 db "八皇后摆法总数：", 0
	arr dd offset arr1, arr2, arr3	;地址数组
	
.code								  									
main PROC
	mov esi, offset arr
	mov edi, offset chess
	mov eax, 0
	call putqueen

	mov edx, offset msg1
	call writestring
	mov eax, sum
	call writedec
	call crlf
	
	exit
main ENDP
putqueen proc
;edi:chess address
;esi:arr of arr1, arr2, arr3 address
;eax:n
;ebx:col	
;edx:arr address
;return:nothing
	push edi
	push esi
	push ecx
	push ebx
	push edx
	mov ebx, 0
again:
	cmp ebx, 8				;外层循环
	jae final_outer
	mov edx, [esi]
	mov ecx, [edx + ebx * 4]				
	cmp ecx, 0
	je L1									;a[col]是否是1
	mov edx, [esi + 4]
	push ebx
	add ebx, eax
	mov ecx, [edx + ebx * 4]	
	pop ebx										
	cmp ecx, 0
	je L1									;b[n+col]是否是1
	mov edx, [esi + 8]
	push eax
	sub eax, ebx
	mov ecx, [edx + eax * 4 + 28]			
	pop  eax
	cmp ecx, 0
	je L1									;c[n-col+7]是否是1
	mov ecx, 0
	call change_arr							;对a,b,c数组对应位置赋ecx
	mov ecx, 1
	call change_chess						;chess[n][col]=ecx
	
	cmp eax, 7								;if(n==7)
	jne next
	
	inc sum
	mov ecx,sum
	mov edx, edi
	call print_chess						;print_chess(chess[],sum)
	call crlf
	mov ecx, sum
	call suspend							;suspend=sum%10==0
	
next:										;else部分
	push eax
	inc eax
	call putqueen
	pop eax
	mov ecx, 1
	call change_arr								;对a,b,c数组对应位置赋ecx
	mov ecx, 0
	call change_chess							;chess[n][col]=0
	
L1:
	inc ebx
	jmp again				;ebx
final_outer:
	pop edx
	pop ebx
	pop ecx
	pop esi
	pop edi
	ret
putqueen endp

change_arr proc
;ecx:1/0
	pushad
	mov edx, [esi]
	mov [edx + ebx * 4], ecx					;a[col]=ecx
	mov edx, [esi + 4]
	mov edi, eax
	add edi, ebx
	mov [edx + edi * 4], ecx					;b[n+col]=ecx
	mov edx, [esi + 8]
	mov edi, eax
	sub edi, ebx
	mov [edx + edi * 4 + 28], ecx				;c[n-col+7]=ecx
	popad
	ret
change_arr endp

change_chess proc
;ecx:1/0
	pushad
	mov esi, 8
	mul esi
	add eax, ebx
	mov [edi + eax * 4], ecx					;chess[n][col]=ecx
	popad
	ret
change_chess endp

print_chess proc
;数组地址需要外面传进来给edx
;ecx:sum
;return:nothing
.data
	message1 db "第", 0
	message2 db "种可能的摆法：", 0DH, 0AH, 0
.code
	pushad 
	push edx
	mov edx, offset message1
	call writestring
	mov eax, ecx
	call writedec
	mov edx, offset message2
	call writestring
	pop edx
	mov ecx, 0
again_outer:
	cmp ecx, 8		;外层循环
	jae final_outer
	mov ebx, 0
again_inter:
	cmp ebx, 8		;内层循环
	jae final_inter
	push edx
	mov edx, 0
	mov eax, ecx
	mov edi, 8
	mul edi			;乘以行的列总数
	mov esi, eax
	add esi, ebx
	pop edx
	mov eax, [edx + esi * 4]
	call writedec
	mov al, ' '
	call writechar
	inc ebx
	jmp again_inter	;ebx	
final_inter:		;内层循环结束
	call crlf
	
	inc ecx
	jmp again_outer	;ecx

final_outer:		;外层循环结束
	popad
	ret
print_chess endp

suspend proc
;ecx:sum
.data
	message3 db "输入任意键继续...", 0AH, 0DH, 0
.code
	pushad
	mov eax, ecx
	mov edx, 0
	mov ebx, 10
	div ebx
	cmp edx, 0
	jne next
	mov edx, offset message3
	call writestring
	call readchar
next:	
	popad
	ret
suspend endp

END main
