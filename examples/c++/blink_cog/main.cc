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
 * \file main.c
 * \brief Blink cog C++ example program.
 */

#include <propeller.h>
#include <stdint.h>
#include <string.h>

#include "led_blinker.h"
#include "led_blinker_mailbox.h"

/**
 * \brief A blinking LED.
 */
class Blinking_LED {
    public:
        /**
         * \brief Acquire the cog resources associated with the LED and start blinking.
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
        Blinking_LED( unsigned int pin, unsigned int n, unsigned int period );

        /**
         * \brief Wait for the LED to finish blinking and release the cog resources
         *        associated with the LED.
         */
        ~Blinking_LED();

        /**
         * \brief Copy construction prohibited.
         */
        Blinking_LED( Blinking_LED const & ) = delete;

        /**
         * \brief Copy assignment prohibited.
         */
        Blinking_LED & operator=( Blinking_LED const & ) = delete;

        /**
         * \brief Move construction prohibited.
         */
        Blinking_LED( Blinking_LED && ) = delete;

        /**
         * \brief Move assignment prohibited.
         */
        Blinking_LED & operator=( Blinking_LED && ) = delete;

    private:
#ifdef __PROPELLER_USE_XMM__
        /**
         * \brief Start the LED blinker cog.
         *
         * \param[in] mailbox The LED blinker communication mailbox.
         *
         * \return The started LED blinker cog's ID.
         */
        static signed int start( LED_Blinker_Mailbox & mailbox );
#endif // __PROPELLER_USE_XMM__

        /**
         * \brief LED blinker communication mailbox.
         */
        LED_Blinker_Mailbox mailbox_;

        /**
         * \brief LED blinker cog ID.
         */
        signed int const cog_;
};

Blinking_LED::Blinking_LED(
    unsigned int const pin,
    unsigned int const n,
    unsigned int const period
) :
    mailbox_( pin, n, period ),
#ifdef __PROPELLER_USE_XMM__
    cog_( start( mailbox_ ))

#else // __PROPELLER_USE_XMM__
    cog_( cognew( _load_start_led_blinker_cog, &mailbox_ ))

#endif // __PROPELLER_USE_XMM__
{
    // if a LED blinker cog was not successfully started, signal completion
    if ( cog_ < 0 ) { mailbox_.complete_ = true; }

    return;
}

Blinking_LED::~Blinking_LED()
{
    // wait for blinking to complete
    while ( !mailbox_.complete_ ) {}

    // stop the LED blinker cog if it was successfully started
    if ( cog_ >= 0 ) { cogstop( cog_ ); }

    return;
}

#ifdef __PROPELLER_USE_XMM__
signed int Blinking_LED::start( LED_Blinker_Mailbox & mailbox )
{
    uint32_t buffer[ 512 ];
    memcpy( buffer, _load_start_led_blinker_cog, sizeof( buffer ));
    return cognew( buffer, &mailbox );
}
#endif // __PROPELLER_USE_XMM__

/**
 * \brief Main loop.
 *
 * \return N/A, enters an infinite loop once blinking is complete.
 */
int main( void )
{
    // create a new scope so that the blinking LED will be destructed when no longer
    // needed
    {
        // create, configure, and start blinking the LED
        Blinking_LED blinking_led( BLINK_LED_PIN, BLINK_CNT, BLINK_PERIOD );
    }

    // infinite loop
    for ( ;; ) {}

    return 0;
}
