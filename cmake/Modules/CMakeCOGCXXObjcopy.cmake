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
# Parameters:
#       - CMAKE_OBJCOPY: The objcopy program to run.
#       - OBJECT: The object file to run objcopy on.

# extract the name of the object file
get_filename_component( OBJECT_NAME ${OBJECT} NAME )

# extract the name of the object file with the file extension removed
get_filename_component( OBJECT_NAME_WE ${OBJECT} NAME_WE )

# extract the location of the object file
get_filename_component( OBJECT_DIR  ${OBJECT} DIRECTORY )

# run objcopy
execute_process(
    COMMAND ${CMAKE_OBJCOPY} --localize-text --rename-section .text=${OBJECT_NAME_WE}.cog ${OBJECT_NAME}
    WORKING_DIRECTORY ${OBJECT_DIR}
    RESULT_VARIABLE OBJCOPY_RESULT
)

# halt the build if there was an objcopy error
if ( ${OBJCOPY_RESULT} )
    message( FATAL_ERROR "CMakeCOGCXXObjcopy.cmake failure: ${OBJCOPY_RESULT}" )

endif ( ${OBJCOPY_RESULT} )
