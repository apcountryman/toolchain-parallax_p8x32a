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
#       toolchain C example programs.

# build the blink program
add_subdirectory( blink )

# build the blink cog program
add_subdirectory( blink_cog )

# build the hello world program
add_subdirectory( hello_world )
