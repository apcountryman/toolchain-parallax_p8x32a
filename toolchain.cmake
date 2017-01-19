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

# File: toolchain.cmake
# Description: Parallax P8X32A Propeller microcontroller CMake toolchain.

#
set( CMAKE_SYSTEM_NAME "Generic" )
set( CMAKE_SYSTEM_PROCESSOR "Parallax P8X32A" )

# locate build tools
find_program( PARALLAX_P8X32A_C_COMPILER   propeller-elf-gcc )
find_program( PARALLAX_P8X32A_CXX_COMPILER propeller-elf-g++ )
find_program( PARALLAX_P8X32A_LINKER       propeller-elf-ld )
find_program( PARALLAX_P8X32A_NM           propeller-elf-nm )
find_program( PARALLAX_P8X32A_OBJCOPY      propeller-elf-objcopy )
find_program( PARALLAX_P8X32A_OBJDUMP      propeller-elf-objdump )
find_program( PARALLAX_P8X32A_RANLIB       propeller-elf-ranlib )
find_program( PARALLAX_P8X32A_STRIP        propeller-elf-strip )

# locate load tools
find_program( PARALLAX_P8X32A_LOADER       propeller-load )

# configure CMake tools
set( CMAKE_C_COMPILER   ${PARALLAX_P8X32A_C_COMPILER} )
set( CMAKE_CXX_COMPILER ${PARALLAX_P8X32A_CXX_COMPILER} )
set( CMAKE_LINKER       ${PARALLAX_P8X32A_LINKER} )
set( CMAKE_NM           ${PARALLAX_P8X32A_NM} )
set( CMAKE_OBJCOPY      ${PARALLAX_P8X32A_OBJCOPY} )
set( CMAKE_OBJDUMP      ${PARALLAX_P8X32A_OBJDUMP} )
set( CMAKE_RANLIB       ${PARALLAX_P8X32A_RANLIB} )
set( CMAKE_STRIP        ${PARALLAX_P8X32A_STRIP} )

# configure the Parallax P8X32A memory model
set(
    PARALLAX_P8X32A_MEMORY_MODELS
    "cog"
    "lmm"
    "xmm"
    "xmmc"
    "xmm-single"
    "xmm-split"
)
list( SORT PARALLAX_P8X32A_MEMORY_MODELS )
set( PARALLAX_P8X32A_MEMORY_MODEL "lmm" CACHE STRING "Parallax P8X32A memory model" )

list( FIND PARALLAX_P8X32A_MEMORY_MODELS ${PARALLAX_P8X32A_MEMORY_MODEL} VALID_MEMORY_MODEL )
if ( ${VALID_MEMORY_MODEL} LESS 0 )
    message( SEND_ERROR "${PARALLAX_P8X32A_MEMORY_MODEL} is not a valid memory model" )

endif ( ${VALID_MEMORY_MODEL} LESS 0 )
