From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 20 Jun 2006 12:41:38 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <20060620144138.5911fa65.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> Here comes the updated patch
> 
> This patch adds long-awaited suport for automatic fan modes. Based on the work
> of Yuan Mu from Winbond, I finished the support with the great help of David
> Hubbard. The documenation update will follow.

I'd rather take this and the documentation patch together. We all know
what happens to patches which "will follow" ;)

> David, I fix the comment you had, thanks! Also I ripped out two more register
> exports (sf3 fan_max and fan_step). This will be neccessary to put back next round.

It's in a much better shape now, thanks to both of you for the work. I
would still have some comments though:

> @@ -416,6 +462,35 @@ static struct w83627ehf_data *w83627ehf_
>  			}
>  		}
>  
> +		for (i = 0; i < 4; i++) {
> +			int pwmcfg, tolerance;
> +			/* pwmcfg, tolarance mapped for i=0, i=1 to same reg */
> +			if (i != 1) {
> +				pwmcfg = w83627ehf_read_value(client,
> +						W83627EHF_REG_PWM_ENABLE[i]);
> +				tolerance = w83627ehf_read_value(client,
> +						W83627EHF_REG_TOLERANCE[i]);
> +			}

Unfortunately my compiler (gcc 3.3.6) complains:

drivers/hwmon/w83627ehf.c: In function `w83627ehf_update_device':
drivers/hwmon/w83627ehf.c:466: warning: `pwmcfg' might be used uninitialized in this function
drivers/hwmon/w83627ehf.c:466: warning: `tolerance' might be used uninitialized in this function

The compiler is wrong, but we can't leave warnings in the code. I guess
this is the reason why you where initializing your temporary variable
in the first place, I'm sorry for asking you to change that.

At this point I'm not too sure what is worst, two redundant inb_p, or
two initializations and four comparisons. I let you decide, as long as
there is no warning. If you go for initialization, please add a comment
explaining it's there to prevent a compiler warning.

> +static ssize_t
> +store_target_temp(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct w83627ehf_data *data = i2c_get_clientdata(client);
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> +	int nr = sensor_attr->index;
> +	u8 val = temp1_to_reg(
> +			SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 127000));
> +
> +	mutex_lock(&data->update_lock);
> +	data->target_temp[nr] = val;
> +	w83627ehf_write_value(client, W83627EHF_REG_TARGET[nr], val);
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t
> +store_tolerance(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct w83627ehf_data *data = i2c_get_clientdata(client);
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> +	int nr = sensor_attr->index;
> +	u16 reg;
> +	/* Limit the temp to 0C - 15C */
> +	u8 val = temp1_to_reg(
> +			SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 15000));
> +
> +	mutex_lock(&data->update_lock);
> +	reg = w83627ehf_read_value(client, W83627EHF_REG_TOLERANCE[nr]);
> +	data->tolerance[nr] = val;
> +	if (nr = 1)
> +		reg = (reg & 0x0f) | (val << 4);
> +	else
> +		reg = (reg & 0xf0) | val;
> +	w83627ehf_write_value(client, W83627EHF_REG_TOLERANCE[nr], reg);
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}

These combinations of temp1_to_reg and SENSORS_LIMIT are inefficient. I
suggest that you instead add two parameters (min and max values) to
temp1_to_reg(). As it is inlined there will be no performance penalty
and the code will look better too.

> +/* Smart Fan registers */
> +
> +#define fan_functions(reg, REG) \
> +static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
> +		       char *buf) \
> +{ \
> +	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
> +	int nr = sensor_attr->index; \
> +	return sprintf(buf, "%d\n", data->reg[nr]); \
> +}\
> +static ssize_t \
> +store_##reg(struct device *dev, struct device_attribute *attr, \
> +			    const char *buf, size_t count) \
> +{\
> +	struct i2c_client *client = to_i2c_client(dev); \
> +	struct w83627ehf_data *data = i2c_get_clientdata(client); \
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
> +	int nr = sensor_attr->index; \
> +	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 255); \
> +	mutex_lock(&data->update_lock); \
> +	data->reg[nr] = val; \
> +	w83627ehf_write_value(client, W83627EHF_REG_##REG[nr],  val); \
> +	mutex_unlock(&data->update_lock); \
> +	return count; \
> +}
> +
> +fan_functions(fan_min_output, FAN_MIN_OUTPUT)
> +
> +#define fan_time_functions(reg, REG) \
> +static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
> +				char *buf) \
> +{ \
> +	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
> +	int nr = sensor_attr->index; \
> +	return sprintf(buf, "%d\n", \
> +			step_time_from_reg(data->reg[nr], data->pwm_mode[nr])); \
> +} \
> +\
> +static ssize_t \
> +store_##reg(struct device *dev, struct device_attribute *attr, \
> +			const char *buf, size_t count) \
> +{ \
> +	struct i2c_client *client = to_i2c_client(dev); \
> +	struct w83627ehf_data *data = i2c_get_clientdata(client); \
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
> +	int nr = sensor_attr->index; \
> +	u8 val = step_time_to_reg(simple_strtoul(buf, NULL, 10), \
> +					data->pwm_mode[nr]); \
> +	mutex_lock(&data->update_lock); \
> +	data->reg[nr] = val; \
> +	w83627ehf_write_value(client, W83627EHF_REG_##REG[nr], val); \
> +	mutex_unlock(&data->update_lock); \
> +	return count; \
> +} \
> +
> +fan_time_functions(fan_stop_time, FAN_STOP_TIME)

Why do you define these two macros, if you then use them only once?

>  /*
>   * Driver and client management
>   */
> @@ -810,6 +1162,7 @@ static int w83627ehf_detect(struct i2c_a
>  	struct i2c_client *client;
>  	struct w83627ehf_data *data;
>  	struct device *dev;
> +	u8 cr24, cr29;
>  	int i, err = 0;
>  
>  	if (!request_region(address + REGION_OFFSET, REGION_LENGTH,
> @@ -848,13 +1201,22 @@ static int w83627ehf_detect(struct i2c_a
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

What does "-> 00" mean? These comments could be improved (maybe merged
with the one right below?) I would also prefer that the masking is done
when testing, rather than when reading the registers, else your
variable names don't make much sense.

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

>  	for (i = 0; i < 10; i++)
>  		device_create_file_in(dev, i);
>  
> -	for (i = 0; i < 5; i++) {
> +	for (i = 0; i < 5; i++)
>  		if (data->has_fan & (1 << i))
>  			device_create_file_fan(dev, i);

Please don't change this.

> +
> +	for (i = 0; i < 4; i++) {
> +		if (data->has_fan & (1 << i)) {
> +			device_create_file_pwm(dev, i);
> +			data->pwm_mode[i] = 1; /* initialize in PWM mode */
> +		}
>  	}

This initialization doesn't make much sense, it is arbitrary and the
value will be overwritten on first update anyway. What's the purpose?

Thanks,
-- 
Jean Delvare

