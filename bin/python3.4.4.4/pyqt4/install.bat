@echo off
set WINPYSCRIPTSDIR=%~dp0..\scripts
call "%WINPYSCRIPTSDIR%\env.bat"
"%WINPYDIR%\Scripts\pip.exe" install PyQt4-4.11.4-cp34-none-win32.whl