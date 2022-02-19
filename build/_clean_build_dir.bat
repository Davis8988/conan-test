@echo off

echo Clean build dir: %~dp0

echo.
echo Cleaning..
echo.

set removeDirColor=
set removeFileColor=
set colorPrint=
where cmdcolor > nul 2>&1 && set "removeDirColor=\033[34;43m" && REM \033[34;43m == "BLUE ON YELLOW"
REM where cmdcolor > nul 2>&1 && set removeFileColor=\033[34;43;35m && REM \033[34;43m == "MAGENTA ON YELLOW"
where cmdcolor > nul 2>&1 && set "colorPrint=| cmdcolor.exe"

set scriptName=%~nx0
for /f %%a in ('dir /b') do (
	if "%%~xa" equ ".bat" echo == Skipping script file: %%a
	if "%%~xa" neq ".bat" (
		if exist "%%a\*" echo %removeDirColor%Removing dir: %%a %colorPrint% && rmdir /q /s "%%a"
		if exist "%%a\*" rmdir /q /s "%%a"  && REM Sometimes needs to have 2 remove attempts..
		if not exist "%%a\*" if exist "%%a" echo %removeFileColor%Removing file: %%a && del /q "%%a"
	)
)
echo.
echo Done
echo.
echo Finished
echo.
timeout /t 5