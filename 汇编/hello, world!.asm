INCLUDE Irvine32.inc

.data
	val1 db "Hello world", 0
	val2 DD 4000h
	val3 DD 2000h
	finalVal db ?
	data1 DD 4203h

.code
main PROC
	mov edx, offset  val1
	call WriteString
	exit
main ENDP
END main
