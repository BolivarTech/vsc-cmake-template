# Project Details

![OS](https://img.shields.io/badge/OS-Windows-darkgreen)
![Environment](https://img.shields.io/badge/environment-VSC-darkgreen)
![Platform](https://img.shields.io/badge/Platform-STM32-darkgreen)
![license](https://img.shields.io/badge/script-cmake-brightgreen.svg?style=flat-square)
![license](https://img.shields.io/badge/language-c/c++-brightgreen.svg?style=flat-square)
![license](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)

This project is a CMake script to compile and install STM32 MCU Projects on Visual Studio Code.

This project is provided "AS IS", no warranty, no responsibilities, no more documentation that the one included in this repository, but the scripts are so simples that it don't needed. ![winking](/images/winking.png)

## Dependencies

To setup the environment on Windows are necessary the following dependencies.

- [VisuaL Studio Code](https://code.visualstudio.com)
  - [STM32 VS Code Extension](https://marketplace.visualstudio.com/items?itemName=stmicroelectronics.stm32-vscode-extension)
  - [Makefile Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.makefile-tools)
  - [C/C++ Extension Pack by franneck94](https://marketplace.visualstudio.com/items?itemName=franneck94.vscode-c-cpp-dev-extension-pack)
  - [Cortex-Debug Extension](https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug)

- [STM32CubeCLT](https://www.st.com/en/development-tools/stm32cubeclt.html)
- [STM32CubeMX](https://www.st.com/en/development-tools/stm32cubemx.html)
- [STMCUFinder](https://www.st.com/en/development-tools/st-mcu-finder-pc.html)
- [Chocolatey](https://chocolatey.org)
  - [Git](https://community.chocolatey.org/packages/git)
  - [make](https://community.chocolatey.org/packages/make)
  - [cmake](https://community.chocolatey.org/packages/cmake)

The STM32CubeCLT include the ARM GNU Toolchain certified by ST, but if you whats
the lasted cross compiler toolchain provided by ARM you can download it from the
official ARM website.

- [ARM GNU Toolchain](https://developer.arm.com/Tools%20and%20Software/GNU%20Toolchain)

## Environment Setup

Install STM32CubeCLT, STM32CubeMX, STMCUFinder and Visual Studio Code that is an strait forward procedure, just follow the on screen steps.

Install Visual Studio Code's required extension.

Chocolatey is repository and packages management for Windows, it is like apt and yam on linux environments, making really easy the automatic packages install and administration on windows following DevOps automation approaches.

[Install Chocolatey](https://chocolatey.org/install#individual) is a little more complicated and is recommended follow the procedure on the link, but on summary the procedure is the follow.

1. Open PowerShell on administrative privileges (*Run as Administrator*)
2. With PowerShell, you must ensure *Get-ExecutionPolicy* is not *Restricted*. We suggest using *Bypass* to bypass the policy to get things installed or *AllSigned* for quite a bit more security.
3. Run *Get-ExecutionPolicy*. If it returns *Restricted*, then run *Set-ExecutionPolicy AllSigned* or *Set-ExecutionPolicy Bypass -Scope Process*.
4. Now run the following PowerShell command:

```PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

5. Paste the copied text into your shell and press Enter.
6. Wait a few seconds for the command to complete.
7. If you don't see any errors, you are ready to use Chocolatey! Type choco or choco -? now, or see Getting Started for usage instructions.


Now that Chocolatey is installed on your system, we can proceed to install the other dependencies using PowerShell.

To install Git, Make used the follow command:

```PowerShell
choco install git make -y
```

To install cmake some parameters needs to be passed as follow:

```PowerShell
choco install cmake --installargs 'ADD_CMAKE_TO_PATH=System DESKTOP_SHORTCUT_REQUESTED=1 ALLUSERS=1' -y
```

If you wants more information about Chocolatey is recommended read the [official documentation](https://docs.chocolatey.org/en-us) page.

## Project Setup

In this section will show how to setup a STM32 VSCODE project from scratch, but use some script files to do it straightforward.

To create the STM32 VSCODE project the following steps needs to be followed:

1. [Create STM32 Project](HowTos/New_STM32_Project.md)
2. [Setup Visual Studio Code](HowTos/Setup_VSCODE.md)
3. [Setup Visual Studio Code Cortex-Debug Extension](HowTos/Setup_Debug.md)
4. [Setup CMake](HowTos/Setup_CMake.md)

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
