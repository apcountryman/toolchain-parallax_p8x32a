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
 * \brief LED blinker mailbox interface and implementation.
 */

#ifndef LED_BLINKER_MAILBOX_H
#define LED_BLINKER_MAILBOX_H

/**
 * \brief A LED blinker communication mailbox.
 */
struct LED_Blinker_Mailbox {
    public:
        /**
         * \brief Initialize the mailbox.
         *
         * \param[in] pin The pin the LED is connected to. If pin is greater than 31, no
         *            LED will be blinked. Ideally this would result in an exception being
         *            thrown, but that would result in the example being too large for the
         *            smaller memory models.
         * \param[in] n The number of times to blink the LED. If n is 0, the LED will be
         *            blinked infinitely. If n is greater than UINT_MAX / 2, no LED will
         *            be blinked. Ideally this would result in an exception being thrown,
         *            but that would result in the example being too large for the smaller
         *            memory models.
         * \param[in] period The blinking period in milliseconds. If period is less than
         *            2, no LED will be blinked. Ideally this would result in an exception
         *            being thrown, but that would result in the example being too large
         *            for the smaller memory models.
         */
        LED_Blinker_Mailbox(
            unsigned int const pin,
            unsigned int const n,
            unsigned int const period
        ) :
            complete_( false ),
            pin_( pin ),
            n_( n ),
            period_( period )
        {
            return;
        }

        /**
         * \brief Default destruction.
         */
        ~LED_Blinker_Mailbox() = default;

        /**
         * \brief Blinking completion signal.
         */
        bool volatile complete_;

        /**
         * \brief The pin the LED is connected to.
         */
        unsigned int const pin_;

        /**
         * \brief The number of times to blink the LED.
         */
        unsigned int const n_;

        /**
         * \brief The blinking period in milliseconds.
         */
        unsigned int const period_;
};

#endif // LED_BLINKER_MAILBOX_H
