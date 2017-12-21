
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

NewLine						db   0Dh, 0Ah, 0
Message						db	'Hello World', 0Dh, 0Ah, 0
FindeFileError						db	'Error FindFile', 0Dh, 0Ah, 0
PrintRegistersFormatString	db	'eax: %08X', 0Dh, 0Ah,
								'ebx: %08X', 0Dh, 0Ah,
								'ecx: %08X', 0Dh, 0Ah,
								'edx: %08X', 0Dh, 0Ah,
								'esi: %08X', 0Dh, 0Ah,
								'edi: %08X', 0Dh, 0Ah,
								'ebp: %08X', 0Dh, 0Ah,
								'esp: %08X', 0Dh, 0Ah, 0

WIN32_Find_Data	    WIN32_FIND_DATAA <?>

format_string_add	db	'result: %08X', 0Dh, 0Ah, 0

format_string_file	db	'%s', 0Dh, 0Ah, 0

StrPath	db 'C:\\asm\*',0

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

	hFind equ[ebp-4]

  ;cadre de pile
	push ebp
	mov ebp, esp
	sub esp, 4

	; FindFirstFileA
	push offset WIN32_Find_Data
	push offset StrPath
	call FindFirstFileA
  mov hFind, eax

	cmp eax, 0xFFFFFFFF
	je findFileError

	; call FindNextFile
showfile:
	lea eax, WIN32_Find_Data
	add eax, WIN32_FIND_DATA.cFileName
	push eax
	push offset format_string_file
	call printf
	add esp, 8
	push offset WIN32_Find_Data
	push hFind
	call FindNextFileA

	cmp eax, 00
	jne showfile

	; call FindClose
	push hFind
	call FindClose
  jmp _end

findFileError:
	push	offset FindeFileError
	call	printf
	add esp, 4

_end:

	; retirer le cadre de pile
	mov esp, ebp
	pop ebp
  add esp, 8

	push 0
	call ExitProcess



	ret
start endp

end
