;��������
include irvine32.inc
.data
    num  dd 1    ;ԭ��
    fir  dd 1    ;fir=1��ʾ��һ��
    p    dd 2    ;����
    e    dd ?    ;ָ��   
    msg  db "������һ����������", 0Dh, 0Ah, 0;
.code
main proc
	mov edx, offset msg;
	call writestring;
    call readint   
    mov  num,eax     ;eax���ԭ����ֵ,numΪҪ�ֽ����
    mov  ebx,p       ;ebx��ŵ�ǰ������p
    mov  ecx,fir     ;ecx��ŵ�һ��ı�ֵfie=1Ϊ��һ����򲻻��һ��
;for(p=2;p<=a;p++)
again:
    cmp ebx,num      ;p<=a
    ja final         ;p>a�ͽ���ѭ��
    call findpnum    ;������������
    inc ebx
    mov p,ebx
    jmp again;
final: 
	
    exit
main endp

findpnum proc

	mov edx, 0		  ;
    mov esi, 0        ;esi���ָ��e��ֵ
    mov eax, num;
    div ebx
    cmp edx,0
    jnz next         ;N%i!=0ֱ����������Ĳ���
    mov eax, num	 ;û�еĻ��ͱ������
    call find_e      ;��ָ��
    mov esi,eax      ;����ָ��������eax�Ż�esi��
    mov eax,num      ;��numֵ����eax
next:
    cmp esi,0
    jz final
    cmp ecx,0        
    jz L1
    call output
    jmp final;
L1:
    mov ecx,0
    mov al,'*';
    call writechar;
    call output;
final:
	
    ret
findpnum endp

find_e proc
    ;push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
again:;
	mov edx, 0
    div p
    cmp edx,0
    jnz final
    mov num,eax
    inc esi
    jmp again;

 final:
	mov eax,esi
    pop  edi
    pop  esi
    pop  edx
    pop  ecx
    pop  ebx
    ;pop  eax

    ret
find_e endp
 
output proc
    push eax
    push ebx
;    push ecx
    push edx
    push esi
    push edi
	mov ecx, 0;
;    mov al,'*'
;    call writechar
    mov eax,ebx
;    call writeint
	call writedec
    mov al,'^'
    call writechar
    mov eax,esi
;    call writeint
	call writedec

    pop  edi
    pop  esi
    pop  edx
;   pop  ecx
    pop  ebx
    pop  eax
         ret
output endp

end main

again:
	cmp **, **
	jz final
	**
	**
	cmp **, **
	ja next
	**
	
next:
	**
	jmp again
	
final:
