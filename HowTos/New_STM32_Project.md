# Create new STM32 Project

Create the project directory and open it on VSCODE and save the Workspace, save it is optional but is helpful to isolate the workspace environment setup.

![Save Workspace](../images/Save_Workspace.png)

Select the STM32 Extension on the left panel.

![STM32 Extension](../images/Select_STM32.png)

On the Project Manager section select "*Create a new application project*"

![STM32 New Project](../images/Create_New_Project.png)

This will open the STM32CubeMX environment to create a new STM32 project, on the "*I Need to*" section you can select if you need create the project based on the MCU, a development board or one example.

![STM32CubeMX New Project](../images/STM32CuveMX-New-Project.png)

On this case I'm using the [NUCLEO-U575ZI-Q](https://www.st.com/en/evaluation-tools/nucleo-u575zi-q.html) development board.

![NUCLEO-U575ZI-Q](../images/Nucleo-U575ZI-Q.jpg)

At the "*I Need To*" section I select "*Access to Boad Selector*" and that will open a new windows to select the board used on the project.

![STM32 Board Selector](../images/STM32-Board-Selector.png)

After select the MCU to use, or on this case the board, click on "*Start Project*" and this will open STM32CubeMX to setup the MCU hardware.

On this windows all the pins, clocks and other specific hardware setups needs to be done.

![STM32 Hardware setup](../images/STMCubeMX-Project-Setup.png)

On the "*Project Manager*" tab the environment needs to be configured.

At the "*Project*" section is important to set the "*Project Name*", "*Project Location*" and on the "*Toolchain/IDE*" select '**Makefile**' option.

![Project Manager ](../images/STMCubeMX-ProjectManager-1.png)

On the "*Code Generator*" section select "*Copy only the necessary library files*"

![Code Generator](../images/STMCubeMX-ProjectManager-2.png)

On this sections all the specific project's configurations needs to be done, this are the basic setup at a STM32 Makefile project.

To generate the code click on "*Generate Code*" and all the code skeleton will be generated on the project folder.

![STM32 Project Skeleton](../images/STM32-Project-Skeleton.png)

After this a Makefile is create on the project's root workspace, including all the files required to create the project.

on VSCODE open a new terminal and excecute "**make all**" on the project's root directory, a '*build*' directory should be created and on it all the compile objects and the .bin, .elf, .hex and .map files.

![STM32 Project Makefile](../images/STM32CubeMX-Makefile.png)

On this way the STM32 project skeleton was created to use Makefiles to build it.
