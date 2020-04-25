INCLUDE Irvine32.inc

.data
	number dd ?, ?, ?, ?, ?, ?, ?, ?, ?, ?   ;int arr[10]
	max dd -3F3F3F3Fh                          
	i dd 0d
	a dd 0d
	
.code										  									
main PROC			
mov esi, offset number
input:
	mov edx, a
	cmp edx, 10
	jl L3
	jmp process

L3:
	call readint
	add a, 1
	mov [esi], eax
	add esi, 4
	jmp input
	
process:							  
	mov edx, i
	cmp edx, 10
	jl L1
	jmp Output
	
L1: 
	mov eax, [esi]
	sub esi, 4
	add i, 1
	cmp eax, max
	jg L2
	jmp process
	
L2:
	mov max, eax
	jmp process

Output:
	mov eax, max
	call writeint
	exit
main ENDP
END main


