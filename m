From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 11 Oct 2011 15:47:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Use i2c_smbus_{read,
Message-Id: <4E946521.4050104@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 10/11/11 16:35, Jean Delvare wrote:
> Make use of the new i2c_smbus_{read,write}_word_swapped functions.
> This makes the driver code more compact and readable. It also ensures
> proper error handling.
Looks good.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> Cc: Dirk Eibach <eibach@gdsys.de>
> Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
> Cc: Guillaume Ligneul <guillaume.ligneul@gmail.com>
> ---
> See http://marc.info/?l=linux-i2c&m1823766914651&w=2
> 
> Note that I removed the register access functions where they would have
> become one-liners. Individual driver maintainers are free to disagree
> with this change and can ask for it to be reverted if they prefer.
> 
>  drivers/hwmon/ad7414.c   |    7 ++----
>  drivers/hwmon/ad7418.c   |   27 +++++++----------------
>  drivers/hwmon/ads1015.c  |   21 +++---------------
>  drivers/hwmon/ads7828.c  |   12 ++--------
>  drivers/hwmon/asb100.c   |   10 ++++----
>  drivers/hwmon/ds1621.c   |   24 ++-------------------
>  drivers/hwmon/ds620.c    |   42 ++++++++-----------------------------
>  drivers/hwmon/gl518sm.c  |    4 +--
>  drivers/hwmon/gl520sm.c  |    4 +--
>  drivers/hwmon/jc42.c     |   52 +++++++++++++++++-----------------------------
>  drivers/hwmon/lm73.c     |    8 +++----
>  drivers/hwmon/lm75.c     |    9 ++-----
>  drivers/hwmon/lm77.c     |    4 +--
>  drivers/hwmon/lm92.c     |   26 +++++++++++------------
>  drivers/hwmon/max16065.c |    4 +--
>  drivers/hwmon/sht21.c    |   26 +++--------------------
>  drivers/hwmon/smm665.c   |   15 +++----------
>  drivers/hwmon/tmp102.c   |   44 +++++++++++++++-----------------------
>  drivers/hwmon/w83781d.c  |   10 ++++----
>  19 files changed, 115 insertions(+), 234 deletions(-)
> 
> --- linux-3.1-rc9.orig/drivers/hwmon/ad7414.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/ad7414.c	2011-10-11 17:01:20.000000000 +0200
> @@ -58,10 +58,9 @@ static inline int ad7414_temp_from_reg(s
>  
>  static inline int ad7414_read(struct i2c_client *client, u8 reg)
>  {
> -	if (reg = AD7414_REG_TEMP) {
> -		int value = i2c_smbus_read_word_data(client, reg);
> -		return (value < 0) ? value : swab16(value);
> -	} else
> +	if (reg = AD7414_REG_TEMP)
> +		return i2c_smbus_read_word_swapped(client, reg);
> +	else
>  		return i2c_smbus_read_byte_data(client, reg);
>  }
>  
> --- linux-3.1-rc9.orig/drivers/hwmon/ad7418.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/ad7418.c	2011-10-11 17:16:31.000000000 +0200
> @@ -76,20 +76,6 @@ static struct i2c_driver ad7418_driver >  	.id_table	= ad7418_id,
>  };
>  
> -/* All registers are word-sized, except for the configuration registers.
> - * AD7418 uses a high-byte first convention. Do NOT use those functions to
> - * access the configuration registers CONF and CONF2, as they are byte-sized.
> - */
> -static inline int ad7418_read(struct i2c_client *client, u8 reg)
> -{
> -	return swab16(i2c_smbus_read_word_data(client, reg));
> -}
> -
> -static inline int ad7418_write(struct i2c_client *client, u8 reg, u16 value)
> -{
> -	return i2c_smbus_write_word_data(client, reg, swab16(value));
> -}
> -
>  static void ad7418_init_client(struct i2c_client *client)
>  {
>  	struct ad7418_data *data = i2c_get_clientdata(client);
> @@ -128,7 +114,9 @@ static struct ad7418_data *ad7418_update
>  		udelay(30);
>  
>  		for (i = 0; i < 3; i++) {
> -			data->temp[i] = ad7418_read(client, AD7418_REG_TEMP[i]);
> +			data->temp[i] > +				i2c_smbus_read_word_swapped(client,
> +						AD7418_REG_TEMP[i]);
>  		}
>  
>  		for (i = 0, ch = 4; i < data->adc_max; i++, ch--) {
> @@ -138,11 +126,12 @@ static struct ad7418_data *ad7418_update
>  
>  			udelay(15);
>  			data->in[data->adc_max - 1 - i] > -				ad7418_read(client, AD7418_REG_ADC);
> +				i2c_smbus_read_word_swapped(client,
> +						AD7418_REG_ADC);
>  		}
>  
>  		/* restore old configuration value */
> -		ad7418_write(client, AD7418_REG_CONF, cfg);
> +		i2c_smbus_write_word_swapped(client, AD7418_REG_CONF, cfg);
>  
>  		data->last_updated = jiffies;
>  		data->valid = 1;
> @@ -182,7 +171,9 @@ static ssize_t set_temp(struct device *d
>  
>  	mutex_lock(&data->lock);
>  	data->temp[attr->index] = LM75_TEMP_TO_REG(temp);
> -	ad7418_write(client, AD7418_REG_TEMP[attr->index], data->temp[attr->index]);
> +	i2c_smbus_write_word_swapped(client,
> +				     AD7418_REG_TEMP[attr->index],
> +				     data->temp[attr->index]);
>  	mutex_unlock(&data->lock);
>  	return count;
>  }
> --- linux-3.1-rc9.orig/drivers/hwmon/ads1015.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/ads1015.c	2011-10-11 17:01:20.000000000 +0200
> @@ -59,19 +59,6 @@ struct ads1015_data {
>  	struct ads1015_channel_data channel_data[ADS1015_CHANNELS];
>  };
>  
> -static s32 ads1015_read_reg(struct i2c_client *client, unsigned int reg)
> -{
> -	s32 data = i2c_smbus_read_word_data(client, reg);
> -
> -	return (data < 0) ? data : swab16(data);
> -}
> -
> -static s32 ads1015_write_reg(struct i2c_client *client, unsigned int reg,
> -			     u16 val)
> -{
> -	return i2c_smbus_write_word_data(client, reg, swab16(val));
> -}
> -
>  static int ads1015_read_value(struct i2c_client *client, unsigned int channel,
>  			      int *value)
>  {
> @@ -87,7 +74,7 @@ static int ads1015_read_value(struct i2c
>  	mutex_lock(&data->update_lock);
>  
>  	/* get channel parameters */
> -	res = ads1015_read_reg(client, ADS1015_CONFIG);
> +	res = i2c_smbus_read_word_swapped(client, ADS1015_CONFIG);
>  	if (res < 0)
>  		goto err_unlock;
>  	config = res;
> @@ -101,13 +88,13 @@ static int ads1015_read_value(struct i2c
>  	config |= (pga & 0x0007) << 9;
>  	config |= (data_rate & 0x0007) << 5;
>  
> -	res = ads1015_write_reg(client, ADS1015_CONFIG, config);
> +	res = i2c_smbus_write_word_swapped(client, ADS1015_CONFIG, config);
>  	if (res < 0)
>  		goto err_unlock;
>  
>  	/* wait until conversion finished */
>  	msleep(conversion_time_ms);
> -	res = ads1015_read_reg(client, ADS1015_CONFIG);
> +	res = i2c_smbus_read_word_swapped(client, ADS1015_CONFIG);
>  	if (res < 0)
>  		goto err_unlock;
>  	config = res;
> @@ -117,7 +104,7 @@ static int ads1015_read_value(struct i2c
>  		goto err_unlock;
>  	}
>  
> -	res = ads1015_read_reg(client, ADS1015_CONVERSION);
> +	res = i2c_smbus_read_word_swapped(client, ADS1015_CONVERSION);
>  	if (res < 0)
>  		goto err_unlock;
>  	conversion = res;
> --- linux-3.1-rc9.orig/drivers/hwmon/ads7828.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/ads7828.c	2011-10-11 17:16:56.000000000 +0200
> @@ -74,13 +74,6 @@ static int ads7828_detect(struct i2c_cli
>  static int ads7828_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id);
>  
> -/* The ADS7828 returns the 12-bit sample in two bytes,
> -	these are read as a word then byte-swapped */
> -static u16 ads7828_read_value(struct i2c_client *client, u8 reg)
> -{
> -	return swab16(i2c_smbus_read_word_data(client, reg));
> -}
> -
>  static inline u8 channel_cmd_byte(int ch)
>  {
>  	/* cmd byte C2,C1,C0 - see datasheet */
> @@ -104,7 +97,8 @@ static struct ads7828_data *ads7828_upda
>  
>  		for (ch = 0; ch < ADS7828_NCH; ch++) {
>  			u8 cmd = channel_cmd_byte(ch);
> -			data->adc_input[ch] = ads7828_read_value(client, cmd);
> +			data->adc_input[ch] > +				i2c_smbus_read_word_swapped(client, cmd);
>  		}
>  		data->last_updated = jiffies;
>  		data->valid = 1;
> @@ -203,7 +197,7 @@ static int ads7828_detect(struct i2c_cli
>  	for (ch = 0; ch < ADS7828_NCH; ch++) {
>  		u16 in_data;
>  		u8 cmd = channel_cmd_byte(ch);
> -		in_data = ads7828_read_value(client, cmd);
> +		in_data = i2c_smbus_read_word_swapped(client, cmd);
>  		if (in_data & 0xF000) {
>  			pr_debug("%s : Doesn't look like an ads7828 device\n",
>  				 __func__);
> --- linux-3.1-rc9.orig/drivers/hwmon/asb100.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/asb100.c	2011-10-11 17:01:20.000000000 +0200
> @@ -829,17 +829,17 @@ static int asb100_read_value(struct i2c_
>  		/* convert from ISA to LM75 I2C addresses */
>  		switch (reg & 0xff) {
>  		case 0x50: /* TEMP */
> -			res = swab16(i2c_smbus_read_word_data(cl, 0));
> +			res = i2c_smbus_read_word_swapped(cl, 0);
>  			break;
>  		case 0x52: /* CONFIG */
>  			res = i2c_smbus_read_byte_data(cl, 1);
>  			break;
>  		case 0x53: /* HYST */
> -			res = swab16(i2c_smbus_read_word_data(cl, 2));
> +			res = i2c_smbus_read_word_swapped(cl, 2);
>  			break;
>  		case 0x55: /* MAX */
>  		default:
> -			res = swab16(i2c_smbus_read_word_data(cl, 3));
> +			res = i2c_smbus_read_word_swapped(cl, 3);
>  			break;
>  		}
>  	}
> @@ -877,10 +877,10 @@ static void asb100_write_value(struct i2
>  			i2c_smbus_write_byte_data(cl, 1, value & 0xff);
>  			break;
>  		case 0x53: /* HYST */
> -			i2c_smbus_write_word_data(cl, 2, swab16(value));
> +			i2c_smbus_write_word_swapped(cl, 2, value);
>  			break;
>  		case 0x55: /* MAX */
> -			i2c_smbus_write_word_data(cl, 3, swab16(value));
> +			i2c_smbus_write_word_swapped(cl, 3, value);
>  			break;
>  		}
>  	}
> --- linux-3.1-rc9.orig/drivers/hwmon/ds1621.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/ds1621.c	2011-10-11 17:22:07.000000000 +0200
> @@ -80,24 +80,6 @@ struct ds1621_data {
>  	u8 conf;			/* Register encoding, combined */
>  };
>  
> -/* Temperature registers are word-sized.
> -   DS1621 uses a high-byte first convention, which is exactly opposite to
> -   the SMBus standard. */
> -static int ds1621_read_temp(struct i2c_client *client, u8 reg)
> -{
> -	int ret;
> -
> -	ret = i2c_smbus_read_word_data(client, reg);
> -	if (ret < 0)
> -		return ret;
> -	return swab16(ret);
> -}
> -
> -static int ds1621_write_temp(struct i2c_client *client, u8 reg, u16 value)
> -{
> -	return i2c_smbus_write_word_data(client, reg, swab16(value));
> -}
> -
>  static void ds1621_init_client(struct i2c_client *client)
>  {
>  	u8 conf, new_conf;
> @@ -136,7 +118,7 @@ static struct ds1621_data *ds1621_update
>  		data->conf = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
>  
>  		for (i = 0; i < ARRAY_SIZE(data->temp); i++)
> -			data->temp[i] = ds1621_read_temp(client,
> +			data->temp[i] = i2c_smbus_read_word_swapped(client,
>  							 DS1621_REG_TEMP[i]);
>  
>  		/* reset alarms if necessary */
> @@ -177,8 +159,8 @@ static ssize_t set_temp(struct device *d
>  
>  	mutex_lock(&data->update_lock);
>  	data->temp[attr->index] = val;
> -	ds1621_write_temp(client, DS1621_REG_TEMP[attr->index],
> -			  data->temp[attr->index]);
> +	i2c_smbus_write_word_swapped(client, DS1621_REG_TEMP[attr->index],
> +				     data->temp[attr->index]);
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> --- linux-3.1-rc9.orig/drivers/hwmon/ds620.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/ds620.c	2011-10-11 17:23:21.000000000 +0200
> @@ -75,33 +75,13 @@ struct ds620_data {
>  	s16 temp[3];		/* Register values, word */
>  };
>  
> -/*
> - *  Temperature registers are word-sized.
> - *  DS620 uses a high-byte first convention, which is exactly opposite to
> - *  the SMBus standard.
> - */
> -static int ds620_read_temp(struct i2c_client *client, u8 reg)
> -{
> -	int ret;
> -
> -	ret = i2c_smbus_read_word_data(client, reg);
> -	if (ret < 0)
> -		return ret;
> -	return swab16(ret);
> -}
> -
> -static int ds620_write_temp(struct i2c_client *client, u8 reg, u16 value)
> -{
> -	return i2c_smbus_write_word_data(client, reg, swab16(value));
> -}
> -
>  static void ds620_init_client(struct i2c_client *client)
>  {
>  	struct ds620_platform_data *ds620_info = client->dev.platform_data;
>  	u16 conf, new_conf;
>  
>  	new_conf = conf > -	    swab16(i2c_smbus_read_word_data(client, DS620_REG_CONF));
> +	    i2c_smbus_read_word_swapped(client, DS620_REG_CONF);
>  
>  	/* switch to continuous conversion mode */
>  	new_conf &= ~DS620_REG_CONFIG_1SHOT;
> @@ -118,8 +98,7 @@ static void ds620_init_client(struct i2c
>  	new_conf |= DS620_REG_CONFIG_R1 | DS620_REG_CONFIG_R0;
>  
>  	if (conf != new_conf)
> -		i2c_smbus_write_word_data(client, DS620_REG_CONF,
> -					  swab16(new_conf));
> +		i2c_smbus_write_word_swapped(client, DS620_REG_CONF, new_conf);
>  
>  	/* start conversion */
>  	i2c_smbus_write_byte(client, DS620_COM_START);
> @@ -141,8 +120,8 @@ static struct ds620_data *ds620_update_c
>  		dev_dbg(&client->dev, "Starting ds620 update\n");
>  
>  		for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
> -			res = ds620_read_temp(client,
> -					      DS620_REG_TEMP[i]);
> +			res = i2c_smbus_read_word_swapped(client,
> +							  DS620_REG_TEMP[i]);
>  			if (res < 0) {
>  				ret = ERR_PTR(res);
>  				goto abort;
> @@ -191,8 +170,8 @@ static ssize_t set_temp(struct device *d
>  
>  	mutex_lock(&data->update_lock);
>  	data->temp[attr->index] = val;
> -	ds620_write_temp(client, DS620_REG_TEMP[attr->index],
> -			 data->temp[attr->index]);
> +	i2c_smbus_write_word_swapped(client, DS620_REG_TEMP[attr->index],
> +				     data->temp[attr->index]);
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> @@ -210,16 +189,15 @@ static ssize_t show_alarm(struct device
>  		return PTR_ERR(data);
>  
>  	/* reset alarms if necessary */
> -	res = i2c_smbus_read_word_data(client, DS620_REG_CONF);
> +	res = i2c_smbus_read_word_swapped(client, DS620_REG_CONF);
>  	if (res < 0)
>  		return res;
>  
> -	conf = swab16(res);
> -	new_conf = conf;
> +	new_conf = conf = res;
>  	new_conf &= ~attr->index;
>  	if (conf != new_conf) {
> -		res = i2c_smbus_write_word_data(client, DS620_REG_CONF,
> -						swab16(new_conf));
> +		res = i2c_smbus_write_word_swapped(client, DS620_REG_CONF,
> +						   new_conf);
>  		if (res < 0)
>  			return res;
>  	}
> --- linux-3.1-rc9.orig/drivers/hwmon/gl518sm.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/gl518sm.c	2011-10-11 17:01:20.000000000 +0200
> @@ -591,7 +591,7 @@ static int gl518_remove(struct i2c_clien
>  static int gl518_read_value(struct i2c_client *client, u8 reg)
>  {
>  	if ((reg >= 0x07) && (reg <= 0x0c))
> -		return swab16(i2c_smbus_read_word_data(client, reg));
> +		return i2c_smbus_read_word_swapped(client, reg);
>  	else
>  		return i2c_smbus_read_byte_data(client, reg);
>  }
> @@ -599,7 +599,7 @@ static int gl518_read_value(struct i2c_c
>  static int gl518_write_value(struct i2c_client *client, u8 reg, u16 value)
>  {
>  	if ((reg >= 0x07) && (reg <= 0x0c))
> -		return i2c_smbus_write_word_data(client, reg, swab16(value));
> +		return i2c_smbus_write_word_swapped(client, reg, value);
>  	else
>  		return i2c_smbus_write_byte_data(client, reg, value);
>  }
> --- linux-3.1-rc9.orig/drivers/hwmon/gl520sm.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/gl520sm.c	2011-10-11 17:01:20.000000000 +0200
> @@ -821,7 +821,7 @@ static int gl520_remove(struct i2c_clien
>  static int gl520_read_value(struct i2c_client *client, u8 reg)
>  {
>  	if ((reg >= 0x07) && (reg <= 0x0c))
> -		return swab16(i2c_smbus_read_word_data(client, reg));
> +		return i2c_smbus_read_word_swapped(client, reg);
>  	else
>  		return i2c_smbus_read_byte_data(client, reg);
>  }
> @@ -829,7 +829,7 @@ static int gl520_read_value(struct i2c_c
>  static int gl520_write_value(struct i2c_client *client, u8 reg, u16 value)
>  {
>  	if ((reg >= 0x07) && (reg <= 0x0c))
> -		return i2c_smbus_write_word_data(client, reg, swab16(value));
> +		return i2c_smbus_write_word_swapped(client, reg, value);
>  	else
>  		return i2c_smbus_write_byte_data(client, reg, value);
>  }
> --- linux-3.1-rc9.orig/drivers/hwmon/jc42.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/jc42.c	2011-10-11 17:24:49.000000000 +0200
> @@ -154,8 +154,6 @@ static int jc42_probe(struct i2c_client
>  		      const struct i2c_device_id *id);
>  static int jc42_detect(struct i2c_client *client, struct i2c_board_info *info);
>  static int jc42_remove(struct i2c_client *client);
> -static int jc42_read_value(struct i2c_client *client, u8 reg);
> -static int jc42_write_value(struct i2c_client *client, u8 reg, u16 value);
>  
>  static struct jc42_data *jc42_update_device(struct device *dev);
>  
> @@ -187,7 +185,7 @@ static int jc42_suspend(struct device *d
>  	struct jc42_data *data = i2c_get_clientdata(client);
>  
>  	data->config |= JC42_CFG_SHUTDOWN;
> -	jc42_write_value(client, JC42_REG_CONFIG, data->config);
> +	i2c_smbus_write_word_swapped(client, JC42_REG_CONFIG, data->config);
>  	return 0;
>  }
>  
> @@ -197,7 +195,7 @@ static int jc42_resume(struct device *de
>  	struct jc42_data *data = i2c_get_clientdata(client);
>  
>  	data->config &= ~JC42_CFG_SHUTDOWN;
> -	jc42_write_value(client, JC42_REG_CONFIG, data->config);
> +	i2c_smbus_write_word_swapped(client, JC42_REG_CONFIG, data->config);
>  	return 0;
>  }
>  
> @@ -315,7 +313,7 @@ static ssize_t set_##value(struct device
>  		return -EINVAL;						\
>  	mutex_lock(&data->update_lock);					\
>  	data->value = jc42_temp_to_reg(val, data->extended);		\
> -	err = jc42_write_value(client, reg, data->value);		\
> +	err = i2c_smbus_write_word_swapped(client, reg, data->value);	\
>  	if (err < 0)							\
>  		ret = err;						\
>  	mutex_unlock(&data->update_lock);				\
> @@ -357,7 +355,8 @@ static ssize_t set_temp_crit_hyst(struct
>  	data->config = (data->config
>  			& ~(JC42_CFG_HYST_MASK << JC42_CFG_HYST_SHIFT))
>  	  | (hyst << JC42_CFG_HYST_SHIFT);
> -	err = jc42_write_value(client, JC42_REG_CONFIG, data->config);
> +	err = i2c_smbus_write_word_swapped(client, JC42_REG_CONFIG,
> +					   data->config);
>  	if (err < 0)
>  		ret = err;
>  	mutex_unlock(&data->update_lock);
> @@ -452,10 +451,10 @@ static int jc42_detect(struct i2c_client
>  				     I2C_FUNC_SMBUS_WORD_DATA))
>  		return -ENODEV;
>  
> -	cap = jc42_read_value(new_client, JC42_REG_CAP);
> -	config = jc42_read_value(new_client, JC42_REG_CONFIG);
> -	manid = jc42_read_value(new_client, JC42_REG_MANID);
> -	devid = jc42_read_value(new_client, JC42_REG_DEVICEID);
> +	cap = i2c_smbus_read_word_swapped(new_client, JC42_REG_CAP);
> +	config = i2c_smbus_read_word_swapped(new_client, JC42_REG_CONFIG);
> +	manid = i2c_smbus_read_word_swapped(new_client, JC42_REG_MANID);
> +	devid = i2c_smbus_read_word_swapped(new_client, JC42_REG_DEVICEID);
>  
>  	if (cap < 0 || config < 0 || manid < 0 || devid < 0)
>  		return -ENODEV;
> @@ -489,14 +488,14 @@ static int jc42_probe(struct i2c_client
>  	i2c_set_clientdata(new_client, data);
>  	mutex_init(&data->update_lock);
>  
> -	cap = jc42_read_value(new_client, JC42_REG_CAP);
> +	cap = i2c_smbus_read_word_swapped(new_client, JC42_REG_CAP);
>  	if (cap < 0) {
>  		err = -EINVAL;
>  		goto exit_free;
>  	}
>  	data->extended = !!(cap & JC42_CAP_RANGE);
>  
> -	config = jc42_read_value(new_client, JC42_REG_CONFIG);
> +	config = i2c_smbus_read_word_swapped(new_client, JC42_REG_CONFIG);
>  	if (config < 0) {
>  		err = -EINVAL;
>  		goto exit_free;
> @@ -504,7 +503,8 @@ static int jc42_probe(struct i2c_client
>  	data->orig_config = config;
>  	if (config & JC42_CFG_SHUTDOWN) {
>  		config &= ~JC42_CFG_SHUTDOWN;
> -		jc42_write_value(new_client, JC42_REG_CONFIG, config);
> +		i2c_smbus_write_word_swapped(new_client, JC42_REG_CONFIG,
> +					     config);
>  	}
>  	data->config = config;
>  
> @@ -535,25 +535,12 @@ static int jc42_remove(struct i2c_client
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&client->dev.kobj, &jc42_group);
>  	if (data->config != data->orig_config)
> -		jc42_write_value(client, JC42_REG_CONFIG, data->orig_config);
> +		i2c_smbus_write_word_swapped(client, JC42_REG_CONFIG,
> +					     data->orig_config);
>  	kfree(data);
>  	return 0;
>  }
>  
> -/* All registers are word-sized. */
> -static int jc42_read_value(struct i2c_client *client, u8 reg)
> -{
> -	int ret = i2c_smbus_read_word_data(client, reg);
> -	if (ret < 0)
> -		return ret;
> -	return swab16(ret);
> -}
> -
> -static int jc42_write_value(struct i2c_client *client, u8 reg, u16 value)
> -{
> -	return i2c_smbus_write_word_data(client, reg, swab16(value));
> -}
> -
>  static struct jc42_data *jc42_update_device(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> @@ -564,28 +551,29 @@ static struct jc42_data *jc42_update_dev
>  	mutex_lock(&data->update_lock);
>  
>  	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
> -		val = jc42_read_value(client, JC42_REG_TEMP);
> +		val = i2c_smbus_read_word_swapped(client, JC42_REG_TEMP);
>  		if (val < 0) {
>  			ret = ERR_PTR(val);
>  			goto abort;
>  		}
>  		data->temp_input = val;
>  
> -		val = jc42_read_value(client, JC42_REG_TEMP_CRITICAL);
> +		val = i2c_smbus_read_word_swapped(client,
> +						  JC42_REG_TEMP_CRITICAL);
>  		if (val < 0) {
>  			ret = ERR_PTR(val);
>  			goto abort;
>  		}
>  		data->temp_crit = val;
>  
> -		val = jc42_read_value(client, JC42_REG_TEMP_LOWER);
> +		val = i2c_smbus_read_word_swapped(client, JC42_REG_TEMP_LOWER);
>  		if (val < 0) {
>  			ret = ERR_PTR(val);
>  			goto abort;
>  		}
>  		data->temp_min = val;
>  
> -		val = jc42_read_value(client, JC42_REG_TEMP_UPPER);
> +		val = i2c_smbus_read_word_swapped(client, JC42_REG_TEMP_UPPER);
>  		if (val < 0) {
>  			ret = ERR_PTR(val);
>  			goto abort;
> --- linux-3.1-rc9.orig/drivers/hwmon/lm73.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/lm73.c	2011-10-11 17:25:42.000000000 +0200
> @@ -34,7 +34,7 @@ static const unsigned short normal_i2c[]
>  #define LM73_REG_CTRL		0x04
>  #define LM73_REG_ID		0x07
>  
> -#define LM73_ID			0x9001 /* or 0x190 after a swab16() */
> +#define LM73_ID			0x9001	/* 0x0190, byte-swapped */
>  #define DRVNAME			"lm73"
>  #define LM73_TEMP_MIN		(-40)
>  #define LM73_TEMP_MAX		150
> @@ -57,7 +57,7 @@ static ssize_t set_temp(struct device *d
>  	/* Write value */
>  	value = (short) SENSORS_LIMIT(temp/250, (LM73_TEMP_MIN*4),
>  		(LM73_TEMP_MAX*4)) << 5;
> -	i2c_smbus_write_word_data(client, attr->index, swab16(value));
> +	i2c_smbus_write_word_swapped(client, attr->index, value);
>  	return count;
>  }
>  
> @@ -68,8 +68,8 @@ static ssize_t show_temp(struct device *
>  	struct i2c_client *client = to_i2c_client(dev);
>  	/* use integer division instead of equivalent right shift to
>  	   guarantee arithmetic shift and preserve the sign */
> -	int temp = ((s16) (swab16(i2c_smbus_read_word_data(client,
> -		attr->index)))*250) / 32;
> +	int temp = ((s16) (i2c_smbus_read_word_swapped(client,
> +		    attr->index))*250) / 32;
>  	return sprintf(buf, "%d\n", temp);
>  }
>  
> --- linux-3.1-rc9.orig/drivers/hwmon/lm75.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/lm75.c	2011-10-11 17:01:20.000000000 +0200
> @@ -371,13 +371,10 @@ static struct i2c_driver lm75_driver = {
>   */
>  static int lm75_read_value(struct i2c_client *client, u8 reg)
>  {
> -	int value;
> -
>  	if (reg = LM75_REG_CONF)
>  		return i2c_smbus_read_byte_data(client, reg);
> -
> -	value = i2c_smbus_read_word_data(client, reg);
> -	return (value < 0) ? value : swab16(value);
> +	else
> +		return i2c_smbus_read_word_swapped(client, reg);
>  }
>  
>  static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value)
> @@ -385,7 +382,7 @@ static int lm75_write_value(struct i2c_c
>  	if (reg = LM75_REG_CONF)
>  		return i2c_smbus_write_byte_data(client, reg, value);
>  	else
> -		return i2c_smbus_write_word_data(client, reg, swab16(value));
> +		return i2c_smbus_write_word_swapped(client, reg, value);
>  }
>  
>  static struct lm75_data *lm75_update_device(struct device *dev)
> --- linux-3.1-rc9.orig/drivers/hwmon/lm77.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/lm77.c	2011-10-11 17:01:20.000000000 +0200
> @@ -365,7 +365,7 @@ static u16 lm77_read_value(struct i2c_cl
>  	if (reg = LM77_REG_CONF)
>  		return i2c_smbus_read_byte_data(client, reg);
>  	else
> -		return swab16(i2c_smbus_read_word_data(client, reg));
> +		return i2c_smbus_read_word_swapped(client, reg);
>  }
>  
>  static int lm77_write_value(struct i2c_client *client, u8 reg, u16 value)
> @@ -373,7 +373,7 @@ static int lm77_write_value(struct i2c_c
>  	if (reg = LM77_REG_CONF)
>  		return i2c_smbus_write_byte_data(client, reg, value);
>  	else
> -		return i2c_smbus_write_word_data(client, reg, swab16(value));
> +		return i2c_smbus_write_word_swapped(client, reg, value);
>  }
>  
>  static void lm77_init_client(struct i2c_client *client)
> --- linux-3.1-rc9.orig/drivers/hwmon/lm92.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/lm92.c	2011-10-11 17:26:23.000000000 +0200
> @@ -117,16 +117,16 @@ static struct lm92_data *lm92_update_dev
>  	if (time_after(jiffies, data->last_updated + HZ)
>  	 || !data->valid) {
>  		dev_dbg(&client->dev, "Updating lm92 data\n");
> -		data->temp1_input = swab16(i2c_smbus_read_word_data(client,
> -				    LM92_REG_TEMP));
> -		data->temp1_hyst = swab16(i2c_smbus_read_word_data(client,
> -				    LM92_REG_TEMP_HYST));
> -		data->temp1_crit = swab16(i2c_smbus_read_word_data(client,
> -				    LM92_REG_TEMP_CRIT));
> -		data->temp1_min = swab16(i2c_smbus_read_word_data(client,
> -				    LM92_REG_TEMP_LOW));
> -		data->temp1_max = swab16(i2c_smbus_read_word_data(client,
> -				    LM92_REG_TEMP_HIGH));
> +		data->temp1_input = i2c_smbus_read_word_swapped(client,
> +				    LM92_REG_TEMP);
> +		data->temp1_hyst = i2c_smbus_read_word_swapped(client,
> +				    LM92_REG_TEMP_HYST);
> +		data->temp1_crit = i2c_smbus_read_word_swapped(client,
> +				    LM92_REG_TEMP_CRIT);
> +		data->temp1_min = i2c_smbus_read_word_swapped(client,
> +				    LM92_REG_TEMP_LOW);
> +		data->temp1_max = i2c_smbus_read_word_swapped(client,
> +				    LM92_REG_TEMP_HIGH);
>  
>  		data->last_updated = jiffies;
>  		data->valid = 1;
> @@ -158,7 +158,7 @@ static ssize_t set_##value(struct device
>   \
>  	mutex_lock(&data->update_lock); \
>  	data->value = TEMP_TO_REG(val); \
> -	i2c_smbus_write_word_data(client, reg, swab16(data->value)); \
> +	i2c_smbus_write_word_swapped(client, reg, data->value); \
>  	mutex_unlock(&data->update_lock); \
>  	return count; \
>  }
> @@ -194,8 +194,8 @@ static ssize_t set_temp1_crit_hyst(struc
>  
>  	mutex_lock(&data->update_lock);
>  	data->temp1_hyst = TEMP_FROM_REG(data->temp1_crit) - val;
> -	i2c_smbus_write_word_data(client, LM92_REG_TEMP_HYST,
> -				  swab16(TEMP_TO_REG(data->temp1_hyst)));
> +	i2c_smbus_write_word_swapped(client, LM92_REG_TEMP_HYST,
> +				     TEMP_TO_REG(data->temp1_hyst));
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> --- linux-3.1-rc9.orig/drivers/hwmon/sht21.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/sht21.c	2011-10-11 17:26:53.000000000 +0200
> @@ -83,25 +83,6 @@ static inline int sht21_rh_ticks_to_per_
>  }
>  
>  /**
> - * sht21_read_word_data() - read word from register
> - * @client: I2C client device
> - * @reg: I2C command byte
> - *
> - * Returns value, negative errno on error.
> - */
> -static inline int sht21_read_word_data(struct i2c_client *client, u8 reg)
> -{
> -	int ret = i2c_smbus_read_word_data(client, reg);
> -	if (ret < 0)
> -		return ret;
> -	/*
> -	 * SMBus specifies low byte first, but the SHT21 returns MSB
> -	 * first, so we have to swab16 the values
> -	 */
> -	return swab16(ret);
> -}
> -
> -/**
>   * sht21_update_measurements() - get updated measurements from device
>   * @client: I2C client device
>   *
> @@ -119,12 +100,13 @@ static int sht21_update_measurements(str
>  	 * maximum two measurements per second at 12bit accuracy shall be made.
>  	 */
>  	if (time_after(jiffies, sht21->last_update + HZ / 2) || !sht21->valid) {
> -		ret = sht21_read_word_data(client, SHT21_TRIG_T_MEASUREMENT_HM);
> +		ret = i2c_smbus_read_word_swapped(client,
> +						  SHT21_TRIG_T_MEASUREMENT_HM);
>  		if (ret < 0)
>  			goto out;
>  		sht21->temperature = sht21_temp_ticks_to_millicelsius(ret);
> -		ret = sht21_read_word_data(client,
> -					SHT21_TRIG_RH_MEASUREMENT_HM);
> +		ret = i2c_smbus_read_word_swapped(client,
> +						  SHT21_TRIG_RH_MEASUREMENT_HM);
>  		if (ret < 0)
>  			goto out;
>  		sht21->humidity = sht21_rh_ticks_to_per_cent_mille(ret);
> --- linux-3.1-rc9.orig/drivers/hwmon/smm665.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/smm665.c	2011-10-11 17:01:20.000000000 +0200
> @@ -214,33 +214,26 @@ static int smm665_read_adc(struct smm665
>  	 *
>  	 * Neither i2c_smbus_read_byte() nor
>  	 * i2c_smbus_read_block_data() worked here,
> -	 * so use i2c_smbus_read_word_data() instead.
> +	 * so use i2c_smbus_read_word_swapped() instead.
>  	 * We could also try to use i2c_master_recv(),
>  	 * but that is not always supported.
>  	 */
> -	rv = i2c_smbus_read_word_data(client, 0);
> +	rv = i2c_smbus_read_word_swapped(client, 0);
>  	if (rv < 0) {
>  		dev_dbg(&client->dev, "Failed to read ADC value: error %d", rv);
>  		return -1;
>  	}
>  	/*
>  	 * Validate/verify readback adc channel (in bit 11..14).
> -	 * High byte is in lower 8 bit of rv, so only shift by 3.
>  	 */
> -	radc = (rv >> 3) & 0x0f;
> +	radc = (rv >> 11) & 0x0f;
>  	if (radc != adc) {
>  		dev_dbg(&client->dev, "Unexpected RADC: Expected %d got %d",
>  			adc, radc);
>  		return -EIO;
>  	}
> -	/*
> -	 * Chip replies with H/L, while SMBus expects L/H.
> -	 * Thus, byte order is reversed, and we have to swap
> -	 * the result.
> -	 */
> -	rv = swab16(rv) & SMM665_ADC_MASK;
>  
> -	return rv;
> +	return rv & SMM665_ADC_MASK;
>  }
>  
>  static struct smm665_data *smm665_update_device(struct device *dev)
> --- linux-3.1-rc9.orig/drivers/hwmon/tmp102.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/tmp102.c	2011-10-11 17:28:44.000000000 +0200
> @@ -55,19 +55,6 @@ struct tmp102 {
>  	int temp[3];
>  };
>  
> -/* SMBus specifies low byte first, but the TMP102 returns high byte first,
> - * so we have to swab16 the values */
> -static inline int tmp102_read_reg(struct i2c_client *client, u8 reg)
> -{
> -	int result = i2c_smbus_read_word_data(client, reg);
> -	return result < 0 ? result : swab16(result);
> -}
> -
> -static inline int tmp102_write_reg(struct i2c_client *client, u8 reg, u16 val)
> -{
> -	return i2c_smbus_write_word_data(client, reg, swab16(val));
> -}
> -
>  /* convert left adjusted 13-bit TMP102 register value to milliCelsius */
>  static inline int tmp102_reg_to_mC(s16 val)
>  {
> @@ -94,7 +81,8 @@ static struct tmp102 *tmp102_update_devi
>  	if (time_after(jiffies, tmp102->last_update + HZ / 3)) {
>  		int i;
>  		for (i = 0; i < ARRAY_SIZE(tmp102->temp); ++i) {
> -			int status = tmp102_read_reg(client, tmp102_reg[i]);
> +			int status = i2c_smbus_read_word_swapped(client,
> +								 tmp102_reg[i]);
>  			if (status > -1)
>  				tmp102->temp[i] = tmp102_reg_to_mC(status);
>  		}
> @@ -130,8 +118,8 @@ static ssize_t tmp102_set_temp(struct de
>  
>  	mutex_lock(&tmp102->lock);
>  	tmp102->temp[sda->index] = val;
> -	status = tmp102_write_reg(client, tmp102_reg[sda->index],
> -				  tmp102_mC_to_reg(val));
> +	status = i2c_smbus_write_word_swapped(client, tmp102_reg[sda->index],
> +					      tmp102_mC_to_reg(val));
>  	mutex_unlock(&tmp102->lock);
>  	return status ? : count;
>  }
> @@ -178,18 +166,19 @@ static int __devinit tmp102_probe(struct
>  	}
>  	i2c_set_clientdata(client, tmp102);
>  
> -	status = tmp102_read_reg(client, TMP102_CONF_REG);
> +	status = i2c_smbus_read_word_swapped(client, TMP102_CONF_REG);
>  	if (status < 0) {
>  		dev_err(&client->dev, "error reading config register\n");
>  		goto fail_free;
>  	}
>  	tmp102->config_orig = status;
> -	status = tmp102_write_reg(client, TMP102_CONF_REG, TMP102_CONFIG);
> +	status = i2c_smbus_write_word_swapped(client, TMP102_CONF_REG,
> +					      TMP102_CONFIG);
>  	if (status < 0) {
>  		dev_err(&client->dev, "error writing config register\n");
>  		goto fail_restore_config;
>  	}
> -	status = tmp102_read_reg(client, TMP102_CONF_REG);
> +	status = i2c_smbus_read_word_swapped(client, TMP102_CONF_REG);
>  	if (status < 0) {
>  		dev_err(&client->dev, "error reading config register\n");
>  		goto fail_restore_config;
> @@ -222,7 +211,8 @@ static int __devinit tmp102_probe(struct
>  fail_remove_sysfs:
>  	sysfs_remove_group(&client->dev.kobj, &tmp102_attr_group);
>  fail_restore_config:
> -	tmp102_write_reg(client, TMP102_CONF_REG, tmp102->config_orig);
> +	i2c_smbus_write_word_swapped(client, TMP102_CONF_REG,
> +				     tmp102->config_orig);
>  fail_free:
>  	kfree(tmp102);
>  
> @@ -240,10 +230,10 @@ static int __devexit tmp102_remove(struc
>  	if (tmp102->config_orig & TMP102_CONF_SD) {
>  		int config;
>  
> -		config = tmp102_read_reg(client, TMP102_CONF_REG);
> +		config = i2c_smbus_read_word_swapped(client, TMP102_CONF_REG);
>  		if (config >= 0)
> -			tmp102_write_reg(client, TMP102_CONF_REG,
> -					 config | TMP102_CONF_SD);
> +			i2c_smbus_write_word_swapped(client, TMP102_CONF_REG,
> +						     config | TMP102_CONF_SD);
>  	}
>  
>  	kfree(tmp102);
> @@ -257,12 +247,12 @@ static int tmp102_suspend(struct device
>  	struct i2c_client *client = to_i2c_client(dev);
>  	int config;
>  
> -	config = tmp102_read_reg(client, TMP102_CONF_REG);
> +	config = i2c_smbus_read_word_swapped(client, TMP102_CONF_REG);
>  	if (config < 0)
>  		return config;
>  
>  	config |= TMP102_CONF_SD;
> -	return tmp102_write_reg(client, TMP102_CONF_REG, config);
> +	return i2c_smbus_write_word_swapped(client, TMP102_CONF_REG, config);
>  }
>  
>  static int tmp102_resume(struct device *dev)
> @@ -270,12 +260,12 @@ static int tmp102_resume(struct device *
>  	struct i2c_client *client = to_i2c_client(dev);
>  	int config;
>  
> -	config = tmp102_read_reg(client, TMP102_CONF_REG);
> +	config = i2c_smbus_read_word_swapped(client, TMP102_CONF_REG);
>  	if (config < 0)
>  		return config;
>  
>  	config &= ~TMP102_CONF_SD;
> -	return tmp102_write_reg(client, TMP102_CONF_REG, config);
> +	return i2c_smbus_write_word_swapped(client, TMP102_CONF_REG, config);
>  }
>  
>  static const struct dev_pm_ops tmp102_dev_pm_ops = {
> --- linux-3.1-rc9.orig/drivers/hwmon/w83781d.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/w83781d.c	2011-10-11 17:01:20.000000000 +0200
> @@ -1245,17 +1245,17 @@ w83781d_read_value_i2c(struct w83781d_da
>  		/* convert from ISA to LM75 I2C addresses */
>  		switch (reg & 0xff) {
>  		case 0x50:	/* TEMP */
> -			res = swab16(i2c_smbus_read_word_data(cl, 0));
> +			res = i2c_smbus_read_word_swapped(cl, 0);
>  			break;
>  		case 0x52:	/* CONFIG */
>  			res = i2c_smbus_read_byte_data(cl, 1);
>  			break;
>  		case 0x53:	/* HYST */
> -			res = swab16(i2c_smbus_read_word_data(cl, 2));
> +			res = i2c_smbus_read_word_swapped(cl, 2);
>  			break;
>  		case 0x55:	/* OVER */
>  		default:
> -			res = swab16(i2c_smbus_read_word_data(cl, 3));
> +			res = i2c_smbus_read_word_swapped(cl, 3);
>  			break;
>  		}
>  	}
> @@ -1289,10 +1289,10 @@ w83781d_write_value_i2c(struct w83781d_d
>  			i2c_smbus_write_byte_data(cl, 1, value & 0xff);
>  			break;
>  		case 0x53:	/* HYST */
> -			i2c_smbus_write_word_data(cl, 2, swab16(value));
> +			i2c_smbus_write_word_swapped(cl, 2, value);
>  			break;
>  		case 0x55:	/* OVER */
> -			i2c_smbus_write_word_data(cl, 3, swab16(value));
> +			i2c_smbus_write_word_swapped(cl, 3, value);
>  			break;
>  		}
>  	}
> --- linux-3.1-rc9.orig/drivers/hwmon/max16065.c	2011-10-11 16:39:33.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/max16065.c	2011-10-11 17:01:20.000000000 +0200
> @@ -137,10 +137,10 @@ static int max16065_read_adc(struct i2c_
>  {
>  	int rv;
>  
> -	rv = i2c_smbus_read_word_data(client, reg);
> +	rv = i2c_smbus_read_word_swapped(client, reg);
>  	if (unlikely(rv < 0))
>  		return rv;
> -	return ((rv & 0xff) << 2) | ((rv >> 14) & 0x03);
> +	return rv >> 6;
>  }
>  
>  static struct max16065_data *max16065_update_device(struct device *dev)
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
