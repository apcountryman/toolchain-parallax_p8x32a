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
 * \file led_blinker.h
 * \brief LED blinker interface.
 */

#ifndef LED_BLINKER_H
#define LED_BLINKER_H

#include <stdint.h>

/**
 * \brief Compiled LED blinker code.
 */
extern uint32_t const _load_start_led_blinker_cog[];

#endif // LED_BLINKER_H
