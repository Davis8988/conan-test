@echo off

set buildConf=Debug
set fileToBuildPath=%~dp0Printings\Printings.vcxproj
echo Executing script: "%~dp0build.bat"
call "%~dp0build.bat"

set silentRun=true

set fileToBuildPath=%~dp0MathLibrary\MathLibrary.vcxproj
echo Executing script: "%~dp0build.bat"
call "%~dp0build.bat"

set fileToBuildPath=%~dp0MathClient\MathClient.vcxproj
echo Executing script: "%~dp0build.bat"
call "%~dp0build.bat"


echo.
echo.
echo.
echo Success - All Done
echo.
timeout /t 5