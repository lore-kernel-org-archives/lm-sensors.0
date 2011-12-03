From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 03 Dec 2011 19:52:31 +0000
Subject: Re: [lm-sensors] [PATCH] f75375s: added Fintek f75387 support
Message-Id: <20111203195231.GA25429@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABRa2TKyTHBSZiWMxZZqC2Y=ZZNTQQt_3BXTrt6JzQzj0OsfNw@mail.gmail.com>
In-Reply-To: <CABRa2TKyTHBSZiWMxZZqC2Y=ZZNTQQt_3BXTrt6JzQzj0OsfNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bjoern,

On Fri, Dec 02, 2011 at 05:09:36PM -0500, Bjoern Gerhart wrote:
> Hi Guenter,
> 
> the mainboard I tested the module on is an Adlink NanoX-TC. However,
> please note that the f75387 chip is _not_ assembled on this board, but
> on the connected proprietary Interface Board developed by our inhouse
> hardware team...
> 
> Thanks so much for the patch review and feedback, which sounds really
> plausible! Below you find the updated patch implementing the
> proposals.
> 
Yes, that is much better. Couple of minor comments below.

> 2011/12/2 Guenter Roeck <guenter.roeck@ericsson.com>:
> > On Thu, Dec 01, 2011 at 10:37:47PM -0500, Guenter Roeck wrote:
> > Configuration register 0x01 and fan register 0x60 are both different. Both are used
> > and needed for fan configuration, so that is definitely a problem that will have
> > to be addressed.
> >
> Ok... so I'll have a look at the difference in the fan related
> registers in order to complete the f75387 implementation.
> 
Yes, we'll need that. Fortunately you have your own board, so hopefully you should
be able to play with fan control even if the pins are not connected.

> --
> Bjoern Gerhart
> 
> 
> diff -uNr linux-2.6.39-orig/drivers/hwmon/f75375s.c
> linux-2.6.39/drivers/hwmon/f75375s.c
> --- linux-2.6.39-orig/drivers/hwmon/f75375s.c	2011-12-02
> 14:41:16.000000000 +0100
> +++ linux-2.6.39/drivers/hwmon/f75375s.c	2011-12-02 14:48:48.000000000 +0100
> @@ -1,6 +1,6 @@
> /*
> - * f75375s.c - driver for the Fintek F75375/SP and F75373
> - *             hardware monitoring features
> + * f75375s.c - driver for the Fintek F75375/SP, F75373 and
> + *             F75387SG/RG hardware monitoring features
>  * Copyright (C) 2006-2007  Riku Voipio
>  *
>  * Datasheets available at:
> @@ -10,6 +10,9 @@
>  *
>  * f75373:
>  * http://www.fintek.com.tw/files/productfiles/F75373_V025P.pdf
> + *
> + * f75387:
> + * http://www.fintek.com.tw/files/productfiles/F75387_V027P.pdf
>  *
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License as published by
> @@ -40,7 +43,7 @@
> /* Addresses to scan */
> static const unsigned short normal_i2c[] = { 0x2d, 0x2e, I2C_CLIENT_END };
> 
> -enum chips { f75373, f75375 };
> +enum chips { f75373, f75375, f75387 };
> 
> /* Fintek F75375 registers  */
> #define F75375_REG_CONFIG0		0x0
> @@ -59,6 +62,7 @@
> #define F75375_REG_VOLT_LOW(nr)		(0x21 + (nr) * 2)
> 
> #define F75375_REG_TEMP(nr)		(0x14 + (nr))
> +#define F75387_REG_TEMP11_LSB(nr)	(0x14 + (nr) + 6)

You really seem to like that ;). Still, I think it should be

#define F75387_REG_TEMP11_LSB(nr)	(0x1a + (nr))

instead.

> #define F75375_REG_TEMP_HIGH(nr)	(0x28 + (nr) * 2)
> #define F75375_REG_TEMP_HYST(nr)	(0x29 + (nr) * 2)
> 
> @@ -108,7 +112,11 @@
> 	u8 pwm[2];
> 	u8 pwm_mode[2];
> 	u8 pwm_enable[2];
> -	s8 temp[2];
> +	/* f75387: For remote temperature reading, it uses signed 11-bit
> +	 * values with LSB = 0.125 degree Celsius, left-justified in 16-bit
> +	 * registers. For original 8bit temp readings, the LSB just is 0.
> +	 */

Multi-line comment should start with

	/*
	 * f75387: For remote temperature reading, it uses signed 11-bit

> +	s16 temp11[2];
> 	s8 temp_high[2];
> 	s8 temp_max_hyst[2];
> };
> @@ -122,6 +130,7 @@
> static const struct i2c_device_id f75375_id[] = {
> 	{ "f75373", f75373 },
> 	{ "f75375", f75375 },
> +	{ "f75387", f75387 },
> 	{ }
> };
> MODULE_DEVICE_TABLE(i2c, f75375_id);
> @@ -205,8 +214,13 @@
> 	if (time_after(jiffies, data->last_updated + 2 * HZ)
> 		|| !data->valid) {
> 		for (nr = 0; nr < 2; nr++) {
> -			data->temp[nr] > -				f75375_read8(client, F75375_REG_TEMP(nr));
> +			/* assign MSB, therefore shift it by 8 bits */
> +			data->temp11[nr] > +				f75375_read8(client, F75375_REG_TEMP(nr)) << 8;
> +			if (data->kind = f75387)
> +				/* merge F75387's temperature LSB (11-bit) */
> +				data->temp11[nr] |> +					f75375_read8(client, F75387_REG_TEMP11_LSB(nr));
> 			data->fan[nr] > 				f75375_read16(client, F75375_REG_FAN(nr));
> 		}
> @@ -435,13 +449,14 @@
> }
> #define TEMP_FROM_REG(val) ((val) * 1000)
> #define TEMP_TO_REG(val) ((val) / 1000)
> +#define TEMP11_FROM_REG(reg)	((reg) / 32 * 125)
> 
> -static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
> +static ssize_t show_temp11(struct device *dev, struct device_attribute *attr,
> 		char *buf)
> {
> 	int nr = to_sensor_dev_attr(attr)->index;
> 	struct f75375_data *data = f75375_update_device(dev);
> -	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr]));
> +	return sprintf(buf, "%d\n", TEMP11_FROM_REG(data->temp11[nr]));
> }
> 
> static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
> @@ -525,12 +540,12 @@
> 	show_in_max, set_in_max, 3);
> static SENSOR_DEVICE_ATTR(in3_min, S_IRUGO|S_IWUSR,
> 	show_in_min, set_in_min, 3);
> -static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp11, NULL, 0);
> static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO|S_IWUSR,
> 	show_temp_max_hyst, set_temp_max_hyst, 0);
> static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO|S_IWUSR,
> 	show_temp_max, set_temp_max, 0);
> -static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp11, NULL, 1);
> static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO|S_IWUSR,
> 	show_temp_max_hyst, set_temp_max_hyst, 1);
> static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO|S_IWUSR,
> @@ -685,10 +700,15 @@
> 
> 	vendid = f75375_read16(client, F75375_REG_VENDOR);
> 	chipid = f75375_read16(client, F75375_CHIP_ID);
> -	if (chipid = 0x0306 && vendid = 0x1934)
> +	if (vendid != 0x1934)
> +		return -ENODEV;
> +
> +	if (chipid = 0x0306)
> 		name = "f75375";
> -	else if (chipid = 0x0204 && vendid = 0x1934)
> +	else if (chipid = 0x0204)
> 		name = "f75373";
> +	else if (chipid = 0x0410)
> +		name = "f75387";
> 	else
> 		return -ENODEV;
> 
> @@ -711,7 +731,7 @@
> 
> MODULE_AUTHOR("Riku Voipio");
> MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("F75373/F75375 hardware monitoring driver");
> +MODULE_DESCRIPTION("F75373/F75375/F75387 hardware monitoring driver");
> 
> module_init(sensors_f75375_init);
> module_exit(sensors_f75375_exit);
> diff -uNr linux-2.6.39-orig/drivers/hwmon/Kconfig
> linux-2.6.39/drivers/hwmon/Kconfig
> --- linux-2.6.39-orig/drivers/hwmon/Kconfig	2011-12-02 14:41:28.000000000 +0100
> +++ linux-2.6.39/drivers/hwmon/Kconfig	2011-12-02 13:21:46.000000000 +0100
> @@ -335,11 +335,11 @@
> 	  will be called f71882fg.
> 
> config SENSORS_F75375S
> -	tristate "Fintek F75375S/SP and F75373"
> +	tristate "Fintek F75375S/SP, F75373 and F75387"
> 	depends on I2C
> 	help
> 	  If you say yes here you get support for hardware monitoring
> -	  features of the Fintek F75375S/SP and F75373
> +	  features of the Fintek F75375S/SP, F75373 and F75387
> 
> 	  This driver can also be built as a module.  If so, the module
> 	  will be called f75375s.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
