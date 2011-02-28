From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 28 Feb 2011 15:17:16 +0000
Subject: Re: [lm-sensors] [PATCH 2/2 v4] mfd: twl4030: Driver for twl4030
Message-Id: <20110228151716.GB3882@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298886492-15039-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1298886492-15039-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keerthy <j-keerthy@ti.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Feb 28, 2011 at 04:48:12AM -0500, Keerthy wrote:
> Introducing a driver for MADC on TWL4030 powerIC. MADC stands for monitoring
> ADC. This driver monitors the real time conversion of analog signals like
> battery temperature, battery cuurent etc.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> V4:
> Removed unwanted else from twl4030_madc_read_channels functions.
> 
> V3:
> Added for_each_set_bit for efficient bit checking
> and locking the mutex earlier in the threaded irq
> handler.
> 
> V2:
> Added functions to convert raw voltages to current and temperature.
> 
> V1:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg44543.html
> 
>  drivers/mfd/Kconfig              |   10 +
>  drivers/mfd/Makefile             |    1 +
>  drivers/mfd/twl4030-madc.c       |  812 ++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/twl4030-madc.h |  142 +++++++
>  4 files changed, 965 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mfd/twl4030-madc.c
>  create mode 100644 include/linux/i2c/twl4030-madc.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index fd01836..029e078 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -167,6 +167,16 @@ config TWL4030_CORE
>           high speed USB OTG transceiver, an audio codec (on most
>           versions) and many other features.
> 
> +config TWL4030_MADC
> +       tristate "Texas Instruments TWL4030 MADC"
> +       depends on TWL4030_CORE
> +       help
> +       This driver provides support for triton TWL4030-MADC. The
> +       driver supports both RT and SW conversion methods.
> +
> +       This driver can be built as a module. If so it will be
> +       named twl4030-madc
> +
>  config TWL4030_POWER
>         bool "Support power resources on TWL4030 family chips"
>         depends on TWL4030_CORE && ARM
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index a54e2c7..2922cc2 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_TPS6507X)                += tps6507x.o
>  obj-$(CONFIG_MENELAUS)         += menelaus.o
> 
>  obj-$(CONFIG_TWL4030_CORE)     += twl-core.o twl4030-irq.o twl6030-irq.o
> +obj-$(CONFIG_TWL4030_MADC)      += twl4030-madc.o
>  obj-$(CONFIG_TWL4030_POWER)    += twl4030-power.o
>  obj-$(CONFIG_TWL4030_CODEC)    += twl4030-codec.o
>  obj-$(CONFIG_TWL6030_PWM)      += twl6030-pwm.o
> diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
> new file mode 100644
> index 0000000..e533c72
> --- /dev/null
> +++ b/drivers/mfd/twl4030-madc.c
> @@ -0,0 +1,812 @@
> +/*
> + *
> + * TWL4030 MADC module driver-This driver monitors the real time
> + * conversion of analog signals like battery temperature,
> + * battery type, battery level etc.
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + * J Keerthy <j-keerthy@ti.com>
> + *
> + * Based on twl4030-madc.c
> + * Copyright (C) 2008 Nokia Corporation
> + * Mikko Ylinen <mikko.k.ylinen@nokia.com>
> + *
> + * Amit Kucheria <amit.kucheria@canonical.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/i2c/twl4030-madc.h>
> +
I didn't have a close look, but I suspect that several includes are missing here.
See Documentation/SubmitChecklist, item #1.

> +/*
> + * struct twl4030_madc_data - a container for madc info
> + * @dev - pointer to device structure for madc
> + * @lock - mutex protecting this data structire
> + * @requests - Array of request struct corresponding to SW1, SW2 and RT
> + * @imr - Interrupt mask register of MADC
> + * @isr - Interrupt status register of MADC
> + */
> +struct twl4030_madc_data {
> +       struct device *dev;
> +       struct mutex lock;      /* mutex protecting this data structire */
> +       struct twl4030_madc_request requests[TWL4030_MADC_NUM_METHODS];
> +       int imr;
> +       int isr;
> +};
> +
> +static struct twl4030_madc_data *twl4030_madc;
> +
> +struct twl4030_prescale_divider_ratios {
> +       s16 numerator;
> +       s16 denominator;
> +};
> +
> +static const struct twl4030_prescale_divider_ratios
> +twl4030_divider_ratios[16] = {
> +       {1, 1},         /* CHANNEL 0 No Prescaler */
> +       {1, 1},         /* CHANNEL 1 No Prescaler */
> +       {6, 10},        /* CHANNEL 2 */
> +       {6, 10},        /* CHANNEL 3 */
> +       {6, 10},        /* CHANNEL 4 */
> +       {6, 10},        /* CHANNEL 5 */
> +       {6, 10},        /* CHANNEL 6 */
> +       {6, 10},        /* CHANNEL 7 */
> +       {3, 14},        /* CHANNEL 8 */
> +       {1, 3},         /* CHANNEL 9 */
> +       {1, 1},         /* CHANNEL 10 NA */

Something else but NA might be helpful here, to distinguish the entry
form 13/14.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
