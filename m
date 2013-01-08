From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 08 Jan 2013 13:18:02 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] lm73: added 'update_interval' attribute
Message-Id: <20130108131802.GA29525@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1356378547-31499-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1356378547-31499-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 05, 2013 at 01:41:19AM -0800, Chris Verges wrote:
> The LM73 supports four A/D conversion resolutions.  The default used by
> the existing lm73 driver is the chip's default, 11-bit (0.25 C/LSB).
> This patch enables changing of this resolution from userspace via the
> update_interval sysfs attribute.  Full details on usage are included in
> Documentation/hwmon/lm73.
> 
> Signed-off-by: Chris Verges <kg4ysn@gmail.com>

Hi Chris,

comments inline.

> ---
>  Documentation/hwmon/lm73 |   78 ++++++++++++++++++++++++++++++++++++
>  drivers/hwmon/lm73.c     |   98 ++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 173 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/hwmon/lm73
> 
> diff --git a/Documentation/hwmon/lm73 b/Documentation/hwmon/lm73
> new file mode 100644
> index 0000000..56150e1
> --- /dev/null
> +++ b/Documentation/hwmon/lm73
> @@ -0,0 +1,78 @@
> +Kernel driver lm73
> +=========
> +
> +Supported chips:
> +  * Texas Instruments LM73
> +    Prefix: 'lm73'
> +    Addresses scanned: I2C 0x48, 0x49, 0x4a, 0x4c, 0x4d, and 0x4e
> +    Datasheet: Publicly available at the Texas Instruments website
> +               http://www.ti.com/product/lm73
> +
> +Author: Chris Verges <kg4ysn@gmail.com>
> +
> +
> +Description
> +-----------
> +
> +The LM73 is a digital temperature sensor.  All temperature values are
> +given in degrees Celsius.
> +
> +Measurement Resolution Support
> +------------------------------
> +
> +The LM73 supports four resolutions, defined in terms of degrees C per
> +LSB: 0.25, 0.125, 0.0625, and 0.3125.  Changing the resolution mode
> +affects the conversion time of the LM73's analog-to-digital converter.
> +From userspace, the desired resolution can be specified as a function of
> +conversion time via the 'update_interval' sysfs attribute for the
> +device.  This attribute will normalize ranges of input values to the
> +maximum times defined for the resolution in the datasheet.
> +
> +    Resolution    Conv. Time    Input Range
> +    (C/LSB)       (msec)        (msec)
> +    --------------------------------------
> +    0.25          14             0..14
> +    0.125         28            15..28
> +    0.0625        56            29..56
> +    0.03125       112           57..infinity
> +    --------------------------------------
> +
> +The following examples show how the 'update_interval' attribute can be
> +used to change the conversion time:
> +
> +    $ echo 0 > update_interval
> +    $ cat update_interval
> +    14
> +    $ cat temp1_input
> +    24250
> +
> +    $ echo 22 > update_interval
> +    $ cat update_interval
> +    28
> +    $ cat temp1_input
> +    24125
> +
> +    $ echo 56 > update_interval
> +    $ cat update_interval
> +    56
> +    $ cat temp1_input
> +    24062
> +
> +    $ echo 85 > update_interval
> +    $ cat update_interval
> +    112
> +    $ cat temp1_input
> +    24031
> +
> +As shown here, the lm73 driver automatically adjusts any user input for
> +'update_interval' via a step function.  Reading back the
> +'update_interval' value after a write operation will confirm the
> +conversion time actively in use.
> +
> +Mathematically, the resolution can be derived from the conversion time
> +via the following function:
> +
> +   g(x) = 0.250 * [log(x/14) / log(2)]
> +
> +where 'x' is the output from 'update_interval' and 'g(x)' is the
> +resolution in degrees C per LSB.
> diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
> index 7272176..cb3e17a 100644
> --- a/drivers/hwmon/lm73.c
> +++ b/drivers/hwmon/lm73.c
> @@ -39,8 +39,51 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
>  #define LM73_TEMP_MIN		(-40)
>  #define LM73_TEMP_MAX		150
>  
> +#define LM73_CTRL_RES_SHIFT	5
> +#define LM73_CTRL_RES_SIZE	2
> +#define LM73_CTRL_RES_MASK \
> +	(((1 << LM73_CTRL_RES_SIZE) - 1) << LM73_CTRL_RES_SHIFT)
> +
> +static const unsigned short lm73_convrates[] = {
> +	14,	/* 11-bits (0.25000 C/LSB): RES1 Bit = 0, RES0 Bit = 0 */
> +	28,	/* 12-bits (0.12500 C/LSB): RES1 Bit = 0, RES0 Bit = 1 */
> +	56,	/* 13-bits (0.06250 C/LSB): RES1 Bit = 1, RES0 Bit = 0 */
> +	112,	/* 14-bits (0.03125 C/LSB): RES1 Bit = 1, RES0 Bit = 1 */
> +};
> +
>  /*-----------------------------------------------------------------------*/
>  
> +/* utility functions */
> +
> +static inline s32 lm73_read(struct i2c_client *client, u8 reg)
> +{
> +	return i2c_smbus_read_byte_data(client, reg);
> +}

This function doesn't add any value. Please call i2c_smbus_read_byte_data()
directly.

> +
> +static inline s32 lm73_write(struct i2c_client *client, u8 reg,
> +			     u8 clear, u8 enable)

lm72_write_mask would be a better name. Also, I'd suggest to drop inline and let
the compiler decide what is better.

> +{
> +	s32 tmp = lm73_read(client, reg);
> +	u8 value;
> +	if (tmp < 0)
> +		return tmp;
> +	value = tmp;
> +	value &= ~clear;
> +	value |= enable;

You don't need two variables. Just use s32 value.

	s32 value = i2c_smbus_read_byte_data(client, reg);
	if (value < 0)
		return value;

	return i2c_smbus_write_byte_data(client, reg,
					 (value & ~clear) | enable);

> +	return i2c_smbus_write_byte_data(client, reg, value);
> +}
> +
> +static inline s32 lm73_write_ctrl(struct i2c_client *client, u8 clear,
> +				  u8 enable)
> +{
> +	/* always clear bits 4:3 and 0 */
> +	enable &= ~((3 << 3) | (1 << 0));
> +	return lm73_write(client, LM73_REG_CTRL,
> +			  clear | (3 << 3) | (1 << 0),
> +			  enable);
> +}

Since you call this function only once, call lm73_write (or rather
lm72_write_mask) directly. And then you don't need to clear bits 3/4 and 0 in
enable since presumably you know what you are doing.

Also, I find masks such as "(3 << 3)" confusing. I would suggest to either use
a define or something like "BIT(3) | BIT(4)" or "(1 << 3) | (1 << 4)".
Maybe use BIT() for all bit masks ?

> +
> +/*-----------------------------------------------------------------------*/
>  
>  static ssize_t set_temp(struct device *dev, struct device_attribute *da,
>  			const char *buf, size_t count)
> @@ -59,7 +102,9 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
>  	value = (short) SENSORS_LIMIT(temp/250, (LM73_TEMP_MIN*4),
>  		(LM73_TEMP_MAX*4)) << 5;
>  	err = i2c_smbus_write_word_swapped(client, attr->index, value);
> -	return (err < 0) ? err : count;
> +	if (err < 0)
> +		return err;
> +	return count;

Unrelated change. While it makes the code more consistent, that would be a
matter of a separate patch.

Thanks,
Guenter

>  }
>  
>  static ssize_t show_temp(struct device *dev, struct device_attribute *da,
> @@ -79,6 +124,52 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *da,
>  	return scnprintf(buf, PAGE_SIZE, "%d\n", temp);
>  }
>  
> +static ssize_t set_convrate(struct device *dev, struct device_attribute *da,
> +			    const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	unsigned long convrate;
> +	s32 err;
> +	u8 res_bits = 0;
> +
> +	err = kstrtoul(buf, 10, &convrate);
> +	if (err < 0)
> +		return err;
> +
> +	/*
> +	 * Convert the desired conversion rate into register bits.
> +	 * res_bits is already initialized, and everything past the
> +	 * second-to-last value in the array is treated as belonging to
> +	 * the last value in the array.
> +	 */
> +	while (res_bits < (ARRAY_SIZE(lm73_convrates) - 1) &&
> +			convrate > lm73_convrates[res_bits])
> +		res_bits++;
> +
> +	err = lm73_write_ctrl(client, LM73_CTRL_RES_MASK,
> +			      res_bits << LM73_CTRL_RES_SHIFT);
> +	if (err < 0)
> +		return err;
> +
> +	return count;
> +}
> +
> +static ssize_t show_convrate(struct device *dev, struct device_attribute *da,
> +			     char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	s32 ctrl;
> +	u8 res_bits = 0;
> +
> +	/* Read existing control value */
> +	ctrl = lm73_read(client, LM73_REG_CTRL);
> +	if (ctrl < 0)
> +		return ctrl;
> +
> +	res_bits = (ctrl & LM73_CTRL_RES_MASK) >> LM73_CTRL_RES_SHIFT;
> +	return scnprintf(buf, PAGE_SIZE, "%hu\n",
> +			lm73_convrates[res_bits]);
> +}
>  
>  /*-----------------------------------------------------------------------*/
>  
> @@ -90,13 +181,14 @@ static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
>  			show_temp, set_temp, LM73_REG_MIN);
>  static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
>  			show_temp, NULL, LM73_REG_INPUT);
> -
> +static SENSOR_DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO,
> +			show_convrate, set_convrate, 0);
>  
>  static struct attribute *lm73_attributes[] = {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
>  	&sensor_dev_attr_temp1_max.dev_attr.attr,
>  	&sensor_dev_attr_temp1_min.dev_attr.attr,
> -
> +	&sensor_dev_attr_update_interval.dev_attr.attr,
>  	NULL
>  };
>  
> -- 
> 1.7.9.5
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
