From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 24 Dec 2012 16:56:05 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] lm73: added 'update_interval' attribute
Message-Id: <20121224165605.GA18259@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1356336669-18722-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1356336669-18722-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 24, 2012 at 12:11:09AM -0800, Chris Verges wrote:
> The LM73 supports four A/D conversion resolutions.  The default used by
> the existing lm73 driver is the chip's default, 11-bit (0.25 C/LSB).
> This patch enables changing of this resolution from userspace via the
> temp1_update_interval attribute.
> 
> To change the resolution, write the maximum conversion time as specified
> in the LM73 datasheet for the resolution desired:
> 
>    echo 14  > temp1_update_interval;   # 11-bit, 0.25 C/LSB
>    echo 28  > temp1_update_interval;   # 12-bit, 0.125 C/LSB
>    echo 56  > temp1_update_interval;   # 13-bit, 0.0625 C/LSB
>    echo 112 > temp1_update_interval;   # 14-bit, 0.03125 C/LSB
> 
We'll need to have Documentation/hwmon/lm73 to describe the above.

> In essence, the user can trade off conversion time for increased
> precision.
> 
> Signed-off-by: Chris Verges <kg4ysn@gmail.com>
> ---
>  drivers/hwmon/lm73.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
> index 7272176..e6c1e05 100644
> --- a/drivers/hwmon/lm73.c
> +++ b/drivers/hwmon/lm73.c
> @@ -39,6 +39,17 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
>  #define LM73_TEMP_MIN		(-40)
>  #define LM73_TEMP_MAX		150
>  
> +#define LM73_CTRL_RES_OFFSET	(5)
> +#define LM73_CTRL_RES_SIZE	(2)

Unnecessary ( )
Maybe LM73_CTRL_RES_SHIFT instead of LM73_CTRL_RES_OFFSET would be better.

> +#define LM73_CTRL_RES_MASK	((1 << LM73_CTRL_RES_SIZE) - 1)
> +
> +static long lm73_valid_convrates[] = {

int or even u16 would be sufficient.

> +	14,	/* 11-bits (0.25000 C/LSB): RES1 Bit = 0, RES0 Bit = 0 */
> +	28,	/* 12-bits (0.12500 C/LSB): RES1 Bit = 0, RES0 Bit = 1 */
> +	56,	/* 13-bits (0.06250 C/LSB): RES1 Bit = 1, RES0 Bit = 0 */
> +	112,	/* 14-bits (0.03125 C/LSB): RES1 Bit = 1, RES0 Bit = 1 */
> +};
> +
>  /*-----------------------------------------------------------------------*/
>  
>  
> @@ -79,6 +90,58 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *da,
>  	return scnprintf(buf, PAGE_SIZE, "%d\n", temp);
>  }
>  
> +static ssize_t set_convrate(struct device *dev, struct device_attribute *da,
> +			    const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	long convrate;
> +	uint32_t ctrl;
> +	u8 res_bits = 0;
> +	u8 value;
> +	u32 err;

Be careful with variable types. u32 and uint32_t wil never be negative. And
please don't mix the types like you do here. But then both need to be int
anyway.

> +
> +	int status = kstrtol(buf, 10, &convrate);
> +	if (status < 0)
> +		return status;
> +
Negative values don't make much sense here, so unsigned long and kstrtoul might
be better. And you don't need both status and err variables; I'd suggest to go
with err.

> +	/* Validate the accepted conversion rate */
> +	while (res_bits < ARRAY_SIZE(lm73_valid_convrates) && lm73_valid_convrates[res_bits] != convrate)

Line length

> +		res_bits++;
> +
You'll want to check for ranges here, eg accept everything from 0 .. 21 to 14,
everything from 21 .. (28 + 56) / 2 to 28 and so on.

> +	if (res_bits >= ARRAY_SIZE(lm73_valid_convrates))
> +		return -EINVAL;
> +
> +	/* Read existing control value */
> +	ctrl = i2c_smbus_read_byte_data(client, attr->index);

Please use LM73_REG_CTRL directly.

> +	if (ctrl < 0)
> +		return ctrl;

ctrl is uint32_t and thus never negative. Needs to be int.

> +
> +	/* Write value */
> +	value = ctrl;

Just define ctrl as int and use it. No need for a separate variable.

> +	value &= ~(LM73_CTRL_RES_MASK << LM73_CTRL_RES_OFFSET);
> +	value |= ((res_bits & LM73_CTRL_RES_MASK) << LM73_CTRL_RES_OFFSET);

res_bits will never be larger than the mask, so no need to mask it here.

> +	err = i2c_smbus_write_byte_data(client, attr->index, value);
> +	return (err < 0) ? err : count;

I personally prefer 
	if (err < 0)
		return err;
	return count;
as less confusing. But if you do it fancy, you might as well use

	return (err < 0) ? : count;

> +}
> +
> +static ssize_t show_convrate(struct device *dev, struct device_attribute *da,
> +			     char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	uint32_t ctrl;
> +	u8 res_bits = 0;
> +
> +	/* Read existing control value */
> +	ctrl = i2c_smbus_read_byte_data(client, attr->index);

You can use LM73_REG_CTRL directly here. Using the ->index variable only
makes sense if there are multiple functions accessing different registers with
the same code.

> +	if (ctrl < 0)
> +		return ctrl;

You defined ctrl as uint32_t, so it will never be negative.

> +
> +	res_bits = (ctrl & ~LM73_CTRL_RES_MASK) >> LM73_CTRL_RES_OFFSET;

		= (ctrl >> LM73_CTRL_RES_OFFSET) & LM73_CTRL_RES_MASK;

> +	return scnprintf(buf, PAGE_SIZE, "%u\n", res_bits);

Need to convert to ms.
	return scnprintf(buf, PAGE_SIZE, "%ld\n", lm73_valid_convrates[res_bits]);

or %d / %u depending on the type of lm73_valid_convrates.

> +}
> +
>  
One empty line is enough.

>  /*-----------------------------------------------------------------------*/
>  
> @@ -90,13 +153,15 @@ static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
>  			show_temp, set_temp, LM73_REG_MIN);
>  static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
>  			show_temp, NULL, LM73_REG_INPUT);
> +static SENSOR_DEVICE_ATTR(temp1_update_interval, S_IWUSR | S_IRUGO,
> +			show_convrate, set_convrate, LM73_REG_CTRL);
>  
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
