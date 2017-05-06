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

# system information
set( CMAKE_SYSTEM_NAME "Generic" )
set( CMAKE_SYSTEM_PROCESSOR "Parallax-P8X32A" )

# mark the toolchain file as advanced
mark_as_advanced( CMAKE_TOOLCHAIN_FILE )

# mark unused, built-in CMake variables as advanced
mark_as_advanced( CMAKE_INSTALL_PREFIX )

# locate build tools
find_program( CMAKE_C_COMPILER   propeller-elf-gcc )
find_program( CMAKE_CXX_COMPILER propeller-elf-g++ )
find_program( CMAKE_LINKER       propeller-elf-ld )
find_program( CMAKE_NM           propeller-elf-nm )
find_program( CMAKE_OBJCOPY      propeller-elf-objcopy )
find_program( CMAKE_OBJDUMP      propeller-elf-objdump )
find_program( CMAKE_RANLIB       propeller-elf-ranlib )
find_program( CMAKE_STRIP        propeller-elf-strip )

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

# Add a load target (<executable>-load) for an executable.
#
# SYNOPSIS:
#       parallax_p8x32a_add_load_target( <executable>
#                                        [BOARD <board>]
#                                        [DEFINE] <variable> ...]
#                                        [EEPROM]
#                                        [INCLUDE <path> ...]
#                                        [PORT <port>]
#                                        [QUIT]
#                                        [RUN]
#                                        [SLOW <delay>]
#                                        [TERMINAL <baud>]
#                                        [VERBOSE] )
#
# OPTIONS:
#       BOARD <board>
#           Adds propeller-load's "-b <type>" option where "<type>" is <board>.
#       DEFINE <variable> ...
#           Adds propeller-load's "-D var=value" option where "var=value" is "<variable>".
#       EEPROM
#           Adds propeller-load's "-e" option.
#       <executable>
#           The name of the executable to make the load target for.
#       INCLUDE <path> ...
#           Adds propeller-load's "-I <path>" option.
#       PORT <port>
#           Adds propeller-load's "-p <port>" option.
#       QUIT
#           Adds propeller-load's "-q" option.
#       RUN
#           Adds propeller-load's "-r" option.
#       SLOW <delay>
#           Adds propeller-load's "-S<n>" option where "<n>" is "<delay>". If "<delay>" is
#           "DEFAULT", the default delay will be used.
#       TERMINAL <baud>
#           Adds propeller-load's "-t<baud>" option. If "<baud>" is "DEFAULT", the default
#           baud rate will be used.
#       VERBOSE
#           Adds propeller-load's "-v" option.
# EXAMPLES:
#       parallax_p8x32a_add_load_target( foo RUN )
#       parallax_p8x32a_add_load_target( foo RUN BOARD eeprom )
#       parallax_p8x32a_add_load_target( foo RUN TERMINAL 115200 BOARD eeprom )
#       parallax_p8x32a_add_load_target( foo EEPROM RUN BOARD eeprom )
function( parallax_p8x32a_add_load_target EXECUTABLE )
    set(
        options
        EEPROM
        QUIT
        RUN
        VERBOSE
    )
    set(
        one_value_args
        BOARD
        PORT
        SLOW
        TERMINAL
    )
    set(
        multi_value_args
        DEFINE
        INCLUDE
    )
    include( CMakeParseArguments )
    cmake_parse_arguments(
        parallax_p8x32a_add_load_target
        "${options}"
        "${one_value_args}"
        "${multi_value_args}"
        ${ARGN}
    )

    # ensure there are no unrecognized arguments
    if( ${parallax_p8x32a_add_load_target_UNPARSED_ARGUMENTS} )
        message(
            FATAL_ERROR
            "'${parallax_p8x32a_add_load_target_UNPARSED_ARGUMENTS}' are not recognized arguments"
        )
    endif( ${parallax_p8x32a_add_load_target_UNPARSED_ARGUMENTS} )

    # configure loader flags
    set( loader_flags "" )

    if( ${parallax_p8x32a_add_load_target_EEPROM} )
        list( APPEND loader_flags "-e" )

    endif( ${parallax_p8x32a_add_load_target_EEPROM} )

    if( ${parallax_p8x32a_add_load_target_QUIT} )
        list( APPEND loader_flags "-q" )

    endif( ${parallax_p8x32a_add_load_target_QUIT} )

    if( ${parallax_p8x32a_add_load_target_RUN} )
        list( APPEND loader_flags "-r" )

    endif( ${parallax_p8x32a_add_load_target_RUN} )

    if( ${parallax_p8x32a_add_load_target_VERBOSE} )
        list( APPEND loader_flags "-v" )

    endif( ${parallax_p8x32a_add_load_target_VERBOSE} )

    if( NOT "${parallax_p8x32a_add_load_target_BOARD}" STREQUAL "" )
        list( APPEND loader_flags "-b" ${parallax_p8x32a_add_load_target_BOARD} )

    endif( NOT "${parallax_p8x32a_add_load_target_BOARD}" STREQUAL "" )

    if( NOT "${parallax_p8x32a_add_load_target_PORT}" STREQUAL "" )
        list( APPEND loader_flags "-p" ${parallax_p8x32a_add_load_target_PORT} )

    endif( NOT "${parallax_p8x32a_add_load_target_PORT}" STREQUAL "" )

    if( NOT "${parallax_p8x32a_add_load_target_SLOW}" STREQUAL "" )
        if( "${parallax_p8x32a_add_load_target_SLOW}" STREQUAL "DEFAULT" )
            list( APPEND loader_flags "-S" )

        else( "${parallax_p8x32a_add_load_target_SLOW}" STREQUAL "DEFAULT" )
            list( APPEND loader_flags "-S${parallax_p8x32a_add_load_target_SLOW}" )

        endif( "${parallax_p8x32a_add_load_target_SLOW}" STREQUAL "DEFAULT" )

    endif( NOT "${parallax_p8x32a_add_load_target_SLOW}" STREQUAL "" )

    if( NOT "${parallax_p8x32a_add_load_target_TERMINAL}" STREQUAL "" )
        if( "${parallax_p8x32a_add_load_target_TERMINAL}" STREQUAL "DEFAULT" )
            list( APPEND loader_flags "-t" )

        else( "${parallax_p8x32a_add_load_target_TERMINAL}" STREQUAL "DEFAULT" )
            list( APPEND loader_flags "-t${parallax_p8x32a_add_load_target_TERMINAL}" )

        endif( "${parallax_p8x32a_add_load_target_TERMINAL}" STREQUAL "DEFAULT" )

    endif( NOT "${parallax_p8x32a_add_load_target_TERMINAL}" STREQUAL "" )

    if( NOT "${parallax_p8x32a_add_load_target_DEFINE}" STREQUAL "" )
        foreach( config_variable IN ITEMS ${parallax_p8x32a_add_load_target_DEFINE} )
            list( APPEND loader_flags "-D" ${config_variable} )

        endforeach( config_variable IN ITEMS ${parallax_p8x32a_add_load_target_DEFINE} )

    endif( NOT "${parallax_p8x32a_add_load_target_DEFINE}" STREQUAL "" )

    if( NOT "${parallax_p8x32a_add_load_target_INCLUDE}" STREQUAL "" )
        foreach( path IN ITEMS ${parallax_p8x32a_add_load_target_INCLUDE} )
            list( APPEND loader_flags "-I" ${path} )

        endforeach( path IN ITEMS ${parallax_p8x32a_add_load_target_INCLUDE} )

    endif( NOT "${parallax_p8x32a_add_load_target_INCLUDE}" STREQUAL "" )

    # add the load target
    add_custom_target(
        ${EXECUTABLE}-load
        COMMAND ${PARALLAX_P8X32A_LOADER} ${loader_flags} ${EXECUTABLE}
        DEPENDS ${EXECUTABLE}
    )

endfunction( parallax_p8x32a_add_load_target )
