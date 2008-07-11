From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 Jul 2008 13:17:37 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] lm90: Support MAX6646,
Message-Id: <20080711151737.4d2d1f89@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Thu, 10 Jul 2008 15:59:35 +0100, Ben Hutchings wrote:
> These Maxim chips are similar to MAX6657 but use unsigned temperature
> values to allow for readings up to 145 degrees.
> 
> Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
> ---
>  drivers/hwmon/Kconfig |    3 +-
>  drivers/hwmon/lm90.c  |   67 ++++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 55 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index b8ab275..cc40c88 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -485,7 +485,8 @@ config SENSORS_LM90
>  	help
>  	  If you say yes here you get support for National Semiconductor LM90,
>  	  LM86, LM89 and LM99, Analog Devices ADM1032 and ADT7461, and Maxim
> -	  MAX6657, MAX6658, MAX6659, MAX6680 and MAX6681 sensor chips.
> +	  MAX6646, MAX6647, MAX6649, MAX6657, MAX6658, MAX6659, MAX6680 and
> +	  MAX6681 sensor chips.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called lm90.
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 9ee7e3a..dbf0dfe 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -25,9 +25,10 @@
>   * that are not handled by this driver. Among others, it has a higher
>   * accuracy than the LM90, much like the LM86 does.
>   *
> - * This driver also supports the MAX6657, MAX6658 and MAX6659 sensor
> - * chips made by Maxim. These chips are similar to the LM86.
> - * Note that there is no easy way to differentiate between the three
> + * This driver also supports the MAX6646, MAX6647, MAX6649, MAX6657,
> + * MAX6658 and MAX6659 sensor chips made by Maxim. These chips are
> + * similar to the LM86.

This isn't really correct. While the MAX6657, MAX6658 and MAX6659 are
indeed similar to the LM86, the MAX6646, MAX6647 and MAX6649 use a
different temperature encoding to support a different temperature range.

> + * Note that there is no easy way to differentiate between the MAX665x
>   * variants. The extra address and features of the MAX6659 are not
>   * supported by this driver. These chips lack the remote temperature
>   * offset feature.

This is also not totally correct, you can differentiate between the
MAX6657 and the MAX6646 (different device ID register value).

So, please make a separate paragraph for the MAX6646, MAX6647 and
MAX6649 chips, instead of merging them in the MAX6657 paragraph.

Your patch should also update Documentation/hwmon/lm90 to mention the
newly supported chips.

> @@ -76,9 +77,10 @@
>   * Addresses to scan
>   * Address is fully defined internally and cannot be changed except for
>   * MAX6659, MAX6680 and MAX6681.
> - * LM86, LM89, LM90, LM99, ADM1032, ADM1032-1, ADT7461, MAX6657 and MAX6658
> - * have address 0x4c.
> - * ADM1032-2, ADT7461-2, LM89-1, and LM99-1 have address 0x4d.
> + * LM86, LM89, LM90, LM99, ADM1032, ADM1032-1, ADT7461, MAX6649, MAX6657
> + * and MAX6658 have address 0x4c.
> + * ADM1032-2, ADT7461-2, LM89-1, LM99-1 and MAX6646 have address 0x4d.
> + * MAX6647 has address 0x4e.
>   * MAX6659 can have address 0x4c, 0x4d or 0x4e (unsupported).
>   * MAX6680 and MAX6681 can have address 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b,
>   * 0x4c, 0x4d or 0x4e.
> @@ -91,7 +93,8 @@ static const unsigned short normal_i2c[] = {
>   * Insmod parameters
>   */
>  
> -I2C_CLIENT_INSMOD_7(lm90, adm1032, lm99, lm86, max6657, adt7461, max6680);
> +I2C_CLIENT_INSMOD_8(lm90, adm1032, lm99, lm86, max6657, adt7461, max6680,
> +		    max6646);
>  
>  /*
>   * The LM90 registers
> @@ -132,7 +135,7 @@ I2C_CLIENT_INSMOD_7(lm90, adm1032, lm99, lm86, max6657, adt7461, max6680);
>  #define LM90_REG_R_TCRIT_HYST		0x21
>  #define LM90_REG_W_TCRIT_HYST		0x21
>  
> -/* MAX6657-specific registers */
> +/* MAX6646/6647/6649/6657/6658/6659 registers */
>  
>  #define MAX6657_REG_R_LOCAL_TEMPL	0x11
>  
> @@ -185,7 +188,7 @@ struct lm90_data {
>  	s16 temp11[5];	/* 0: remote input
>  			   1: remote low limit
>  			   2: remote high limit
> -			   3: remote offset (except max6657)
> +			   3: remote offset (except max6646 and max6657)
>  			   4: local input */
>  	u8 temp_hyst;
>  	u8 alarms; /* bitvector */
> @@ -197,6 +200,8 @@ struct lm90_data {
>   * value, the LM90 uses signed 8-bit values with LSB = 1 degree Celsius.
>   * For remote temperatures and limits, it uses signed 11-bit values with
>   * LSB = 0.125 degree Celsius, left-justified in 16-bit registers.
> + * Some Maxim chips use 16-bit signed or unsigned values for local and
> + * both remote temperatures.

That's a bit confusing, makes it sound like the same chip can do both,
and also that these chips have 16 bits of actual resolution. I am also
not aware of any of these chips supporting two external temperature
sensors? What about just:

 * Some Maxim chips use unsigned values instead.

>   */
>  
>  static inline int temp_from_s8(s8 val)
> @@ -204,11 +209,21 @@ static inline int temp_from_s8(s8 val)
>  	return val * 1000;
>  }
>  
> +static inline int temp_from_u8(u8 val)
> +{
> +	return val * 1000;
> +}
> +
>  static inline int temp_from_s16(s16 val)
>  {
>  	return val / 32 * 125;
>  }
>  
> +static inline int temp_from_u16(u16 val)
> +{
> +	return val / 32 * 125;
> +}
> +
>  static s8 temp_to_s8(long val)
>  {
>  	if (val <= -128000)
> @@ -220,6 +235,15 @@ static s8 temp_to_s8(long val)
>  	return (val + 500) / 1000;
>  }
>  
> +static u8 temp_to_u8(long val)
> +{
> +	if (val <= 0)
> +		return 0;
> +	if (val >= 255000)
> +		return 255;
> +	return (val + 500) / 1000;
> +}
> +
>  static s16 temp_to_s16(long val)
>  {
>  	if (val <= -128000)
> @@ -311,6 +335,8 @@ static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
>  
>  	if (data->kind = adt7461)
>  		temp = temp_from_u8_adt7461(data, data->temp8[attr->index]);
> +	else if (data->kind = max6646)
> +		temp = temp_from_u8(data->temp8[attr->index]);
>  	else
>  		temp = temp_from_s8(data->temp8[attr->index]);
>  
> @@ -336,6 +362,8 @@ static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
>  	mutex_lock(&data->update_lock);
>  	if (data->kind = adt7461)
>  		data->temp8[nr] = temp_to_u8_adt7461(data, val);
> +	else if (data->kind = max6646)
> +		data->temp8[nr] = temp_to_u8(val);
>  	else
>  		data->temp8[nr] = temp_to_s8(val);
>  	i2c_smbus_write_byte_data(client, reg[nr], data->temp8[nr]);
> @@ -352,6 +380,8 @@ static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
>  
>  	if (data->kind = adt7461)
>  		temp = temp_from_u16_adt7461(data, data->temp11[attr->index]);
> +	else if (data->kind = max6646)
> +		temp = temp_from_u16(data->temp11[attr->index]);
>  	else
>  		temp = temp_from_s16(data->temp11[attr->index]);
>  
> @@ -381,12 +411,15 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
>  		data->temp11[nr] = temp_to_u16_adt7461(data, val);
>  	else if (data->kind = max6657 || data->kind = max6680)
>  		data->temp11[nr] = temp_to_s8(val) << 8;
> +	else if (data->kind = max6646)
> +		data->temp11[nr] = temp_to_u8(val) << 8;
>  	else
>  		data->temp11[nr] = temp_to_s16(val);
>  
>  	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
>  				  data->temp11[nr] >> 8);
> -	if (data->kind != max6657 && data->kind != max6680)
> +	if (data->kind != max6657 && data->kind != max6680
> +	    && data->kind != max6646)
>  		i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2 + 1],
>  					  data->temp11[nr] & 0xff);
>  	mutex_unlock(&data->update_lock);
> @@ -696,6 +729,8 @@ static int lm90_detect(struct i2c_adapter *adapter, int address, int kind)
>  			 && (reg_config1 & 0x03) = 0x00
>  			 && reg_convrate <= 0x07) {
>  			 	kind = max6680;
> +			} else if (chip_id = 0x59) {
> +				kind = max6646;

I see no reason why you wouldn't check the config and conversion rate
registers as we do for all other chips, to make detection a bit more
reliable.

>  			}
>  		}
>  
> @@ -725,6 +760,8 @@ static int lm90_detect(struct i2c_adapter *adapter, int address, int kind)
>  		name = "max6680";
>  	} else if (kind = adt7461) {
>  		name = "adt7461";
> +	} else if (kind = max6646) {
> +		name = "max6646";
>  	}
>  
>  	/* We can fill in the remaining client fields */
> @@ -748,7 +785,7 @@ static int lm90_detect(struct i2c_adapter *adapter, int address, int kind)
>  					      &dev_attr_pec)))
>  			goto exit_remove_files;
>  	}
> -	if (data->kind != max6657) {
> +	if (data->kind != max6657 && data->kind != max6646) {
>  		if ((err = device_create_file(&new_client->dev,
>  				&sensor_dev_attr_temp2_offset.dev_attr)))
>  			goto exit_remove_files;
> @@ -811,7 +848,7 @@ static int lm90_detach_client(struct i2c_client *client)
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&client->dev.kobj, &lm90_group);
>  	device_remove_file(&client->dev, &dev_attr_pec);
> -	if (data->kind != max6657)
> +	if (data->kind != max6657 && data->kind != max6646)
>  		device_remove_file(&client->dev,
>  				   &sensor_dev_attr_temp2_offset.dev_attr);
>  
> @@ -871,7 +908,7 @@ static struct lm90_data *lm90_update_device(struct device *dev)
>  		lm90_read_reg(client, LM90_REG_R_REMOTE_CRIT, &data->temp8[3]);
>  		lm90_read_reg(client, LM90_REG_R_TCRIT_HYST, &data->temp_hyst);
>  
> -		if (data->kind = max6657) {
> +		if (data->kind = max6657 || data->kind = max6646) {
>  			lm90_read16(client, LM90_REG_R_LOCAL_TEMP,
>  				    MAX6657_REG_R_LOCAL_TEMPL,
>  				    &data->temp11[4]);
> @@ -886,6 +923,7 @@ static struct lm90_data *lm90_update_device(struct device *dev)
>  		if (lm90_read_reg(client, LM90_REG_R_REMOTE_LOWH, &h) = 0) {
>  			data->temp11[1] = h << 8;
>  			if (data->kind != max6657 && data->kind != max6680
> +			 && data->kind != max6646
>  			 && lm90_read_reg(client, LM90_REG_R_REMOTE_LOWL,
>  					  &l) = 0)
>  				data->temp11[1] |= l;
> @@ -893,12 +931,13 @@ static struct lm90_data *lm90_update_device(struct device *dev)
>  		if (lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH, &h) = 0) {
>  			data->temp11[2] = h << 8;
>  			if (data->kind != max6657 && data->kind != max6680
> +			 && data->kind != max6646
>  			 && lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHL,
>  					  &l) = 0)
>  				data->temp11[2] |= l;
>  		}
>  
> -		if (data->kind != max6657) {
> +		if (data->kind != max6657 && data->kind != max6646) {
>  			if (lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSH,
>  					  &h) = 0
>  			 && lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSL,

All the rest looks good.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
