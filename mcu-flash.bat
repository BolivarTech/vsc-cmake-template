@echo off
REM This script flash the STM32 MCU wiht the file especified.
REM Author: Julian Bolivar
REM Date: 2023-10-09

echo STM32 MCU Flashing File script
if "%~1"=="" goto Help
if %1==-h goto Help
set bin_file=%1
if "%~2"=="" (set mem_add=0x08000000) else (set mem_add=%2%)
STM32_Programmer_CLI -c port=swd speed=Reliable -e all -w %bin_file% %mem_add% -v -rst -run -score -vb 1
goto EOF

:Help
    echo This script flash STM32 MCU using STM32_Programmer_CLI.
    echo --- 
    echo Usage:
    echo      mcu-flash.bat [file] [mem_add]: flash the [file] on the MCU mem_add
    echo                                      if mem_add is not defined use 0x08000000 as default.
    echo      mcu-flash.bat -h: print this message

:EOF
@echo on