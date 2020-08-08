@echo off

rem Change to the directory of this script
cd /d %0\..

ver | find "XP" > nul
if %ERRORLEVEL% == 0 goto vXp
ver | find "Version 10." > nul
if %ERRORLEVEL% == 0 goto vTen

goto done

:vXp
echo "Windows XP"
set target=%UserProfile%\vimfiles
set cmd=junction "%target%" "%cd%"
start /I %cmd% 
set cmd=fsutil hardlink create "%UserProfile%\_vimrc" "%cd%\vimrc"
start /I %cmd% 
goto done

:vTen
echo "Windows 10"
set target=%UserProfile%\vimfiles
set cmd=mklink /D "%target%" "%cd%"
start /I %cmd%
set target=%UserProfile%\_vimrc
set cmd=mklink "%target%" "%cd%"\vimrc
start /I %cmd%

goto done

echo "Done"

:done
