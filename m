From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 20 Apr 2008 16:03:28 +0000
Subject: Re: [lm-sensors] [patch 2.6.25-rc9 3/5] lm75: support 12-bit
Message-Id: <20080420180328.62118958@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161030.56626.david-b@pacbell.net>
In-Reply-To: <200804161030.56626.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 16 Apr 2008 10:30:56 -0700, David Brownell wrote:
> Make the lm75 driver so that use the best resolution available on
> each chip it finds ... usually this is 12 bits (0.0625 degrees C).
> 
> Note that this preserves the quirky "round away from zero" behavior
> for converting temperatures to sensor values.  (I'd think no rounding
> at all would be better.)

As explained before [1], there's nothing quirky here, so please remove
this confusing comment. The lm75 driver has never "rounded away from
zero". Your patch OTOH is broken in many places as far as temperature
conversions are concerned.

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021372.html

> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/hwmon/Kconfig |    4 +++-
>  drivers/hwmon/lm75.c  |   44 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 39 insertions(+), 9 deletions(-)
> 
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -391,7 +391,9 @@ config SENSORS_LM75
>  		- Texas Instruments TMP100, TMP101, TMP75, TMP175, TMP275
>  
>  	  This driver supports driver model based binding through board
> -	  specific I2C device tables.
> +	  specific I2C device tables.  When those tables report a chip
> +	  type that's recognized as supporting it, this driver uses 12-bit
> +	  sample resolution (to 1/16 degree C).
>  
>  	  It also supports the "legacy" style of driver binding.  To use
>  	  that with some chips which don't replicate LM75 quirks exactly,
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -27,7 +27,6 @@
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> -#include "lm75.h"
>  
>  
>  /*
> @@ -65,6 +64,8 @@ struct lm75_data {
>  						   0 = input
>  						   1 = max
>  						   2 = hyst */
> +	u16			round;		/* f(resolution) */
> +	u16			mask;

mask is f(resolution) too, maybe you can mention it. And it should be
s16, otherwise the masking operation will not work properly.

>  };
>  
>  static int lm75_read_value(struct i2c_client *client, u8 reg);
> @@ -74,7 +75,7 @@ static struct lm75_data *lm75_update_dev
>  
>  /*-----------------------------------------------------------------------*/
>  
> -/* sysfs attributes for hwmon */
> +/* sysfs attributes for hwmon, handling any sample resolution */
>  
>  static inline s16 temp_to_reg(struct lm75_data *lm75, long temp)
>  {
> @@ -83,12 +84,19 @@ static inline s16 temp_to_reg(struct lm7
>  	else if (temp > lm75->max)
>  		temp = lm75->max;
>  
> -	return LM75_TEMP_TO_REG(temp);
> +	/* "Round away from zero" -- unusual but backwards-compatible.
> +	 * Rounding should really be done *after* conversion.
> +	 */

Please drop this incorrect comment.

> +	temp += (temp < 0) ? -lm75->round : lm75->round;
> +	return ((temp * 256) / 1000) & lm75->mask;

This is broken, just try it with negative values. The whole point of
the lm75->round value is to account for integer divisions truncating
the result rather than rounding it. This only works if you add (or
remove, for negative values) exactly half of the divider value. Here
you have a rounding offset that depends on the resolution, but in the
end you divide by 1000 regardless of the resolution, and on top of that
you add the offset before multiplying rather before dividing.

This conversion function should return the following depending on the
resolution:

 9-bit: ((temp +/- 250) / 500) << 7
10-bit: ((temp +/- 125) / 250) << 6
11-bit: ((temp +/- 62) / 125) << 5
12-bit: ((temp +/- 31) / 62) << 4

I don't really care how exactly you implement this but the result must
be the same!

>  }
>  
>  static inline int reg_to_temp(s16 reg)
>  {
> -	return LM75_TEMP_FROM_REG(reg);
> +	/* Use integer division instead of logical right shift to
> +	 * preserve sign (compiler uses arithmetic right shift).
> +	 */
> +	return (reg * 1000) / 256;
>  }
>  
>  static ssize_t show_temp(struct device *dev, struct device_attribute *da,
> @@ -97,7 +105,8 @@ static ssize_t show_temp(struct device *
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>  	struct lm75_data *data = lm75_update_device(dev);
>  
> -	return sprintf(buf, "%d\n", reg_to_temp(data->temp[attr->index]));
> +	return sprintf(buf, "%d\n",
> +		reg_to_temp(data->temp[attr->index]) & data->mask);

Bogus masking. It should happen inside reg_to_temp, not after it.

>  }
>  
>  static ssize_t set_temp(struct device *dev, struct device_attribute *da,
> @@ -144,6 +153,7 @@ static int lm75_probe(struct i2c_client 
>  	int status;
>  	u8 set_mask, clr_mask;
>  	int new;
> +	int resolution;
>  
>  	if (!i2c_check_functionality(client->adapter,
>  			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
> @@ -163,13 +173,27 @@ static int lm75_probe(struct i2c_client 
>  	set_mask = 0;
>  	clr_mask = (1 << 0)			/* continuous conversions */
>  		| (1 << 6) | (1 << 5);		/* 9-bit mode */
> +	resolution = 9;
>  
>  	data->min = -55 * 1000;
>  	data->max = 125 * 1000;
>  
>  	/* for tmp175 or tmp275, use name "tmp75" */
> -	if (strcmp(client->name, "tmp75") = 0)
> +	if (strcmp(client->name, "tmp75") = 0) {
>  		data->min = -40 * 1000;
> +		set_mask |= (1 << 6) | (1 << 5);
> +		resolution = 12;
> +
> +	/* for ds1775, use name "ds75" */
> +	} else if (strcmp(client->name, "ds75") = 0
> +			|| strcmp(client->name, "mcp980x") = 0
> +			|| strcmp(client->name, "tmp100") = 0
> +			|| strcmp(client->name, "tmp101") = 0) {

Please align the strcmps (spaces following tabs is OK.)

> +		set_mask |= (1 << 6) | (1 << 5);
> +		resolution = 12;
> +
> +	} else if (strcmp(client->name, "max6626") = 0)
> +		resolution = 12;
>  
>  	/* NOTE:  also need to ensure that the chip is in interrupt mode
>  	 * in various cases, and maybe handle SMBALERT#.
> @@ -188,6 +212,9 @@ static int lm75_probe(struct i2c_client 
>  		lm75_write_value(client, LM75_REG_CONF, new);
>  	dev_dbg(&client->dev, "Config %02x\n", new);
>  
> +	data->round = 500 / (1 << (resolution - 8));

What about the more simple
	data->round = 500 >> (resolution - 8);
?

> +	data->mask = ~((1 << (16 - resolution)) - 1);
> +
>  	/* Register sysfs hooks */
>  	if ((status = sysfs_create_group(&client->dev.kobj, &lm75_group)))
>  		goto exit_free;
> @@ -198,8 +225,9 @@ static int lm75_probe(struct i2c_client 
>  		goto exit_remove;
>  	}
>  
> -	dev_info(&client->dev, "%s: sensor '%s'\n",
> -		data->hwmon_dev->bus_id, client->name);
> +	dev_info(&client->dev,
> +		"%s: sensor '%s', resolution %d millidegrees C\n",
> +		data->hwmon_dev->bus_id, client->name, data->round * 2);
>  
>  	return 0;
>  

Note: I will not have the time to review the SMBus Alert patches now,
so I suggest that you work on cleaning up and fixing the first 3
patches of the series so that they have a chance to make it into
2.6.25. We'll take care of the last 2 patches later.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
