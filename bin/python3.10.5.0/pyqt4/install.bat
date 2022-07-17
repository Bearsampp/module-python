@echo off
set WINPYSCRIPTSDIR=%~dp0..\scripts
call "%WINPYSCRIPTSDIR%\env.bat"
"%WINPYDIR%\Scripts\pip.exe" install PyQwt-5.2.1-cp37-cp37m-win_amd64.whl
