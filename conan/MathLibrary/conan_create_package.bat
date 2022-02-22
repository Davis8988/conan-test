@echo off


set packageName=MathLibrary
set conanCreateCmnd=conan create . testing/release

where conan >nul 2>&1 || set PATH=%PATH%;C:\Program Files\Conan\conan
where conan >nul 2>&1 || echo Error - Missing Conan from system path && pause && exit /b 1


pushd "%~dp0"
if %errorlevel% neq 0 echo Error - Failed to CD into: "%~dp0" && pause && exit /b 1 


echo Packing %packageName% using Conan 
echo Executing: %conanCreateCmnd%
%conanCreateCmnd%
if %errorlevel% neq 0 echo. && echo Error - Failure during execution of: %conanCreateCmnd% && echo Failed packing %packageName% using Conan && echo. && pause && exit /b 1

echo.
echo Success
echo.
echo Done
echo.

timeout /t 6

pause