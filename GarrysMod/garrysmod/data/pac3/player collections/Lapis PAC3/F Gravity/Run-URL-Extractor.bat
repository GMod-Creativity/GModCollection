@echo off
:: Check if a file was dragged
if "%~1"=="" (
    echo Drag and drop a .txt file onto this .bat file to extract URLs.
    pause
    exit /b
)

:: Launch the PowerShell script with the path to the dragged file
powershell -ExecutionPolicy Bypass -File "%~dp0Extract-Urls.ps1" "%~1"
