;求素因数
include irvine32.inc
.data
    num  dd 1    ;原数
    fir  dd 1    ;fir=1表示第一项
    p    dd 2    ;素数
    e    dd ?    ;指数   
    msg  db "请输入一个正整数：", 0Dh, 0Ah, 0;
.code
main proc
	mov edx, offset msg;
	call writestring;
    call readint   
    mov  num,eax     ;eax存放原数的值,num为要分解的数
    mov  ebx,p       ;ebx存放当前的素数p
    mov  ecx,fir     ;ecx存放第一项的标值fie=1为第一项，否则不会第一项
;for(p=2;p<=a;p++)
again:
    cmp ebx,num      ;p<=a
    ja final         ;p>a就结束循环
    call findpnum    ;调用求素因子
    inc ebx
    mov p,ebx
    jmp again;
final: 
	
    exit
main endp

findpnum proc

	mov edx, 0		  ;
    mov esi, 0        ;esi存放指数e的值
    mov eax, num;
    div ebx
    cmp edx,0
    jnz next         ;N%i!=0直接跳到后面的操作
    mov eax, num	 ;没有的话就变成商了
    call find_e      ;求指数
    mov esi,eax      ;将求指数函数的eax放回esi中
    mov eax,num      ;将num值还给eax
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

    push edx
    push esi
    push edi
	mov ecx, 0;

    mov eax,ebx

	call writedec
    mov al,'^'
    call writechar
    mov eax,esi

	call writedec
    pop  edi
    pop  esi
    pop  edx

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
