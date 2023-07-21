@echo off & title %~nx0  
REM & color 0F

goto :DOES_PYTHON_EXIST

:DOES_PYTHON_EXIST
python -V | find /v "Python" >NUL 2>NUL && (goto :PYTHON_DOES_NOT_EXIST)
python -V | find "Python"    >NUL 2>NUL && (goto :PYTHON_DOES_EXIST)
goto :EOF

:PYTHON_DOES_NOT_EXIST
echo Python is not installed on your system.
echo Now opeing the download URL.
start "" "https://www.python.org/downloads/windows/"
goto :EOF

:PYTHON_DOES_EXIST
:: This will retrieve Python 3.8.0 for example.
for /f "delims=" %%V in ('python -V') do @set ver=%%V
echo %ver% is installed...
goto :DOES_PIP_EXIST
goto :EOF

:DOES_PIP_EXIST
pip -V | find /v "pip" >NUL 2>NUL && (goto :PIP_DOES_NOT_EXIST)
pip -V | find "pip"    >NUL 2>NUL && (goto :PIP_DOES_EXIST)
goto :EOF

:PIP_DOES_NOT_EXIST
echo pip is not installed on your system.
echo python install pip
goto :EOF

:PIP_DOES_EXIST
:: This will retrieve Python 3.8.0 for example.
for /f "delims=" %%V in ('pip -V') do @set ver=%%V
echo %ver% is installed...

set INPUTFILE=%1
set OUTPUT=OUTPUT
echo Delete content of %OUTPUT% folder. 
pause
IF EXIST %INPUTFILE% (
    goto :EXTRACT_ZIP
) ELSE (
    echo %INPUTFILE% not avaliable.
    goto :EOF
)

:EXTRACT_ZIP
echo unzip file %INPUTFILE%
powershell Expand-Archive \"%INPUTFILE%\" -DestinationPath %OUTPUT% -Force
pip install brotli
for %%I in (%OUTPUT%/*.br) do (
    echo extracting  %OUTPUT%/%%~nI%%~xI to %OUTPUT%/%%~nI
    del %OUTPUT%/%%~nI >nul 2>&1
    python run_brotli.py --force -d -i %OUTPUT%/%%~nI%%~xI -o  %OUTPUT%/%%~nI
)
goto :DAT_TO_IMG
goto :EOF

:DAT_TO_IMG
for %%I in (%OUTPUT%/*dat) do (
   call :SetVar %%I 
)
set IMG=IMG
mkdir %IMG% 2> NUL
MOVE /Y %OUTPUT%\*.img  %IMG%\
COPY /Y flash.txt %IMG%\
goto :EOF
:SetVar
  Set FileName=%1
  
  SET _result=%FileName:~-3%
    IF %_result%==dat (
        SET OP=""
        FOR /f "tokens=1 delims=." %%a IN ("%FileName%") do set OP=%%a
        echo dat2img %OUTPUT%/%OP%.transfer.list %OUTPUT%/%FileName% %OUTPUT%/%OP%.img
        python sdat2img.py "%OUTPUT%/%OP%.transfer.list" "%OUTPUT%/%FileName%" "%OUTPUT%/%OP%.img"
    )
   
    


