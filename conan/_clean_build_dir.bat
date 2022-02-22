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

for /f %%a in ('dir /b') do (
	if "%%~xa" equ ".bat" echo == Skipping script file: %%a
	if "%%~xa" equ ".py" echo == Skipping script file: %%a
	if "%%~xa" neq ".bat" if "%%~xa" neq ".py" call :REMOVE_FILE "%%a" 
	if exist "%%a\*"  call :REMOVE_DIR "%%a" 
)

echo.
echo Done
echo.
echo Finished
echo.
timeout /t 5
exit /b 0


:REMOVE_FILE
if not exist "%~1" EXIT /B
echo %removeFileColor%Removing file: %~1 && del /q "%~1"
EXIT /B

:REMOVE_DIR
if not exist "%~1" EXIT /B
echo %removeDirColor%Removing dir: %%a %colorPrint% && rmdir /q /s "%%a"
rmdir /q /s "%%a"  && REM Sometimes needs to have 2 remove attempts..
EXIT /B

