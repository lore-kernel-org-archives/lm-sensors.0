From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Mar 2013 15:55:16 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: (lm75) Tune resolution and sample time per chip
Message-Id: <20130312155516.GB30269@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130312155108.054dd75e@endymion.delvare>
In-Reply-To: <20130312155108.054dd75e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 12, 2013 at 03:51:08PM +0100, Jean Delvare wrote:
> Most LM75-compatible chips can either sample much faster or with a
> much better resolution than the original LM75 chip. So far the lm75
> driver did not let the user take benefit of these improvements. Do it
> now.
> 
> I decided to almost always configure the chip to use the best
> resolution possible, which also means the longest sample time. The
> only chips for which I didn't are the DS75, DS1775 and STDS75, because
> they are really too slow in 12-bit mode (1.2 to 1.5 second worst case)
> so I went for 11-bit mode as a more reasonable tradeoff. This choice is
> dictated by the fact that the hwmon subsystem is meant for system
> monitoring, it has never been supposed to be ultra-fast, and as a
> matter of fact we do cache the sampled values in almost all drivers.
> 
> If anyone isn't pleased with these default settings, they can always
> introduce a platform data structure or DT support for the lm75. That
> being said, it seems nobody ever complained that the driver wouldn't
> refresh the value faster than every 1.5 second, and the change made
> it faster for all chips even in 12-bit mode, so I don't expect any
> complaint.
> 
I have been using update-interval to make it configurable.
Good example is the LM90 driver.

> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/hwmon/lm75 |    7 ++++---
>  drivers/hwmon/lm75.c     |   42 ++++++++++++++++++++++++++++++++++++------
>  2 files changed, 40 insertions(+), 9 deletions(-)
> 
> --- linux-3.9-rc2.orig/drivers/hwmon/lm75.c	2013-03-12 15:46:05.343493393 +0100
> +++ linux-3.9-rc2/drivers/hwmon/lm75.c	2013-03-12 15:46:06.388517515 +0100
> @@ -169,6 +169,7 @@ lm75_probe(struct i2c_client *client, co
>  	int status;
>  	u8 set_mask, clr_mask;
>  	int new;
> +	enum lm75_type kind = id->driver_data;
>  
>  	if (!i2c_check_functionality(client->adapter,
>  			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
> @@ -187,30 +188,59 @@ lm75_probe(struct i2c_client *client, co
>  	set_mask = 0;
>  	clr_mask = LM75_SHUTDOWN;		/* continuous conversions */
>  
> -	switch (id->driver_data) {
> +	switch (kind) {
>  	case adt75:
>  		clr_mask |= 1 << 5;		/* not one-shot mode */
> +		data->resolution = 12;
> +		data->sample_time = HZ / 8;
>  		break;
>  	case ds1775:
>  	case ds75:
>  	case stds75:
> -		clr_mask |= 3 << 5;		/* 9-bit mode */
> +		clr_mask |= 3 << 5;
> +		set_mask |= 2 << 5;		/* 11-bit mode */
> +		data->resolution = 11;
> +		data->sample_time = HZ;
> +		break;
> +	case lm75:
> +	case lm75a:
> +		data->resolution = 9;
> +		data->sample_time = HZ / 2;
> +		break;
> +	case max6625:
> +		data->resolution = 9;
> +		data->sample_time = HZ / 4;
> +		break;
> +	case max6626:
> +		data->resolution = 12;
> +		data->resolution_limits = 9;
> +		data->sample_time = HZ / 4;
> +		break;
> +	case tcn75:
> +		data->resolution = 9;
> +		data->sample_time = HZ / 8;
>  		break;
>  	case mcp980x:
> +		data->resolution_limits = 9;
> +		/* fall through */
>  	case tmp100:
>  	case tmp101:
> +		set_mask |= 3 << 5;		/* 12-bit mode */
> +		data->resolution = 12;
> +		data->sample_time = HZ;
> +		clr_mask |= 1 << 7;		/* not one-shot mode */
> +		break;
>  	case tmp105:
>  	case tmp175:
>  	case tmp275:
>  	case tmp75:
> -		clr_mask |= 3 << 5;		/* 9-bit mode */
> +		set_mask |= 3 << 5;		/* 12-bit mode */
>  		clr_mask |= 1 << 7;		/* not one-shot mode */
> +		data->resolution = 12;
> +		data->sample_time = HZ / 2;
>  		break;
>  	}
>  
> -	data->resolution = 9;
> -	data->sample_time = HZ + HZ / 2;
> -
>  	/* configure as specified */
>  	status = lm75_read_value(client, LM75_REG_CONF);
>  	if (status < 0) {
> --- linux-3.9-rc2.orig/Documentation/hwmon/lm75	2013-03-12 15:09:42.543176379 +0100
> +++ linux-3.9-rc2/Documentation/hwmon/lm75	2013-03-12 15:49:08.893730398 +0100
> @@ -67,7 +67,8 @@ the temperature falls below the Hysteres
>  All temperatures are in degrees Celsius, and are guaranteed within a
>  range of -55 to +125 degrees.
>  
> -The LM75 only updates its values each 1.5 seconds; reading it more often
> +The driver caches the values for a period varying between 1 second for the
> +slowest chips and 125 ms for the fastest chips; reading it more often
>  will do no harm, but will return 'old' values.
>  
>  The original LM75 was typically used in combination with LM78-like chips
> @@ -78,8 +79,8 @@ The LM75 is essentially an industry stan
>  LM75 clones not listed here, with or without various enhancements,
>  that are supported. The clones are not detected by the driver, unless
>  they reproduce the exact register tricks of the original LM75, and must
> -therefore be instantiated explicitly. The specific enhancements (such as
> -higher resolution) are not currently supported by the driver.
> +therefore be instantiated explicitly. Higher resolution up to 12-bit
> +is supported by this driver, other specific enhancements are not.
>  
>  The LM77 is not supported, contrary to what we pretended for a long time.
>  Both chips are simply not compatible, value encoding differs.
> 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
