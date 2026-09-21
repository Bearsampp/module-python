@echo off
set WINPYSCRIPTSDIR=%~dp0..\scripts
call "%WINPYSCRIPTSDIR%\env_for_icons.bat"
cd/D "%WINPYWORKDIR%"
rem backward compatibility for python command-line users
"%WINPYDIR%\python.exe" %*
