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
set( TOOLCHAIN_PARALLAX_P8X32A_MINOR 0 )
set( TOOLCHAIN_PARALLAX_P8X32A_PATCH 0 )

# add a blink pin option for the blink example programs
set( BLINK_PIN 0 CACHE STRING "Blink example program blink pin" )
if( NOT BLINK_PIN MATCHES "^([0-9]|1[0-9]|2[0-7])$" )
    message( FATAL_ERROR "BLINK_PIN must be a number between 0 and 27 inclusive" )

endif( NOT BLINK_PIN MATCHES "^([0-9]|1[0-9]|2[0-7])$" )


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
