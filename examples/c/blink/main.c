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
 * \brief Blink C example program.
 */

#include <limits.h>
#include <propeller.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

/**
 * \brief A LED instance's attributes.
 */
typedef struct LED_Attributes_ {
    /**
     * \brief Bit mask for interacting with the I/O registers.
     */
    uint32_t mask;

    /**
     * \brief The state of the DIRA when it was acquired.
     */
    uint32_t dira_initial;

    /**
     * \brief The state of the OUTA when it was acquired.
     */
    uint32_t outa_initial;
} LED_Attributes;

/**
 * \brief A LED instance.
 */
typedef LED_Attributes * LED;

/**
 * \brief Construct a LED by acquiring the pin resources associated with it, recording
 *        their initial state, and driving the LED low.
 *
 * \param[in] attributes The attributes for the constructed LED. If attributes points to
 *            NULL, no LED will be constructed.
 * \param[in] pin The pin the LED is connected to. If pin is greater than 31, the LED will
 *            be non-responsive.
 *
 * \return On Success: A pointer to the attributes of the constructed LED.
 * \return On Failure: A pointer to NULL.
 */
static LED led_construct(
    LED_Attributes * attributes,
    unsigned int pin
)
{
    // ensure the LED's configuration is valid (pin is handled implicitly by mask
    //      calculation)
    if ( !attributes ) { return NULL; }

    // configure the LED's attributes
    attributes->mask         = 1 << pin;
    attributes->dira_initial = DIRA;
    attributes->outa_initial = OUTA;

    // configure the pin as an output, initially driven low
    OUTA &= ~attributes->mask;
    DIRA |=  attributes->mask;

    return attributes;
}

/**
 * \brief Destruct a LED by releasing the pin resources associated with the LED, and
 *        restoring them to their prior state.
 *
 * \param[in] led The LED to destruct. If led points to NULL, no LED will be destructed.
 *
 * \attention This function assumes that led was constructed (successfully or not) by
 *            led_construct() and that its data has not been corrupted since. If it was
 *            not, erroneous behavior could occur.
 *
 * \attention Setting the LED passed to this function to NULL after this function returns
 *            is highly recommended.
 */
static void led_destruct( LED led )
{
    // ensure there is a LED to destruct
    if ( !led ) { return; }

    // restore the pin resources to their prior state
    if ( led->dira_initial & led->mask ) { DIRA |=  led->mask; }
    else                                 { DIRA &= ~led->mask; }

    if ( led->outa_initial & led->mask ) { OUTA |=  led->mask; }
    else                                 { OUTA &= ~led->mask; }

    return;
}

/**
 * \brief Toggle the state of a LED.
 *
 * \param[in] led The LED to toggle. If led points to NULL, no LED will be toggled.
 *
 * \attention This function assumes that led was constructed (successfully or not) by
 *            led_construct() and that its data has not been corrupted since. If it was
 *            not, erroneous behavior could occur.
 */
static void led_toggle( LED led )
{
    // ensure there is a LED to toggle
    if ( !led ) { return; }

    // toggle the state of the LED
    OUTA ^= led->mask;

    return;
}

/**
 * \brief Convert a period in milliseconds to a number of clock ticks.
 *
 * \param[in] The period, in milliseconds, to convert.
 *
 * \return The number of clock ticks in period.
 */
static uint32_t ms_to_ticks( unsigned int ms )
{
    return ( CLKFREQ / 1000U ) * ms;
}

/**
 * \brief Blink a LED.
 *
 * \param[in] led The LED to blink.
 * \param[in] n The number of times to blink the LED. If n is 0, the LED will be blinked
 *            infinitely. If n is greater than UINT_MAX / 2, no LED will be blinked.
 * \param[in] period The blinking period in milliseconds. If period is less than 2, no LED
 *            will be blinked.
 */
static void blink( LED led, unsigned int n, unsigned int period )
{
    // ensure function pre-conditions are met
    bool error = n > UINT_MAX / 2 ? true
               : period < 2       ? true
                                  : false;

    if ( error ) { return; }

    // initialize the timing parameters
    uint32_t const half_period_ticks = ms_to_ticks( period / 2 );
    uint32_t       next_cnt          = half_period_ticks + CNT;

    // blink the LED
    for ( unsigned int i = 0; n == 0 || i < 2 * n; ++i ) {
        // wait half a clock period
        next_cnt = waitcnt2( next_cnt, half_period_ticks );

        // toggle the state of the LED
        led_toggle( led );

    } // for

    return;
}

/**
 * \brief Main loop.
 *
 * \return N/A, enters an infinite loop once blinking is complete.
 */
int main( void )
{
    // configure the LED;
    LED_Attributes attributes = {};
    LED led = led_construct( &attributes, BLINK_PIN );

    // blink the LED
    blink( led, BLINK_CNT, BLINK_PERIOD );

    // release the LED pin resources
    led_destruct( led );
    led = NULL;

    // infinite loop
    for ( ;; ) {}

    return 0;
}
