include irvine32.inc
.data
    eVal1 real4 2.71828 
.code
main proc
    call DumpRegs
    mov eax, eVal1
    call WriteHex
    call crlf
    call DumpRegs
    exit
main endp
end main