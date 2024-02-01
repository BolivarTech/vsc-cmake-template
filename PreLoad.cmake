# ##############################################################################
# Template PreLoad.cmake configuration for ARM MCUS
# Author: Julian Bolivar
# Version: 2.0.0
# Date: 2024-02-01
# ##############################################################################
# CMake Project Setup:
#     Environment sets called before running the cmake script

set(CMAKE_GENERATOR "Unix Makefiles" CACHE INTERNAL "" FORCE)
message("Generator set to ${CMAKE_GENERATOR} on PreLoad.cmake")
