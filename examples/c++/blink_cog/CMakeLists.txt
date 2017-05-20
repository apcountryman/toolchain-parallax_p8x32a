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
#       toolchain blink cog C++ example program.

# build the blink cog program
add_executable(
    example-c++-blink_cog
    main.cc
    led_blinker.cogcc
)
target_compile_definitions(
    example-c++-blink_cog
    PRIVATE BLINK_LED_PIN=${BLINK_LED_PIN}
    PRIVATE BLINK_CNT=${BLINK_CNT}
    PRIVATE BLINK_PERIOD=${BLINK_PERIOD}
)
parallax_p8x32a_add_load_target(
    example-c++-blink_cog
    ${WRITE_EEPROM} RUN
    BOARD ${BOARD}
)
