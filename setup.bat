@echo off

rem Change to the directory of this script
cd /d %0\..

ver | find "XP" > nul
if %ERRORLEVEL% == 0 goto vXp

goto vOver

:vXp
set target=%UserProfile%\vimfiles
set cmd=junction "%target%" "%cd%"
start /I %cmd% 
set cmd=fsutil hardlink create "%UserProfile%\_vimrc" "%cd%\vimrc"
start /I %cmd% 
goto done


:vOver

goto done

:done
