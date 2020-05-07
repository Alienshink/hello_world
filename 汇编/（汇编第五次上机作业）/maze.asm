INCLUDE Irvine32.inc
.data      
	arrmaze db 256 dup(0)
	row dd 16
    amaze db    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1,
                1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1
    bmaze db    1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1,
                1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
                1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1 
    cmaze db    1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1,
                1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1  
    dmaze db    1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 
                1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 
                1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1
    emaze db    1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1,
                1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 3, 1, 1, 
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    fmaze db    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    maze  dd offset amaze, bmaze, cmaze, dmaze, emaze, fmaze
    three dd 3
    sixteen dd 16
    msg1 db "挑战者，你的迷宫如下：", 0Dh, 0Ah, 0
    msg2 db "我的路线用4表示：", 0Dh, 0Ah, 0
.code								  									
main PROC
	mov ecx, row
    call createmaze
    mov edx, offset msg1
    call WriteString

    mov edx, offset arrmaze
	call printSqueen

    mov edx, offset msg2
    call writeString
    mov ecx, row
    mov esi, 1      ;start address
    mov edi, 1
    mov edx, 17
    call demo1

    mov edx, offset arrmaze
	call printSqueen
	exit
main ENDP
demo1 proc
;ecx:size
;esi:i
;edi:j
;0:road
;1:wall
;2:start
;3:end
;4:route
    pushad
again:
    cmp ecx, 256            ;规定如果步数大于总格子数，就算挑战失败
    jae final
    mov al, arrmaze[edx]
    cmp al, 3
    jz final

    inc edi                 ;turn right
    call address            ;数组位置在edx中
    mov al, arrmaze[edx]
    cmp al, 4
    jz next_1
    cmp al, 0
    jnz next_1
    mov arrmaze[edx], 4
    inc ecx
    jmp again
next_1:
    cmp al, 1
    jnz next_2
    dec edi
next_2:                     ;turn down
    inc esi
    call address
    mov al, arrmaze[edx]
    cmp al, 4
    jz next_3
    cmp al, 0
    jnz next_3
    mov arrmaze[edx], 4
    inc ecx
    jmp again
next_3:
    cmp al, 1
    jnz next_4
    dec esi
next_4:                     
    
    inc ecx
    jmp again
final:
    popad
    ret
demo1 endp
createmaze proc
;!ecx:size
;esi:i
;ebx:j
;edi:maze's arr address 
;return:nothing
    pushad
    mov edi, [maze]
    mov esi, 0
again:
    cmp esi, ecx
    jae final       ;outer
    mov ebx, 0
again1: 
    cmp ebx, ecx
    jae final1      ;inter
    push ebx
    call point      ;得到两个数组的偏移量，一个在eax，一个在edx
    
    mov al, arrmaze[ebx]
    add al, [edi + edx]
    mov arrmaze[ebx], al
    pop ebx
    inc ebx
    jmp again1      ;ebx,ecx
    
final1:
    inc esi
    push edx
    push ebx
    mov edx, 0
    mov eax, esi
    div three
    cmp edx, 0
    jz process
    jmp L1
process:
    mov edi, maze[eax * 4]
L1:
    pop ebx
    pop edx
    jmp again       ;esi,ecx
final:
    popad
    ret
createmaze endp 
printSqueen proc
;print squeen arr and every elements is 1B
;!ecx:size
;!edx:maze address
;esi:i
;ebx:j
;!return:nothing
    pushad
    mov esi, 0
again:
    cmp esi, ecx
    jae final       ;outer
    mov ebx, 0
again1:
    cmp ebx, ecx
    jae final1      ;inter
    push edx        ;保存edx的值，mul会改变edx
    mov edi, ecx     ;这个是大小   
    mov eax, esi
    mul edi
    add eax, ebx
    pop edx
    mov edi, eax
    mov al, [edx + edi]
    add al, '0'     ;加0让数据是以数字输出
    call WriteChar
    mov al, ' '     ;为了好看输出空格
    call WriteChar
    inc ebx
    jmp again1      ;ebx,ecx
    
final1:
    call Crlf
    inc esi
    jmp again       ;esi,ecx
final:
    popad
    ret
printSqueen endp
point proc
;eax:arrmaze point
;edx:maze point
;esi:i
;ebx:j
    push ecx
    push edi
    push esi
    mov edx, 0
    mov eax, esi
    mul sixteen
    add eax, ebx
    mov edi, eax    ;point of arrmaze
    
    mov edx, 0
    mov eax, esi
    div three
    mov eax, edx
    mul sixteen
    add eax, ebx
    mov edx, eax    ;point of maze
    mov ebx, edi    ;point of arrmaze
    pop esi
    pop edi
    pop ecx
    ret
point endp
address proc
    push eax
    mov eax, esi
    mul sixteen
    add eax, edi
    mov edx, eax    
    pop eax
    ret
address endp
END main
