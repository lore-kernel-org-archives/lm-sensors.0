From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Feb 2010 09:56:08 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/adt7411: improve locking
Message-Id: <20100221105608.5474cc86@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1266513278-15333-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1266513278-15333-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 18 Feb 2010 18:14:38 +0100, Wolfram Sang wrote:
> Add proper locking for the cached variables. Also get rid of ref_is_vdd, which
> became obsolete.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Jean Delvare <khali@linux-fr.org>

Yes, exactly what I had in mind. Patch applied, thanks.

> ---
>  drivers/hwmon/adt7411.c |   21 ++++++++++++++-------
>  1 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
> index 2a86314..05b34b1 100644
> --- a/drivers/hwmon/adt7411.c
> +++ b/drivers/hwmon/adt7411.c
> @@ -48,9 +48,9 @@ static const unsigned short normal_i2c[] = { 0x48, 0x4a, 0x4b, I2C_CLIENT_END };
>  
>  struct adt7411_data {
>  	struct mutex device_lock;	/* for "atomic" device accesses */
> +	struct mutex update_lock;
>  	unsigned long next_update;
>  	int vref_cached;
> -	bool ref_is_vdd;
>  	struct device *hwmon_dev;
>  };
>  
> @@ -142,18 +142,18 @@ static ssize_t adt7411_show_input(struct device *dev,
>  	int val;
>  	u8 lsb_reg, lsb_shift;
>  
> +	mutex_lock(&data->update_lock);
>  	if (time_after_eq(jiffies, data->next_update)) {
>  		val = i2c_smbus_read_byte_data(client, ADT7411_REG_CFG3);
>  		if (val < 0)
> -			return val;
> -		data->ref_is_vdd = val & ADT7411_CFG3_REF_VDD;
> +			goto exit_unlock;
>  
> -		if (data->ref_is_vdd) {
> +		if (val & ADT7411_CFG3_REF_VDD) {
>  			val = adt7411_read_10_bit(client,
>  					ADT7411_REG_INT_TEMP_VDD_LSB,
>  					ADT7411_REG_VDD_MSB, 2);
>  			if (val < 0)
> -				return val;
> +				goto exit_unlock;
>  
>  			data->vref_cached = val * 7000 / 1024;
>  		} else {
> @@ -167,9 +167,13 @@ static ssize_t adt7411_show_input(struct device *dev,
>  	lsb_shift = 2 * (nr & 0x03);
>  	val = adt7411_read_10_bit(client, lsb_reg,
>  			ADT7411_REG_EXT_TEMP_AIN1_MSB + nr, lsb_shift);
> +	if (val < 0)
> +		goto exit_unlock;
>  
> -	return val < 0 ? val :
> -			sprintf(buf, "%u\n", val * data->vref_cached / 1024);
> +	val = sprintf(buf, "%u\n", val * data->vref_cached / 1024);
> + exit_unlock:
> +	mutex_unlock(&data->update_lock);
> +	return val;
>  }
>  
>  static ssize_t adt7411_show_bit(struct device *dev,
> @@ -198,7 +202,9 @@ static ssize_t adt7411_set_bit(struct device *dev, struct device_attribute *attr
>  	ret = adt7411_modify_bit(client, s_attr2->index, s_attr2->nr, flag);
>  
>  	/* force update */
> +	mutex_lock(&data->update_lock);
>  	data->next_update = jiffies;
> +	mutex_unlock(&data->update_lock);
>  
>  	return ret < 0 ? ret : count;
>  }
> @@ -280,6 +286,7 @@ static int __devinit adt7411_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, data);
>  	mutex_init(&data->device_lock);
> +	mutex_init(&data->update_lock);
>  
>  	ret = adt7411_modify_bit(client, ADT7411_REG_CFG1,
>  				 ADT7411_CFG1_START_MONITOR, 1);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
