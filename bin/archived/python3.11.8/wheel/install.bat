@echo off
set WINPYSCRIPTSDIR=%~dp0..\scripts
call "%WINPYSCRIPTSDIR%\env.bat"
"%WINPYDIR%\Scripts\pip.exe" install pywin32-306-cp311-cp311-win_amd64.whl
