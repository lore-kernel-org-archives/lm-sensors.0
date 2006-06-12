From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Jun 2006 16:30:55 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <20060612183055.f5e30f1e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Sorry for the late answer.

> This patch adds long-awaited suport for automatic fan modes. Based on the work
> of Yuan Mu from Winbond, I finished the support with the great help of David
> Hubbard. The documenation update will follow.
> 
> Signed-Off-By: Yuan Mu <Ymu at Winbond.com.tw>
> Signed-Off-By: Rudolf Marek <r.marek at sh.cvut.cz>
> Signed-Off-By: David Hubbard <david.c.hubbard at gmail.com>
> 
> Some notes: The patch should be OK. It was checked/tested many times by me and
> David. This patch is based on ehf_patch_rc1 and ehf_patch_fix_fan45. More than
> 80 columns were fixed and on 4 places mutex lock/unlock was placed.
> 
> David, please can you check/test this final patch before Jean takes it?
> Please have a look to store_pwm_enable which has non-trivial locking. I belive 
> it is OK and I tested briefly, but better to be sure.

Here's my review:

> +/* SmartFan registers */
> +/* DC or PWM output fan configuration */
> +static const u8 W83627EHF_REG_PWM_ENABLE[] = {
> +	0x04,			/* SYS FAN0 output mode and PWM mode */
> +	0x04,			/* CPU FAN0 output mode and PWM mode */
> +	0x12,			/* AUX FAN mode all fan MIN */
> +	0x62			/* CPU fan1 mode */
> +};

Missing comma after the last entry.

Also the comments lack consistency, in particular we don't care that
register 0x12 contains "fan min" bits here.

> +
> +/* maps the user modes to chip modes */

I don't see how this comment is related to the following data.

> +static const u8 W83627EHF_PWM_MODE_SHIFT[] = { 0, 1, 0, 6 };
> +static const u8 W83627EHF_PWM_ENABLE_SHIFT[] = { 2, 4, 1, 4 };
> +
> +/* FAN Duty Cycle, be used to control */
> +static const u8 W83627EHF_REG_PWM[] = { 0x01, 0x03, 0x11, 0x61 };
> +static const u8 W83627EHF_REG_TARGET_TEMP[] = { 0x05, 0x06, 0x13, 0x63 };

The name is not very well chosen, these registers can hold both a target
temperature or a target fan speed depending on the control mode (even
if we don't support the latter at the moment.) What about just
W83627EHF_REG_TARGET?

> +static const u8 W83627EHF_REG_TOLERANCE[] = { 0x07, 0x07, 0x14, 0x62 };
> +
> +
> +/* Advanced Fan control */
> +static const u8 W83627EHF_REG_FAN_MIN_OUTPUT[] = { 0x08, 0x09, 0x15, 0x64 };
> +static const u8 W83627EHF_REG_FAN_MAX_OUTPUT[] = { 0x67, 0x69 };
> +static const u8 W83627EHF_REG_FAN_STEP[] = { 0x68, 0x6A };
> +static const u8 W83627EHF_REG_FAN_STOP_TIME[] = { 0x0C, 0x0D, 0x17, 0x66 };
> +static const u8 W83627EHF_REG_FAN_STEP_TIME[] = { 0x0E, 0x0F };
> +

For arrays with four values it's quite clear that there's one value for
each fan, but for the arrays with only two values,  it's not so clear.
Some comments would be welcome.

>  /*
>   * Conversions
>   */
>  
> +/* 0 is PWM mode, output in ms */
> +static inline unsigned int step_time_from_reg(u8 reg, u8 mode)
> +{
> +	return mode ? 100 * reg : 400 * reg; 
> +}

Comment is wrong, PWM mode is 1 not 0.

> +
> +static inline u8 step_time_to_reg(unsigned int msec, u8 mode)
> +{
> +	return mode ? (msec + 50) / 100 : (msec + 200) / 400;
> +}
> +

Missing check for overflow!

>  static inline unsigned int
>  fan_from_reg(u8 reg, unsigned int div)
>  {
> @@ -223,6 +262,21 @@ struct w83627ehf_data {
>  	s16 temp_max[2];
>  	s16 temp_max_hyst[2];
>  	u32 alarms;
> + 
> +	u8 pwm_mode[4]; /* 0->DC variable voltage, 1->PWM variable duty cycle */
> +	u8 pwm_enable[4]; /* 0->disabled
> +			   * 1->manual
> +			   * 2->thermal cruise (also called SmartFan I)
> +			   */
> +	u8 pwm[4];
> +	u8 target_temp[4];
> +	u8 tolerance[4];
> +
> +	u8 fan_min_output[4]; /* minimum fan speed */
> +	u8 fan_max_output[2];
> +	u8 fan_step[2];
> +	u8 fan_stop_time[4];
> +	u8 fan_step_time[2]; /* 0 Down time, 1 up time */
>  };
>  
>  static inline int is_word_sized(u16 reg)
> @@ -350,6 +404,7 @@ static struct w83627ehf_data *w83627ehf_
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct w83627ehf_data *data = i2c_get_clientdata(client);
>  	int i;
> +	int tmp = 0;

Initialization not needed.

>  
>  	mutex_lock(&data->update_lock);
>  
> @@ -416,6 +471,43 @@ static struct w83627ehf_data *w83627ehf_
>  			}
>  		}
>  
> +		for (i = 0; i < 4; i++) {
> +			if (i != 1)
> +				tmp = w83627ehf_read_value(client,
> +						W83627EHF_REG_PWM_ENABLE[i]);
> +			data->pwm_mode[i] > +				((tmp >> W83627EHF_PWM_MODE_SHIFT[i]) & 1)
> +				? 0 : 1;
> +			if (data->pwm_enable[i] != 0 ||
> +			    ((tmp >> W83627EHF_PWM_ENABLE_SHIFT[i]) & 3) != 0)
> +				data->pwm_enable[i] = 
> +					((tmp >> W83627EHF_PWM_ENABLE_SHIFT[i])
> +						& 3) + 1;

I don't understand this test, can you please explain?

> +			data->pwm[i] = w83627ehf_read_value(client,
> +						W83627EHF_REG_PWM[i]);
> +			data->fan_min_output[i] = w83627ehf_read_value(client,
> +						W83627EHF_REG_FAN_MIN_OUTPUT[i]);
> +			data->fan_stop_time[i] = w83627ehf_read_value(client,
> +						W83627EHF_REG_FAN_STOP_TIME[i]);
> +			data->target_temp[i] > +				w83627ehf_read_value(client,
> +					W83627EHF_REG_TARGET_TEMP[i]) &
> +					(data->pwm_mode[i] = 1 ? 0x7f : 0xff);
> +			data->tolerance[i] > +				(w83627ehf_read_value(client,
> +					W83627EHF_REG_TOLERANCE[i]) >>
> +					(i = 1 ? 4 : 0)) & 0x0f;
> +		}

Register 0x07 is read twice, this could be avoided with the same trick
you use for register 0x04. I would also suggest that you make the
temporary variable(s) local as you only use it (them) here. What about
the following?

		for (i = 0; i < 4; i++) {
			int pwmcfg, tolerance;

			if (i != 1) {
				pwmcfg = w83627ehf_read_value(client,
						W83627EHF_REG_PWM_ENABLE[i]);
				tolerance = w83627ehf_read_value(client,
						W83627EHF_REG_TOLERANCE[i]);
			}

			data->pwm_mode[i] 				((pwmcfg >> W83627EHF_PWM_MODE_SHIFT[i]) & 1)
				? 0 : 1;

			(... other register reads ...)

			data->tolerance[i] = (tolerance >> (i = 1 ? 4 : 0)) & 0x0f;
		}

> +
> +		for (i = 0; i < 2; i++) {
> +			data->fan_max_output[i] = w83627ehf_read_value(client,
> +						W83627EHF_REG_FAN_MAX_OUTPUT[i]);
> +			data->fan_step[i] = w83627ehf_read_value(client,
> +						W83627EHF_REG_FAN_STEP[i]);
> +			data->fan_step_time[i] = w83627ehf_read_value(client,
> +						W83627EHF_REG_FAN_STEP_TIME[i]);
> +		}
> +
>  		/* Measured temperatures and limits */
>  		data->temp1 = w83627ehf_read_value(client,
>  			      W83627EHF_REG_TEMP1);
> @@ -777,6 +869,321 @@ static struct sensor_device_attribute sd
>  	SENSOR_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13),
>  };
>  
> +#define show_pwm_reg(reg) \
> +static ssize_t show_##reg (struct device *dev, struct device_attribute *attr, \
> +				char *buf) \
> +{ \
> +	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);\
> +	int nr = sensor_attr->index;\
> +	return sprintf(buf,"%d\n", data->reg[nr]); \

Missing space after comma. Your spaces before backslashes are also
inconsistent.

> +}
> +
> +show_pwm_reg(pwm_mode)
> +show_pwm_reg(pwm_enable)
> +show_pwm_reg(pwm)
> +
> +static ssize_t
> +store_pwm_mode(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct w83627ehf_data *data = w83627ehf_update_device(dev);

No, you don't need to call update_device in a "store" sysfs callback.

> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> +	int nr = sensor_attr->index;
> +	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 1);

Using SENSOR_LIMIT here doesn't make sense, as we're not dealing with a
range. Better return -EINVAL if value is neither 0 nor 1.

> +	u16 reg = w83627ehf_read_value(client, W83627EHF_REG_PWM_ENABLE[nr]);
> +
> +	if (data->pwm_mode[nr] != val) {
> +		mutex_lock(&data->update_lock);
> +		data->pwm_mode[nr] = val;
> +		reg = (reg & ~(1 << W83627EHF_PWM_MODE_SHIFT[nr]));

reg &= ..., or at least drop the extra pair of parentheses.

> +		if (!val)
> +			reg |= 1 << W83627EHF_PWM_MODE_SHIFT[nr];
> +		w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr],
> +					reg);
> +		mutex_unlock(&data->update_lock);
> +	}
> +	return count;
> +}

Locking is broken. You're doing a read-modify-write cycle, you must
hold the lock before the read. You also must hold the lock when testing
data->pwm_mode[nr] - even though I don't think you should test it at
all, I see no reason to make the register write conditional.

Same comments apply to all your store callback functions, it seems.

> +
> +static ssize_t
> +store_pwm(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct w83627ehf_data *data = w83627ehf_update_device(dev);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> +	int nr = sensor_attr->index;
> +	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 255);
> +
> +	if (data->pwm_enable[nr] != 0 && data->pwm[nr] != val) {
> +		mutex_lock(&data->update_lock);
> +		data->pwm[nr] = val;
> +		w83627ehf_write_value(client, W83627EHF_REG_PWM[nr],
> +					val);
> +		mutex_unlock(&data->update_lock);
> +	}
> +	return count;
> +}
> +
> +static ssize_t
> +store_pwm_enable(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct w83627ehf_data *data = w83627ehf_update_device(dev);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> +	int nr = sensor_attr->index;
> +	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 3);
> +	u16 reg = w83627ehf_read_value(client, W83627EHF_REG_PWM_ENABLE[nr]);
> +
> +	if (data->pwm_enable[nr] != val) {
> +		if (!val) {
> +			store_pwm(dev, attr, "255", 3);
> +			mutex_lock(&data->update_lock);
> +			data->pwm_enable[nr] = val;
> +		}
> +		else {
> +			mutex_lock(&data->update_lock);
> +			data->pwm_enable[nr] = val;
> +			val--;
> +		}
> +		reg = (reg & ~(11 << W83627EHF_PWM_ENABLE_SHIFT[nr]));

What is this "11" falling from the sky?

> +		reg |= val << W83627EHF_PWM_ENABLE_SHIFT[nr];
> +		w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr],
> +					reg);
> +		mutex_unlock(&data->update_lock);
> +	}
> +	return count;
> +}

I just realized that you are emulating pwm_enable = 0. I guess the chip
doesn't support it? Then you don't want to implement it in the driver.
This emulation makes your code much more complex with no gain at all.
Drivers must implement what the chip support, they must NOT emulate
features.

I'm stopping my review here. Please fix:
* use of w83627ehf_update_device
* use of SENSORS_LIMIT
* locking
* conditional register writes
all around the place, then test the patch again, and then I'll review
it again.

> +
> +
> +#define show_tol_temp(reg) \
> +static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
> +				char *buf) \
> +{ \
> +	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
> +	int nr = sensor_attr->index; \
> +	return sprintf(buf,"%d\n", temp1_from_reg(data->reg[nr])); \
> +}
> +
> +show_tol_temp(tolerance)
> +show_tol_temp(target_temp)
> +
> +static ssize_t
> +store_target_temp(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct w83627ehf_data *data = w83627ehf_update_device(dev);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> +	int nr = sensor_attr->index;
> +	u8 val = temp1_to_reg(
> +			SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 127000));
> +
> +	if (data->target_temp[nr] != val) {
> +		mutex_lock(&data->update_lock);
> +		data->target_temp[nr] = val;
> +		w83627ehf_write_value(client, W83627EHF_REG_TARGET_TEMP[nr],
> +					val);
> +		mutex_unlock(&data->update_lock);
> +	}
> +	return count;
> +}
> +
> +static ssize_t
> +store_tolerance(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct w83627ehf_data *data = w83627ehf_update_device(dev);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> +	int nr = sensor_attr->index;
> +	/* Limit the temp to 0C - 15C */
> +	u8 val = temp1_to_reg(
> +			SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 15000));
> +
> +	u16 reg = w83627ehf_read_value(client, W83627EHF_REG_TOLERANCE[nr]);
> +
> +	if (data->tolerance[nr] != val) {
> +		mutex_lock(&data->update_lock);
> +		data->tolerance[nr] = val;
> +		if (nr = 1)
> +			reg = (reg & 0x0f) | (val << 4);
> +		else
> +			reg = (reg & 0xf0) | val;
> +		w83627ehf_write_value(client,
> +				W83627EHF_REG_TOLERANCE[nr], reg);
> +		mutex_unlock(&data->update_lock);
> +	}
> +	return count;
> +}
> +
> +static struct sensor_device_attribute sda_pwm[] = {
> +	SENSOR_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0),
> +	SENSOR_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1),
> +	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2),
> +	SENSOR_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 3),
> +};
> +
> +static struct sensor_device_attribute sda_pwm_mode[] = {
> +	SENSOR_ATTR(pwm1_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
> +		    store_pwm_mode, 0),
> +	SENSOR_ATTR(pwm2_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
> +		    store_pwm_mode, 1),
> +	SENSOR_ATTR(pwm3_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
> +		    store_pwm_mode, 2),
> +	SENSOR_ATTR(pwm4_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
> +		    store_pwm_mode, 3),
> +};
> +
> +static struct sensor_device_attribute sda_pwm_enable[] = {
> +	SENSOR_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
> +		    store_pwm_enable, 0),
> +	SENSOR_ATTR(pwm2_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
> +		    store_pwm_enable, 1),
> +	SENSOR_ATTR(pwm3_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
> +		    store_pwm_enable, 2),
> +	SENSOR_ATTR(pwm4_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
> +		    store_pwm_enable, 3),
> +};
> +
> +static struct sensor_device_attribute sda_target_temp[] = {
> +	SENSOR_ATTR(temp1_target, S_IWUSR | S_IRUGO, show_target_temp,
> +		    store_target_temp, 0),
> +	SENSOR_ATTR(temp2_target, S_IWUSR | S_IRUGO, show_target_temp,
> +		    store_target_temp, 1),
> +	SENSOR_ATTR(temp3_target, S_IWUSR | S_IRUGO, show_target_temp,
> +		    store_target_temp, 2),
> +	SENSOR_ATTR(temp4_target, S_IWUSR | S_IRUGO, show_target_temp,
> +		    store_target_temp, 3),
> +};
> +
> +static struct sensor_device_attribute sda_tolerance[] = {
> +	SENSOR_ATTR(temp1_tolerance, S_IWUSR | S_IRUGO, show_tolerance,
> +		    store_tolerance, 0),
> +	SENSOR_ATTR(temp2_tolerance, S_IWUSR | S_IRUGO, show_tolerance,
> +		    store_tolerance, 1),
> +	SENSOR_ATTR(temp3_tolerance, S_IWUSR | S_IRUGO, show_tolerance,
> +		    store_tolerance, 2),
> +	SENSOR_ATTR(temp4_tolerance, S_IWUSR | S_IRUGO, show_tolerance,
> +		    store_tolerance, 3),
> +};
> +
> +static void device_create_file_pwm(struct device *dev, int i)
> +{
> +	device_create_file(dev, &sda_pwm[i].dev_attr);
> +	device_create_file(dev, &sda_pwm_mode[i].dev_attr);
> +	device_create_file(dev, &sda_pwm_enable[i].dev_attr);
> +	device_create_file(dev, &sda_target_temp[i].dev_attr);
> +	device_create_file(dev, &sda_tolerance[i].dev_attr);
> +}
> +
> +/* Smart Fan registers */
> +
> +#define fan_functions(reg, REG) \
> +static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
> +		       char *buf) \
> +{ \
> +	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
> +	int nr = sensor_attr->index; \
> +	return sprintf(buf,"%d\n", data->reg[nr]); \
> +}\
> +static ssize_t \
> +store_##reg(struct device *dev, struct device_attribute *attr, \
> +			    const char *buf, size_t count) \
> +{\
> +	struct i2c_client *client = to_i2c_client(dev); \
> +	struct w83627ehf_data *data = i2c_get_clientdata(client); \
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
> +	int nr = sensor_attr->index; \
> +	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 255);\
> +	if ( data->reg[nr] != val ) { \
> +		mutex_lock(&data->update_lock); \
> +		data->reg[nr] = val; \
> +		w83627ehf_write_value(client, W83627EHF_REG_##REG[nr], \
> +					 val); \
> +		mutex_unlock(&data->update_lock); \
> +	} \
> +	return count; \
> +}
> +
> +fan_functions(fan_min_output, FAN_MIN_OUTPUT)
> +fan_functions(fan_max_output, FAN_MAX_OUTPUT)
> +fan_functions(fan_step, FAN_STEP)
> +
> +#define fan_time_functions(reg, REG) \
> +static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
> +				char *buf) \
> +{ \
> +	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
> +	int nr = sensor_attr->index; \
> +	return sprintf(buf,"%d\n", \
> +			step_time_from_reg(data->reg[nr], data->pwm_mode[nr])); \
> +} \
> +\
> +static ssize_t \
> +store_##reg(struct device *dev, struct device_attribute *attr, \
> +			const char *buf, size_t count) \
> +{ \
> +	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
> +	struct i2c_client *client = to_i2c_client(dev); \
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
> +	int nr = sensor_attr->index; \
> +	u8 val = step_time_to_reg(simple_strtoul(buf, NULL, 10), \
> +					data->pwm_mode[nr]); \
> +	if ( data->reg[nr] != val ) { \
> +		mutex_lock(&data->update_lock); \
> +		data->reg[nr] = val; \
> +		w83627ehf_write_value(client, W83627EHF_REG_##REG[nr], \
> +					 val); \
> +		mutex_unlock(&data->update_lock); \
> +	} \
> +	return count; \
> +} \
> +
> +fan_time_functions(fan_step_time, FAN_STEP_TIME)
> +fan_time_functions(fan_stop_time, FAN_STOP_TIME)
> +
> +
> +static struct sensor_device_attribute sda_sf3_arrays_fan4[] = {
> +	SENSOR_ATTR(fan4_stop_time, S_IWUSR | S_IRUGO, show_fan_stop_time,
> +		    store_fan_stop_time, 3),
> +	SENSOR_ATTR(fan4_min_output, S_IWUSR | S_IRUGO, show_fan_min_output,
> +		    store_fan_min_output, 3),
> +	SENSOR_ATTR(fan4_max_output, S_IWUSR | S_IRUGO, show_fan_max_output,
> +		    store_fan_max_output, 1),
> +	SENSOR_ATTR(fan4_step, S_IWUSR | S_IRUGO, show_fan_step,
> +		    store_fan_step, 1),
> +};
> +
> +static struct sensor_device_attribute sda_sf3_arrays[] = {
> +	SENSOR_ATTR(fan_step_up_time, S_IWUSR | S_IRUGO, show_fan_step_time,
> +		    store_fan_step_time, 1),
> +	SENSOR_ATTR(fan_step_down_time, S_IWUSR | S_IRUGO, show_fan_step_time,
> +		    store_fan_step_time, 0),
> +	SENSOR_ATTR(fan1_stop_time, S_IWUSR | S_IRUGO, show_fan_stop_time,
> +		    store_fan_stop_time, 0),
> +	SENSOR_ATTR(fan2_stop_time, S_IWUSR | S_IRUGO, show_fan_stop_time,
> +		    store_fan_stop_time, 1),
> +	SENSOR_ATTR(fan3_stop_time, S_IWUSR | S_IRUGO, show_fan_stop_time,
> +		    store_fan_stop_time, 2),
> +	SENSOR_ATTR(fan1_min_output, S_IWUSR | S_IRUGO, show_fan_min_output,
> +		    store_fan_min_output, 0),
> +	SENSOR_ATTR(fan2_min_output, S_IWUSR | S_IRUGO, show_fan_min_output,
> +		    store_fan_min_output, 1),
> +	SENSOR_ATTR(fan3_min_output, S_IWUSR | S_IRUGO, show_fan_min_output,
> +		    store_fan_min_output, 2),
> +	SENSOR_ATTR(fan2_max_output, S_IWUSR | S_IRUGO, show_fan_max_output,
> +		    store_fan_max_output, 0),
> +	SENSOR_ATTR(fan2_step, S_IWUSR | S_IRUGO, show_fan_step,
> +		    store_fan_step, 0),
> +};
> +
>  /*
>   * Driver and client management
>   */
> @@ -810,6 +1217,7 @@ static int w83627ehf_detect(struct i2c_a
>  	struct i2c_client *client;
>  	struct w83627ehf_data *data;
>  	struct device *dev;
> +	u8 cr24, cr29;
>  	int i, err = 0;
>  
>  	if (!request_region(address + REGION_OFFSET, REGION_LENGTH,
> @@ -848,13 +1256,22 @@ static int w83627ehf_detect(struct i2c_a
>  		data->fan_min[i] = w83627ehf_read_value(client,
>  				   W83627EHF_REG_FAN_MIN[i]);
>  
> +	/* fan4 and fan5 share some pins with the GPIO and serial flash */
> +
> +	superio_enter();
> +	/* flash needs to be disabled for AUXFANIN1/fan5 -> 00 */
> +	cr24 = superio_inb(0x24) & 0x2; 
> +	cr29 = superio_inb(0x29) & 0x6; /* CPUFANIN1/fan4 ->00 */
> +	superio_exit();
> +	
>  	/* It looks like fan4 and fan5 pins can be alternatively used
>  	   as fan on/off switches */
> +	
>  	data->has_fan = 0x07; /* fan1, fan2 and fan3 */
>  	i = w83627ehf_read_value(client, W83627EHF_REG_FANDIV1);
> -	if (i & (1 << 2))
> +	if ((i & (1 << 2)) && (!cr29))
>  		data->has_fan |= (1 << 3);
> -	if (i & (1 << 0))
> +	if ((i & (1 << 0)) && (!cr24))
>  		data->has_fan |= (1 << 4);
>  
>  	/* Register sysfs hooks */
> @@ -864,13 +1281,28 @@ static int w83627ehf_detect(struct i2c_a
>  		goto exit_detach;
>  	}
>  
> +  	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays); i++)
> +  		device_create_file(dev, &sda_sf3_arrays[i].dev_attr);
> +
> +	/* if fan4 is enabled create the sf3 files for it */
> +	if (data->has_fan & (1 << 3))
> +		for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
> +			device_create_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
> +
>  	for (i = 0; i < 10; i++)
>  		device_create_file_in(dev, i);
>  
> -	for (i = 0; i < 5; i++) {
> +	for (i = 0; i < 5; i++)
>  		if (data->has_fan & (1 << i))
>  			device_create_file_fan(dev, i);
> +
> +	for (i = 0; i < 4; i++) {
> +		if (data->has_fan & (1 << i)) {
> +			device_create_file_pwm(dev, i);
> +			data->pwm_mode[i] = 1; /* initialize in PWM mode */
> +		}
>  	}
> +
>  	for (i = 0; i < ARRAY_SIZE(sda_temp); i++)
>  		device_create_file(dev, &sda_temp[i].dev_attr);
>  
> 


-- 
Jean Delvare

