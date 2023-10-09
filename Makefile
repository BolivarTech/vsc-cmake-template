# ##############################################################################
# Make to generate project's files structures
# Author: Julian Bolivar
# Date: 2023-10-09
.PHONY: all build cmake clean install

BUILD_DIR := build
BUILD_TYPE ?= Debug

all: build install

${BUILD_DIR}/Makefile:
	cmake \
		-G "Unix Makefiles" \
		-B${BUILD_DIR} \
		-DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
		-DCMAKE_TOOLCHAIN_FILE=gcc-arm-none-eabi.cmake \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=ON

cmake: ${BUILD_DIR}/Makefile

build: cmake
	$(MAKE) -C ${BUILD_DIR} --no-print-directory

install:
	$(MAKE) -C ${BUILD_DIR} install

clean:
	rd /s /q $(BUILD_DIR)
