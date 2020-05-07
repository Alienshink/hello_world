include irvine32.inc
.data
    
    msg  db "¾Å¾Å³Ë·¨±í£º", 0Dh, 0Ah, 0;
.code
main proc
	mov edx, offset msg
	call writestring
	mov eax, 1
again_outer:
	cmp eax, 9
	ja final_outer

	mov ebx, 1
	
again_inter:
	cmp ebx, eax
	ja final_inter
	
	push ebx
	push eax
	call print_table
	
	inc ebx
	jmp again_inter
	
final_inter:
	call crlf
	
	inc eax
	jmp again_outer
final_outer:
	
    exit
main endp
;print(i,j)
print_table proc
	push ebp
	mov ebp, esp
	pushad
	mov eax, [ebp + 8]
	call writedec
	mov al, '*'
	call writechar
	mov eax, [ebp + 12]
	call writedec
	mov al, '='
	call writechar
	mov edx, 0
	mov eax, [ebp + 8]
	mov ebx, [ebp +12]
	mul ebx
	call writedec
	mov al, ' '
	call writechar
	popad
	pop ebp
	ret 8
print_table endp

end main
