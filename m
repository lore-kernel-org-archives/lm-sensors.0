From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 07 Nov 2010 16:30:00 +0000
Subject: Re: [lm-sensors] [PATCH 3/7] hwmon: (w83795) List all usable
Message-Id: <20101107163000.GC18730@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101107164445.00fdb093@endymion.delvare>
In-Reply-To: <20101107164445.00fdb093@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 07, 2010 at 10:44:45AM -0500, Jean Delvare wrote:
> Temperature sources are not correlated directly with temperature
> channels. A look-up table is required to find out which temperature
> sources can be used depending on which temperature channels (both
> analog and digital) are enabled.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

> ---
>  w83795.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 3 deletions(-)
> 
> --- a/drivers/hwmon/w83795.c	2010-11-05 21:44:32.000000000 +0100
> +++ b/drivers/hwmon/w83795.c	2010-11-05 22:01:58.000000000 +0100
> @@ -178,6 +178,14 @@ static const u8 IN_LSB_SHIFT_IDX[][2] >  
>  #define W83795_REG_TSS(index)		(0x209 + (index))
>  
> +#define TSS_MAP_RESERVED		0xff
> +static const u8 tss_map[4][6] = {
> +	{ 0,  1,  2,  3,  4,  5},
> +	{ 6,  7,  8,  9,  0,  1},
> +	{10, 11, 12, 13,  2,  3},
> +	{ 4,  5,  4,  5, TSS_MAP_RESERVED, TSS_MAP_RESERVED},
> +};
> +
>  #define PWM_OUTPUT			0
>  #define PWM_FREQ			1
>  #define PWM_START			2
> @@ -930,6 +938,27 @@ show_pwm_mode(struct device *dev, struct
>  	return sprintf(buf, "%u\n", mode);
>  }
>  
> +/*
> + * Check whether a given temperature source can ever be useful.
> + * Returns the number of selectable temperature channels which are
> + * enabled.
> + */
> +static int w83795_tss_useful(const struct w83795_data *data, int tsrc)
> +{
> +	int useful = 0, i;
> +
> +	for (i = 0; i < 4; i++) {
> +		if (tss_map[i][tsrc] = TSS_MAP_RESERVED)
> +			continue;
> +		if (tss_map[i][tsrc] < 6)	/* Analog */
> +			useful += (data->has_temp >> tss_map[i][tsrc]) & 1;
> +		else				/* Digital */
> +			useful += (data->has_dts >> (tss_map[i][tsrc] - 6)) & 1;
> +	}
> +
> +	return useful;
> +}
> +
>  static ssize_t
>  show_temp_src(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> @@ -1608,8 +1637,6 @@ store_sf_setup(struct device *dev, struc
>  	SENSOR_ATTR_2(temp##index##_beep, S_IWUSR | S_IRUGO,		\
>  		show_alarm_beep, store_beep, BEEP_ENABLE,		\
>  		index + (index > 4 ? 11 : 17)),				\
> -	SENSOR_ATTR_2(temp##index##_source_sel, S_IWUSR | S_IRUGO,	\
> -		show_temp_src, store_temp_src, NOT_USED, index - 1),	\
>  	SENSOR_ATTR_2(temp##index##_pwm_enable, S_IWUSR | S_IRUGO,	\
>  		show_temp_pwm_enable, store_temp_pwm_enable,		\
>  		TEMP_PWM_ENABLE, index - 1),				\
> @@ -1695,7 +1722,7 @@ static const struct sensor_device_attrib
>  	SENSOR_ATTR_FAN(14),
>  };
>  
> -static const struct sensor_device_attribute_2 w83795_temp[][29] = {
> +static const struct sensor_device_attribute_2 w83795_temp[][28] = {
>  	SENSOR_ATTR_TEMP(1),
>  	SENSOR_ATTR_TEMP(2),
>  	SENSOR_ATTR_TEMP(3),
> @@ -1726,6 +1753,21 @@ static const struct sensor_device_attrib
>  	SENSOR_ATTR_PWM(8),
>  };
>  
> +static const struct sensor_device_attribute_2 w83795_tss[6] = {
> +	SENSOR_ATTR_2(temp1_source_sel, S_IWUSR | S_IRUGO,
> +		      show_temp_src, store_temp_src, NOT_USED, 0),
> +	SENSOR_ATTR_2(temp2_source_sel, S_IWUSR | S_IRUGO,
> +		      show_temp_src, store_temp_src, NOT_USED, 1),
> +	SENSOR_ATTR_2(temp3_source_sel, S_IWUSR | S_IRUGO,
> +		      show_temp_src, store_temp_src, NOT_USED, 2),
> +	SENSOR_ATTR_2(temp4_source_sel, S_IWUSR | S_IRUGO,
> +		      show_temp_src, store_temp_src, NOT_USED, 3),
> +	SENSOR_ATTR_2(temp5_source_sel, S_IWUSR | S_IRUGO,
> +		      show_temp_src, store_temp_src, NOT_USED, 4),
> +	SENSOR_ATTR_2(temp6_source_sel, S_IWUSR | S_IRUGO,
> +		      show_temp_src, store_temp_src, NOT_USED, 5),
> +};
> +
>  static const struct sensor_device_attribute_2 sda_single_files[] = {
>  	SENSOR_ATTR_2(intrusion0_alarm, S_IWUSR | S_IRUGO, show_alarm_beep,
>  		      store_chassis_clear, ALARM_STATUS, 46),
> @@ -1890,6 +1932,15 @@ static int w83795_handle_files(struct de
>  		}
>  	}
>  
> +	for (i = 0; i < ARRAY_SIZE(w83795_tss); i++) {
> +		j = w83795_tss_useful(data, i);
> +		if (!j)
> +			continue;
> +		err = fn(dev, &w83795_tss[i].dev_attr);
> +		if (err)
> +			return err;
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(sda_single_files); i++) {
>  		err = fn(dev, &sda_single_files[i].dev_attr);
>  		if (err)
> 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
