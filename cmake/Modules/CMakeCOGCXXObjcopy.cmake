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

# File: CMakeCOGCXXObjcopy.cmake
# Description: Run objcopy on an embedded C++ cog program so that it can be linked into a
#       larger program.

message( STATUS "CMakeCOGCXXObjcopy.cmake" )

# extract the name of the object file
get_filename_component( OBJECT_NAME ${OBJECT} NAME )

# extract the location of the object file
get_filename_component( OBJECT_DIR  ${OBJECT} DIRECTORY )

message( STATUS "CMAKE_OBJCOPY ${CMAKE_OBJCOPY}" )
message( STATUS "OBJECT        ${OBJECT}" )
message( STATUS "OBJECT_NAME   ${OBJECT_NAME}" )
message( STATUS "OBJECT_DIR    ${OBJECT_DIR}" )

# run objcopy
execute_process(
    COMMAND ${CMAKE_OBJCOPY} --localize-text --rename-section .text=led_blinker.cog ${OBJECT_NAME}
    WORKING_DIRECTORY ${OBJECT_DIR}
    RESULT_VARIABLE OBJCOPY_RESULT
)

# halt the build if there was an objcopy error
if ( ${OBJCOPY_RESULT} )
    message( FATAL_ERROR "CMakeCOGCXXObjcopy.cmake failure: ${OBJCOPY_RESULT}" )

endif ( ${OBJCOPY_RESULT} )
