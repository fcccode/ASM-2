
.386
.model FLAT, stdcall
option casemap:none
	
	
pushcontext listing ;suppress listing of includes
.nolist
.nocref
WIN32_LEAN_AND_MEAN equ 1 ;this is to reduce assembly time
include windows.inc
include stdio.inc
popcontext listing
			
.data

Message						db	'Hello World', 0Dh, 0Ah, 0
PrintRegistersFormatString	db	'eax: %08X', 0Dh, 0Ah,
								'ebx: %08X', 0Dh, 0Ah,
								'ecx: %08X', 0Dh, 0Ah,
								'edx: %08X', 0Dh, 0Ah,
								'esi: %08X', 0Dh, 0Ah,
								'edi: %08X', 0Dh, 0Ah,
								'ebp: %08X', 0Dh, 0Ah,
								'esp: %08X', 0Dh, 0Ah, 0
								
WIN32_Find_Data	    WIN32_FIND_DATAA <?>
StrPath	db	'C:\*',0
								
format_string_add	db	'result: %08X', 0Dh, 0Ah, 0

.code

PrintRegisters macro
	push	esp
	push	ebp
	push	edi
	push	esi
	push	edx
	push	ecx
	push	ebx
	push	eax
	push	offset PrintRegistersFormatString
	call	printf
	add		esp, 36
endm

my_add proc
arg1 equ [ebp+8]
arg2 equ [ebp+12]

	push ebp
	mov ebp, esp

	mov eax, arg1
	add eax, arg2

	mov esp, ebp
	pop ebp
	ret 8
my_add endp

start proc

	; PrintRegisters
	; push	offset Message
	; call	printf
	; add		esp, 4
	; PrintRegisters

	; push 1
	; push 3
	; call my_add

	; push eax
	; push offset format_string_add
	; call printf
	; add esp, 8

	; push 0
	; call ExitProcess

	; Il ne lui reste que ce qui suit dans son code

	; push
	; mov
	; sub	esp,4

	push offset WIN32_Find_Data
	push offset StrPath
	call FindFirstFileA
	; conserver le HANDLE

	lea eax,WIN32_Find_Data
	add eax,WIN32_FIND_DATAA.cFileName
	push eax
	call printf
	add esp,4

	push 0
	call ExitProcess

	ret
start endp

end
