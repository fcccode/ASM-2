.386
.model FLAT, stdcall
option casemap:none

WIN32_LEAN_AND_MEAN equ 1 ;this is to reduce assembly time
include windows.inc
include stdio.inc

.data

HelloWorldString	db	'Hello world!', 0x0D, 0x0A, 0

.code

mystrlen proc

    push ebp
    mov ebp, esp

    mov ebx, [ebp+8]  ; Argument
    xor eax, eax      ; eax = 0

re:
    cmp byte ptr [ebx], 0  ; if String[ebx] == \00
    jz myend             ; if == 0
    inc eax            ; else lenght(eax) ++
    inc ebx            ; indice ++
    jmp re             ; loop

myend:
    pop ebp             ; realign stack
    ret

mystrlen endp

start proc

    push offset HelloWorldString
    call mystrlen

    push 0
    call ExitProcess
    ret

start endp

end