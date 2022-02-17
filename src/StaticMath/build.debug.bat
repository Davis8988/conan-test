@echo off

set msbuildPath=C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe
set solutionPath=%~dp0StaticMath.sln
set buildConf=Debug
set buildPlatform=x64
if not exist "%solutionPath%" echo Error - Missing or unreachable solution file: %solutionPath% && pause && exit 1

:: Get File Name
set solutionFileName=
for %%F in ("%solutionPath%") do set "solutionFileName=%%~nxF"

echo Building solution: %solutionFileName%
echo Conf: %buildConf%^|%buildPlatform%
echo.

CHOICE /C YN /M "Are you sure"
if %errorlevel% equ 2 echo Aborting.. && ping 127.0.0.1 -n 2 > nul && exit /b 0
echo.

echo Compiling..
echo Executing: 
echo "%msbuildPath%" /p:Configuration=%buildConf% /p:Platform=%buildPlatform% "%solutionPath%"

"%msbuildPath%" /p:Configuration=%buildConf% /p:Platform=%buildPlatform% "%solutionPath%"

echo.
pause




