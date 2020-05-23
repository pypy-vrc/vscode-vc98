@echo off
@setlocal

@call "C:\Program Files (x86)\Microsoft Visual Studio\VC98\Bin\VCVARS32.BAT"

@set INCLUDE=C:\PROGRAM FILES\MICROSOFT PLATFORM SDK\INCLUDE;%INCLUDE%
@set LIB=C:\PROGRAM FILES\MICROSOFT PLATFORM SDK\LIB;%LIB%

if not exist bin @mkdir bin
if not exist obj @mkdir obj

@echo Compiling...
cl /nologo /c /W3 /WX /MD /GX /O2 /Oi /Fo"obj/" /Fp"obj/pch.pch" /Yc"pch.h" pch.c
@if errorlevel 1 goto :BAD

@echo Compiling...
cl /nologo /c /W3 /WX /MD /GX /O2 /Oi /Fo"obj/" /Fp"obj/pch.pch" /Yu"pch.h" *.c
@if errorlevel 1 goto :BAD

@echo Linking...
link /NOLOGO /INCREMENTAL:NO /MACHINE:I386 /SUBSYSTEM:CONSOLE /ENTRY:mainCRTStartup /DEBUG /PDB:"bin/test.pdb" /OPT:NOWIN98 /OUT:bin/test.exe "obj/*.obj"
@if errorlevel 1 goto :BAD
goto :SUCCESS

:SUCCESS
@echo Build success
@goto :END

:BAD
@echo Build failure

:END
