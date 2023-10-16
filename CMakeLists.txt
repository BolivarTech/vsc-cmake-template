# ##############################################################################
# Template CMakeLists.txt configuration for STM32 MCUS
# Author: Julian Bolivar
# Version: 1.0.0
# Date: 2023-10-08
# ##############################################################################
# CMake Project Setup
cmake_minimum_required(VERSION 3.27)

# To include cross compiling toolchain
#include(./gcc-arm-none-eabi.cmake)

project("cmake-test"
        VERSION 1.0.0
        LANGUAGES C CXX ASM)

enable_language(C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)
# ##############################################################################

# ##############################################################################
# MCU Specific Setup
# Edit your MCU information up to the next border
set(MCU_FAMILY STM32U5xx)
set(MCU_MODEL STM32U575xx)
set(CPU_PARAMETERS
    -mcpu=cortex-m33
    -mfpu=fpv4-sp-d16
    -mfloat-abi=hard
    -mthumb)

set(STARTUP_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/CubeMX/src/startup_stm32u575xx.s)
set(MCU_LINKER_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/CubeMX/STM32U575xx_FLASH.ld)
# Default MCU base flash Memory Address
set(MCU_MEM_ADD 0x08000000)
# ##############################################################################

# ##############################################################################
# Project Build Specific Setups
set(PROJECT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Project)

if(NOT DEFINED CMAKE_BUILD_TYPE AND DEFINED ENV{CMAKE_BUILD_TYPE})
    set(CMAKE_BUILD_TYPE $ENV{CMAKE_BUILD_TYPE})
elseif(NOT DEFINED CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

MESSAGE(STATUS "Using build type: ${CMAKE_BUILD_TYPE}")

if(NOT DEFINED CMAKE_GENERATOR AND DEFINED ENV{CMAKE_GENERATOR})
    set(CMAKE_GENERATOR $ENV{CMAKE_GENERATOR})
elseif(NOT DEFINED CMAKE_GENERATOR)
    set(CMAKE_GENERATOR "Unix Makefiles")
endif()

MESSAGE(STATUS "Using cmake generator: ${CMAKE_GENERATOR}")

# if a toolchain file is used, the user wants to cross compile.
# in this case read the toolchain file and keep the CMAKE_HOST_SYSTEM_*
# variables around so they can be used in CMakeLists.txt.
# In all other cases, the host and target platform are the same.
if(NOT DEFINED CMAKE_TOOLCHAIN_FILE AND DEFINED ENV{CMAKE_TOOLCHAIN_FILE})
    set(CMAKE_TOOLCHAIN_FILE $ENV{CMAKE_TOOLCHAIN_FILE})
elseif(NOT DEFINED CMAKE_TOOLCHAIN_FILE)
    set(CMAKE_TOOLCHAIN_FILE "gcc-arm-none-eabi.cmake")
endif()

MESSAGE(STATUS "Using toolchain file: ${CMAKE_TOOLCHAIN_FILE}")
# ##############################################################################

# ##############################################################################    
# MCU Code
# Headers
set(CUBEMX_INCLUDE_DIRECTORIES
    ${CMAKE_CURRENT_SOURCE_DIR}/Core/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/Drivers/${MCU_FAMILY}_HAL_Driver/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/Drivers/${MCU_FAMILY}_HAL_Driver/Inc/Legacy
    ${CMAKE_CURRENT_SOURCE_DIR}/Drivers/CMSIS/Device/ST/${MCU_FAMILY}/Include
    ${CMAKE_CURRENT_SOURCE_DIR}/Drivers/CMSIS/Include
    ${CMAKE_CURRENT_SOURCE_DIR}/CubeMX/include)

# Sources
file(GLOB_RECURSE STM32CUBEMX_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/Core/*.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Drivers/*.c
    ${CMAKE_CURRENT_SOURCE_DIR}/CubeMX/*.c)
# ##############################################################################    

# ##############################################################################    
# Project Subdirectory
# Add Headers
set(PROJECT_INCLUDE_DIRECTORIES 
    ${PROJECT_DIR}/include)

# Add Sources
file(GLOB_RECURSE PROJECT_SOURCES FOLLOW_SYMLINKS
    ${PROJECT_DIR}/src/*.cpp
    ${PROJECT_DIR}/src/*.c
    ${PROJECT_DIR}/src/*.s)
# ##############################################################################    

# ##############################################################################
# Executable Setup
set(EXECUTABLE ${CMAKE_PROJECT_NAME})

add_executable(${EXECUTABLE}
    ${STM32CUBEMX_SOURCES} 
    ${PROJECT_SOURCES}
    ${STARTUP_SCRIPT})

# Embedded macros(defines)
target_compile_definitions(${EXECUTABLE} PRIVATE
    ${MCU_MODEL}
    USE_HAL_DRIVER
    USE_FULL_LL_DRIVER
    STM32_THREAD_SAFE_STRATEGY=2)

# Add header directories (AFTER add_executable !!)
target_include_directories(${EXECUTABLE} PRIVATE
    ${CUBEMX_INCLUDE_DIRECTORIES}
    ${PROJECT_INCLUDE_DIRECTORIES})

# Compiler and linker options
target_compile_options(${EXECUTABLE} PRIVATE
    ${CPU_PARAMETERS}
    -Wall
    -Wextra
    -Wpedantic
    -Wno-unused-parameter
    $<$<COMPILE_LANGUAGE:CXX>:
        -Wno-volatile
        -Wold-style-cast
        -Wuseless-cast
        -Wsuggest-override>
    $<$<CONFIG:Debug>:-Og -g3 -ggdb>
    $<$<CONFIG:Release>:-Og -g0>)

target_link_options(${EXECUTABLE} PRIVATE
    -T${MCU_LINKER_SCRIPT}
    ${CPU_PARAMETERS}
    -Wl,-Map=${CMAKE_PROJECT_NAME}.map
    -Wl,--gc-sections
    --specs=nosys.specs
    -Wl,--start-group
    -lc
    -lm
    -lnosys
    -lstdc++
    -Wl,--end-group
    -Wl,--print-memory-usage)

add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${EXECUTABLE}>)

add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${EXECUTABLE}>
    ${EXECUTABLE}.hex
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${EXECUTABLE}>
    ${EXECUTABLE}.bin)
# ##############################################################################

# ##############################################################################
# use the install to Flash on the MCU

file(COPY ./mcu-flash.bat
    DESTINATION ${CMAKE_BINARY_DIR})

install(CODE "execute_process(COMMAND ${CMAKE_BINARY_DIR}/mcu-flash.bat \
        ${EXECUTABLE}${CMAKE_EXECUTABLE_SUFFIX_CXX} ${MCU_MEM_ADD})"
        COMPONENT ${EXECUTABLE})
# ##############################################################################