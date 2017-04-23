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
 * \brief Blink C++ example program.
 */

#include <propeller.h>
#include <stdint.h>
#include <limits.h>

/**
 * \brief A LED.
 */
class LED {
    public:
        /**
         * \brief Acquire the pin resources associated with the LED, record their initial
         *        state, and drive the LED low.
         *
         * \param[in] pin The pin the LED is connected to. If pin is greater than 31, the
         *            LED will be non-responsive. Ideally this would result in an
         *            exception being thrown but that would result in the example being
         *            too large for the smaller memory models.
         */
        LED( unsigned int const pin );

        /**
         * \brief Release the pin resources associated with the LED, restoring them to
         *        their prior state.
         */
        ~LED();

        /**
         * \brief Toggle the state of the LED.
         */
        void toggle( void );

    private:
        /**
         * \brief Default construction prohibited.
         */
        LED();

        /**
         * \brief Copy construction prohibited.
         */
        LED( LED const & led );

        /**
         * \brief Copy assignment prohibited.
         */
        LED & operator=( LED const & led );

        /**
         * \brief Bit mask for interacting with the I/O registers.
         */
        uint32_t const mask_;

        /**
         * \brief The state of the DIRA when it was acquired.
         */
        uint32_t const dira_initial_;

        /**
         * \brief The state of the OUTA when it was acquired.
         */
        uint32_t const outa_initial_;
};

LED::LED( unsigned int const pin ) :
    mask_( 1 << pin ),
    dira_initial_( DIRA ),
    outa_initial_( OUTA )
{
    // configure the pin as an output, initially driven low
    OUTA &= ~mask_;
    DIRA |=  mask_;

    return;
}

LED::~LED()
{
    // restore the pin resources to their prior state
    if ( dira_initial_ & mask_ ) { DIRA |=  mask_; }
    else                         { DIRA &= ~mask_; }

    if ( outa_initial_ & mask_ ) { OUTA |=  mask_; }
    else                         { OUTA &= ~mask_; }

    return;
}

void LED::toggle( void )
{
    // toggle the state of the LED
    OUTA ^= mask_;

    return;
}

/**
 * \brief Convert a period in milliseconds to a number of clock ticks.
 *
 * \param[in] ms The period, in milliseconds, to convert.
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
static void blink( LED & led, unsigned int n, unsigned int period )
{
    // ensure function pre-conditions are met
    bool error = n > UINT_MAX / 2 ? true
               : period < 2       ? true
                                  : false;

    if ( error ) { return; }

    // initialize the timing parameters
    uint32_t const half_period_ticks = ms_to_ticks( period / 2 );
    uint32_t next_cnt                = half_period_ticks + CNT;

    // blink the LED
    for ( unsigned int i = 0; n == 0 || i < 2 * n; ++i ) {
        // wait half a period
        next_cnt = waitcnt2( next_cnt, half_period_ticks );

        // toggle the state of the LED
        led.toggle();

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
    // create a new scope so that the LED will be destructed when no longer needed
    {
        // create and configure the LED
        LED led( BLINK_PIN );

        // blink the LED
        blink( led, BLINK_CNT, BLINK_PERIOD );
    }

    // infinite loop
    for ( ;; ) {}

    return 0;
}
