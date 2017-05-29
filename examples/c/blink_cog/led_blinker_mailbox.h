/**
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

/**
 * \file led_blinker_mailbox.h
 * \brief LED blinker mailbox interface.
 */

#ifndef LED_BLINKER_MAILBOX_H
#define LED_BLINKER_MAILBOX_H

#include <stdbool.h>

/**
 * \brief A LED blinker communication mailbox.
 */
typedef struct LED_Blinker_Mailbox_ {
    /**
     * \brief Blinking completion signal.
     */
    bool volatile complete;

    /**
     * \brief The pin the LED is connected to.
     */
    unsigned int pin;

    /**
     * \brief The number of times to blink the LED.
     */
    unsigned int n;

    /**
     * \brief The blinking period in milliseconds.
     */
    unsigned int period;
} LED_Blinker_Mailbox;

/**
 * \brief Initialize a LED blinker communication mailbox.
 *
 * \param[in] pin The pin the LED is connected to. If pin is greater than 31, no LED will
 *            be blinked.
 * \param[in] n The number of times to blink the LED. If n is 0, the LED will be blinked
 *            infinitely. If n is greater than UINT_MAX / 2, no LED will be blinked.
 * \param[in] period The blinking period in milliseconds. If period is less than 2, no LED
 *            will be blinked.
 */
#define LED_BLINKER_MAILBOX_CONSTRUCT( pin, n, period ) (LED_Blinker_Mailbox){ \
    .complete = false, \
    .pin      = pin, \
    .n        = n, \
    .period   = period, \
}

#endif // LED_BLINKER_MAILBOX_H
