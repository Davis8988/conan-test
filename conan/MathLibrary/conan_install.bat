@echo off

set conanProfile=default
set conanInstallCmnd=conan install . -pr %conanProfile%

echo Conan Install

where conan >nul 2>&1 || set PATH=%PATH%;C:\Program Files\Conan\conan
where conan >nul 2>&1 || echo Error - Missing Conan from system path && pause && exit /b 1

:: Go up one folder to where main CMakeLists.txt file is
pushd "%~dp0"
if %errorlevel% neq 0 echo Error - Failed to CD into: "%~dp0" && pause && exit /b 1 


echo Installing required libs using Conan profile: %conanProfile%

:: Remove old conanbuildinfo.cmake file
if exist "%CD%\conanbuildinfo.cmake" echo Removing old file: "%CD%\conanbuildinfo.cmake" && del /q "%CD%\conanbuildinfo.cmake"
if exist "%CD%\conanbuildinfo.cmake" echo Error - Failed removing old file: "%CD%\conanbuildinfo.cmake" && pause && exit /b 1


echo Executing: %conanInstallCmnd%
%conanInstallCmnd%
if %errorlevel% neq 0 echo. && echo Error - Failure during execution of: %conanInstallCmnd% && echo Failed installing required libs using Conan for: MathClient && echo. && pause && exit /b 1

echo.
if not exist "conanbuildinfo.cmake" echo Error - Missing generated conan file: "%CD%\conanbuildinfo.cmake" && echo Although conan install command exited with a '0' exit code, && echo   did the conan install command: '%conanInstallCmnd%' really worked? && pause && exit /b 1

echo.
echo Success
echo.
echo Done
echo.

timeout /t 6
