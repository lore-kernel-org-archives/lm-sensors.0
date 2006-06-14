From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 14 Jun 2006 12:48:56 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <449005B8.6090908@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,
> 
> The name is not very well chosen, these registers can hold both a target
> temperature or a target fan speed depending on the control mode (even
> if we don't support the latter at the moment.) What about just
> W83627EHF_REG_TARGET?

I think this is in the plan for future driver upgrade.

> 
>> +static const u8 W83627EHF_REG_TOLERANCE[] = { 0x07, 0x07, 0x14, 0x62 };
>> +
>> +
>> +/* Advanced Fan control */
>> +static const u8 W83627EHF_REG_FAN_MIN_OUTPUT[] = { 0x08, 0x09, 0x15, 0x64 };
>> +static const u8 W83627EHF_REG_FAN_MAX_OUTPUT[] = { 0x67, 0x69 };
>> +static const u8 W83627EHF_REG_FAN_STEP[] = { 0x68, 0x6A };
>> +static const u8 W83627EHF_REG_FAN_STOP_TIME[] = { 0x0C, 0x0D, 0x17, 0x66 };
>> +static const u8 W83627EHF_REG_FAN_STEP_TIME[] = { 0x0E, 0x0F };
>> +
> 
> For arrays with four values it's quite clear that there's one value for
> each fan, but for the arrays with only two values,  it's not so clear.
> Some comments would be welcome.

OK

> 
>>  /*
>>   * Conversions
>>   */
>>  
>> +/* 0 is PWM mode, output in ms */
>> +static inline unsigned int step_time_from_reg(u8 reg, u8 mode)
>> +{
>> +	return mode ? 100 * reg : 400 * reg; 
>> +}
> 
> Comment is wrong, PWM mode is 1 not 0.

Good catch.

> 
>> +
>> +static inline u8 step_time_to_reg(unsigned int msec, u8 mode)
>> +{
>> +	return mode ? (msec + 50) / 100 : (msec + 200) / 400;
>> +}
>> +
> 
> Missing check for overflow!

When it is bigger than 255... Will fix...

=>
> Initialization not needed.

OK

> 
>>  
>>  	mutex_lock(&data->update_lock);
>>  
>> @@ -416,6 +471,43 @@ static struct w83627ehf_data *w83627ehf_
>>  			}
>>  		}
>>  
>> +		for (i = 0; i < 4; i++) {
>> +			if (i != 1)
>> +				tmp = w83627ehf_read_value(client,
>> +						W83627EHF_REG_PWM_ENABLE[i]);
>> +			data->pwm_mode[i] >> +				((tmp >> W83627EHF_PWM_MODE_SHIFT[i]) & 1)
>> +				? 0 : 1;
>> +			if (data->pwm_enable[i] != 0 ||
>> +			    ((tmp >> W83627EHF_PWM_ENABLE_SHIFT[i]) & 3) != 0)
>> +				data->pwm_enable[i] = 
>> +					((tmp >> W83627EHF_PWM_ENABLE_SHIFT[i])
>> +						& 3) + 1;
> 
> I don't understand this test, can you please explain?

Well this is for that MODE 0 emulation. I think we agreed we can ignore the mode.

> 
>> +			data->pwm[i] = w83627ehf_read_value(client,
>> +						W83627EHF_REG_PWM[i]);
>> +			data->fan_min_output[i] = w83627ehf_read_value(client,
>> +						W83627EHF_REG_FAN_MIN_OUTPUT[i]);
>> +			data->fan_stop_time[i] = w83627ehf_read_value(client,
>> +						W83627EHF_REG_FAN_STOP_TIME[i]);
>> +			data->target_temp[i] >> +				w83627ehf_read_value(client,
>> +					W83627EHF_REG_TARGET_TEMP[i]) &
>> +					(data->pwm_mode[i] = 1 ? 0x7f : 0xff);
>> +			data->tolerance[i] >> +				(w83627ehf_read_value(client,
>> +					W83627EHF_REG_TOLERANCE[i]) >>
>> +					(i = 1 ? 4 : 0)) & 0x0f;
>> +		}
> 
> Register 0x07 is read twice, this could be avoided with the same trick
> you use for register 0x04. I would also suggest that you make the
> temporary variable(s) local as you only use it (them) here. What about
> the following?
> 
> 		for (i = 0; i < 4; i++) {
> 			int pwmcfg, tolerance;
> 
> 			if (i != 1) {
> 				pwmcfg = w83627ehf_read_value(client,
> 						W83627EHF_REG_PWM_ENABLE[i]);
> 				tolerance = w83627ehf_read_value(client,
> 						W83627EHF_REG_TOLERANCE[i]);
> 			}
> 


Ok looks good.

> 			data->pwm_mode[i] > 				((pwmcfg >> W83627EHF_PWM_MODE_SHIFT[i]) & 1)
> 				? 0 : 1;
> 
> 			(... other register reads ...)
> 
> 			data->tolerance[i] = (tolerance >> (i = 1 ? 4 : 0)) & 0x0f;
> 		}
> 
>> +
>> +		for (i = 0; i < 2; i++) {
>> +			data->fan_max_output[i] = w83627ehf_read_value(client,
>> +						W83627EHF_REG_FAN_MAX_OUTPUT[i]);
>> +			data->fan_step[i] = w83627ehf_read_value(client,
>> +						W83627EHF_REG_FAN_STEP[i]);
>> +			data->fan_step_time[i] = w83627ehf_read_value(client,
>> +						W83627EHF_REG_FAN_STEP_TIME[i]);
>> +		}
>> +
>>  		/* Measured temperatures and limits */
>>  		data->temp1 = w83627ehf_read_value(client,
>>  			      W83627EHF_REG_TEMP1);
>> @@ -777,6 +869,321 @@ static struct sensor_device_attribute sd
>>  	SENSOR_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13),
>>  };
>>  
>> +#define show_pwm_reg(reg) \
>> +static ssize_t show_##reg (struct device *dev, struct device_attribute *attr, \
>> +				char *buf) \
>> +{ \
>> +	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
>> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);\
>> +	int nr = sensor_attr->index;\
>> +	return sprintf(buf,"%d\n", data->reg[nr]); \
> 
> Missing space after comma. Your spaces before backslashes are also
> inconsistent.

Ok I will try to unify this. There are three authors of this patch so sometimes
it is quite hard to get all stuff right.


> 
>> +}
>> +
>> +show_pwm_reg(pwm_mode)
>> +show_pwm_reg(pwm_enable)
>> +show_pwm_reg(pwm)
>> +
>> +static ssize_t
>> +store_pwm_mode(struct device *dev, struct device_attribute *attr,
>> +			const char *buf, size_t count)
>> +{
>> +	struct w83627ehf_data *data = w83627ehf_update_device(dev);
> 
> No, you don't need to call update_device in a "store" sysfs callback.

Yes good catch.


>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>> +	int nr = sensor_attr->index;
>> +	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 1);
> 
> Using SENSOR_LIMIT here doesn't make sense, as we're not dealing with a
> range. Better return -EINVAL if value is neither 0 nor 1.

Well yes why not, maybe we should write a note to a docs?

> 
>> +	u16 reg = w83627ehf_read_value(client, W83627EHF_REG_PWM_ENABLE[nr]);
>> +
>> +	if (data->pwm_mode[nr] != val) {
>> +		mutex_lock(&data->update_lock);
>> +		data->pwm_mode[nr] = val;
>> +		reg = (reg & ~(1 << W83627EHF_PWM_MODE_SHIFT[nr]));
> 
> reg &= ..., or at least drop the extra pair of parentheses.

oOK

> 
>> +		if (!val)
>> +			reg |= 1 << W83627EHF_PWM_MODE_SHIFT[nr];
>> +		w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr],
>> +					reg);
>> +		mutex_unlock(&data->update_lock);
>> +	}
>> +	return count;
>> +}
> 
> Locking is broken. You're doing a read-modify-write cycle, you must
> hold the lock before the read. 
> You also must hold the lock when testing
> data->pwm_mode[nr] - even though I don't think you should test it at
> all, I see no reason to make the register write conditional.

 The register writes are just time "savers" I think it Yuan did it also for the
new driver...

> 
> Same comments apply to all your store callback functions, it seems.

I'm not a author of this code, I just did not catch it ...

>> +
>> +static ssize_t
>> +store_pwm(struct device *dev, struct device_attribute *attr,
>> +			const char *buf, size_t count)
>> +{
>> +	struct w83627ehf_data *data = w83627ehf_update_device(dev);
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>> +	int nr = sensor_attr->index;
>> +	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 255);
>> +
>> +	if (data->pwm_enable[nr] != 0 && data->pwm[nr] != val) {
>> +		mutex_lock(&data->update_lock);
>> +		data->pwm[nr] = val;
>> +		w83627ehf_write_value(client, W83627EHF_REG_PWM[nr],
>> +					val);
>> +		mutex_unlock(&data->update_lock);
>> +	}
>> +	return count;
>> +}
>> +
>> +static ssize_t
>> +store_pwm_enable(struct device *dev, struct device_attribute *attr,
>> +			const char *buf, size_t count)
>> +{
>> +	struct w83627ehf_data *data = w83627ehf_update_device(dev);
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>> +	int nr = sensor_attr->index;
>> +	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 3);
>> +	u16 reg = w83627ehf_read_value(client, W83627EHF_REG_PWM_ENABLE[nr]);
>> +
>> +	if (data->pwm_enable[nr] != val) {
>> +		if (!val) {
>> +			store_pwm(dev, attr, "255", 3);
>> +			mutex_lock(&data->update_lock);
>> +			data->pwm_enable[nr] = val;
>> +		}
>> +		else {
>> +			mutex_lock(&data->update_lock);
>> +			data->pwm_enable[nr] = val;
>> +			val--;
>> +		}
>> +		reg = (reg & ~(11 << W83627EHF_PWM_ENABLE_SHIFT[nr]));
> 
> What is this "11" falling from the sky?
> 
>> +		reg |= val << W83627EHF_PWM_ENABLE_SHIFT[nr];
>> +		w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr],
>> +					reg);
>> +		mutex_unlock(&data->update_lock);
>> +	}
>> +	return count;
>> +}
> 
> I just realized that you are emulating pwm_enable = 0. I guess the chip
> doesn't support it? Then you don't want to implement it in the driver.
> This emulation makes your code much more complex with no gain at all.
> Drivers must implement what the chip support, they must NOT emulate
> features.

On the other hand we want consistent interface... I thought that either the file
could be present or not, but if present it MUST support 0 and 1 at least.

I think you told me that that -EINVAL should do it and I can revert the
emulation stuff back. But I think we should FIX this in docs so it cannot be a
matter of interpretation.

I will fix  the minor stuff too.

> * use of w83627ehf_update_device
> * use of SENSORS_LIMIT
> * locking
> * conditional register writes

As for the conditional register writes. You just told me to save one read and
you dont want the conditional writes? hmmm?

> all around the place, then test the patch again, and then I'll review
> it again.
OK

Many thanks for the review. As I already told you we need some kind of wiki page
describing all those pitfalls so I can easily check the stuff and dont forget
about anything..

Anyone will help me?

Regards
Rudolf

