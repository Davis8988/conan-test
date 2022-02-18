@echo off

set msbuildPath=C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe

if not defined fileToBuildPath set fileToBuildPath=%~dp0StaticMath.sln
if not defined buildConf set buildConf=Debug
if not defined buildPlatform set buildPlatform=x64
if not defined logFilePath set logFilePath=%~dp0LastBuild.log

if not exist "%fileToBuildPath%" echo Error - Missing or unreachable file to build: %fileToBuildPath% && pause && exit 1

:: Get File Name
set fileToBuildName=
for %%F in ("%fileToBuildPath%") do set "fileToBuildName=%%~nxF"

echo Building file: %fileToBuildName%
echo Conf: %buildConf%^|%buildPlatform%
echo.

set logFileParams=/fileLogger
set logFileParams=%logFileParams% /fileLoggerParameters
set logFileParams=%logFileParams%:LogFile="%logFilePath%"
set logFileParams=%logFileParams%;Overwrite
set logFileParams=%logFileParams%;Encoding=UTF-8

set msbuildCmnd="%msbuildPath%"
set msbuildCmnd=%msbuildCmnd% /p:Configuration=%buildConf%
set msbuildCmnd=%msbuildCmnd% /p:IncludePath="%~dp0MathLibrary;%~dp0Printings;$(IncludePath)"
set msbuildCmnd=%msbuildCmnd% /p:Platform=%buildPlatform%
set msbuildCmnd=%msbuildCmnd% /t:Build
set msbuildCmnd=%msbuildCmnd% "%fileToBuildPath%"
set msbuildCmnd=%msbuildCmnd% %logFileParams%

:: Clean old log file before building
if exist "%logFilePath%" echo Removing old log file: "%logFilePath%" && del /q "%logFilePath%"

echo Executing: 
echo %msbuildCmnd%

if not defined silentRun CHOICE /C YN /M "Are you sure"
if %errorlevel% equ 2 echo Aborting.. && ping 127.0.0.1 -n 2 > nul && exit 0
echo.

%msbuildCmnd%
if %errorlevel% neq 0 echo. && echo Error - Failed compiling %fileToBuildName% in conf: %buildConf%^|%buildPlatform% && echo. && echo Failure during execution of: && echo %msbuildCmnd% && echo. && pause && exit 1

echo.
echo Success
echo.

echo Checking if project was built or was already existing
echo.
if not exist "%logFilePath%" echo. && echo Error - Missing or unreachable log file: "%logFilePath%" && echo. && pause && exit 1


setlocal EnableDelayedExpansion
set projectsUpToDateCount=0
for /f %%a in ('type "%logFilePath%" ^| find /i "All outputs are up-to-date." /c') do (set projectsUpToDateCount=%%a)
echo.
echo projectsUpToDateCount=!projectsUpToDateCount!
if /i "!projectsUpToDateCount!" equ "2" echo \033[30;42mOK - Project was already up to date | cmdcolor
if /i "!projectsUpToDateCount!" equ "4" echo \033[30;42mOK - Project was already up to date | cmdcolor
if /i "!projectsUpToDateCount!" equ "6" echo \033[30;42mOK - Project was already up to date | cmdcolor
if /i "!projectsUpToDateCount!" equ "0" echo \033[41mNo - Project was built | cmdcolor
echo.

if exist "%logFilePath%" echo Removing log file: "%logFilePath%" && del /q "%logFilePath%"


echo Done

echo.
pause




