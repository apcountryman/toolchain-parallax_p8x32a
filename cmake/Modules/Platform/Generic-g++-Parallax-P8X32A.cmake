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

# File: Generic-g++-Parallax-P8X32A.cmake
# Description: Parallax P8X32A Propeller microcontroller specific configuration.

# common COG C++ flags
set( CMAKE_COGCXX_FLAGS_INIT "-Wno-main -r -mcog -xc++" )

# use C++ build type flags for COG C++
set( CMAKE_COGCXX_FLAGS_DEBUG_INIT          "${CMAKE_CXX_FLAGS_DEBUG_INIT}" )
set( CMAKE_COGCXX_FLAGS_MINSIZEREL_INIT     "${CMAKE_CXX_FLAGS_MINSIZEREL_INIT}" )
set( CMAKE_COGCXX_FLAGS_RELEASE_INIT        "${CMAKE_CXX_FLAGS_RELEASE_INIT}" )
set( CMAKE_COGCXX_FLAGS_RELWITHDEBINFO_INIT "${CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT}" )
