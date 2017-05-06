# toolchain-parallax_p8x32a
toolchain-parallax_p8x32a is a CMake toolchain for the Parallax P8X32A Propeller
microcontroller.

## Obtaining the Source Code
HTTPS:
```
git clone https://github.com/apcountryman/toolchain-parallax_p8x32a.git
```
SSH:
```
git clone git@github.com:apcountryman/toolchain-parallax_p8x32a.git
```

## Dependencies
- CMake 3.0.2 +
- propeller-elf-gcc/propeller-elf-g++ ? + (tested with 4.6.1)
- Parallax P8X32A Propeller Binutils ? + (tested with 2.21)
- propeller-load ? + (program does not report version)

## Usage

### Finding Tools
This toolchain expects to find `propeller-elf-gcc`, `propeller-elf-g++`, the associated
binary utilities, and `propeller-load` in the path(s) searched by CMake `find_program()`.
If the toolchain fails to locate tools, consult the documentation of `find_program()`.

### Addling Loader Targets
To add load targets for an executable, use the `parallax_p8x32a_add_load_target()`
function provided by the toolchain. For an executable `foo`, this function adds build
target `foo-load` for loading the executable.

`parallax_p8x32a_add_load_target()` has only one required parameter, the name of the
executable to create a load target for. For details on the optional arguments, and what
they default to when not provided, consult `parallax_p8x32a_add_load_target()`'s
documentation found in the `toolchain.cmake` file.

### Optional CMake Variables
In addition to providing a method for adding load targets for executables, optional
convenience cache variables are provided for controlling compilation and loading. For
details on what variables are available for use, see the `toolchain.cmake` file. Usage of
these variables is demonstrated in the `CMakeLists.txt` files for the example programs.

## git Hooks
To install this repository's git hooks, run the `install` script which is located in the
`hooks` directory.
```
./hooks/install
```

## Authors
- Andrew Countryman

## License
Copyright 2017 Andrew Countryman <apcountryman@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file
except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the
License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
either express or implied. See the License for the specific language governing
permissions and limitations under the License.
