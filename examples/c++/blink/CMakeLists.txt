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
#       toolchain blink C++ example program.

# build the blink program
add_executable(
    example-c++-blink
    main.cc
)
target_compile_definitions(
    example-c++-blink
    PRIVATE BLINK_PIN=${BLINK_PIN}
)
parallax_p8x32a_add_load_target(
    example-c++-blink
    ${WRITE_EEPROM} RUN
    BOARD ${BOARD}
)
