From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 15 May 2009 07:47:49 +0000
Subject: Re: [lm-sensors] [PATCH RFC 2/2] tmp401: Add support for TI's
Message-Id: <4A0D1E25.7080505@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090514092456.GB6644@ubuntu>
In-Reply-To: <20090514092456.GB6644@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Review below.

On 05/14/2009 11:24 AM, Andre Prendel wrote:
> This patch adds support for the TI TMP411 sensor chip to the TMP401 driver.
> ---
> Index: linux-2.6/drivers/hwmon/tmp401.c
> =================================> --- linux-2.6.orig/drivers/hwmon/tmp401.c	2009-05-13 22:19:54.000000000 +0200
> +++ linux-2.6/drivers/hwmon/tmp401.c	2009-05-13 23:25:03.000000000 +0200
> @@ -1,6 +1,9 @@
>   /* tmp401.c
>    *
>    * Copyright (C) 2007,2008 Hans de Goede<hdegoede@redhat.com>
> + * Gabriel Konat
> + * Sander Leget
> + * Wouter Willems
>    *
>    * This program is free software; you can redistribute it and/or modify
>    * it under the terms of the GNU General Public License as published by

This looks a but strange, please make this something like:
  * Preliminary tmp411 support by:
    Gabriel Konat, Sander Leget &  Wouter Willems

<snip>

 > +static struct tmp401_data *tmp401_update_device_reg16(
 > +	struct i2c_client *client, struct tmp401_data *data)
 > +{
 > +	int i;
 > +
 > +	for (i = 0; i<  2; i++) {
 > +		/*
 > +		 * High byte must be read first immediately followed
 > +		 * by the low byte
 > +		 */
 > +		data->temp[i] = i2c_smbus_read_byte_data(client,
 > +			TMP401_TEMP_MSB[i])<<  8;
 > +		data->temp[i] |= i2c_smbus_read_byte_data(client,
 > +			TMP401_TEMP_LSB[i]);
 > +		data->temp_low[i] = i2c_smbus_read_byte_data(client,
 > +			TMP401_TEMP_LOW_LIMIT_MSB_READ[i])<<  8;
 > +		data->temp_low[i] |= i2c_smbus_read_byte_data(client,
 > +			TMP401_TEMP_LOW_LIMIT_LSB[i]);
 > +		data->temp_high[i] = i2c_smbus_read_byte_data(client,
 > +			TMP401_TEMP_HIGH_LIMIT_MSB_READ[i])<<  8;
 > +		data->temp_high[i] |= i2c_smbus_read_byte_data(client,
 > +			TMP401_TEMP_HIGH_LIMIT_LSB[i]);
 > +		data->temp_crit[i] = i2c_smbus_read_byte_data(client,
 > +			TMP401_TEMP_CRIT_LIMIT[i]);
 > +
 > +		if(data->kind = TMP411_DEVICE_ID) {

This should be:
+		if(data->kind = tmp411) {

!!



 > +			data->temp_lowest[i] = i2c_smbus_read_byte_data(client,
 > +				TMP411_TEMP_LOWEST_MSB[i])<<  8;
 > +			data->temp_lowest[i] |= i2c_smbus_read_byte_data(
 > +				client, TMP411_TEMP_LOWEST_LSB[i]);
 > +
 > +			data->temp_highest[i] = i2c_smbus_read_byte_data(
 > +				client, TMP411_TEMP_HIGHEST_MSB[i])<<  8;
 > +			data->temp_highest[i] |= i2c_smbus_read_byte_data(
 > +				client, TMP411_TEMP_HIGHEST_LSB[i]);
 > +		}
 > +	}
 > +	return data;
 > +}
 > +


Other then that it looks good! I've tested this on both a tmp401
and tmp411 and with that one fix from above it works as it should on both.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
