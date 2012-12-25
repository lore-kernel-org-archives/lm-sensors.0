From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 25 Dec 2012 02:42:44 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] lm73: added 'update_interval' attribute
Message-Id: <20121225024244.GA17859@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1356378547-31499-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1356378547-31499-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 24, 2012 at 11:49:06AM -0800, Chris Verges wrote:
> The LM73 supports four A/D conversion resolutions.  The default used by
> the existing lm73 driver is the chip's default, 11-bit (0.25 C/LSB).
> This patch enables changing of this resolution from userspace via the
> temp1_update_interval attribute.  Full details on use of this mechanism
> are described in Documentation/hwmon/lm73.
> 
> Signed-off-by: Chris Verges <kg4ysn@gmail.com>

I'll be out of town for the next couple of weeks. I'll get back to you
afterwards.

Guenter

> ---
>  Documentation/hwmon/lm73 |   78 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hwmon/lm73.c     |   76 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 150 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/hwmon/lm73
> 
> diff --git a/Documentation/hwmon/lm73 b/Documentation/hwmon/lm73
> new file mode 100644
> index 0000000..2d947d3
> --- /dev/null
> +++ b/Documentation/hwmon/lm73
> @@ -0,0 +1,78 @@
> +Kernel driver lm90
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
> +    0.25          14             0..21
> +    0.125         28            22..42
> +    0.0625        56            43..84
> +    0.03125       112           85..infinity
> +    --------------------------------------
> +
> +The following examples show how the 'update_interval' attribute can be
> +used to change the conversion time:
> +
> +    $ echo 0 > temp1_update_interval
> +    $ cat temp1_update_interval
> +    14
> +    $ cat temp1_input
> +    24250
> +
> +    $ echo 36 > temp1_update_interval
> +    $ cat temp1_update_interval
> +    28
> +    $ cat temp1_input
> +    24125
> +
> +    $ echo 56 > temp1_update_interval
> +    $ cat temp1_update_interval
> +    56
> +    $ cat temp1_input
> +    24062
> +
> +    $ echo 85 > temp1_update_interval
> +    $ cat temp1_update_interval
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
> index 7272176..f443fad 100644
> --- a/drivers/hwmon/lm73.c
> +++ b/drivers/hwmon/lm73.c
> @@ -21,7 +21,6 @@
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/err.h>
>  
> -
>  /* Addresses scanned */
>  static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
>  					0x4d, 0x4e, I2C_CLIENT_END };
> @@ -39,8 +38,20 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
>  #define LM73_TEMP_MIN		(-40)
>  #define LM73_TEMP_MAX		150
>  
> -/*-----------------------------------------------------------------------*/
> +#define LM73_CTRL_RES_SHIFT	5
> +#define LM73_CTRL_RES_SIZE	2
> +#define LM73_CTRL_RES_MASK	((1 << LM73_CTRL_RES_SIZE) - 1)
>  
> +#define SCALE_150_PERCENT(x)	(((x) * 150) / 100)
> +
> +static const unsigned short lm73_valid_convrates[] = {
> +	14,	/* 11-bits (0.25000 C/LSB): RES1 Bit = 0, RES0 Bit = 0 */
> +	28,	/* 12-bits (0.12500 C/LSB): RES1 Bit = 0, RES0 Bit = 1 */
> +	56,	/* 13-bits (0.06250 C/LSB): RES1 Bit = 1, RES0 Bit = 0 */
> +	112,	/* 14-bits (0.03125 C/LSB): RES1 Bit = 1, RES0 Bit = 1 */
> +};
> +
> +/*-----------------------------------------------------------------------*/
>  
>  static ssize_t set_temp(struct device *dev, struct device_attribute *da,
>  			const char *buf, size_t count)
> @@ -79,6 +90,62 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *da,
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
> +	u8 value;
> +
> +	err = kstrtoul(buf, 10, &convrate);
> +	if (err < 0)
> +		return err;
> +
> +	/* Read existing control value */
> +	err = i2c_smbus_read_byte_data(client, LM73_REG_CTRL);
> +	if (err < 0)
> +		return err;
> +	value = err;
> +
> +	/* Convert the desired conversion rate into register bits */
> +	if (convrate < SCALE_150_PERCENT(lm73_valid_convrates[0]))
> +		res_bits = 0;
> +	else if (convrate < SCALE_150_PERCENT(lm73_valid_convrates[1]))
> +		res_bits = 1;
> +	else if (convrate < SCALE_150_PERCENT(lm73_valid_convrates[2]))
> +		res_bits = 2;
> +	else
> +		res_bits = 3;
> +
> +	/* Create the new control register value */
> +	value &= ~(LM73_CTRL_RES_MASK << LM73_CTRL_RES_SHIFT);
> +	value |= (res_bits << LM73_CTRL_RES_SHIFT);
> +
> +	/* Write value */
> +	err = i2c_smbus_write_byte_data(client, LM73_REG_CTRL, value);
> +	if (err < 0)
> +		return err;
> +	return count;
> +}
> +
> +static ssize_t show_convrate(struct device *dev, struct device_attribute *da,
> +			     char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	uint32_t ctrl;
> +	u8 res_bits = 0;
> +
> +	/* Read existing control value */
> +	ctrl = i2c_smbus_read_byte_data(client, LM73_REG_CTRL);
> +	if (ctrl < 0)
> +		return ctrl;
> +
> +	res_bits = (ctrl >> LM73_CTRL_RES_SHIFT) & LM73_CTRL_RES_MASK;
> +	return scnprintf(buf, PAGE_SIZE, "%hu\n",
> +			lm73_valid_convrates[res_bits]);
> +}
>  
>  /*-----------------------------------------------------------------------*/
>  
> @@ -90,13 +157,14 @@ static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
>  			show_temp, set_temp, LM73_REG_MIN);
>  static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
>  			show_temp, NULL, LM73_REG_INPUT);
> -
> +static SENSOR_DEVICE_ATTR(temp1_update_interval, S_IWUSR | S_IRUGO,
> +			show_convrate, set_convrate, LM73_REG_CTRL);
>  
>  static struct attribute *lm73_attributes[] = {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
>  	&sensor_dev_attr_temp1_max.dev_attr.attr,
>  	&sensor_dev_attr_temp1_min.dev_attr.attr,
> -
> +	&sensor_dev_attr_temp1_update_interval.dev_attr.attr,
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
