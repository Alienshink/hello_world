
INCLUDE Irvine32.inc

.data
	a dd ?
	b dd ?
	t dd ?
	optype dd ?
	msg1 db "1)加法", 0
	msg2 db "2)减法", 0
	msg3 db "3)乘法", 0
	msg4 db "4)除法", 0
	msg5 db "请输入运算类型(1-4): ", 0
	msg6 db "请输入第一个整数: ", 0
	msg7 db "请输入第整二个整数: ", 0
	msg8 db "运算结果：", 0
	msg9 db "运算的余数是: ", 0
	msg dd offset msg1, msg2, msg3, msg4, msg5
	msg10 db "请输入任意键继续（输入q/Q结束）", 0
	chartype db ?
	
.code										  									
main PROC	
again:	
	call clrscr
	call displaymenu
	call input
	mov ecx, offset addop
	dec optype
	mov ebx, 18
	mov eax, optype
	mul ebx
	add ecx, eax
	jmp ecx						;利用地址实现跳转，无需分支结构
	
addop:
	mov eax, a
	add eax, b
	call writeint
	jmp final
	
subop:
	mov eax, a
	sub eax, b
	call writeint
	jmp final
	
mulop:
	mov eax, a
	mul  b
	call writeint
	jmp final
	
divop:
	mov edx, 0
	mov eax, a
	div  b							;进行完除法之后，eax保存商，edx保存余数，要等这两个用完才可以再次使用
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
	call crlf
	mov edx, offset msg10
	call writestring
	call readchar
	cmp al, 'q'
	jz final_2
	cmp al, 'Q'
	jz final_2
	jmp again
final_2:
	exit
main ENDP

displaymenu proc
	mov ecx, 0
again:
	cmp ecx, 5
	jae final 
	mov edx, msg[ecx * 4]
	call writestring
	call crlf
	inc ecx
	jmp again
final:
	ret
displaymenu endp

input proc
;把运算的a，b和类型都放在内存中
	call readint
	mov optype, eax
	call readint
	mov a, eax
	call readint
	mov b, eax
	mov edx, offset msg8
	call writeString
	call crlf
	ret
input endp

END main

