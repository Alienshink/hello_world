INCLUDE Irvine32.inc
;本代码没有用寄存器返回函数需要返回的值，而是用主存，是因为后面更长的处理字符串考虑到前缀表达式用主存的值感觉更好操作一些
.data
	val db 100 dup(?)
	data1 DD 2 dup(?)
	optype dd 4 dup(?)
	msg7 db "请输入一个表达式：（只有两个数字和一个运算符）", 0
	msg8 db "运算的结果为：", 0
	msg9 db "运算的余数是: ", 0
	msg10 db "操作符标志：", 0
	opnum dd 0													;为操作符数组中操作符的个数
																;以后可以处理更长的字符串做准备
	
.code
main PROC 				
			
	call clrscr
	mov edx, offset msg7
	call writestring
	call crlf

	mov edx, offset val
	mov ecx, 100
	call readstring

	mov esi, offset val
	mov eax, 0
	call extractnum
	mov data1, eax
	mov eax, esi
	sub eax, 00404000h
	call opsign
	inc esi
	call extractnum
	mov data1[4], eax
	
	dec optype
	mov eax, optype
	mov ecx, arrop[eax * 4]
	mov edx, offset msg8
	call writestring
	jmp ecx						;利用地址实现跳转，无需分支结构
	
addop:
	mov eax, data1
	add eax, data1[4]
	call writeint
	jmp final
	
subop:
	mov eax, data1
	sub eax, data1[4]
	call writeint
	jmp final
	
mulop:
	mov eax, data1
	mul  data1[4]
	call writeint
	jmp final
	
divop:
	mov edx, 0
	mov eax, data1
	div  data1[4]					;进行完除法之后，eax保存商，edx保存余数，要等这两个用完才可以再次使用
	call writeint					;或者用其他寄存器保存值，这边使用的为ebx保存中间结果，edx要输出字符串使用
	call crlf
	mov ebx, edx
	mov edx, offset msg9
	call writestring
	call crlf
	mov eax, ebx					;ebx保存着余数
	call writeint
	jmp final
	
final:
	exit
	arrop dd offset addop, subop, mulop, divop
	exit
main ENDP

;***********************************************
;提取字符串连续数字并转为数字（适用于正整数）
;recevice:esi为开始地址 
;return:  数据储存在eax中返回
;***********************************************
extractnum proc
.data
	base dd 10
	
.code
		push ecx
		push edx
		push edi
		push ebx
		mov eax, 0
again:
	cmp byte ptr[esi], '0'
	jb final
	cmp byte ptr[esi], '9'
	ja final 
	mov ebx, 0
	mov bl, [esi]
	sub bl, '0'
	mul base
	add eax, ebx
	inc esi
	jmp again
	
final:		
	pop ebx
	pop edi
	pop edx
	pop ecx
	ret
extractnum endp

opsign proc					
;只需要把偏移位置给eax，就可以判断这个位置是什么操作符		
;操作符后面是用1，2，3，4对应加减乘除储存在optype数组中	
;用opnum储存了optype数组的操作符个数
	push eax
	push edx
	push esi
	mov esi, opnum
	cmp val[eax], '+'
	jz process_1
	cmp val[eax], '-'
	jz process_2
	cmp val[eax], '*'
	jz process_3
	cmp val[eax], '/'
	jz process_4
	jmp final
process_1:
	mov edx, 1
	mov optype[esi * 4], edx
	jmp final
process_2:
	mov edx, 2
	mov optype[esi * 4], edx
	jmp final
process_3:
	mov edx, 3
	mov optype[esi * 4], edx
	jmp final
process_4:
	mov edx, 4
	mov optype[esi * 4], edx
	jmp final
final:
	inc opnum
	mov edx, offset msg10
	call writestring
	mov eax, optype
	call writeint
	call crlf
	pop esi
	pop edx
	pop eax
	ret
opsign endp

END main
