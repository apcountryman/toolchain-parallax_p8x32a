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
message( STATUS "CMakeLists.txt - pre project()" )
project( toolchain-parallax_p8x32a C CXX COGCXX )
message( STATUS "CMakeLists.text - post project()" )

# version
set( TOOLCHAIN_PARALLAX_P8X32A_MAJOR 0 )
set( TOOLCHAIN_PARALLAX_P8X32A_MINOR 0 )
set( TOOLCHAIN_PARALLAX_P8X32A_PATCH 0 )

# add a board option for loading
set( BOARD "eeprom" CACHE STRING "The board type to use when loading example programs" )

# add a burn option for loading
option( WRITE "Write example programs to EEPROM when loading" OFF )
if( WRITE )
    set( WRITE_EEPROM "EEPROM" )

endif( WRITE )

# add a blink pin option for the blink example programs
set( BLINK_PIN    "0"    CACHE STRING "Blink example program blink pin" )
set( BLINK_CNT    "0"    CACHE STRING "Blink example program blink count (0 == infinite)" )
set( BLINK_PERIOD "1000" CACHE STRING "Blink example program blink period in milliseconds" )

# configure compilation and linking
set(
    CMAKE_C_FLAGS
    "${CMAKE_C_FLAGS} \
    -m${PARALLAX_P8X32A_MEMORY_MODEL} \
    --std=c99 \
    -Werror -Wall -Wpointer-arith -Wstrict-prototypes \
    "
)
set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} \
    -m${PARALLAX_P8X32A_MEMORY_MODEL} \
    -std=c++03 \
    -Werror -Wall -Wpointer-arith \
    "
)

# build the examples
add_subdirectory( examples )
