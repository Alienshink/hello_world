INCLUDE Irvine32.inc

.data
	number dd 1, 2, 3, 4, 55, 46, 73, 81, 9, 10   ;int arr[10]
	max dd -3F3F3F3Fh                          
	i dd 0d
	
.code										  									
main PROC			
mov ebx, offset number
mov esi, offset number
Begin:							  
	mov edx, i
	cmp edx, 10
	jl Input
	jmp Output
	
Input: 
	mov eax, [esi]
	add esi, 4
	add i, 1
	cmp eax, max
	jg Process
	jmp Begin
	
Process:
	mov max, eax
	lea ebx, max
	jmp Begin

Output:
	sub eax, ebx
	call writeint
	exit
main ENDP
END main


