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

# File: CMakeDetermineCOGCXXCompiler.cmake
# Description: Find the COG C++ compiler and configure CMakeCOGCXXCompiler.cmake.in.

message( STATUS "CMakeDetermineCOGCXXCompiler.cmake" )

# insist that the COG C++ compiler be provided by the user or a toolchain
if( NOT CMAKE_COGCXX_COMPILER )
    message( FATAL_ERROR "CMAKE_COGCXX_COMPILER must be set by the user or a toolchain" )

endif( NOT CMAKE_COGCXX_COMPILER )

# TODO: Not sure why this is required, guessing it allows specification of the COG C++
#       compiler using an environment variable?
set( CMAKE_COGCXX_COMPILER_ENV_VAR "COGCXX" )
