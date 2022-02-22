@echo off

set conanProfile=default

echo Conan Install

where conan >nul 2>&1 || set PATH=%PATH%;C:\Program Files\Conan\conan
where conan >nul 2>&1 || echo Error - Missing Conan from system path && pause && exit /b 1

pushd "%~dp0"
if %errorlevel% neq 0 echo Error - Failed to CD into: "%~dp0" && pause && exit /b 1 


echo Installing required libs using Conan profile: %conanProfile%

if exist "%CD%\conanbuildinfo.cmake" echo Removing old file: "%CD%\conanbuildinfo.cmake" && del /q "%CD%\conanbuildinfo.cmake"
if exist "%CD%\conanbuildinfo.cmake" echo Error - Failed removing old file: "%CD%\conanbuildinfo.cmake" && pause && exit /b 1

echo Executing: conan install .. -pr %conanProfile%
conan install .. -pr %conanProfile%
if %errorlevel% neq 0 echo. && echo Error - Failure during execution of: conan install .. -pr %conanProfile% && echo Failed installing required libs using Conan for: MathClient && echo. && pause && exit /b 1

echo.
if not exist "conanbuildinfo.cmake" echo Error - Missing generated conan file: "%CD%\conanbuildinfo.cmake" && echo Although it exited with a '0' exit code, && echo   did the conan install command: 'conan install .. -pr %conanProfile%' really worked? && pause && exit /b 1

echo Moving "%CD%\conanbuildinfo.cmake" to root repo dir:  "%CD%\..\conanbuildinfo.cmake"
if exist "%CD%\..\conanbuildinfo.cmake" echo Removing old root repo file: "%CD%\..\conanbuildinfo.cmake" && del /q "%CD%\..\conanbuildinfo.cmake"
if exist "%CD%\..\conanbuildinfo.cmake" echo Error - Failed removing old root repo file: "%CD%\..\conanbuildinfo.cmake" && pause && exit /b 1

echo Executing: move "%CD%\conanbuildinfo.cmake" "%CD%\..\conanbuildinfo.cmake"
move "%CD%\conanbuildinfo.cmake" "%CD%\..\conanbuildinfo.cmake"
if %errorlevel% neq 0 echo WARNING: Seems like 'move' command failed to work. && echo Validating it now..
if not exist "%CD%\..\conanbuildinfo.cmake" echo Error - Failed moving: "%CD%\conanbuildinfo.cmake" to: "%CD%\..\conanbuildinfo.cmake" && pause && exit /b 1
echo.


echo.
echo Success
echo.
echo Done
echo.

timeout /t 6
