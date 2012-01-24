From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Jan 2012 20:20:41 +0000
Subject: Re: [lm-sensors] [PATCH 46/79] hwmon: (lm78) Fix checkpatch issues
Message-Id: <20120124212041.294dcb7b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327373398-997-47-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327373398-997-47-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 23 Jan 2012 18:49:25 -0800, Guenter Roeck wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Fixed:
> ERROR: code indent should use tabs where possible
> ERROR: do not use assignment in if condition
> ERROR: space prohibited before that close parenthesis ')'
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: spaces required around that '<' (ctx:VxV)
> ERROR: spaces required around that '=' (ctx:VxV)
> ERROR: trailing statements should be on next line
> ERROR: trailing whitespace
> WARNING: simple_strtol is obsolete, use kstrtol instead
> WARNING: simple_strtoul is obsolete, use kstrtoul instead
> 
> Modify multi-line comments to follow Documentation/CodingStyle.
> 
> Not fixed (false positive):
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> 
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm78.c |  215 +++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 141 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
> index 6df0b46..6a69d1e 100644
> --- a/drivers/hwmon/lm78.c
> +++ b/drivers/hwmon/lm78.c
> @@ -1,23 +1,23 @@
>  /*
> -    lm78.c - Part of lm_sensors, Linux kernel modules for hardware
> -             monitoring
> -    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> 
> -    Copyright (c) 2007, 2011  Jean Delvare <khali@linux-fr.org>
> -
> -    This program is free software; you can redistribute it and/or modify
> -    it under the terms of the GNU General Public License as published by
> -    the Free Software Foundation; either version 2 of the License, or
> -    (at your option) any later version.
> -
> -    This program is distributed in the hope that it will be useful,
> -    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -    GNU General Public License for more details.
> -
> -    You should have received a copy of the GNU General Public License
> -    along with this program; if not, write to the Free Software
> -    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> -*/
> + * lm78.c - Part of lm_sensors, Linux kernel modules for hardware
> + *	    monitoring
> + * Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
> + * Copyright (c) 2007, 2011  Jean Delvare <khali@linux-fr.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> @@ -74,11 +74,15 @@ enum chips { lm78, lm79 };
>  #define LM78_REG_I2C_ADDR 0x48
>  
>  
> -/* Conversions. Rounding and limit checking is only done on the TO_REG 
> -   variants. */
> +/*
> + * Conversions. Rounding and limit checking is only done on the TO_REG
> + * variants.
> + */
>  
> -/* IN: mV, (0V to 4.08V)
> -   REG: 16mV/bit */
> +/*
> + * IN: mV, (0V to 4.08V)

That comma could go away, methinks.

> + * REG: 16mV/bit
> + */
>  static inline u8 IN_TO_REG(unsigned long val)
>  {
>  	unsigned long nval = SENSORS_LIMIT(val, 0, 4080);
> (...)
> @@ -669,11 +721,13 @@ static struct i2c_driver lm78_driver = {
>  	.address_list	= normal_i2c,
>  };
>  
> -/* The SMBus locks itself, but ISA access must be locked explicitly! 
> -   We don't want to lock the whole ISA bus, so we lock each client
> -   separately.
> -   We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
> -   would slow down the LM78 access and should not be necessary.  */
> +/*
> + * The SMBus locks itself, but ISA access must be locked explicitly!
> + * We don't want to lock the whole ISA bus, so we lock each client
> + * separately.
> + * We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
> + * would slow down the LM78 access and should not be necessary.
> + */
>  static int lm78_read_value(struct lm78_data *data, u8 reg)
>  {
>  	struct i2c_client *client = data->client;
> @@ -691,13 +745,15 @@ static int lm78_read_value(struct lm78_data *data, u8 reg)
>  		return i2c_smbus_read_byte_data(client, reg);
>  }
>  
> -/* The SMBus locks itself, but ISA access muse be locked explicitly! 
> -   We don't want to lock the whole ISA bus, so we lock each client
> -   separately.
> -   We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
> -   would slow down the LM78 access and should not be necessary. 
> -   There are some ugly typecasts here, but the good new is - they should
> -   nowhere else be necessary! */
> +/*
> + * The SMBus locks itself, but ISA access muse be locked explicitly!
> + * We don't want to lock the whole ISA bus, so we lock each client
> + * separately.
> + * We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
> + * would slow down the LM78 access and should not be necessary.

This is the exact same comment as for the previous function...

> + * There are some ugly typecasts here, but the good new is - they should
> + * nowhere else be necessary!

... and this one no longer applies. So maybe you can kill the whole block?

> + */
>  static int lm78_write_value(struct lm78_data *data, u8 reg, u8 value)
>  {
>  	struct i2c_client *client = data->client;
> @@ -823,8 +879,11 @@ static int __devinit lm78_isa_probe(struct platform_device *pdev)
>  	lm78_init_device(data);
>  
>  	/* Register sysfs hooks */
> -	if ((err = sysfs_create_group(&pdev->dev.kobj, &lm78_group))
> -	 || (err = device_create_file(&pdev->dev, &dev_attr_name)))
> +	err = sysfs_create_group(&pdev->dev.kobj, &lm78_group);
> +	if (err)
> +		goto exit_remove_files;
> +	err = device_create_file(&pdev->dev, &dev_attr_name);
> +	if (err)
>  		goto exit_remove_files;
>  
>  	data->hwmon_dev = hwmon_device_register(&pdev->dev);

Doesn't this change increase the binary size?

The rest looks good.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
