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

# File: CMakeLists.txt
# Description: Core CMake rules for the Parallax P8X32A Propeller microcontroller CMake
#       toolchain example programs.

cmake_minimum_required( VERSION 3.0.2 )
project( toolchain-parallax_p8x32a C CXX )

# version
set( TOOLCHAIN_PARALLAX_P8X32A_MAJOR 0 )
set( TOOLCHAIN_PARALLAX_P8X32A_MINOR 1 )
set( TOOLCHAIN_PARALLAX_P8X32A_PATCH 0 )

# add a board option for loading
set( BOARD "eeprom" CACHE STRING "The board type to use when loading example programs" )

# add a configuration variable define option for loading
set( BOARD_CONFIG "" CACHE STRING "Board config variable patches to use when loading example programs" )
if( NOT "${BOARD_CONFIG}" STREQUAL "" )
    set( LOAD_DEFINE "DEFINE" ${BOARD_CONFIG} )

endif( NOT "${BOARD_CONFIG}" STREQUAL "" )

# add a burn option for loading
option( WRITE "Write example programs to EEPROM when loading example programs" OFF )
if( WRITE )
    set( LOAD_EEPROM "EEPROM" )

endif( WRITE )

# add an include path option for loading
set( BOARD_INCLUDE "" CACHE STRING "Add board paths to search when loading example programs" )
if( NOT "${BOARD_INCLUDE}" STREQUAL "" )
    set( LOAD_INCLUDE "INCLUDE" ${BOARD_INCLUDE} )

endif( NOT "${BOARD_INCLUDE}" STREQUAL "" )

# add a port option for loading
set( PORT "" CACHE STRING "The serial port to use when loading example programs" )
if( NOT "${PORT}" STREQUAL "" )
    set( LOAD_PORT "PORT" ${PORT} )

endif( NOT "${PORT}" STREQUAL "" )

# add a delay option for loading
set( DELAY "" CACHE STRING "Delay to use when loading example programs" )
if ( NOT "${DELAY}" STREQUAL "" )
    set( LOAD_SLOW "SLOW" ${DELAY} )

endif ( NOT "${DELAY}" STREQUAL "" )

# add a verbosity option for loading
option( VERBOSE "Enable verbose output when loading example programs" OFF )
if( VERBOSE )
    set( LOAD_VERBOSE "VERBOSE" )

endif( VERBOSE )

# add options for configuring the blink example programs
set( BLINK_PIN    "0"    CACHE STRING "Blink example program blink pin" )
set( BLINK_CNT    "0"    CACHE STRING "Blink example program blink count (0 == infinite)" )
set( BLINK_PERIOD "1000" CACHE STRING "Blink example program blink period in milliseconds" )

# configure compilation and linking
set(
    CMAKE_C_FLAGS
    "${CMAKE_C_FLAGS} \
    -m${PARALLAX_P8X32A_MEMORY_MODEL} \
    --std=gnu99 \
    -Werror -Wall -Wpointer-arith -Wstrict-prototypes \
    -mfcache -fno-exceptions \
    "
)
set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} \
    -m${PARALLAX_P8X32A_MEMORY_MODEL} \
    -std=gnu++0x \
    -Werror -Wall -Wpointer-arith \
    -mfcache -fno-exceptions -fno-rtti \
    "
)

# build the examples
add_subdirectory( examples )
