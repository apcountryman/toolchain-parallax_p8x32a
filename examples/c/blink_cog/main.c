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
 * \brief Blink cog C example program.
 */

#include <propeller.h>
#include <stddef.h>

#include "led_blinker.h"
#include "led_blinker_mailbox.h"

/**
 * \brief A blinking LED instance's attributes.
 */
typedef struct Blinking_LED_Attributes_ {
    /**
     * \brief LED blinker communication mailbox.
     */
    LED_Blinker_Mailbox mailbox;

    /**
     * \brief LED blinker cog ID.
     */
    signed int cog;
} Blinking_LED_Attributes;

/**
 * \brief A blinking LED instance.
 */
typedef Blinking_LED_Attributes * Blinking_LED;

/**
 * \brief Acquire the cog resources associated with the LED and start blinking.
 *
 * \param[in] attributes The attributes for the constructed LED. If attributes points to
 *            NULL, no LED will be constructed.
 * \param[in] pin The pin the LED is connected to. If pin is greater than 31, no LED will
 *            be blinked.
 * \param[in] n The number of times to blink the LED. If n is 0, the LED will be blinked
 *            infinitely. If n is greater than UINT_MAX / 2, no LED will be blinked.
 * \param[in] period The blinking period in milliseconds. If period is less than 2, no LED
 *            will be blinked.
 *
 * \return On Success: A pointer to the attributes of the constructed LED.
 * \return On Failure: A pointer to NULL.
 */
static Blinking_LED blinking_led_construct(
    Blinking_LED_Attributes * attributes,
    unsigned int pin,
    unsigned int n,
    unsigned int period
)
{
    // ensure the LED's configuration is valid
    if ( !attributes ) { return NULL; }

    // configure the LED's attributes
    attributes->mailbox = LED_BLINKER_MAILBOX_CONSTRUCT( pin, n, period );
    attributes->cog     = cognew( _load_start_led_blinker_cog, &attributes->mailbox );

    // if a LED blinker cog was not successfully started, signal completion
    if ( attributes->cog < 0 ) { attributes->mailbox.complete = true; }

    return attributes;
}

/**
 * \brief Wait for the LED to finish blinking and release the cog resources associated
 *        with the LED.
 *
 * \param[in] led The LED to destruct. If led points to NULL, no LED will be destructed.
 *
 * \attention This function assumes that led was constructed (successfully or not) by
 *            blinking_led_construct() and that its data has not been corrupted since. If
 *            it was not, erroneous behavior could occur.
 *
 * \attention Setting the LED passed to this function to NULL after this function returns
 *            is highly recommended.
 */
static void blinking_led_destruct( Blinking_LED blinking_led )
{
    // ensure there is a LED to destruct
    if ( !blinking_led ) { return; }

    // wait for blinking to complete
    while( !blinking_led->mailbox.complete ) {}

    // stop the LED blinker cog if it was successfully started
    if ( blinking_led->cog >= 0 ) { cogstop( blinking_led->cog ); }

    return;
}

/**
 * \brief Main loop.
 *
 * \return N/A, enters an infinite loop once blinking is complete.
 */
int main( void )
{
    // configure, and start blinking the LED
    Blinking_LED_Attributes attributes = {};
    Blinking_LED blinking_led = blinking_led_construct(
        &attributes,
        BLINK_LED_PIN,
        BLINK_CNT,
        BLINK_PERIOD
    );

    // release the LED resources
    blinking_led_destruct( blinking_led );
    blinking_led = NULL;

    // infinite loop
    for ( ;; ) {}

    return 0;
}
