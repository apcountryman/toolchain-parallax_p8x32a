# toolchain-parallax_p8x32a
#
# Copyright 2017 Andrew Countryman <apcountryman@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
# file except in compliance with the License. You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under
# the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the specific language governing
# permissions and limitations under the License.

# File: toolchain.cmake
# Description: Parallax P8X32A Propeller microcontroller CMake toolchain.

message( STATUS "toolchain.cmake" )

#
set( CMAKE_SYSTEM_NAME "Generic" )
set( CMAKE_SYSTEM_PROCESSOR "Parallax P8X32A" )

# add toolchain specific CMake modules to the CMake modules path
list( APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/Modules" )

# mark the toolchain file as advanced
mark_as_advanced( CMAKE_TOOLCHAIN_FILE )

# mark unused, built-in CMake variables as advanced
mark_as_advanced( CMAKE_INSTALL_PREFIX )

# locate build tools
find_program( CMAKE_C_COMPILER      propeller-elf-gcc )
find_program( CMAKE_CXX_COMPILER    propeller-elf-g++ )
find_program( CMAKE_COGCXX_COMPILER propeller-elf-g++ )
find_program( CMAKE_LINKER          propeller-elf-ld )
find_program( CMAKE_NM              propeller-elf-nm )
find_program( CMAKE_OBJCOPY         propeller-elf-objcopy )
find_program( CMAKE_OBJDUMP         propeller-elf-objdump )
find_program( CMAKE_RANLIB          propeller-elf-ranlib )
find_program( CMAKE_STRIP           propeller-elf-strip )

mark_as_advanced( CMAKE_COGCXX_COMPILER )

# locate load tools
find_program( PARALLAX_P8X32A_LOADER propeller-load )
mark_as_advanced( PARALLAX_P8X32A_LOADER )

# provide an optional memory model configuration variable
set(
    PARALLAX_P8X32A_MEMORY_MODELS
    "cog"
    "lmm"
    "xmm"
    "xmmc"
    "xmm-single"
    "xmm-split"
)
list( SORT PARALLAX_P8X32A_MEMORY_MODELS )
set( PARALLAX_P8X32A_MEMORY_MODEL "lmm" CACHE STRING "Parallax P8X32A memory model" )

list(
    FIND PARALLAX_P8X32A_MEMORY_MODELS
    ${PARALLAX_P8X32A_MEMORY_MODEL}
    VALID_MEMORY_MODEL
)
if ( ${VALID_MEMORY_MODEL} LESS 0 )
    message( FATAL_ERROR "${PARALLAX_P8X32A_MEMORY_MODEL} is not a valid memory model" )

endif ( ${VALID_MEMORY_MODEL} LESS 0 )

# Add a basic load target for an executable.
#
# SYNOPSIS:
#       parallax_p8x32a_add_load_target( <executable>
#                                        [EEPROM] [RUN] [TERMINAL]
#                                        [BOARD <board>] )
#
# OPTIONS:
#       BOARD <board>
#           Adds propeller-load's "-b <type>" option where "<type>" is <board>.
#       EEPROM
#           Adds propeller-load's "-e" option.
#       <executable>
#           The name of the executable to make the load target for.
#       RUN
#           Adds propeller-load's "-r" option.
#       TERMINAL
#           Adds propeller-load's "-t" option.
# EXAMPLES:
#       parallax_p8x32a_add_load_target( foo RUN )
#       parallax_p8x32a_add_load_target( foo RUN BOARD eeprom )
#       parallax_p8x32a_add_load_target( foo RUN TERMINAL BOARD eeprom )
#       parallax_p8x32a_add_load_target( foo EEPROM RUN BOARD eeprom )
function( parallax_p8x32a_add_load_target EXECUTABLE )
    set( options EEPROM RUN TERMINAL )
    set( one_value_args BOARD )
    set( multi_value_args )
    include( CMakeParseArguments )
    cmake_parse_arguments(
        parallax_p8x32a_add_load_target
        "${options}"
        "${one_value_args}"
        "${multi_value_args}"
        ${ARGN}
    )

    # configure loader arguments
    set( loader_args "" )

    if( parallax_p8x32a_add_load_target_EEPROM )
        set( loader_args ${loader_args} "-e" )

    endif( parallax_p8x32a_add_load_target_EEPROM )

    if( parallax_p8x32a_add_load_target_RUN )
        set( loader_args ${loader_args} "-r" )

    endif( parallax_p8x32a_add_load_target_RUN )

    if( parallax_p8x32a_add_load_target_TERMINAL )
        set( loader_args ${loader_args} "-t" )

    endif( parallax_p8x32a_add_load_target_TERMINAL )

    if( NOT "${parallax_p8x32a_add_load_target_BOARD}" STREQUAL "" )
        set( loader_args ${loader_args} "-b" ${parallax_p8x32a_add_load_target_BOARD} )

    endif( NOT "${parallax_p8x32a_add_load_target_BOARD}" STREQUAL "" )

    # add the load target
    add_custom_target(
        ${EXECUTABLE}-load
        COMMAND ${PARALLAX_P8X32A_LOADER} ${loader_args} ${EXECUTABLE}
        DEPENDS ${EXECUTABLE}
    )
endfunction( parallax_p8x32a_add_load_target )
