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

# File: CMakeDetermineCOGCCompiler.cmake
# Description: Find the COG C compiler and configure CMakeCOGCCompiler.cmake.in.

# insist that the COG C compiler be provided by the user or a toolchain
if( NOT CMAKE_COGC_COMPILER )
    message( FATAL_ERROR "CMAKE_COGC_COMPILER must be set by the user or a toolchain" )

endif( NOT CMAKE_COGC_COMPILER )

# store COG C compiler information
configure_file(
    ${CMAKE_CURRENT_LIST_DIR}/CMakeCOGCCompiler.cmake.in
    ${CMAKE_PLATFORM_INFO_DIR}/CMakeCOGCCompiler.cmake
    @ONLY
)

# set CMake's compiler environment variable for the language
set( CMAKE_COGC_COMPILER_ENV_VAR "COGC" )
