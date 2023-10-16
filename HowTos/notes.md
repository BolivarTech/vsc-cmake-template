# Notes

to flash the MCU
STM32_Programmer_CLI -c port=swd speed=Reliable -e all -w .\cmake-test.elf 0x08000000 -v -rst -run -score -vb 1