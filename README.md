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

## Example Programs
Example programs for blinking a LED, and displaying a "Hello, world!" message are
provided. Each example program has two implementations: one written in C, the other in
C++. Both implementations use the same general design.

The example programs' usage of `parallax_p8x32a_add_load_target()` is more complex than
what most projects will need. This was done to allow configuration of loader parameters
using CMake cache variables.

### Building
Create a build directory, initialize the build directory, and build the example programs.
```
$ mkdir build
$ cd build
$ cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain.cmake ..
$ make
```

### General Configuration
By default, the example programs are configured to use the `lmm` memory model and the
`eeprom` board type, and not load the program to EEPROM. For details on changing these and
other configuration options, refer to
[Usage: Optional CMake Variables](#optional-cmake-variables).

### blink
For the blink example programs, the pin the LED is connected to, the number of times the
LED is blinked, and the period of the LED blink are configurable. This is done using the
following CMake cache variables:
```
BLINK_LED_PIN
BLINK_CNT
BLINK_PERIOD
```

To load a blink example program, build one of the following make targets:
```
example-c-blink-load
example-c++-blink-load
```

### "Hello, world!"
The "Hello, world!" example program requires no configuration. To load a "Hello, world!"
example program, build one of the following make targets:
```
example-c-hello_world-load
example-c++-hello_world-load
```

## git Hooks
To install this repository's git hooks, run the `install` script which is located in the
`hooks` directory.
```
$ ./hooks/install
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
