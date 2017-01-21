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
# Description: CMake rules for the Parallax P8X32A Propeller microcontroller CMake
#       toolchain blink C example program.

# add a blink pin CMake option
set( BLINK_PIN 0 CACHE STRING "Blink example program blink pin" )
if( NOT BLINK_PIN MATCHES "^([0-9]|1[0-9]|2[0-7])$" )
    message( FATAL_ERROR "BLINK_PIN must be a number between 0 and 27 inclusive" )

endif( NOT BLINK_PIN MATCHES "^([0-9]|1[0-9]|2[0-7])$" )

# build the hello world program
add_executable(
    example-c-blink
    main.c
)
target_compile_definitions(
    example-c-blink
    PRIVATE BLINK_PIN=${BLINK_PIN}
)
