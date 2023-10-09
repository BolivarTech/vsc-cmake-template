# Project Details

![Environment](https://img.shields.io/badge/environment-VSC-darkgreen)
![licence](https://img.shields.io/badge/script-cmake-brightgreen.svg?style=flat-square)
![licence](https://img.shields.io/badge/language-c/c++-brightgreen.svg?style=flat-square)
![license](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)

This project is a simple CMake script to compile and install STM32 MCU Projets on Visual Studio Code.

This poject is provided "AS IS", no waranty, no responsabilities, no more documentation that the one included in this repository, but the scripts are so simples that is don't needed. ;-)

## Dependencies

This scripts use the cmake and make command on the windows environments
in your environment.

## Notes

to flash the MCU
STM32_Programmer_CLI -c port=swd speed=Reliable -e all -w .\cmake-test.elf 0x08000000 -v -rst -run -score -vb 1

## Generate Config Files

### Add Capabilities

### Optional Features

### Credits

- [Julian Bolivar](https://www.bolivartech.com)

### License

Copyright © [BolivarTech](https://www.bolivartech.com) 2023 All Rights Reserved.

Visual Studio Code cmake template for STM32 MCUs © 2023 by [Julian Bolivar](https://www.bolivartech.com) is licensed under [Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/legalcode)

Please see [License File](LICENSE.md) for more information.
