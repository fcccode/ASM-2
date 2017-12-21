.386
.model FLAT, stdcall
option casemap:none

WIN32_LEAN_AND_MEAN equ 1 ;this is to reduce assembly time
include windows.inc
include stdio.inc

.data
HelloWorldString	db	'Hello World !', 0x0D, 0x0A, 0	; 	0x0D is the value of \r and
					databyte							;	0x0A is the value of \n
														;	0 <=> caractère de fin de chaîne
.code

start proc

	push offset HelloWorldString
	call printf
	add esp, 4 	; we have to clean the argument from the stack
				; because printf use cdecl as calling convention
	
	push 42
	call ExitProcess
	
	ret

start endp

end

