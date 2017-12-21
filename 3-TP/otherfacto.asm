.386
.model FLAT, stdcall
option casemap:none

WIN32_LEAN_AND_MEAN equ 1 ;this is to reduce assembly time
include windows.inc
include stdio.inc

.data

gValue			dd	10

FactorialString	db	'Factorial %d is %d', 0x0D, 0x0A, 0
													; 0x0D is the value of \r and
													; 0x0A is the value of \n
													; don't forget the null character at the end of a string
													


.code

factorial proc
	
	push ebp
 	mov ebp, esp
 	cmp [ebp+8], 1
 	jnz short loc_401010
 	mov eax, 1
 	jmp short loc_401023

loc_401010:
 	mov eax, [ebp+8]
 	sub eax, 1
 	push eax
 	call factorial
 	add eax, 4
 	imul eax, [ebp+8]

loc_401023:
 	mov esp, ebp
	pop ebp
 	retn

factorial endp

start proc

	push dword ptr [gValue]
	call factorial

	push eax
	push dword ptr [gValue]
	push offset FactorialString
	call printf
	add esp, 4 	; we have to clean the argument from the stack
				; because printf use cdecl as calling convention
	
	push 0
	call ExitProcess
	
	ret

start endp

end

