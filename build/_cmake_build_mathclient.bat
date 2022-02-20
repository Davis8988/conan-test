@echo off

echo CMake Build MathClient

where cmake >nul 2>&1 || set PATH=%PATH%;C:\Program Files\CMake\bin
where cmake >nul 2>&1 || echo Error - Missing CMake from system path && pause && exit /b 1

pushd "%~dp0"
if %errorlevel% neq 0 echo Error - Failed to CD into: "%~dp0" && pause && exit /b 1 


echo Generating makefiles by executing: cmake .. -G "Visual Studio 16 2019"
cmake .. -G "Visual Studio 16 2019"
if %errorlevel% neq 0 echo. && echo Error - Failure during execution of: cmake .. -G "Visual Studio 16 2019" && echo Failed generating makefiles for: MathClient && echo. && pause && exit /b 1

echo.
echo Cleaning by executing: cmake --build . --target clean
cmake --build . --target clean
if %errorlevel% neq 0 echo. && echo Error - Failure during execution of: cmake --build . --target clean && echo Failed cleaning: MathClient && echo. && pause && exit /b 1

echo.
echo Building by executing: cmake --build .
cmake --build . 
if %errorlevel% neq 0 echo. && echo Error - Failure during execution of: cmake --build . && echo Failed building: MathClient && echo. && pause && exit /b 1

echo.
echo Success
echo.
echo Done
echo.

timeout /t 6
