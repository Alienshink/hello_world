
INCLUDE Irvine32.inc

.data
	a dd ?
	b dd ?
	t dd ?
	optype dd ?
	msg1 db "1)�ӷ�", 0
	msg2 db "2)����", 0
	msg3 db "3)�˷�", 0
	msg4 db "4)����", 0
	msg5 db "��������������(1-4): ", 0
	msg6 db "�������һ������: ", 0
	msg7 db "�����������������: ", 0
	msg8 db "��������", 0
	msg9 db "�����������: ", 0
	msg dd offset msg1, msg2, msg3, msg4, msg5
	msg10 db "���������������������q/Q������", 0
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
	jmp ecx						;���õ�ַʵ����ת�������֧�ṹ
	
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
	div  b							;���������֮��eax�����̣�edx����������Ҫ������������ſ����ٴ�ʹ��
	call writeint					;�����������Ĵ�������ֵ�����ʹ�õ�Ϊebx�����м�����edxҪ����ַ���ʹ��
	call crlf
	mov ebx, edx
	mov edx, offset msg9
	call writestring
	call crlf
	mov eax, ebx					;ebx����������
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
;�������a��b�����Ͷ������ڴ���
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

