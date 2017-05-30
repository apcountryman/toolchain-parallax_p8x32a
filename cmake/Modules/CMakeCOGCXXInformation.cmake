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

# File: CMakeCOGCXXInformation.cmake
# Description: Set up rule variables for COG C++.

# object extension
set( CMAKE_COGCXX_OUTPUT_EXTENSION .cog )

# compiler name without platform specific extensions
set( CMAKE_BASE_NAME g++ )

# load platform specific information
include( Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_BASE_NAME}-${CMAKE_SYSTEM_PROCESSOR} REQUIRED )

# locate the objcopy script
set( CMAKE_COGCXX_OBJCOPY ${CMAKE_CURRENT_LIST_DIR}/CMakeCOGObjcopy.cmake )

# initialize flags
set( CMAKE_COGCXX_FLAGS_INIT "$ENV{COGCXXFLAGS} ${CMAKE_COGCXX_FLAGS_INIT}" )
set(
    CMAKE_COGCXX_FLAGS "${CMAKE_COGCXX_FLAGS_INIT}"
    CACHE STRING "Flags used by the compiler during all build types."
)

set(
    CMAKE_COGCXX_FLAGS_DEBUG "${CMAKE_COGCXX_FLAGS_DEBUG_INIT}"
    CACHE STRING "Flags used by the compiler during debug builds."
)
set(
    CMAKE_COGCXX_FLAGS_MINSIZEREL "${CMAKE_COGCXX_FLAGS_MINSIZEREL_INIT}"
    CACHE STRING "Flags used by the compiler during release builds for minimum size."
)
set(
    CMAKE_COGCXX_FLAGS_RELEASE "${CMAKE_COGCXX_FLAGS_RELEASE_INIT}"
    CACHE STRING "Flags used by the compiler during release builds."
)
set(
    CMAKE_COGCXX_FLAGS_RELWITHDEBINFO "${CMAKE_COGCXX_FLAGS_RELWITHDEBINFO_INIT}"
    CACHE STRING "Flags used by the compiler during release builds with debug info."
)

# object compilation
set(
    CMAKE_COGCXX_COMPILE_OBJECT
    "<CMAKE_COGCXX_COMPILER> <DEFINES> <FLAGS> -o <OBJECT> <SOURCE>"
    "${CMAKE_COMMAND} -DCMAKE_OBJCOPY=${CMAKE_OBJCOPY} -DOBJECT=<OBJECT> -P ${CMAKE_COGCXX_OBJCOPY}"
)

# mark the built in compiler flags as advanced
mark_as_advanced(
    CMAKE_COGCXX_FLAGS
    CMAKE_COGCXX_FLAGS_DEBUG
    CMAKE_COGCXX_FLAGS_MINSIZEREL
    CMAKE_COGCXX_FLAGS_RELEASE
    CMAKE_COGCXX_FLAGS_RELWITHDEBINFO
)
