
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
DirectoryFound	db 'Directory Found', 0Dh, 0Ah, 0
CurrentDir	db '.', 0
ParentDir	db '..', 0

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

StrPath	db "C:\asm\softs\Uasm\Samples\*",0

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

lsdir proc

	path equ[ebp+8]
	hFind equ[ebp-4]

	push ebp
	mov ebp, esp
	sub esp, 4

	mov eax, path
	;cadre de pile

	; FindFirstFileA
	push offset WIN32_Find_Data
	push eax
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

	lea eax, WIN32_Find_Data
	add eax, WIN32_FIND_DATA.dwFileAttributes
	test dword ptr [eax], FILE_ATTRIBUTE_DIRECTORY
	je next_file

	push	offset DirectoryFound
	call	printf
	add esp, 4

	lea eax, WIN32_Find_Data
	add eax, WIN32_FIND_DATA.cFileName
  push eax
	push offset CurrentDir
	call strcmp
	cmp eax, 00
	je next_file

	lea eax, WIN32_Find_Data
	add eax, WIN32_FIND_DATA.cFileName
  push eax
	push offset ParentDir
	call strcmp
	cmp eax, 00
	je next_file

	lea eax, WIN32_Find_Data
	add eax, WIN32_FIND_DATA.cFileName
  push eax
	push path
	call strcat

	push path
	call lsdir
	add esp, 4

next_file:
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
	add esp, 4
	mov esp, ebp
	pop ebp
	ret


lsdir endp

start proc

	push offset StrPath
	call lsdir

	push 0
	call ExitProcess



	ret
start endp

end
