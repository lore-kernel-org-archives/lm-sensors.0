From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 Jul 2008 12:17:47 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] lm90: Rename temperature conversion
Message-Id: <20080711141747.56df4b3c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080710145855.GA19302@solarflare.com>
In-Reply-To: <20080710145855.GA19302@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Thu, 10 Jul 2008 15:58:56 +0100, Ben Hutchings wrote:
> The encoding of temperatures varies between chips and modes.  So do not
> use "temp1" or "temp2" in the names of the conversion functions, but
> specify the encoding.

Note that temp1 and temp2 in these function names were originally
supposed to mean "1-byte temperature value" and "2-byte temperature
value", respectively. So this isn't related with the temp1 and temp2
temperature channels. But I agree that this is confusing and I prefer
the new names you suggested.

> Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
> ---
>  drivers/hwmon/lm90.c |   46 +++++++++++++++++++++++-----------------------
>  1 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index f16c7ee..9ee7e3a 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -199,17 +199,17 @@ struct lm90_data {
>   * LSB = 0.125 degree Celsius, left-justified in 16-bit registers.
>   */
>  
> -static inline int temp1_from_reg(s8 val)
> +static inline int temp_from_s8(s8 val)
>  {
>  	return val * 1000;
>  }
>  
> -static inline int temp2_from_reg(s16 val)
> +static inline int temp_from_s16(s16 val)
>  {
>  	return val / 32 * 125;
>  }
>  
> -static s8 temp1_to_reg(long val)
> +static s8 temp_to_s8(long val)
>  {
>  	if (val <= -128000)
>  		return -128;
> @@ -220,7 +220,7 @@ static s8 temp1_to_reg(long val)
>  	return (val + 500) / 1000;
>  }
>  
> -static s16 temp2_to_reg(long val)
> +static s16 temp_to_s16(long val)
>  {
>  	if (val <= -128000)
>  		return 0x8000;
> @@ -248,23 +248,23 @@ static u8 hyst_to_reg(long val)
>   * ADT7461 in "extended mode" operation uses unsigned integers offset by
>   * 64 (e.g., 0 -> -64 degC).  The range is restricted to -64..191 degC.
>   */
> -static inline int temp1_from_reg_adt7461(struct lm90_data *data, u8 val)
> +static inline int temp_from_u8_adt7461(struct lm90_data *data, u8 val)
>  {
>  	if (data->flags & LM90_FLAG_ADT7461_EXT)
>  		return (val - 64) * 1000;
>  	else
> -		return temp1_from_reg(val);
> +		return temp_from_s8(val);
>  }
>  
> -static inline int temp2_from_reg_adt7461(struct lm90_data *data, u16 val)
> +static inline int temp_from_u16_adt7461(struct lm90_data *data, u16 val)
>  {
>  	if (data->flags & LM90_FLAG_ADT7461_EXT)
>  		return (val - 0x4000) / 64 * 250;
>  	else
> -		return temp2_from_reg(val);
> +		return temp_from_s16(val);
>  }
>  
> -static u8 temp1_to_reg_adt7461(struct lm90_data *data, long val)
> +static u8 temp_to_u8_adt7461(struct lm90_data *data, long val)
>  {
>  	if (data->flags & LM90_FLAG_ADT7461_EXT) {
>  		if (val <= -64000)
> @@ -281,7 +281,7 @@ static u8 temp1_to_reg_adt7461(struct lm90_data *data, long val)
>  	}
>  }
>  
> -static u16 temp2_to_reg_adt7461(struct lm90_data *data, long val)
> +static u16 temp_to_u16_adt7461(struct lm90_data *data, long val)
>  {
>  	if (data->flags & LM90_FLAG_ADT7461_EXT) {
>  		if (val <= -64000)
> @@ -310,9 +310,9 @@ static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
>  	int temp;
>  
>  	if (data->kind = adt7461)
> -		temp = temp1_from_reg_adt7461(data, data->temp8[attr->index]);
> +		temp = temp_from_u8_adt7461(data, data->temp8[attr->index]);
>  	else
> -		temp = temp1_from_reg(data->temp8[attr->index]);
> +		temp = temp_from_s8(data->temp8[attr->index]);
>  
>  	return sprintf(buf, "%d\n", temp);
>  }
> @@ -335,9 +335,9 @@ static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
>  
>  	mutex_lock(&data->update_lock);
>  	if (data->kind = adt7461)
> -		data->temp8[nr] = temp1_to_reg_adt7461(data, val);
> +		data->temp8[nr] = temp_to_u8_adt7461(data, val);
>  	else
> -		data->temp8[nr] = temp1_to_reg(val);
> +		data->temp8[nr] = temp_to_s8(val);
>  	i2c_smbus_write_byte_data(client, reg[nr], data->temp8[nr]);
>  	mutex_unlock(&data->update_lock);
>  	return count;
> @@ -351,9 +351,9 @@ static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
>  	int temp;
>  
>  	if (data->kind = adt7461)
> -		temp = temp2_from_reg_adt7461(data, data->temp11[attr->index]);
> +		temp = temp_from_u16_adt7461(data, data->temp11[attr->index]);
>  	else
> -		temp = temp2_from_reg(data->temp11[attr->index]);
> +		temp = temp_from_s16(data->temp11[attr->index]);
>  
>  	return sprintf(buf, "%d\n", temp);
>  }
> @@ -378,11 +378,11 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
>  
>  	mutex_lock(&data->update_lock);
>  	if (data->kind = adt7461)
> -		data->temp11[nr] = temp2_to_reg_adt7461(data, val);
> +		data->temp11[nr] = temp_to_u16_adt7461(data, val);
>  	else if (data->kind = max6657 || data->kind = max6680)
> -		data->temp11[nr] = temp1_to_reg(val) << 8;
> +		data->temp11[nr] = temp_to_s8(val) << 8;
>  	else
> -		data->temp11[nr] = temp2_to_reg(val);
> +		data->temp11[nr] = temp_to_s16(val);
>  
>  	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
>  				  data->temp11[nr] >> 8);
> @@ -401,11 +401,11 @@ static ssize_t show_temphyst(struct device *dev, struct device_attribute *devatt
>  	int temp;
>  
>  	if (data->kind = adt7461)
> -		temp = temp1_from_reg_adt7461(data, data->temp8[attr->index]);
> +		temp = temp_from_u8_adt7461(data, data->temp8[attr->index]);
>  	else
> -		temp = temp1_from_reg(data->temp8[attr->index]);
> +		temp = temp_from_s8(data->temp8[attr->index]);
>  
> -	return sprintf(buf, "%d\n", temp - temp1_from_reg(data->temp_hyst));
> +	return sprintf(buf, "%d\n", temp - temp_from_s8(data->temp_hyst));
>  }
>  
>  static ssize_t set_temphyst(struct device *dev, struct device_attribute *dummy,
> @@ -417,7 +417,7 @@ static ssize_t set_temphyst(struct device *dev, struct device_attribute *dummy,
>  	long hyst;
>  
>  	mutex_lock(&data->update_lock);
> -	hyst = temp1_from_reg(data->temp8[2]) - val;
> +	hyst = temp_from_s8(data->temp8[2]) - val;
>  	i2c_smbus_write_byte_data(client, LM90_REG_W_TCRIT_HYST,
>  				  hyst_to_reg(hyst));
>  	mutex_unlock(&data->update_lock);

Acked-by: Jean Delvare <khali@linux-fr.org>

I am also adding this patch to my set of lm90 patches, so it will be
included in future reposts automatically.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
