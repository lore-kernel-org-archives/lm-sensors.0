From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 06 Aug 2008 08:08:54 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon: (w83791d) add support for
Message-Id: <48995C16.3070905@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200808060029.47083.m.hulsman@tudelft.nl>
In-Reply-To: <200808060029.47083.m.hulsman@tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marc Hulsman wrote:
> Last patch in the series. Adds support for automatic PWM control using smart 
> fan 1 thermal cruise mode. Fan speed cruise mode shares registers with 
> thermal cruise mode which makes implementing it a bit more complicated. As it 
> does not add much over manual PWM control I did not implement it (for now?). 
> 
> Marc
> PS: I will be away from my mail during the next two weeks.
> PS2: When is it possible to remove the 'EXPERIMENTAL' status of the driver? 
> 
> ---
> Adds support to set target temperature and tolerance for thermal cruise mode.
> 
> Signed-off-by: Marc Hulsman <m.hulsman@tudelft.nl>
> 

Looks good:
Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

(This ofcourse cannot be send upstream until patch 3/4 is fixed)

Regards,

Hans

> ---
>  Documentation/hwmon/w83791d |   19 ++++-
>  drivers/hwmon/w83791d.c     |  150 
> ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 164 insertions(+), 5 deletions(-)
> 
> ---
> Index: linux-2.6.27-rc1/drivers/hwmon/w83791d.c
> =================================> --- linux-2.6.27-rc1.orig/drivers/hwmon/w83791d.c
> +++ linux-2.6.27-rc1/drivers/hwmon/w83791d.c
> @@ -125,6 +125,17 @@ static const u8 W83791D_REG_PWM[NUMBER_O
>  	0xA1,			/* PWM 5 duty cycle register in DataSheet */
>  };
>  
> +static const u8 W83791D_REG_PWM_TARGET[3] = {
> +	0x85,			/* PWM 1 target temperature for temp 1 */
> +	0x86,			/* PWM 2 target temperature for temp 2*/
> +	0x96,			/* PWM 3 target temperature for temp 3*/
> +};
> +
> +static const u8 W83791D_REG_PWM_TOL[2] = {
> +	0x87,			/* PWM 1/2 temperature tolerance */
> +	0x97,			/* PWM 3 temperature tolerance */
> +};
> +
>  static const u8 W83791D_REG_FAN_CFG[2] = {
>  	0x84,			/* FAN 1/2 configuration */
>  	0x95,			/* FAN 3 configuration */
> @@ -234,6 +245,17 @@ static u8 fan_to_reg(long rpm, int div)
>  				 (val) < 0 ? ((val) - 250) / 500 * 128 : \
>  				 ((val) + 250) / 500 * 128)
>  
> +/* for thermal cruise target temp, 7-bits, LSB = 1 degree Celsius */
> +#define TARGET_TEMP_FROM_REG(val)	((val) * 1000)
> +#define TARGET_TEMP_TO_REG(val)		((val) < 0 ? 0 : \
> +					(val) >= 127000 ? 127 : \
> +					((val) + 500) / 1000)
> +
> +/* for thermal cruise temp tolerance, 4-bits, LSB = 1 degree Celsius */
> +#define TOL_TEMP_FROM_REG(val)		((val) * 1000)
> +#define TOL_TEMP_TO_REG(val)		((val) < 0 ? 0 : \
> +					(val) >= 15000 ? 15 : \
> +					((val) + 500) / 1000)
>  
>  #define BEEP_MASK_TO_REG(val)		((val) & 0xffffff)
>  #define BEEP_MASK_FROM_REG(val)		((val) & 0xffffff)
> @@ -290,6 +312,9 @@ struct w83791d_data {
>  	u8 pwm_enable[3];	/* pwm enable status for fan 1-3
>  					(fan 4-5 only support manual mode) */
>  
> +	u8 pwm_target[3];	/* pwm 1-3 target temperature  */
> +	u8 pwm_tolerance[3];	/* pwm 1-3 temperature tolerance */
> +
>  	/* Misc */
>  	u32 alarms;		/* realtime status register encoding,combined */
>  	u8 beep_enable;		/* Global beep enable */
> @@ -774,6 +799,110 @@ static struct sensor_device_attribute sd
>  			show_pwmenable, store_pwmenable, 2),
>  };
>  
> +/* For Smart Fan I / Thermal Cruise */
> +static ssize_t show_pwm_target(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> +	struct w83791d_data *data = w83791d_update_device(dev);
> +	int nr = sensor_attr->index;
> +	return sprintf(buf, "%d\n", TARGET_TEMP_FROM_REG(data->pwm_target[nr]));
> +}
> +
> +static ssize_t store_pwm_target(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct w83791d_data *data = i2c_get_clientdata(client);
> +	int nr = sensor_attr->index;
> +	unsigned long val;
> +	u8 target_mask;
> +
> +	if (strict_strtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	mutex_lock(&data->update_lock);
> +	data->pwm_target[nr] = TARGET_TEMP_TO_REG(val);
> +	target_mask = w83791d_read(client,
> +				W83791D_REG_PWM_TARGET[nr]) & 0x80;
> +	w83791d_write(client, W83791D_REG_PWM_TARGET[nr],
> +				data->pwm_target[nr] | target_mask);
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +static struct sensor_device_attribute sda_pwm_target[] = {
> +	SENSOR_ATTR(pwm1_target, S_IWUSR | S_IRUGO,
> +			show_pwm_target, store_pwm_target, 0),
> +	SENSOR_ATTR(pwm2_target, S_IWUSR | S_IRUGO,
> +			show_pwm_target, store_pwm_target, 1),
> +	SENSOR_ATTR(pwm3_target, S_IWUSR | S_IRUGO,
> +			show_pwm_target, store_pwm_target, 2),
> +};
> +
> +static ssize_t show_pwm_tolerance(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> +	struct w83791d_data *data = w83791d_update_device(dev);
> +	int nr = sensor_attr->index;
> +	return sprintf(buf, "%d\n", TOL_TEMP_FROM_REG(data->pwm_tolerance[nr]));
> +}
> +
> +static ssize_t store_pwm_tolerance(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct w83791d_data *data = i2c_get_clientdata(client);
> +	int nr = sensor_attr->index;
> +	unsigned long val;
> +	u8 target_mask;
> +	u8 reg_idx = 0;
> +	u8 val_shift = 0;
> +	u8 keep_mask = 0;
> +
> +	if (strict_strtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	switch (nr) {
> +	case 0:
> +		reg_idx = 0;
> +		val_shift = 0;
> +		keep_mask = 0xf0;
> +		break;
> +	case 1:
> +		reg_idx = 0;
> +		val_shift = 4;
> +		keep_mask = 0x0f;
> +		break;
> +	case 2:
> +		reg_idx = 1;
> +		val_shift = 0;
> +		keep_mask = 0xf0;
> +		break;
> +	}
> +
> +	mutex_lock(&data->update_lock);
> +	data->pwm_tolerance[nr] = TOL_TEMP_TO_REG(val);
> +	target_mask = w83791d_read(client,
> +			W83791D_REG_PWM_TOL[reg_idx]) & keep_mask;
> +	w83791d_write(client, W83791D_REG_PWM_TOL[reg_idx],
> +			(data->pwm_tolerance[nr] << val_shift) | target_mask);
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +static struct sensor_device_attribute sda_pwm_tolerance[] = {
> +	SENSOR_ATTR(pwm1_tolerance, S_IWUSR | S_IRUGO,
> +			show_pwm_tolerance, store_pwm_tolerance, 0),
> +	SENSOR_ATTR(pwm2_tolerance, S_IWUSR | S_IRUGO,
> +			show_pwm_tolerance, store_pwm_tolerance, 1),
> +	SENSOR_ATTR(pwm3_tolerance, S_IWUSR | S_IRUGO,
> +			show_pwm_tolerance, store_pwm_tolerance, 2),
> +};
> +
>  /* read/write the temperature1, includes measured value and limits */
>  static ssize_t show_temp1(struct device *dev, struct device_attribute 
> *devattr,
>  				char *buf)
> @@ -1044,6 +1173,12 @@ static struct attribute *w83791d_attribu
>  	&sda_pwmenable[0].dev_attr.attr,
>  	&sda_pwmenable[1].dev_attr.attr,
>  	&sda_pwmenable[2].dev_attr.attr,
> +	&sda_pwm_target[0].dev_attr.attr,
> +	&sda_pwm_target[1].dev_attr.attr,
> +	&sda_pwm_target[2].dev_attr.attr,
> +	&sda_pwm_tolerance[0].dev_attr.attr,
> +	&sda_pwm_tolerance[1].dev_attr.attr,
> +	&sda_pwm_tolerance[2].dev_attr.attr,
>  	NULL
>  };
>  
> @@ -1403,6 +1538,21 @@ static struct w83791d_data *w83791d_upda
>  		data->pwm_enable[1] = ((reg_array_tmp[0] >> 4) & 0x03) + 1;
>  		data->pwm_enable[2] = ((reg_array_tmp[1] >> 2) & 0x03) + 1;
>  
> +		/* Update PWM target temperature */
> +		for (i = 0; i < 2; i++) {
> +			data->pwm_target[i] = w83791d_read(client,
> +				W83791D_REG_PWM_TARGET[i]) & 0x7f;
> +		}
> +
> +		/* Update PWM temperature tolerance */
> +		for (i = 0; i < 1; i++) {
> +			reg_array_tmp[i] = w83791d_read(client,
> +					W83791D_REG_PWM_TOL[i]);
> +		}
> +		data->pwm_tolerance[0] = reg_array_tmp[0] & 0x0f;
> +		data->pwm_tolerance[1] = (reg_array_tmp[0] >> 4) & 0x0f;
> +		data->pwm_tolerance[2] = reg_array_tmp[1] & 0x0f;
> +
>  		/* Update the first temperature sensor */
>  		for (i = 0; i < 3; i++) {
>  			data->temp1[i] = w83791d_read(client,
> Index: linux-2.6.27-rc1/Documentation/hwmon/w83791d
> =================================> --- linux-2.6.27-rc1.orig/Documentation/hwmon/w83791d
> +++ linux-2.6.27-rc1/Documentation/hwmon/w83791d
> @@ -77,6 +77,9 @@ readings can be divided by a programmabl
>  
>  Each fan controlled is controlled by PWM. The PWM duty cycle can be read and
>  set for each fan separately. Valid values range from 0 (stop) to 255 (full).
> +PWM 1-3 support Thermal Cruise mode, in which the PWMs are automatically
> +regulated to keep respectively temp 1-3 at a certain target temperature.
> +See below for the description of the sysfs-interface.
>  
>  The w83791d has a global bit used to enable beeping from the speaker when an
>  alarm is triggered as well as a bitmask to enable or disable the beep for
> @@ -116,9 +119,19 @@ chip-specific options are documented her
>  pwm[1-3]_enable - 	this file controls mode of fan/temperature control for
>  		  	fan 1-3. Fan/PWM 4-5 only support manual mode.
>  		            * 1 Manual mode
> -		            * 2 Thermal Cruise mode   (no further support)
> +		            * 2 Thermal Cruise mode
>  		            * 3 Fan Speed Cruise mode (no further support)
>  
> +pwm[1-3]_target - 	defines the target temperature for Thermal Cruise mode.
> +			Unit: millidegree Celsius
> +			RW
> +
> +pwm[1-3]_tolerance - 	temperature tolerance for Thermal Cruise mode.
> +			Specifies an interval around the target temperature
> +			in which the fan speed is not changed.
> +			Unit: millidegree Celsius
> +			RW
> +
>  Alarms bitmap vs. beep_mask bitmask
>  ------------------------------------
>  For legacy code using the alarms and beep_mask files:
> @@ -146,7 +159,3 @@ tart2        :  alarms: 0x020000 beep_ma
>  tart3        :  alarms: 0x040000 beep_mask: 0x100000 <= mismatch
>  case_open    :  alarms: 0x001000 beep_mask: 0x001000
>  global_enable:  alarms: -------- beep_mask: 0x800000 (modified via 
> beep_enable)
> -
> -W83791D TODO:
> ----------------
> -Provide a patch for Thermal Cruise registers.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
