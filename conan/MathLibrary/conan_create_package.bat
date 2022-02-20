@echo off

set conanFile=%~dp0conanfile_MathLibrary.py

where conan >nul 2>&1 || set PATH=%PATH%;C:\Program Files\Conan\conan
where conan >nul 2>&1 || echo Error - Missing Conan from system path && pause && exit /b 1


pushd "%~dp0"
if %errorlevel% neq 0 echo Error - Failed to CD into: "%~dp0" && pause && exit /b 1 


echo Packing MathLibrary using Conan 
echo Executing: conan create "%conanFile%"
conan create "%conanFile%"
if %errorlevel% neq 0 echo. && echo Error - Failure during execution of: conan create "%conanFile%" && echo Failed packing MathLibrary using Conan && echo. && pause && exit /b 1

echo.
echo Success
echo.
echo Done
echo.

timeout /t 6

