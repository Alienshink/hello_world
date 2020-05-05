INCLUDE Irvine32.inc

.data
	number dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10   ;int arr[10]
	max dd -3F3F3F3Fh                          
	i dd 0d
.code										  									
main PROC			
Begin:							  
	mov edx, i
	cmp edx, 3
	jl Input
	jmp Output
	
Input:
	call readint
	add i, 1
	cmp eax, max
	jg Process
	jmp Begin
	
Process:
	mov max, eax
	jmp Begin

Output:
	mov eax, max
	call writeint
	exit
main ENDP
END main

