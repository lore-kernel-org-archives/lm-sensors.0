From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Feb 2010 13:13:15 +0000
Subject: Re: [lm-sensors] [PATCH] ads787x A/D driver for hwmon
Message-Id: <20100212141315.1132595d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1265759943-19863-1-git-send-email-pthomas8589@gmail.com>
In-Reply-To: <1265759943-19863-1-git-send-email-pthomas8589@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue,  9 Feb 2010 16:59:03 -0700, Paul Thomas wrote:
> ---
>  drivers/hwmon/Kconfig   |    9 ++
>  drivers/hwmon/Makefile  |    1 +
>  drivers/hwmon/ads787x.c |  199 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hwmon/ads787x.h |   51 ++++++++++++
>  4 files changed, 260 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/ads787x.c
>  create mode 100644 drivers/hwmon/ads787x.h

We carefully avoid "x" for digits in hwmon driver names. Please name
the driver after one of the supported chips.

> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 68cf877..4f49ed2 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -169,6 +169,15 @@ config SENSORS_ADM9240
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called adm9240.
> +	  
> +config SENSORS_ADS787x
> +	tristate "TI ADS787x A/D converter"
> +	depends on SPI
> +	help
> +	  If you say yes here you get support for TI ADS7871, ....
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called ads7871.	  

Please move to the end of the file, with the other Texas Instruments chips.

>  
>  config SENSORS_ADT7462
>  	tristate "Analog Devices ADT7462"

> (...)
> diff --git a/drivers/hwmon/ads787x.h b/drivers/hwmon/ads787x.h
> new file mode 100644
> index 0000000..56737a3
> --- /dev/null
> +++ b/drivers/hwmon/ads787x.h
> @@ -0,0 +1,51 @@
> +/*
> + *  ads787x - driver for TI ADS7871 A/D converter
> + *
> + *  Copyright (c) 2010 Paul Thomas <pthomas8589@gmail.com>
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + *  GNU General Public License for more details.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 or 
> + *  later as publishhed by the Free Software Foundation.
> + */
> +
> +/*From figure 18 in the datasheet*/
> +/*Register addresses*/
> +#define REG_LS_BYTE	0 /*A/D Output Data, LS Byte*/
> +#define REG_MS_BYTE	1 /*A/D Output Data, MS Byte*/
> +#define REG_PGA_VALID	2 /*PGA Valid Register*/
> +#define REG_AD_CONTROL	3 /*A/D Control Register*/
> +#define REG_GAIN_MUX	4 /*Gain/Mux Register*/
> +#define REG_IO_STATE	5 /*Digital I/O State Register*/
> +#define REG_IO_CONTROL	6 /*Digital I/O Control Register*/
> +#define REG_OSC_CONTROL	7 /*Rev/Oscillator Control Register*/
> +#define REG_SER_CONTROL 24 /*Serial Interface Control Register*/
> +#define REG_ID		31 /*ID Register*/
> +
> +/*From figure 17 in the datasheet
> +* These bits get ORed with the address to form
> +* the instruction byte */
> +/*Instruction Bit masks*/
> +#define INST_MODE_bm	(1<<7)
> +#define INST_READ_bm	(1<<6)
> +#define INST_16BIT_bm	(1<<5)
> +
> +/*From figure 18 in the datasheet*/
> +/*bit masks for Rev/Oscillator Control Register*/
> +#define MUX_CNV_bv	7
> +#define MUX_CNV_bm	(1<<MUX_CNV_bv)
> +#define MUX_M3_bm	(1<<3) /*M3 selects single ended*/
> +#define MUX_G_bv	4 /*allows for reg = (gain << MUX_G_bv) | ...*/
> +
> +/*From figure 18 in the datasheet*/
> +/*bit masks for Rev/Oscillator Control Register*/
> +#define OSC_OSCR_bm	(1<<5)
> +#define OSC_OSCE_bm	(1<<4)
> +#define OSC_REFE_bm	(1<<3)
> +#define OSC_BUFE_bm	(1<<2)
> +#define OSC_R2V_bm	(1<<1)
> +#define OSC_RBG_bm	(1<<0)
> \ No newline at end of file

Please move back to the .c file. There's no point in having separate
header files which will never be included by more than one driver file.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
