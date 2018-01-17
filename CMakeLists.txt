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
project(
    toolchain-parallax_p8x32a
    VERSION   0.2.4
    LANGUAGES C COGC CXX COGCXX
)

# add options for configuring the blink example programs
set( BLINK_LED_PIN "0"    CACHE STRING "Blink example program LED pin" )
set( BLINK_CNT     "0"    CACHE STRING "Blink example program blink count (0 == infinite)" )
set( BLINK_PERIOD  "1000" CACHE STRING "Blink example program blink period in milliseconds" )

# configure compilation and linking
set(
    CMAKE_C_FLAGS
    "${CMAKE_C_FLAGS} \
    -m${PARALLAX_P8X32A_MEMORY_MODEL} \
    --std=gnu1x \
    -Werror -Wall -Wpointer-arith -Wstrict-prototypes \
    -mfcache -fno-exceptions \
    -u __serial_exit \
    "
)
set(
    CMAKE_COGC_FLAGS
    "${CMAKE_COGC_FLAGS} \
    -std=gnu1x \
    -Werror -Wall -Wpointer-arith -Wstrict-prototypes \
    -fno-exceptions \
    "
)
set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} \
    -m${PARALLAX_P8X32A_MEMORY_MODEL} \
    -std=gnu++0x \
    -Werror -Wall -Wpointer-arith \
    -mfcache -fno-exceptions -fno-rtti \
    -u __serial_exit \
    "
)
set(
    CMAKE_COGCXX_FLAGS
    "${CMAKE_COGCXX_FLAGS} \
    -std=gnu++0x \
    -Werror -Wall -Wpointer-arith \
    -fno-exceptions -fno-rtti \
    "
)

# build the examples
add_subdirectory( examples )
