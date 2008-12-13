From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 13 Dec 2008 19:21:40 +0000
Subject: Re: [lm-sensors] PATCH: prepare f71882fg driver for adding f8000
Message-Id: <20081213202140.71afbc94@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <49419104.1040809@redhat.com>
In-Reply-To: <49419104.1040809@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Thu, 11 Dec 2008 23:15:32 +0100, Hans de Goede wrote:
> See attachment,

For future patches, please get the file path right so that I don't have
to edit the patch before I apply it.

> A review would be greatly appreciated.

Here you go:

> This patch is a preperation patch for adding f8000 support to the f71882fg

Typo: preparation.

> driver. If you look at the register addresses and esp, the bits used for
> the temperature channels, then you will notice that it appears that they
> start at 1 in a system meant to start at 0. As the f8000 actually uses the 0
> addresses and bits, this patch changes the f71882fg driver to take 4
> temperatures numbered 0-3 in to account, using 1-3 in this new scheme for
> the temperatures actually present in the f718x2fg
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> --- f71882fg.c.patched-upto-06-no-io-to-unreserved-ports	2008-12-11 17:06:41.000000000 +0100
> +++ f71882fg.c	2008-12-11 21:38:44.000000000 +0100
> @@ -63,9 +63,9 @@
>  #define F71882FG_REG_FAN_STATUS		0x92
>  #define F71882FG_REG_FAN_BEEP		0x93
>  
> -#define F71882FG_REG_TEMP(nr)		(0x72 + 2 * (nr))
> -#define F71882FG_REG_TEMP_OVT(nr)	(0x82 + 2 * (nr))
> -#define F71882FG_REG_TEMP_HIGH(nr)	(0x83 + 2 * (nr))
> +#define F71882FG_REG_TEMP(nr)		(0x70 + 2 * (nr))
> +#define F71882FG_REG_TEMP_OVT(nr)	(0x80 + 2 * (nr))
> +#define F71882FG_REG_TEMP_HIGH(nr)	(0x81 + 2 * (nr))
>  #define F71882FG_REG_TEMP_STATUS	0x62
>  #define F71882FG_REG_TEMP_BEEP		0x63
>  #define F71882FG_REG_TEMP_HYST1		0x6C
> @@ -138,11 +138,11 @@
>  	u16	fan_full_speed[4];
>  	u8	fan_status;
>  	u8	fan_beep;
> -	u8	temp[3];
> -	u8	temp_ovt[3];
> -	u8	temp_high[3];
> -	u8	temp_hyst[3];
> -	u8	temp_type[3];
> +	u8	temp[4];
> +	u8	temp_ovt[4];
> +	u8	temp_high[4];
> +	u8	temp_hyst[4];
> +	u8	temp_type[4];

I think this would deserve a comment about the fact that there really
only are 3 temperature channels and the array has room for 4 only for
coding convenience.

>  	u8	temp_status;
>  	u8	temp_beep;
>  	u8	temp_diode_open;
> @@ -264,48 +264,48 @@
>  	SENSOR_ATTR_2(in6_input, S_IRUGO, show_in, NULL, 0, 6),
>  	SENSOR_ATTR_2(in7_input, S_IRUGO, show_in, NULL, 0, 7),
>  	SENSOR_ATTR_2(in8_input, S_IRUGO, show_in, NULL, 0, 8),
> -	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0),
> +	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 1),
>  	SENSOR_ATTR_2(temp1_max, S_IRUGO|S_IWUSR, show_temp_max,
> -		store_temp_max, 0, 0),
> +		store_temp_max, 0, 1),
>  	SENSOR_ATTR_2(temp1_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
> -		store_temp_max_hyst, 0, 0),
> +		store_temp_max_hyst, 0, 1),
>  	SENSOR_ATTR_2(temp1_crit, S_IRUGO|S_IWUSR, show_temp_crit,
> -		store_temp_crit, 0, 0),
> +		store_temp_crit, 0, 1),
>  	SENSOR_ATTR_2(temp1_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
> -		0, 0),
> -	SENSOR_ATTR_2(temp1_type, S_IRUGO, show_temp_type, NULL, 0, 0),
> +		0, 1),
> +	SENSOR_ATTR_2(temp1_type, S_IRUGO, show_temp_type, NULL, 0, 1),
>  	SENSOR_ATTR_2(temp1_beep, S_IRUGO|S_IWUSR, show_temp_beep,
> -		store_temp_beep, 0, 0),
> -	SENSOR_ATTR_2(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 0),
> -	SENSOR_ATTR_2(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0, 0),
> -	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1),
> +		store_temp_beep, 0, 1),
> +	SENSOR_ATTR_2(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 1),
> +	SENSOR_ATTR_2(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0, 1),
> +	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 2),
>  	SENSOR_ATTR_2(temp2_max, S_IRUGO|S_IWUSR, show_temp_max,
> -		store_temp_max, 0, 1),
> +		store_temp_max, 0, 2),
>  	SENSOR_ATTR_2(temp2_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
> -		store_temp_max_hyst, 0, 1),
> +		store_temp_max_hyst, 0, 2),
>  	SENSOR_ATTR_2(temp2_crit, S_IRUGO|S_IWUSR, show_temp_crit,
> -		store_temp_crit, 0, 1),
> +		store_temp_crit, 0, 2),
>  	SENSOR_ATTR_2(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
> -		0, 1),
> -	SENSOR_ATTR_2(temp2_type, S_IRUGO, show_temp_type, NULL, 0, 1),
> +		0, 2),
> +	SENSOR_ATTR_2(temp2_type, S_IRUGO, show_temp_type, NULL, 0, 2),
>  	SENSOR_ATTR_2(temp2_beep, S_IRUGO|S_IWUSR, show_temp_beep,
> -		store_temp_beep, 0, 1),
> -	SENSOR_ATTR_2(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 1),
> -	SENSOR_ATTR_2(temp2_fault, S_IRUGO, show_temp_fault, NULL, 0, 1),
> -	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 2),
> +		store_temp_beep, 0, 2),
> +	SENSOR_ATTR_2(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 2),
> +	SENSOR_ATTR_2(temp2_fault, S_IRUGO, show_temp_fault, NULL, 0, 2),
> +	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 3),
>  	SENSOR_ATTR_2(temp3_max, S_IRUGO|S_IWUSR, show_temp_max,
> -		store_temp_max, 0, 2),
> +		store_temp_max, 0, 3),
>  	SENSOR_ATTR_2(temp3_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
> -		store_temp_max_hyst, 0, 2),
> +		store_temp_max_hyst, 0, 3),
>  	SENSOR_ATTR_2(temp3_crit, S_IRUGO|S_IWUSR, show_temp_crit,
> -		store_temp_crit, 0, 2),
> +		store_temp_crit, 0, 3),
>  	SENSOR_ATTR_2(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
> -		0, 2),
> -	SENSOR_ATTR_2(temp3_type, S_IRUGO, show_temp_type, NULL, 0, 2),
> +		0, 3),
> +	SENSOR_ATTR_2(temp3_type, S_IRUGO, show_temp_type, NULL, 0, 3),
>  	SENSOR_ATTR_2(temp3_beep, S_IRUGO|S_IWUSR, show_temp_beep,
> -		store_temp_beep, 0, 2),
> -	SENSOR_ATTR_2(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 2),
> -	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 2),
> +		store_temp_beep, 0, 3),
> +	SENSOR_ATTR_2(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 3),
> +	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 3),
>  };
>  
>  static struct sensor_device_attribute_2 f71882fg_in_temp_attr[] = {
> @@ -678,7 +678,7 @@
>  		}
>  
>  		/* Get High & boundary temps*/
> -		for (nr = 0; nr < 3; nr++) {
> +		for (nr = 1; nr < 4; nr++) {
>  			data->temp_ovt[nr] = f71882fg_read8(data,
>  						F71882FG_REG_TEMP_OVT(nr));
>  			data->temp_high[nr] = f71882fg_read8(data,
> @@ -686,25 +686,25 @@
>  		}
>  
>  		/* Have to hardcode hyst*/
> -		data->temp_hyst[0] = f71882fg_read8(data,
> +		data->temp_hyst[1] = f71882fg_read8(data,
>  						F71882FG_REG_TEMP_HYST1) >> 4;
>  		/* Hyst temps 2 & 3 stored in same register */
>  		reg = f71882fg_read8(data, F71882FG_REG_TEMP_HYST23);
> -		data->temp_hyst[1] = reg & 0x0F;
> -		data->temp_hyst[2] = reg >> 4;
> +		data->temp_hyst[2] = reg & 0x0F;
> +		data->temp_hyst[3] = reg >> 4;
>  
>  		/* Have to hardcode type, because temp1 is special */
>  		reg  = f71882fg_read8(data, F71882FG_REG_TEMP_TYPE);
>  		reg2 = f71882fg_read8(data, F71882FG_REG_PECI);
>  		if ((reg2 & 0x03) = 0x01)
> -			data->temp_type[0] = 6 /* PECI */;
> +			data->temp_type[1] = 6 /* PECI */;
>  		else if ((reg2 & 0x03) = 0x02)
> -			data->temp_type[0] = 5 /* AMDSI */;
> +			data->temp_type[1] = 5 /* AMDSI */;
>  		else
> -			data->temp_type[0] = (reg & 0x02) ? 2 : 4;
> +			data->temp_type[1] = (reg & 0x02) ? 2 : 4;
>  
> -		data->temp_type[1] = (reg & 0x04) ? 2 : 4;
> -		data->temp_type[2] = (reg & 0x08) ? 2 : 4;
> +		data->temp_type[2] = (reg & 0x04) ? 2 : 4;
> +		data->temp_type[3] = (reg & 0x08) ? 2 : 4;
>  
>  		data->temp_beep = f71882fg_read8(data, F71882FG_REG_TEMP_BEEP);
>  
> @@ -763,7 +763,7 @@
>  						F71882FG_REG_TEMP_STATUS);
>  		data->temp_diode_open = f71882fg_read8(data,
>  						F71882FG_REG_TEMP_DIODE_OPEN);
> -		for (nr = 0; nr < 3; nr++)
> +		for (nr = 1; nr < 4; nr++)
>  			data->temp[nr] = f71882fg_read8(data,
>  						F71882FG_REG_TEMP(nr));
>  
> @@ -1032,19 +1032,19 @@
>  
>  	/* convert value to register contents */
>  	switch (nr) {
> -		case 0:
> -			val = val << 4;
> -			break;
>  		case 1:
> -			val = val | (data->temp_hyst[2] << 4);
> +			val = val << 4;
>  			break;
>  		case 2:
> -			val = data->temp_hyst[1] | (val << 4);
> +			val = val | (data->temp_hyst[3] << 4);
> +			break;
> +		case 3:
> +			val = data->temp_hyst[2] | (val << 4);
>  			break;
>  	}
>  
> -	f71882fg_write8(data, nr ? F71882FG_REG_TEMP_HYST23 :
> -		F71882FG_REG_TEMP_HYST1, val);
> +	f71882fg_write8(data, (nr = 1) ? F71882FG_REG_TEMP_HYST1 :

I'd make this (nr <= 1), in case you ever need to handle an hysteresis
for "temp0".

> +		F71882FG_REG_TEMP_HYST23, val);
>  
>  store_temp_max_hyst_exit:
>  	mutex_unlock(&data->update_lock);
> @@ -1103,7 +1103,7 @@
>  	struct f71882fg_data *data = f71882fg_update_device(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
>  
> -	if (data->temp_beep & (1 << (nr + 1)))
> +	if (data->temp_beep & (1 << nr))
>  		return sprintf(buf, "1\n");
>  	else
>  		return sprintf(buf, "0\n");
> @@ -1118,9 +1118,9 @@
>  
>  	mutex_lock(&data->update_lock);
>  	if (val)
> -		data->temp_beep |= 1 << (nr + 1);
> +		data->temp_beep |= 1 << nr;
>  	else
> -		data->temp_beep &= ~(1 << (nr + 1));
> +		data->temp_beep &= ~(1 << nr);
>  
>  	f71882fg_write8(data, F71882FG_REG_TEMP_BEEP, data->temp_beep);
>  	mutex_unlock(&data->update_lock);
> @@ -1134,7 +1134,7 @@
>  	struct f71882fg_data *data = f71882fg_update_device(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
>  
> -	if (data->temp_status & (1 << (nr + 1)))
> +	if (data->temp_status & (1 << nr))
>  		return sprintf(buf, "1\n");
>  	else
>  		return sprintf(buf, "0\n");
> @@ -1146,7 +1146,7 @@
>  	struct f71882fg_data *data = f71882fg_update_device(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
>  
> -	if (data->temp_diode_open & (1 << (nr + 1)))
> +	if (data->temp_diode_open & (1 << nr))
>  		return sprintf(buf, "1\n");
>  	else
>  		return sprintf(buf, "0\n");

All the rest looks OK to me. And I think I see where you are going with
this, and I like it :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
