@echo off

set UASM_EXECUTABLE=C:\Users\user\Desktop\ASM\softs\uasm64.exe
set WININC_PATH=C:\Users\user\Desktop\ASM\softs\WinInc

set FILE_TO_COMPILE=%1

set FILENAME_NO_EXT=%FILE_TO_COMPILE:~0,-4%

@echo on

"%UASM_EXECUTABLE%" -I"%WININC_PATH%\Include" -coff %FILE_TO_COMPILE%
@if ErrorLevel 1 (
	goto :EOF
)

POLINK /ENTRY:start@0 /SUBSYSTEM:CONSOLE /LIBPATH:"%WININC_PATH%\lib" %FILENAME_NO_EXT%.obj msvcrt.lib kernel32.lib -OUT:%FILENAME_NO_EXT%.exe
@if ErrorLevel 1 (
	goto :EOF
)

@rem delete temporary file
@del %FILENAME_NO_EXT%.obj

%FILENAME_NO_EXT%.exe %2

@echo ExitCode: %ErrorLevel%