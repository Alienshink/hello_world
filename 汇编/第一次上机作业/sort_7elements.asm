INCLUDE Irvine32.inc
;for(int i = 0; i < n; i++){
;	for(int j = 0; j < n; j++){
;	if(a[j] < a[i]){
;	t = a[i];
;	a[i] = a[j];
;	a[j] = t;
;	}
;	{
;{
.data
	arr dd 3, 4, 55, 46, 73, 81, 9, 10   
	num dd ($ - arr) / 4                
	i dd 0d
	j dd 0
	
.code										  									
main PROC			
	mov eax, i
	mov ebx, j
	mov ecx, num	
	
again_1:
	cmp eax, ecx
	jae final
	mov ebx, 0
again_2:
	cmp ebx, ecx
	jae next_1
	mov edx, arr[eax * 4];edx保存中间变量，因为不能cmp中两个不能直接都用寄存器比较
	cmp edx, arr[ebx * 4]
	jae next_2
	mov esi, arr[eax * 4]
	mov edi, arr[ebx * 4]
	mov arr[eax * 4], edi
	mov arr[ebx * 4], esi
	jmp again_2
next_1:
	add eax, 1
	jmp again_1
next_2:
	add ebx, 1
	jmp again_2
final:
	mov ebx, num
	mov edx, offset arr
	call print_arr
	exit
main ENDP

print_arr proc
;num需要外面传进来给ebx
;arr也同样需要外面传进来给edx
	mov ecx, 0
again:	
	cmp ecx, ebx
	je final
	mov eax, [edx + ecx * 4]
	call writeint
	mov al, ','
	call writechar
	add ecx, 1
	jmp again
final:	
	ret
print_arr endp

END main


