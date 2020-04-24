INCLUDE Irvine32.inc
;������û���üĴ������غ�����Ҫ���ص�ֵ�����������棬����Ϊ��������Ĵ����ַ������ǵ�ǰ׺���ʽ�������ֵ�о����ò���һЩ
.data
	val db 100 dup(?)
	data1 DD 2 dup(?)
	optype dd 4 dup(?)
	msg7 db "������һ�����ʽ����ֻ���������ֺ�һ���������", 0
	msg8 db "����Ľ��Ϊ��", 0
	msg9 db "�����������: ", 0
	msg10 db "��������־��", 0
	opnum dd 0													;Ϊ�����������в������ĸ���
																;�Ժ���Դ���������ַ�����׼��
	
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
	jmp ecx						;���õ�ַʵ����ת�������֧�ṹ
	
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
	div  data1[4]					;���������֮��eax�����̣�edx����������Ҫ������������ſ����ٴ�ʹ��
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
	exit
	arrop dd offset addop, subop, mulop, divop
	exit
main ENDP

;***********************************************
;��ȡ�ַ����������ֲ�תΪ���֣���������������
;recevice:esiΪ��ʼ��ַ 
;return:  ���ݴ�����eax�з���
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
;ֻ��Ҫ��ƫ��λ�ø�eax���Ϳ����ж����λ����ʲô������		
;��������������1��2��3��4��Ӧ�Ӽ��˳�������optype������	
;��opnum������optype����Ĳ���������
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
