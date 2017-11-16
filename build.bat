@echo off
if "%1" == "clean" goto :clean
if "%1" == "run" goto :run

:build
echo building
pushd %cd%
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x86
popd %cd%

pushd %cd%
for /r %%f in (*.c) do cd %%~dpf & if not exist %%~dpnf.exe (cl /nologo %%f kernel32.lib user32.lib gdi32.lib comctl32.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib)
popd %cd%
goto :eof

:run
echo running
pushd %cd%
for /r %%f in (*.c) do if exist %%~dpnf.exe (echo Run %%~dpnf & %%~dpnf.exe)
popd %cd%
goto :eof

:clean
echo cleaning
del /s/q *.exe *.obj
goto :eof