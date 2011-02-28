From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 28 Feb 2011 15:11:24 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 v3] hwmon: twl4030: Hwmon Driver for
Message-Id: <20110228151124.GA3882@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298873141-5617-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1298873141-5617-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keerthy <j-keerthy@ti.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, Feb 28, 2011 at 01:05:41AM -0500, Keerthy wrote:
> This driver exposes the sysfs nodes of the TWL4030 MADC module.
> All the voltage channel values are expressed in terms of mV. Channel 13
> and channel 14 are reserved. There are channels which represent
> temperature and current the output is represented by celcius
> and mA respectively.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> V3:
> Corrected channel 15 index
> 
> V2:
> Changed the names of the sysfs attributes compliant to current,
> voltage and temperature attributes.
> 
> V1:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg44542.html
> 
>  Documentation/hwmon/twl4030-madc-hwmon |   45 +++++++++
>  drivers/hwmon/Kconfig                  |   10 ++
>  drivers/hwmon/Makefile                 |    1 +
>  drivers/hwmon/twl4030-madc-hwmon.c     |  153 ++++++++++++++++++++++++++++++++
>  4 files changed, 209 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/twl4030-madc-hwmon
>  create mode 100644 drivers/hwmon/twl4030-madc-hwmon.c
> 
> diff --git a/Documentation/hwmon/twl4030-madc-hwmon b/Documentation/hwmon/twl4030-madc-hwmon
> new file mode 100644
> index 0000000..ef79843
> --- /dev/null
> +++ b/Documentation/hwmon/twl4030-madc-hwmon
> @@ -0,0 +1,45 @@
> +Kernel driver twl4030-madc
> +============> +
> +Supported chips:
> +	* Texas Instruments TWL4030
> +	Prefix: 'twl4030-madc'
> +
> +
> +Authors:
> +	J Keerthy <j-keerthy@ti.com>
> +
> +Description
> +-----------
> +
> +The Texas Instruments TWL4030 is a Power Management and Audio Circuit. Among
> +other things it contains a 10-bit A/D converter MADC. The converter has 16
> +channels which can be used in different modes.
> +
> +
> +See this table for the meaning of the different channels
> +
> +Channel Signal
> +------------------------------------------
> +0	Battery type(BTYPE)
> +1	BCI: Battery temperature (BTEMP)
> +2	GP analog input
> +3	GP analog input
> +4	GP analog input
> +5	GP analog input
> +6	GP analog input
> +7	GP analog input
> +8	BCI: VBUS voltage(VBUS)
> +9	Backup Battery voltage (VBKP)
> +10	BCI: Battery charger current (ICHG)
> +11	BCI: Battery charger voltage (VCHG)
> +12	BCI: Main battery voltage (VBAT)
> +13	Reserved
> +14	Reserved
> +15	VRUSB Supply/Speaker left/Speaker right polarization level
> +
> +
> +The Sysfs nodes will represent the voltage in the units of mV,
> +the temperature channel shows the converted temperature in
> +degree celcius. The Battery charging current channel represents
> +battery charging current in mA.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 297bc9a..cb3d895 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -941,6 +941,16 @@ config SENSORS_TMP421
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called tmp421.
>  
> +config SENSORS_TWL4030_MADC
> +	tristate "Texas Instruments TWL4030 MADC Hwmon"
> +	depends on TWL4030_MADC
> +	help
> +	If you say yes here you get hwmon support for triton
> +	TWL4030-MADC.
> +
> +	This driver can also be built as a module. If so it will be called
> +	twl4030-madc-hwmon.
> +
>  config SENSORS_VIA_CPUTEMP
>  	tristate "VIA CPU temperature sensor"
>  	depends on X86
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index dde02d9..bc7d740 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -102,6 +102,7 @@ obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
>  obj-$(CONFIG_SENSORS_TMP102)	+= tmp102.o
>  obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
>  obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
> +obj-$(CONFIG_SENSORS_TWL4030_MADC)+= twl4030-madc-hwmon.o
>  obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
>  obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
>  obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
> diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-madc-hwmon.c
> new file mode 100644
> index 0000000..5eb563f
> --- /dev/null
> +++ b/drivers/hwmon/twl4030-madc-hwmon.c
> @@ -0,0 +1,153 @@
> +/*
> + *
> + * TWL4030 MADC Hwmon driver-This driver monitors the real time
> + * conversion of analog signals like battery temperature,
> + * battery type, battery level etc. User can ask for the conversion on a
> + * particular channel using the sysfs nodes.
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + * J Keerthy <j-keerthy@ti.com>
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
> +#include <linux/platform_device.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/i2c/twl4030-madc.h>

You are including a file which is only introduced in a subsequent patch. This would break 
the ability to bisect if patches are applied in that order. Please reorder your patches.

> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>

The driver uses information from <linux/init.h>, <linux/stddef.h>,
<linux/sysfs.h>, <linux/module.h>, <linux/err.h>, <linux/kernel.h>,
and possibly others I might have missed. You should include those files
explicitly and not depend on other include files to do it for you.

See Linux "Kernel patch submission checklist" in SubmittingPatches, item #1.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
