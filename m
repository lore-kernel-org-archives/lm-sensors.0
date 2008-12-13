From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 13 Dec 2008 22:18:22 +0000
Subject: Re: [lm-sensors] PATCH: fix various sysfs callback function issues
Message-Id: <20081213231822.3ce68c38@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4941926A.600@redhat.com>
In-Reply-To: <4941926A.600@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Thu, 11 Dec 2008 23:21:30 +0100, Hans de Goede wrote:
> Again see attachment.

Review:

> While working on adding f8000 support I noticed that various of the
> store sysfs functions (and a few of the show also) had issues.
> 
> This patch fixes the following issues in these functions:
> * store: storing the result of strto[u]l in an int, resulting in a possible
>   overflow before boundary checking
> * store: use of f71882fg_update_device(), we don't want to read the whole
>   device in store functions, just the registers we need
> * store: use of cached register values instead of reading the needed regs
>   in the store function, including cases where f71882fg_update_device() was
>   not used, this could cause real isues
> * show: shown value is a calculation of 2 or more cached register reads,
>   without locking the data struct.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> --- linux/drivers/hwmon/f71882fg.c.07-applied	2008-12-11 21:38:44.000000000 +0100
> +++ linux/drivers/hwmon/f71882fg.c	2008-12-11 22:54:21.000000000 +0100
> @@ -832,6 +832,7 @@ static ssize_t store_fan_full_speed(stru
>  	val = fan_to_reg(val);
>  
>  	mutex_lock(&data->update_lock);
> +	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
>  	if (data->pwm_enable & (1 << (2 * nr)))
>  		/* PWM mode */
>  		count = -EINVAL;
> @@ -862,9 +863,10 @@ static ssize_t store_fan_beep(struct dev
>  {
>  	struct f71882fg_data *data = dev_get_drvdata(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
> -	int val = simple_strtoul(buf, NULL, 10);
> +	unsigned long val = simple_strtoul(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> +	data->fan_beep = f71882fg_read8(data, F71882FG_REG_FAN_BEEP);
>  	if (val)
>  		data->fan_beep |= 1 << nr;
>  	else
> @@ -909,10 +911,8 @@ static ssize_t store_in_max(struct devic
>  	*devattr, const char *buf, size_t count)
>  {
>  	struct f71882fg_data *data = dev_get_drvdata(dev);
> -	int val = simple_strtoul(buf, NULL, 10) / 8;
> -
> -	if (val > 255)
> -		val = 255;
> +	long val = simple_strtol(buf, NULL, 10) / 8;
> +	val = SENSORS_LIMIT(val, 0, 255);
>  
>  	mutex_lock(&data->update_lock);
>  	f71882fg_write8(data, F71882FG_REG_IN1_HIGH, val);
> @@ -939,9 +939,10 @@ static ssize_t store_in_beep(struct devi
>  {
>  	struct f71882fg_data *data = dev_get_drvdata(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
> -	int val = simple_strtoul(buf, NULL, 10);
> +	unsigned long val = simple_strtoul(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> +	data->in_beep = f71882fg_read8(data, F71882FG_REG_IN_BEEP);
>  	if (val)
>  		data->in_beep |= 1 << nr;
>  	else
> @@ -988,10 +989,8 @@ static ssize_t store_temp_max(struct dev
>  {
>  	struct f71882fg_data *data = dev_get_drvdata(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
> -	int val = simple_strtoul(buf, NULL, 10) / 1000;
> -
> -	if (val > 255)
> -		val = 255;
> +	long val = simple_strtol(buf, NULL, 10) / 1000;
> +	val = SENSORS_LIMIT(val, 0, 255);
>  
>  	mutex_lock(&data->update_lock);
>  	f71882fg_write8(data, F71882FG_REG_TEMP_HIGH(nr), val);
> @@ -1006,9 +1005,13 @@ static ssize_t show_temp_max_hyst(struct
>  {
>  	struct f71882fg_data *data = f71882fg_update_device(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
> +	int temp_max_hyst;
> +
> +	mutex_lock(&data->update_lock);
> +	temp_max_hyst = (data->temp_high[nr] - data->temp_hyst[nr]) * 1000;
> +	mutex_unlock(&data->update_lock);
>  
> -	return sprintf(buf, "%d\n",
> -		(data->temp_high[nr] - data->temp_hyst[nr]) * 1000);
> +	return sprintf(buf, "%d\n", temp_max_hyst);
>  }
>  
>  static ssize_t store_temp_max_hyst(struct device *dev, struct device_attribute
> @@ -1016,37 +1019,37 @@ static ssize_t store_temp_max_hyst(struc
>  {
>  	struct f71882fg_data *data = dev_get_drvdata(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
> -	int val = simple_strtoul(buf, NULL, 10) / 1000;
> +	long val = simple_strtol(buf, NULL, 10) / 1000;
>  	ssize_t ret = count;
> +	u8 reg;
>  
>  	mutex_lock(&data->update_lock);
>  
>  	/* convert abs to relative and check */
> -	val = data->temp_high[nr] - val;
> -	if (val < 0 || val > 15) {
> -		ret = -EINVAL;
> -		goto store_temp_max_hyst_exit;
> -	}
> -
> +	reg = f71882fg_read8(data, F71882FG_REG_TEMP_HIGH(nr));
> +	val = SENSORS_LIMIT(val, reg - 15, reg);
> +	val = reg - val;
>  	data->temp_hyst[nr] = val;
> +	data->temp_high[nr] = reg;

This would gain in efficiency and, I suspect, clarity by using
data->temp_high[nr] directly instead of aliasing it to reg.
>  
>  	/* convert value to register contents */
>  	switch (nr) {
>  		case 1:
> -			val = val << 4;
> +			reg = val << 4;
>  			break;

This is overwriting 4 bits of F71882FG_REG_TEMP_HYST1 with 0s. I guess
these are reserved/unused bits, but I still consider this bad practice.

>  		case 2:
> -			val = val | (data->temp_hyst[3] << 4);
> +			reg = f71882fg_read8(data, F71882FG_REG_TEMP_HYST23);
> +			reg = (reg & 0xf0) | val;
>  			break;
>  		case 3:
> -			val = data->temp_hyst[2] | (val << 4);
> +			reg = f71882fg_read8(data, F71882FG_REG_TEMP_HYST23);
> +			reg = (reg & 0x0f) | (val << 4);
>  			break;
>  	}
>  
>  	f71882fg_write8(data, (nr = 1) ? F71882FG_REG_TEMP_HYST1 :
> -		F71882FG_REG_TEMP_HYST23, val);
> +		F71882FG_REG_TEMP_HYST23, reg);
>  
> -store_temp_max_hyst_exit:
>  	mutex_unlock(&data->update_lock);
>  	return ret;
>  }
> @@ -1065,10 +1068,8 @@ static ssize_t store_temp_crit(struct de
>  {
>  	struct f71882fg_data *data = dev_get_drvdata(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
> -	int val = simple_strtoul(buf, NULL, 10) / 1000;
> -
> -	if (val > 255)
> -		val = 255;
> +	long val = simple_strtol(buf, NULL, 10) / 1000;
> +	val = SENSORS_LIMIT(val, 0, 255);
>  
>  	mutex_lock(&data->update_lock);
>  	f71882fg_write8(data, F71882FG_REG_TEMP_OVT(nr), val);
> @@ -1083,9 +1084,13 @@ static ssize_t show_temp_crit_hyst(struc
>  {
>  	struct f71882fg_data *data = f71882fg_update_device(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
> +	int temp_crit_hyst;
> +
> +	mutex_lock(&data->update_lock);
> +	temp_crit_hyst = (data->temp_ovt[nr] - data->temp_hyst[nr]) * 1000;
> +	mutex_unlock(&data->update_lock);
>  
> -	return sprintf(buf, "%d\n",
> -		(data->temp_ovt[nr] - data->temp_hyst[nr]) * 1000);
> +	return sprintf(buf, "%d\n", temp_crit_hyst);
>  }
>  
>  static ssize_t show_temp_type(struct device *dev, struct device_attribute
> @@ -1114,9 +1119,10 @@ static ssize_t store_temp_beep(struct de
>  {
>  	struct f71882fg_data *data = dev_get_drvdata(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
> -	int val = simple_strtoul(buf, NULL, 10);
> +	unsigned long val = simple_strtoul(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> +	data->temp_beep = f71882fg_read8(data, F71882FG_REG_TEMP_BEEP);
>  	if (val)
>  		data->temp_beep |= 1 << nr;
>  	else
> @@ -1157,16 +1163,16 @@ static ssize_t show_pwm(struct device *d
>  {
>  	struct f71882fg_data *data = f71882fg_update_device(dev);
>  	int val, nr = to_sensor_dev_attr_2(devattr)->index;
> +	mutex_lock(&data->update_lock);
>  	if (data->pwm_enable & (1 << (2 * nr)))
>  		/* PWM mode */
>  		val = data->pwm[nr];
>  	else {
>  		/* RPM mode */
> -		mutex_lock(&data->update_lock);
>  		val = 255 * fan_from_reg(data->fan_target[nr])
>  			/ fan_from_reg(data->fan_full_speed[nr]);
> -		mutex_unlock(&data->update_lock);
>  	}
> +	mutex_unlock(&data->update_lock);
>  	return sprintf(buf, "%d\n", val);
>  }
>  
> @@ -1174,23 +1180,26 @@ static ssize_t store_pwm(struct device *
>  			 struct device_attribute *devattr, const char *buf,
>  			 size_t count)
>  {
> -	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
> -	struct f71882fg_data *data = f71882fg_update_device(dev);
> +	struct f71882fg_data *data = dev_get_drvdata(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
>  	long val = simple_strtol(buf, NULL, 10);
>  	val = SENSORS_LIMIT(val, 0, 255);
>  
>  	mutex_lock(&data->update_lock);
> +	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
>  	if (data->pwm_enable & (1 << (2 * nr))) {
>  		/* PWM mode */
>  		f71882fg_write8(data, F71882FG_REG_PWM(nr), val);
>  		data->pwm[nr] = val;
>  	} else {
>  		/* RPM mode */
> -		int target = val * fan_from_reg(data->fan_full_speed[nr]) / 255;
> -		f71882fg_write16(data, F71882FG_REG_FAN_TARGET(nr),
> -				 fan_to_reg(target));
> -		data->fan_target[nr] = fan_to_reg(target);
> +		int target, full_speed;
> +		full_speed = f71882fg_read16(data,
> +					     F71882FG_REG_FAN_FULL_SPEED(nr));
> +		target = fan_to_reg(val * fan_from_reg(full_speed) / 255);
> +		f71882fg_write16(data, F71882FG_REG_FAN_TARGET(nr), target);
> +		data->fan_target[nr] = target;
> +		data->fan_full_speed[nr] = full_speed;
>  	}
>  	mutex_unlock(&data->update_lock);
>  
> @@ -1222,6 +1231,7 @@ static ssize_t store_pwm_enable(struct d
>  		return -EINVAL;
>  
>  	mutex_lock(&data->update_lock);
> +	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
>  	switch (val) {
>  	case 1:
>  		data->pwm_enable |= 2 << (2 * nr);
> @@ -1255,6 +1265,7 @@ static ssize_t show_pwm_auto_point_pwm(s
>  	int pwm = to_sensor_dev_attr_2(devattr)->index;
>  	int point = to_sensor_dev_attr_2(devattr)->nr;
>  
> +	mutex_lock(&data->update_lock);
>  	if (data->pwm_enable & (1 << (2 * pwm))) {
>  		/* PWM mode */
>  		result = data->pwm_auto_point_pwm[pwm][point];
> @@ -1262,6 +1273,7 @@ static ssize_t show_pwm_auto_point_pwm(s
>  		/* RPM mode */
>  		result = 32 * 255 / (32 + data->pwm_auto_point_pwm[pwm][point]);
>  	}
> +	mutex_unlock(&data->update_lock);
>  
>  	return sprintf(buf, "%d\n", result);
>  }
> @@ -1270,14 +1282,14 @@ static ssize_t store_pwm_auto_point_pwm(
>  					struct device_attribute *devattr,
>  					const char *buf, size_t count)
>  {
> -	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
> -	struct f71882fg_data *data = f71882fg_update_device(dev);
> +	struct f71882fg_data *data = dev_get_drvdata(dev);
>  	int pwm = to_sensor_dev_attr_2(devattr)->index;
>  	int point = to_sensor_dev_attr_2(devattr)->nr;
> -	int val = simple_strtoul(buf, NULL, 10);
> +	long val = simple_strtoul(buf, NULL, 10);

simple_strtol

>  	val = SENSORS_LIMIT(val, 0, 255);
>  
>  	mutex_lock(&data->update_lock);
> +	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
>  	if (data->pwm_enable & (1 << (2 * pwm))) {
>  		/* PWM mode */
>  	} else {
> @@ -1328,37 +1340,29 @@ static ssize_t store_pwm_auto_point_temp
>  					      struct device_attribute *devattr,
>  					      const char *buf, size_t count)
>  {
> -	struct f71882fg_data *data = f71882fg_update_device(dev);
> +	struct f71882fg_data *data = dev_get_drvdata(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
>  	int point = to_sensor_dev_attr_2(devattr)->nr;
>  	long val = simple_strtol(buf, NULL, 10) / 1000;
> +	int hyst_reg_nr;
> +	u8 hyst_reg;
>  
>  	mutex_lock(&data->update_lock);
> +	data->pwm_auto_point_temp[nr][point] > +		f71882fg_read8(data, F71882FG_REG_POINT_TEMP(nr, point)); 

Trailing whitespace.

>  	val = SENSORS_LIMIT(val, data->pwm_auto_point_temp[nr][point] - 15,
>  				data->pwm_auto_point_temp[nr][point]);
>  	val = data->pwm_auto_point_temp[nr][point] - val;
>  
> -	switch (nr) {
> -	case 0:
> -		val = (data->pwm_auto_point_hyst[0] & 0xf0) | val;
> -		break;
> -	case 1:
> -		val = (data->pwm_auto_point_hyst[0] & 0x0f) | (val << 4);
> -		break;
> -	case 2:
> -		val = (data->pwm_auto_point_hyst[1] & 0xf0) | val;
> -		break;
> -	case 3:
> -		val = (data->pwm_auto_point_hyst[1] & 0x0f) | (val << 4);
> -		break;
> -	}
> -	if (nr = 0 || nr = 1) {
> -		f71882fg_write8(data, F71882FG_REG_FAN_HYST0, val);
> -		data->pwm_auto_point_hyst[0] = val;
> -	} else {
> -		f71882fg_write8(data, F71882FG_REG_FAN_HYST1, val);
> -		data->pwm_auto_point_hyst[1] = val;
> -	}
> +	hyst_reg_nr = (nr >= 2) ? 1 : 0;
> +	hyst_reg = f71882fg_read8(data, F71882FG_REG_FAN_HYST0 + hyst_reg_nr);
> +	if (nr & 1)
> +		hyst_reg = (hyst_reg & 0x0f) | (val << 4);
> +	else
> +		hyst_reg = (hyst_reg & 0xf0) | val;
> +
> +	f71882fg_write8(data, F71882FG_REG_FAN_HYST0 + hyst_reg_nr, hyst_reg);
> +	data->pwm_auto_point_hyst[hyst_reg_nr] = hyst_reg;

Hmm, that's a nice cleanup, but it doesn't really belong to this patch
as far as I can see. Also, if you are going to use
F71882FG_REG_FAN_HYST0 that way, you should make it a macro. So I'd
suggest moving all this to a separate patch.

>  	mutex_unlock(&data->update_lock);
>  
>  	return count;
> @@ -1380,11 +1384,13 @@ static ssize_t store_pwm_interpolate(str
>  				     struct device_attribute *devattr,
>  				     const char *buf, size_t count)
>  {
> -	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
> -	struct f71882fg_data *data = f71882fg_update_device(dev);
> +	struct f71882fg_data *data = dev_get_drvdata(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
> -	int val = simple_strtoul(buf, NULL, 10);
> +	unsigned long val = simple_strtoul(buf, NULL, 10);
> +
>  	mutex_lock(&data->update_lock);
> +	data->pwm_auto_point_mapping[nr] > +		f71882fg_read8(data, F71882FG_REG_POINT_MAPPING(nr));
>  	if (val)
>  		val = data->pwm_auto_point_mapping[nr] | (1 << 4);
>  	else
> @@ -1413,8 +1419,7 @@ static ssize_t store_pwm_auto_point_chan
>  					    struct device_attribute *devattr,
>  					    const char *buf, size_t count)
>  {
> -	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
> -	struct f71882fg_data *data = f71882fg_update_device(dev);
> +	struct f71882fg_data *data = dev_get_drvdata(dev);
>  	int nr = to_sensor_dev_attr_2(devattr)->index;
>  	long val = simple_strtol(buf, NULL, 10);
>  	switch (val) {
> @@ -1431,6 +1436,8 @@ static ssize_t store_pwm_auto_point_chan
>  		return -EINVAL;
>  	}
>  	mutex_lock(&data->update_lock);
> +	data->pwm_auto_point_mapping[nr] > +		f71882fg_read8(data, F71882FG_REG_POINT_MAPPING(nr));
>  	val = (data->pwm_auto_point_mapping[nr] & 0xfc) | val;
>  	f71882fg_write8(data, F71882FG_REG_POINT_MAPPING(nr), val);
>  	data->pwm_auto_point_mapping[nr] = val;
> @@ -1456,8 +1463,7 @@ static ssize_t store_pwm_auto_point_temp
>  					 struct device_attribute *devattr,
>  					 const char *buf, size_t count)
>  {
> -	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
> -	struct f71882fg_data *data = f71882fg_update_device(dev);
> +	struct f71882fg_data *data = dev_get_drvdata(dev);
>  	int pwm = to_sensor_dev_attr_2(devattr)->index;
>  	int point = to_sensor_dev_attr_2(devattr)->nr;
>  	long val = simple_strtol(buf, NULL, 10) / 1000;

The rest looks good and is actually very welcome.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
