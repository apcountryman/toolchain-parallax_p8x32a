/*
 * toolchain-parallax_p8x32a
 *
 * Copyright 2017 Andrew Countryman <apcountryman@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
 * file except in compliance with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under
 * the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
 * ANY KIND, either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */

/*
 * File: main.c
 * Description: Blink C example program.
 */

#include <propeller.h>

// ensure the blink pin has been defined
#ifndef BLINK_PIN
    #error "Blink pin not defined"

#endif

// ensure the blink pin is a valid pin and is not a pin used for special purposes
#if BLINK_PIN > 27
    #error "Excessive blink pin"

#endif

int main( void )
{
    // calculate the bitmask for toggling the blink pin
    uint32_t const blink_mask = 1 << BLINK_PIN;

    // configure the blink pin as an output
    DIRA |= blink_mask;

    // toggle the blink pin at 1 Hz
    for ( ;; ) {
        // wait 0.5 seconds
        waitcnt( CNT + CLKFREQ / 2 );

        // toggle the state of the blink pin
        OUTA ^= blink_mask;

    } // for

    return 0;
}
