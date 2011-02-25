From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Feb 2011 14:43:52 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (lm85) Add support for EMC6D103S
Message-Id: <20110225154352.6e88c7c9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298252352-20931-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1298252352-20931-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sun, 20 Feb 2011 17:39:12 -0800, Guenter Roeck wrote:
> EMC6D103S is similar to EMC6D103, only it does not support registers 62[5:7],
> 6D[0:7], and 6E[0:7]. Register respective sysfs attributes and update affected
> registers for all other chips only.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> v2: Fix typo in subject
>     Add EMC66D103 and EMC6D103S to driver documentation

Can you please update wiki/Devices too?

Review:

> 
>  Documentation/hwmon/lm85 |   13 ++++++-
>  drivers/hwmon/lm85.c     |   97 ++++++++++++++++++++++++++++++----------------
>  2 files changed, 75 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/hwmon/lm85 b/Documentation/hwmon/lm85
> index 239258a..0bc9a22 100644
> --- a/Documentation/hwmon/lm85
> +++ b/Documentation/hwmon/lm85
> @@ -26,6 +26,14 @@ Supported chips:
>      Prefix: 'emc6d102'
>      Addresses scanned: I2C 0x2c, 0x2d, 0x2e
>      Datasheet: http://www.smsc.com/main/catalog/emc6d102.html
> +  * SMSC EMC6D103
> +    Prefix: 'emc6d103'
> +    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
> +    Datasheet: http://www.smsc.com/main/catalog/emc6d103.html
> +  * SMSC EMC6D103S
> +    Prefix: 'emc6d103s'
> +    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
> +    Datasheet: http://www.smsc.com/main/catalog/emc6d103s.html
>  
>  Authors:
>          Philip Pokorny <ppokorny@penguincomputing.com>,
> @@ -122,9 +130,12 @@ to be register compatible. The EMC6D100 offers all the features of the
>  EMC6D101 plus additional voltage monitoring and system control features.
>  Unfortunately it is not possible to distinguish between the package
>  versions on register level so these additional voltage inputs may read
> -zero. The EMC6D102 features addtional ADC bits thus extending precision
> +zero. EMC6D102 and EMC6D103 feature addtional ADC bits thus extending precision
>  of voltage and temperature channels.
>  
> +SMSC EMC6D103S is similar to EMC6D103, but does not support registers 62[5:7],
> +6D[0:7], and 6E[0:7]. Respective sysfs attributes (pwmX_auto_pwm_minctl and
> +tempX_auto_temp_off) are therefore not supported for this chip.

The documentation being user-oriented, I think it is more valuable to
document the missing features than the missing registers. The register
values can be seen in the driver source code for the interested.

If you really insist on documenting the registers, please prefix
hexadecimal values with 0x for clarity, and drop the [0:7]s which don't
add value.

Lastly, "not created" would seem more appropriate than "not supported"
in the last sentence.

>  
>  Hardware Configurations
>  -----------------------
> diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
> index d2cc286..d4dd824 100644
> --- a/drivers/hwmon/lm85.c
> +++ b/drivers/hwmon/lm85.c
> @@ -41,7 +41,7 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
>  enum chips {
>  	any_chip, lm85b, lm85c,
>  	adm1027, adt7463, adt7468,
> -	emc6d100, emc6d102, emc6d103
> +	emc6d100, emc6d102, emc6d103, emc6d103s
>  };
>  
>  /* The LM85 registers */
> @@ -352,6 +352,7 @@ static const struct i2c_device_id lm85_id[] = {
>  	{ "emc6d101", emc6d100 },
>  	{ "emc6d102", emc6d102 },
>  	{ "emc6d103", emc6d103 },
> +	{ "emc6d103s", emc6d103s },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, lm85_id);
> @@ -935,16 +936,18 @@ static ssize_t set_temp_auto_temp_min(struct device *dev,
>  		| (data->pwm_freq[nr] & 0x07));
>  
>  /* Update temp_auto_hyst and temp_auto_off */
> -	data->zone[nr].hyst = HYST_TO_REG(TEMP_FROM_REG(
> -		data->zone[nr].limit) - TEMP_FROM_REG(
> -		data->zone[nr].off_desired));
> -	if (nr = 0 || nr = 1) {
> -		lm85_write_value(client, LM85_REG_AFAN_HYST1,
> -			(data->zone[0].hyst << 4)
> -			| data->zone[1].hyst);
> -	} else {
> -		lm85_write_value(client, LM85_REG_AFAN_HYST2,
> -			(data->zone[2].hyst << 4));
> +	if (data->type != emc6d103s) {
> +		data->zone[nr].hyst = HYST_TO_REG(TEMP_FROM_REG(
> +			data->zone[nr].limit) - TEMP_FROM_REG(
> +			data->zone[nr].off_desired));
> +		if (nr = 0 || nr = 1) {
> +			lm85_write_value(client, LM85_REG_AFAN_HYST1,
> +				(data->zone[0].hyst << 4)
> +				| data->zone[1].hyst);
> +		} else {
> +			lm85_write_value(client, LM85_REG_AFAN_HYST2,
> +				(data->zone[2].hyst << 4));
> +		}
>  	}

This piece of code could probably go away altogether. It tries to be
smart, but it's bogus. data->zone[nr].off_desired is only initialized
if set_temp_auto_temp_off() is called, so if set_temp_auto_temp_min()
is called first, the "off" value will be set improperly.

It would seem better, and easier, to leave the delta unchanged between
"min" and "off", until the user sets the "off" value again. This is
what other drivers do (except that other drivers make it clear that
this is an hysteresis and not two separate values.)

>  	mutex_unlock(&data->update_lock);
>  	return count;
> @@ -1084,13 +1087,7 @@ static struct attribute *lm85_attributes[] = {
>  	&sensor_dev_attr_pwm1_auto_pwm_min.dev_attr.attr,
>  	&sensor_dev_attr_pwm2_auto_pwm_min.dev_attr.attr,
>  	&sensor_dev_attr_pwm3_auto_pwm_min.dev_attr.attr,
> -	&sensor_dev_attr_pwm1_auto_pwm_minctl.dev_attr.attr,
> -	&sensor_dev_attr_pwm2_auto_pwm_minctl.dev_attr.attr,
> -	&sensor_dev_attr_pwm3_auto_pwm_minctl.dev_attr.attr,
>  
> -	&sensor_dev_attr_temp1_auto_temp_off.dev_attr.attr,
> -	&sensor_dev_attr_temp2_auto_temp_off.dev_attr.attr,
> -	&sensor_dev_attr_temp3_auto_temp_off.dev_attr.attr,
>  	&sensor_dev_attr_temp1_auto_temp_min.dev_attr.attr,
>  	&sensor_dev_attr_temp2_auto_temp_min.dev_attr.attr,
>  	&sensor_dev_attr_temp3_auto_temp_min.dev_attr.attr,
> @@ -1111,6 +1108,26 @@ static const struct attribute_group lm85_group = {
>  	.attrs = lm85_attributes,
>  };
>  
> +static struct attribute *lm85_attributes_minctl[] = {
> +	&sensor_dev_attr_pwm1_auto_pwm_minctl.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_pwm_minctl.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_pwm_minctl.dev_attr.attr,
> +};
> +
> +static const struct attribute_group lm85_group_minctl = {
> +	.attrs = lm85_attributes_minctl,
> +};
> +
> +static struct attribute *lm85_attributes_temp_off[] = {
> +	&sensor_dev_attr_temp1_auto_temp_off.dev_attr.attr,
> +	&sensor_dev_attr_temp2_auto_temp_off.dev_attr.attr,
> +	&sensor_dev_attr_temp3_auto_temp_off.dev_attr.attr,
> +};
> +
> +static const struct attribute_group lm85_group_temp_off = {
> +	.attrs = lm85_attributes_temp_off,
> +};
> +
>  static struct attribute *lm85_attributes_in4[] = {
>  	&sensor_dev_attr_in4_input.dev_attr.attr,
>  	&sensor_dev_attr_in4_min.dev_attr.attr,
> @@ -1258,16 +1275,9 @@ static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
>  		case LM85_VERSTEP_EMC6D103_A1:
>  			type_name = "emc6d103";
>  			break;
> -		/*
> -		 * Registers apparently missing in EMC6D103S/EMC6D103:A2
> -		 * compared to EMC6D103:A0, EMC6D103:A1, and EMC6D102
> -		 * (according to the data sheets), but used unconditionally
> -		 * in the driver: 62[5:7], 6D[0:7], and 6E[0:7].
> -		 * So skip EMC6D103S for now.
>  		case LM85_VERSTEP_EMC6D103S:
>  			type_name = "emc6d103s";
>  			break;
> -		 */
>  		}
>  	} else {
>  		dev_dbg(&adapter->dev,
> @@ -1302,6 +1312,7 @@ static int lm85_probe(struct i2c_client *client,
>  	case emc6d100:
>  	case emc6d102:
>  	case emc6d103:
> +	case emc6d103s:
>  		data->freq_map = adm1027_freq_map;
>  		break;
>  	default:
> @@ -1319,6 +1330,17 @@ static int lm85_probe(struct i2c_client *client,
>  	if (err)
>  		goto err_kfree;
>  
> +	/* minctl and temp_off exist on all chips except emc6d103s */
> +	if (data->type != emc6d103s) {
> +		err = sysfs_create_group(&client->dev.kobj, &lm85_group_minctl);
> +		if (err)
> +			goto err_kfree;
> +		err = sysfs_create_group(&client->dev.kobj,
> +					 &lm85_group_temp_off);
> +		if (err)
> +			goto err_kfree;
> +	}
> +
>  	/* The ADT7463/68 have an optional VRM 10 mode where pin 21 is used
>  	   as a sixth digital VID input rather than an analog input. */
>  	data->vid = lm85_read_value(client, LM85_REG_VID);
> @@ -1345,6 +1367,8 @@ static int lm85_probe(struct i2c_client *client,
>  	/* Error out and cleanup code */
>   err_remove_files:
>  	sysfs_remove_group(&client->dev.kobj, &lm85_group);
> +	sysfs_remove_group(&client->dev.kobj, &lm85_group_minctl);
> +	sysfs_remove_group(&client->dev.kobj, &lm85_group_temp_off);
>  	sysfs_remove_group(&client->dev.kobj, &lm85_group_in4);
>  	if (data->type = emc6d100)
>  		sysfs_remove_group(&client->dev.kobj, &lm85_group_in567);

For consistency, you should only call sysfs_remove_group for devices
which need it.

> @@ -1358,6 +1382,8 @@ static int lm85_remove(struct i2c_client *client)
>  	struct lm85_data *data = i2c_get_clientdata(client);
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&client->dev.kobj, &lm85_group);
> +	sysfs_remove_group(&client->dev.kobj, &lm85_group_minctl);
> +	sysfs_remove_group(&client->dev.kobj, &lm85_group_temp_off);
>  	sysfs_remove_group(&client->dev.kobj, &lm85_group_in4);
>  	if (data->type = emc6d100)
>  		sysfs_remove_group(&client->dev.kobj, &lm85_group_in567);

This is calling for a separate function to remove the files, doesn't it?

> @@ -1487,7 +1513,8 @@ static struct lm85_data *lm85_update_device(struct device *dev)
>  			/* More alarm bits */
>  			data->alarms |= lm85_read_value(client,
>  						EMC6D100_REG_ALARM3) << 16;
> -		} else if (data->type = emc6d102 || data->type = emc6d103) {
> +		} else if (data->type = emc6d102 || data->type = emc6d103 ||
> +			   data->type = emc6d103s) {
>  			/* Have to read LSB bits after the MSB ones because
>  			   the reading of the MSB bits has frozen the
>  			   LSBs (backward from the ADM1027).
> @@ -1573,17 +1600,19 @@ static struct lm85_data *lm85_update_device(struct device *dev)
>  			}
>  		}
>  
> -		i = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
> -		data->autofan[0].min_off = (i & 0x20) != 0;
> -		data->autofan[1].min_off = (i & 0x40) != 0;
> -		data->autofan[2].min_off = (i & 0x80) != 0;
> +		if (data->type != emc6d103s) {
> +			i = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
> +			data->autofan[0].min_off = (i & 0x20) != 0;
> +			data->autofan[1].min_off = (i & 0x40) != 0;
> +			data->autofan[2].min_off = (i & 0x80) != 0;
>  
> -		i = lm85_read_value(client, LM85_REG_AFAN_HYST1);
> -		data->zone[0].hyst = i >> 4;
> -		data->zone[1].hyst = i & 0x0f;
> +			i = lm85_read_value(client, LM85_REG_AFAN_HYST1);
> +			data->zone[0].hyst = i >> 4;
> +			data->zone[1].hyst = i & 0x0f;
>  
> -		i = lm85_read_value(client, LM85_REG_AFAN_HYST2);
> -		data->zone[2].hyst = i >> 4;
> +			i = lm85_read_value(client, LM85_REG_AFAN_HYST2);
> +			data->zone[2].hyst = i >> 4;
> +		}
>  
>  		data->last_config = jiffies;
>  	}  /* last_config */

Other than these minor things, the patch looks sane, and I've tested
that it causes no regression on my EMC6D102.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
