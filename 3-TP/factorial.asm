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
	
	; argument is at [esp + 4]
	mov eax,[esp+4]
	cmp eax,1
	jg calculation
	mov eax, 1
	ret 4

	calculation:
	dec eax
	push eax
	call factorial
	mul dword ptr [esp+4]
	ret 4

	; we want to use stdcall as calling convention
	; we have to clean the stack

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

