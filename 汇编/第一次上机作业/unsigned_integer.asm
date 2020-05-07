
INCLUDE Irvine32.inc

.data
	integer dd ?

.code
main PROC
	call readint
	cmp eax, 0
	jge unsigned
	call writeint
	jmp final
unsigned:
	call writedec
final:
	exit
main ENDP
END main
