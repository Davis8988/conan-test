@echo off

pushd "%~dp0"
if %errorlevel% neq 0 echo Error - Failed to CD to: %~dp0 && pause && exit /b 1

echo Cleaning x64 x86 ..
for %%a in (x64 x86) do (
	for /f %%f in ('dir /b') do if exist "%%f\%%a" echo Removing dir: %%f\%%a && rmdir /q /s "%%f\%%a"
	for /f %%f in ('dir /b') do if exist "%%f\%%a" echo Removing dir: %%f\%%a && rmdir /q /s "%%f\%%a"
	for /f %%f in ('dir /b') do if exist "%%f\%%a" echo Error - Failed removing dir: %%f\%%a && pause && exit /b 1
	
	if exist "%%a" echo Removing dir: %%a && rmdir /q /s "%%a"
	if exist "%%a" echo Removing dir: %%a && rmdir /q /s "%%a"
	if exist "%%a" echo Error - Failed removing dir: %%a && pause && exit /b 1
)


echo.

echo Cleaning Debug Release ..
for %%a in (Debug Release) do (
	for /f %%f in ('dir /b') do if exist "%%f\%%a" echo Removing dir: %%f\%%a && rmdir /q /s "%%f\%%a"
	for /f %%f in ('dir /b') do if exist "%%f\%%a" echo Removing dir: %%f\%%a && rmdir /q /s "%%f\%%a"
	for /f %%f in ('dir /b') do if exist "%%f\%%a" echo Error - Failed removing dir: %%f\%%a && pause && exit /b 1
	
	if exist "%%a" echo Removing dir: %%a && rmdir /q /s "%%a"
	if exist "%%a" echo Removing dir: %%a && rmdir /q /s "%%a"
	if exist "%%a" echo Error - Failed removing dir: %%a && pause && exit /b 1
)
echo.

echo Done
echo.

pause
