From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 20 Apr 2008 11:33:27 +0000
Subject: Re: [lm-sensors] [patch 2.6.25-rc9 2/5] lm75: add new-style driver
Message-Id: <20080420133327.11269ad7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161030.12898.david-b@pacbell.net>
In-Reply-To: <200804161030.12898.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 16 Apr 2008 10:30:12 -0700, David Brownell wrote:
> Teach the LM75 driver how to use new-style driver binding:
> 
>  - Create a second driver struct, using new-style driver binding methods
>    cribbed from the legacy code.
> 
>  - Make the legacy probe logic delegate all its work to this new code.
> 
>  - The old driver struct was renamed as "lm75_legacy".
> 
>  - Sensor limits are chip-specific; record them, and use them in new
>    routines to interconvert temperature and register values.
> 
>  - More careful initialization.  Chips are put into 9-bit mode so
>    the current interconversion routines will never fail.
> 
>  - Save the original chip configuration, and restore it on exit.
> 
> A later patch updates those interconversion routines to support
> higher resolution measurements on chips which support them.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/hwmon/Kconfig |    9 +-
>  drivers/hwmon/lm75.c  |  191 +++++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 149 insertions(+), 51 deletions(-)
> 

Out of the various comments I made back in September 2007, there's
really only one which I have to repeat here. Let's say that the other
ones were only nitpicking on my side. 

> (...)
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -54,18 +54,19 @@ static const u8 LM75_REG_TEMP[3] = {
>  
>  /* Each client has this additional data */
>  struct lm75_data {
> -	struct i2c_client	client;
> +	struct i2c_client	*client;
>  	struct device		*hwmon_dev;
>  	struct mutex		update_lock;
> +	long			min, max;
> +	u8			orig_conf;
>  	char			valid;		/* !=0 if registers are valid */
>  	unsigned long		last_updated;	/* In jiffies */
> -	u16			temp[3];	/* Register values,
> +	s16			temp[3];	/* Register values,
>  						   0 = input
>  						   1 = max
>  						   2 = hyst */
>  };
>  
> -static void lm75_init_client(struct i2c_client *client);
>  static int lm75_read_value(struct i2c_client *client, u8 reg);
>  static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value);
>  static struct lm75_data *lm75_update_device(struct device *dev);
> @@ -75,13 +76,28 @@ static struct lm75_data *lm75_update_dev
>  
>  /* sysfs attributes for hwmon */
>  
> +static inline s16 temp_to_reg(struct lm75_data *lm75, long temp)
> +{
> +	if (temp < lm75->min)
> +		temp = lm75->min;
> +	else if (temp > lm75->max)
> +		temp = lm75->max;
> +
> +	return LM75_TEMP_TO_REG(temp);

This is inefficient. Your have already done half of what
LM75_TEMP_TO_REG() does, so you're better copying the rest in your
function.

Alternatively, you could just move the addition of the min and max
settings the next patch in the series, as I can't really see how they
are related to converting the driver to new-style i2c. This would be in
line with your own comment that my complaint is "addressed in the third
patch".

> +}
> +
> +static inline int reg_to_temp(s16 reg)
> +{
> +	return LM75_TEMP_FROM_REG(reg);
> +}
> +
>  static ssize_t show_temp(struct device *dev, struct device_attribute *da,
>  			 char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>  	struct lm75_data *data = lm75_update_device(dev);
> -	return sprintf(buf, "%d\n",
> -		       LM75_TEMP_FROM_REG(data->temp[attr->index]));
> +
> +	return sprintf(buf, "%d\n", reg_to_temp(data->temp[attr->index]));
>  }
>  
>  static ssize_t set_temp(struct device *dev, struct device_attribute *da,
> @@ -94,7 +110,7 @@ static ssize_t set_temp(struct device *d
>  	long temp = simple_strtol(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> -	data->temp[nr] = LM75_TEMP_TO_REG(temp);
> +	data->temp[nr] = temp_to_reg(data, temp);
>  	lm75_write_value(client, LM75_REG_TEMP[nr], data->temp[nr]);
>  	mutex_unlock(&data->update_lock);
>  	return count;

<snip>

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
