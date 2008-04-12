From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Apr 2008 15:32:21 +0000
Subject: Re: [lm-sensors] [PATCH] LM63: Add controls for configuring device
Message-Id: <20080412173221.7b2a2f41@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Trent,

Redirecting to the correct mailing-list...

On Thu, 3 Apr 2008 18:29:13 -0700 (PDT), Trent Piepho wrote:
> Add controls that configure settings normally done by the BIOS.  Turned on
> with CONFIG_SENSORS_LM63_SETUP

What system do you need this for?

> 
> pwm1_polarity:  0 = low for fan off, 1 = low for fan on.  Changing the
>  	polarity will adjust the pwm value to try to keep the fan at the
>  	same setting.  E.g, if the fan is on and polarity is 0, changing
>  	polarity to 1 will keep the fan on by setting pwm1 to the opposite
>  	of what it was, as opposed to keeping pwm1 the same and causing the
>  	fan to turn off.

I am reluctant to accept this as a run-time option... It's a good thing
that you preserve the fan speed, but still, one of the polarities is
wrong, and wrong polarity doesn't bode well with automatic fan speed
control, which the LM63 implements: you'll end up with either fan at full
speed (bad) or stopped (worse). The polarity should really be set
before the driver is loaded and never changed after that.

> 
> pwm1_enable:  Add ability to set this control, which switches between
>  	direct PWM control and temperature table look up.

That's pretty standard and should be included unconditionally. The only
reason why it was missing so far is because automatic (temperature
look-up) mode wasn't implemented yet.

> 
> fan1_enable:  Enables/disables fan tach monitoring.  Turning this on/off
>  	will create/remove the other fan related sysfs files.

Again I am reluctant to make this a run-time selection, because you're
not just enabling/disabling the tachometer function, you're also
disabling/enabling the ALERT output which shares the same pin. Only one
configuration is correct for the hardware setup, so it should be set
once and for all before the driver is loaded.

> 
> conv_rate:  Set the conversion rate, format is log2(frequency)

I fail to see the point of this one, given that the driver caches the
data for 1 second anyway?

> 
> pwm1_auto_point[1-8]_temp and pwm_auto_point[1-8]_pwm:  The lookup table
>  	used for automatic fan PWM control based on temp2.

Yeah, good.

> 
> pwm1_auto_hyst:  The hysteresis to use in automatic fan PWM.  When temp2 is
>  	greater than pwm_auto_pointN_temp, it will use pwm_auto_pointN_pwm.
>  	It will keep this until the temp gets pwm_auto_hyst degrees below
>  	pwm_auto_pointN_temp.

We avoid this kind of "general" file in sysfs because they don't follow
the standard so applications aren't able to use them. The standard way
to handle the case where a single register corresponds to multiple
sysfs files is to create them all, and make only one of them writable.
So in your case that would be:

pwm_auto_point1_temp_hyst: read/write
pwm_auto_point[2-8]_temp_hyst: read only

> 
> temp2_offset:  Offset applied to the temp2 reading, for adjusting to
>  	different thermal diodes.
> 
> pwm1_freq:  The frequency the PWM output operates at.  It's set in Hz and
>  	supports ranges of 23..700 and 5806..180000.  Setting the frequency
>  	will also adjust the internal pwm setting to try to keep the duty
>  	cycle the same.

These two are pretty standard as well by now, so I would be fine having
them created unconditionally.

This basically leaves only two or three configuration bits (pwm1_polarity, 
fan1_enable and maybe conv_rate if you can explain) that would belong
to CONFIG_SENSORS_LM63_SETUP. Quite frankly, I'd rather see you use
i2cset to write them to the LM63 chip at boot time, rather than adding
code to the lm63 driver, even as a separate option. You'll have to
write some boot code either way. I am still commenting on these
functions in your patch below if you want to improve the code for
yourself, but I doubt it will ever make it upstream.

> 
> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> ---
>   drivers/hwmon/Kconfig |   15 ++
>   drivers/hwmon/lm63.c  |  371 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 381 insertions(+), 5 deletions(-)
> 

Preliminary note: many lines over 80 columns in your patch, please fix.

Review:

> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 4dc76bc..3df79af 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -366,6 +366,21 @@ config SENSORS_LM63
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called lm63.
> 
> +config SENSORS_LM63_SETUP
> +	boolean "Addition LM63 configuration controls"
> +	depends on SENSORS_LM63
> +	default n
> +	help
> +	  Adds additional controls to the LM63 driver to set things that
> +	  would normally be configured by the BIOS.
> +
> +	  One could use this if their BIOS was broken or othewise setting the
> +	  LM63 up in a sub-optimal manner.  It's also useful for embedded
> +	  system with no BIOS, or for developers who are writing the BIOS.
> +
> +	  If the prospect of reading the LM63's data sheet is daunting to you,
> +	  then you should probably just leave this off.
> +
>   config SENSORS_LM70
>   	tristate "National Semiconductor LM70"
>   	depends on SPI_MASTER && EXPERIMENTAL
> diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
> index 1162870..7ce3c54 100644
> --- a/drivers/hwmon/lm63.c
> +++ b/drivers/hwmon/lm63.c
> @@ -77,6 +77,10 @@ I2C_CLIENT_INSMOD_1(lm63);
>   #define LM63_REG_PWM_VALUE		0x4C
>   #define LM63_REG_PWM_FREQ		0x4D
> 
> +#define LM63_REG_PWM_AUTO_TEMP		0x50
> +#define LM63_REG_PWM_AUTO_PWM		0x51

I'd rather define these as macros, as many other drivers do:

/* nr from 0 to 7 */
#define LM63_REG_PWM_AUTO_TEMP(nr)		(0x50 + (nr) * 2)
#define LM63_REG_PWM_AUTO_PWM(nr)		(0x51 + (nr) * 2)

> +#define LM63_REG_PWM_AUTO_HYST		0x4F
> +
>   #define LM63_REG_LOCAL_TEMP		0x00
>   #define LM63_REG_LOCAL_HIGH		0x05
> 
> @@ -91,6 +95,8 @@ I2C_CLIENT_INSMOD_1(lm63);
>   #define LM63_REG_REMOTE_TCRIT		0x19
>   #define LM63_REG_REMOTE_TCRIT_HYST	0x21
> 
> +#define LM63_REG_CONV_RATE		0x04
> +
>   #define LM63_REG_ALERT_STATUS		0x02
>   #define LM63_REG_ALERT_MASK		0x16
> 
> @@ -123,6 +129,9 @@ I2C_CLIENT_INSMOD_1(lm63);
>   #define HYST_TO_REG(val)	((val) <= 0 ? 0 : \
>   				 (val) >= 127000 ? 127 : \
>   				 ((val) + 500) / 1000)
> +#define HYST5_TO_REG(val)	((val) <= 0 ? 0 : \
> +				 (val) >= 31000 ? 31 : \
> +				 ((val) + 500) / 1000)
> 
>   /*
>    * Functions declaration
> @@ -148,6 +157,11 @@ static struct i2c_driver lm63_driver = {
>   	.detach_client	= lm63_detach_client,
>   };
> 
> +#ifdef CONFIG_SENSORS_LM63_SETUP
> +#define NUM_TEMP11	4
> +#else
> +#define NUM_TEMP11	3
> +#endif
>   /*
>    * Client data (each client gets its own)
>    */
> @@ -168,9 +182,10 @@ struct lm63_data {
>   	s8 temp8[3];	/* 0: local input
>   			   1: local high limit
>   			   2: remote critical limit */
> -	s16 temp11[3];	/* 0: remote input
> -			   1: remote low limit
> -			   2: remote high limit */
> +	s16 temp11[NUM_TEMP11]; /* 0: remote input
> +				   1: remote low limit
> +				   2: remote high limit
> +				   3: remote offset */
>   	u8 temp2_crit_hyst;
>   	u8 alarms;
>   };
> @@ -240,6 +255,272 @@ static ssize_t show_pwm1_enable(struct device *dev, struct device_attribute *dum
>   	return sprintf(buf, "%d\n", data->config_fan & 0x20 ? 1 : 2);
>   }
> 
> +#ifdef CONFIG_SENSORS_LM63_SETUP
> +static ssize_t set_pwm1_enable(struct device *dev, struct device_attribute *dummy,
> +			       const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm63_data *data = i2c_get_clientdata(client);
> +	unsigned long val = simple_strtoul(buf, NULL, 0);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case 2: /* Lookup Table mode */
> +		data->config_fan &= ~0x20;
> +		break;
> +	case 1: /* Direct mode */
> +		data->config_fan |= 0x20;
> +		break;
> +	default:
> +		return -EINVAL;

You're returning with a mutex held!

> +	}
> +	i2c_smbus_write_byte_data(client, LM63_REG_CONFIG_FAN, data->config_fan);

You should not assume that data->config_fan was up-to-date. Do a proper
read/modify/write cycle instead.

> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}

This function could change the permissions of the sysfs files that
correspond to registers that go read/write or read-only. A few drivers
are doing that already.

> +
> +static ssize_t set_pwm1_polarity(struct device *dev, struct device_attribute *dummy,
> +				 const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm63_data *data = lm63_update_device(dev);
> +	unsigned long val = simple_strtoul(buf, NULL, 0) ? 0x10 : 0;
> +
> +	mutex_lock(&data->update_lock);
> +	if ((data->config_fan & 0x10) = val) {

Again you shouldn't assume that data->config_fan is up-to-date.

Inverting the condition would result in less duplicated code.

> +		/* Already set to desired value */
> +		mutex_unlock(&data->update_lock);
> +		return count;
> +	}
> +
> +	data->config_fan ^= 0x10;
> +
> +	/* Invert duty cycle, to keep fan at the same setting */
> +	data->pwm1_value = 2 * data->pwm1_freq - data->pwm1_value;

Same for data->pwm1_value, it might not be up-to-date.

> +
> +	i2c_smbus_write_byte_data(client, LM63_REG_CONFIG_FAN, data->config_fan);
> +	i2c_smbus_write_byte_data(client, LM63_REG_PWM_VALUE, data->pwm1_value);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_pwm1_polarity(struct device *dev,
> +				  struct device_attribute *dummy, char *buf)
> +{
> +	struct lm63_data *data = lm63_update_device(dev);

Why call lm63_update_device()? data->config_fan isn't updated by this
function.

> +	return sprintf(buf, "%d\n", !!(data->config_fan & 0x10));
> +}
> +
> +/* forward declaration */
> +static const struct attribute_group lm63_group_fan1;
> +
> +static ssize_t set_fan1_enable(struct device *dev, struct device_attribute *dummy,
> +			       const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm63_data *data = i2c_get_clientdata(client);
> +	unsigned long val = simple_strtoul(buf, NULL, 0);
> +
> +	/* Remove the group if it's already there.  In theory data->config
> +	 * will tell us if the the group is there or not, but this way is
> +	 * resistant to sysfs and the lm63 state getting out of sync
> +	 */
> +	mutex_lock(&data->update_lock);
> +	sysfs_remove_group(&client->dev.kobj, &lm63_group_fan1);
> +	if (val) {
> +		int err;
> +
> +		err = sysfs_create_group(&client->dev.kobj, &lm63_group_fan1);
> +		if (err < 0) {
> +			sysfs_remove_group(&client->dev.kobj, &lm63_group_fan1);

Useless: if sysfs_create_group() failed, there's nothing left to remove.

> +			mutex_unlock(&data->update_lock);
> +			return err;
> +		}
> +
> +		data->config |= 0x04;
> +	} else
> +		data->config &= ~0x04;
> +
> +	i2c_smbus_write_byte_data(client, LM63_REG_CONFIG1, data->config);
> +	mutex_unlock(&data->update_lock);

I don't like this... For one thing, removing files to create them right
after is ugly. For another, libsensors scans sysfs for attributes at
initialization time and doesn't expect attributes to be added or
removed after that.

> +
> +	return count;
> +}
> +
> +static ssize_t show_fan1_enable(struct device *dev,
> +				struct device_attribute *dummy, char *buf)
> +{
> +	struct lm63_data *data = lm63_update_device(dev);

Again there's no point in calling lm63_update_device(), unless you
change it to read register LM63_REG_CONFIG_FAN and cache the result.

> +
> +	return sprintf(buf, "%d\n", !!(data->config_fan & 0x04));
> +}
> +
> +static ssize_t set_conv_rate(struct device *dev, struct device_attribute *dummy,
> +			     const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	long val = simple_strtol(buf, NULL, 0);
> +
> +	/* Value is log2(rate) */
> +	if (val < -4 || val > 5)
> +		return -EINVAL;

What a friendly unit ;)

> +
> +	i2c_smbus_write_byte_data(client, LM63_REG_CONV_RATE, val + 4);
> +	return count;
> +}
> +
> +static ssize_t show_conv_rate(struct device *dev,
> +			      struct device_attribute *dummy, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int data;

Better find another name. "data" is consistently used throughout the
whole driver for something different.

> +
> +	data = i2c_smbus_read_byte_data(client, LM63_REG_CONV_RATE);

Because this isn't cached, you're giving users an easy way to saturate
the SMBus. Either make the attribute readable by root only, or cache
its value.

> +	if (data > 9)
> +		data = 9;
> +	return sprintf(buf, "%d\n", data - 4);
> +}
> +
> +static ssize_t set_pwm1_freq(struct device *dev, struct device_attribute *dummy,
> +			    const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm63_data *data = lm63_update_device(dev);
> +	unsigned long val = simple_strtoul(buf, NULL, 0);
> +	unsigned long freq;
> +
> +	/* Only support the ranges [23, 700] and [5806, 180000] */

And even then... frequencies 180 kHz, 90 kHz, 700 Hz and 350 Hz are
hardly usable due to the chip design. I don't really consider PWM steps
of 50% or 25% as acceptable. In particular when using automatic fan
speed control, this would probably be awful. I think this is worth a
note in Documentation/hwmon/lm63. Maybe also output the resulting PWM
step resolution to the kernel log?

> +	if (val > 180000 || val < 23)
> +		return -EINVAL;
> +	if (val > 700 && val < 5806)
> +		return -EINVAL;

For PWM frequency values, the drivers are supposed to pick the nearest
available frequency, not to reject unsupported ones.

> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (val <= 700) {
> +		data->config_fan |= 8;
> +		freq = 1400;

FWIW, the datasheet suggests that the frequency is actually 1406 Hz
(see the Application Notes section 3.1)

> +	} else {
> +		data->config_fan &= ~8;
> +		freq = 360000;
> +	}
> +	freq = (freq + val) / (val * 2);
> +
> +	/* Adjust PWM to same duty cycle at new frequency */
> +	data->pwm1_value = (data->pwm1_value * freq + data->pwm1_freq/2) /
> +			    data->pwm1_freq;
> +	data->pwm1_freq = freq;
> +
> +	i2c_smbus_write_byte_data(client, LM63_REG_PWM_FREQ, data->pwm1_freq);
> +	i2c_smbus_write_byte_data(client, LM63_REG_CONFIG_FAN, data->config_fan);
> +	i2c_smbus_write_byte_data(client, LM63_REG_PWM_VALUE, data->pwm1_value);
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_pwm1_freq(struct device *dev, struct device_attribute *dummy,
> +			      char *buf)
> +{
> +	struct lm63_data *data = lm63_update_device(dev);
> +	unsigned int freq;
> +
> +	freq = (data->config_fan & 8) ? 1400 : 360000;
> +	freq = (freq + data->pwm1_freq) / (data->pwm1_freq * 2);
> +
> +	return sprintf(buf, "%u\n", freq);
> +}
> +
> +static ssize_t set_pwm_auto_point_temp(struct device *dev,
> +	struct device_attribute *devattr, const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm63_data *data = lm63_update_device(dev);

No reason to call lm63_update_device() AFAICS.

> +	const struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	const int nr = attr->index;

We now recommend the following, more compact construct:

	const int nr = to_sensor_dev_attr(devattr)->index;

> +	long val = simple_strtol(buf, NULL, 0);
> +
> +	if (!(data->config_fan & 0x20)) /* registers are read-only */
> +		return -EPERM;

So basically the user has to set PWM in manual mode first before he/she
can change the points of the automatic mode. While it makes some sense,
other chips / drivers don't have this limitation, so it might be
confusing. This should be documented in Documentation/hwmon/lm63.

> +
> +	i2c_smbus_write_byte_data(client, LM63_REG_PWM_AUTO_TEMP + nr * 2,
> +				  HYST_TO_REG(val));
> +
> +	return count;
> +}
> +
> +static ssize_t show_pwm_auto_point_temp(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	const struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	const int nr = attr->index;
> +	int data = i2c_smbus_read_byte_data(client,
> +					    LM63_REG_PWM_AUTO_TEMP + nr * 2);

Should be cached.

> +
> +	return sprintf(buf, "%d\n", TEMP8_FROM_REG(data));
> +}
> +
> +static ssize_t set_pwm_auto_point_pwm(struct device *dev,
> +	struct device_attribute *devattr, const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm63_data *data = lm63_update_device(dev);

No reason to call lm63_update_device() AFAICS.

> +	const struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	const int nr = attr->index;
> +	long val = simple_strtol(buf, NULL, 0);
> +
> +	if (!(data->config_fan & 0x20)) /* registers are read-only */
> +		return -EPERM;
> +
> +	val = val <= 0 ? 0 : val >= 255 ? 2 * data->pwm1_freq :
> +	      (val * data->pwm1_freq * 2 + 127) / 255;
> +	i2c_smbus_write_byte_data(client, LM63_REG_PWM_AUTO_PWM + nr * 2, val);
> +
> +	return count;
> +}

This function looks a lot like set_pwm1(), it should be possible to
share the code.

> +
> +static ssize_t show_pwm_auto_point_pwm(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm63_data *data = lm63_update_device(dev);
> +	const struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	const int nr = attr->index;
> +	int val = i2c_smbus_read_byte_data(client,
> +					   LM63_REG_PWM_AUTO_PWM + nr * 2);

Should be cached.

> +
> +	return sprintf(buf, "%d\n", val >= 2 * data->pwm1_freq ? 255 :
> +		       (val * 255 + data->pwm1_freq) / (2 * data->pwm1_freq));
> +}
> +

Here again this function looks a lot like show_pwm1(), so it should be
possible to share the code.

> +static ssize_t show_pwm_auto_hyst(struct device *dev,
> +				  struct device_attribute *dummy, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	unsigned int val = i2c_smbus_read_byte_data(client,
> +						    LM63_REG_PWM_AUTO_HYST);

Should be cached.

> +
> +	return sprintf(buf, "%d\n", TEMP8_FROM_REG(val));
> +}
> +
> +static ssize_t set_pwm_auto_hyst(struct device *dev, struct device_attribute *dummy,
> +				 const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	long val = simple_strtol(buf, NULL, 0);
> +
> +	i2c_smbus_write_byte_data(client, LM63_REG_PWM_AUTO_HYST,
> +				  HYST5_TO_REG(val));
> +	return count;
> +}
> +
> +#endif /* CONFIG_SENSORS_LM63_SETUP */
> +
>   static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
>   			  char *buf)
>   {
> @@ -273,11 +554,15 @@ static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
>   static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
>   			  const char *buf, size_t count)
>   {
> -	static const u8 reg[4] = {
> +	static const u8 reg[] = {
>   		LM63_REG_REMOTE_LOW_MSB,
>   		LM63_REG_REMOTE_LOW_LSB,
>   		LM63_REG_REMOTE_HIGH_MSB,
>   		LM63_REG_REMOTE_HIGH_LSB,
> +#ifdef CONFIG_SENSORS_LM63_SETUP
> +		LM63_REG_REMOTE_OFFSET_MSB,
> +		LM63_REG_REMOTE_OFFSET_LSB,
> +#endif
>   	};
> 
>   	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> @@ -341,12 +626,58 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *devattr,
>   	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
>   }
> 
> +
> +#ifdef CONFIG_SENSORS_LM63_SETUP
> +/* Attributes for setting up the LM63's configuration, typically done by the
> + * BIOS.  */
> +
> +#define SENSOR_ATTR_PWM_AUTO_POINT_TEMP(n) \
> +	SENSOR_DEVICE_ATTR(pwm1_auto_point##n##_temp, S_IWUSR | S_IRUGO, \
> +		show_pwm_auto_point_temp, set_pwm_auto_point_temp, n-1)
> +#define SENSOR_ATTR_PWM_AUTO_POINT_PWM(n) \
> +	SENSOR_DEVICE_ATTR(pwm1_auto_point##n##_pwm, S_IWUSR | S_IRUGO, \
> +		show_pwm_auto_point_pwm, set_pwm_auto_point_pwm, n-1)
> +
> +SENSOR_ATTR_PWM_AUTO_POINT_TEMP(1);
> +SENSOR_ATTR_PWM_AUTO_POINT_TEMP(2);
> +SENSOR_ATTR_PWM_AUTO_POINT_TEMP(3);
> +SENSOR_ATTR_PWM_AUTO_POINT_TEMP(4);
> +SENSOR_ATTR_PWM_AUTO_POINT_TEMP(5);
> +SENSOR_ATTR_PWM_AUTO_POINT_TEMP(6);
> +SENSOR_ATTR_PWM_AUTO_POINT_TEMP(7);
> +SENSOR_ATTR_PWM_AUTO_POINT_TEMP(8);
> +
> +SENSOR_ATTR_PWM_AUTO_POINT_PWM(1);
> +SENSOR_ATTR_PWM_AUTO_POINT_PWM(2);
> +SENSOR_ATTR_PWM_AUTO_POINT_PWM(3);
> +SENSOR_ATTR_PWM_AUTO_POINT_PWM(4);
> +SENSOR_ATTR_PWM_AUTO_POINT_PWM(5);
> +SENSOR_ATTR_PWM_AUTO_POINT_PWM(6);
> +SENSOR_ATTR_PWM_AUTO_POINT_PWM(7);
> +SENSOR_ATTR_PWM_AUTO_POINT_PWM(8);

I don't see much value in having two separate macros for this. Just
have SENSOR_ATTR_PWM_AUTO_POINT() create pairs of files?

> +
> +static DEVICE_ATTR(pwm1_auto_hyst, S_IWUSR | S_IRUGO, show_pwm_auto_hyst,
> +	set_pwm_auto_hyst);
> +static DEVICE_ATTR(pwm1_polarity, S_IWUSR | S_IRUGO, show_pwm1_polarity,
> +	set_pwm1_polarity);
> +static DEVICE_ATTR(fan1_enable, S_IWUSR | S_IRUGO, show_fan1_enable,
> +	set_fan1_enable);
> +static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, show_pwm1_enable,
> +	set_pwm1_enable);
> +static DEVICE_ATTR(conv_rate, S_IWUSR | S_IRUGO, show_conv_rate,
> +	set_conv_rate);
> +static DEVICE_ATTR(pwm1_freq, S_IWUSR | S_IRUGO, show_pwm1_freq, set_pwm1_freq);
> +static SENSOR_DEVICE_ATTR(temp2_offset, S_IWUSR | S_IRUGO, show_temp11,
> +	set_temp11, 3);
> +#else
> +static DEVICE_ATTR(pwm1_enable, S_IRUGO, show_pwm1_enable, NULL);
> +#endif
> +
>   static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
>   static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan,
>   	set_fan, 1);
> 
>   static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm1, set_pwm1);
> -static DEVICE_ATTR(pwm1_enable, S_IRUGO, show_pwm1_enable, NULL);
> 
>   static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp8, NULL, 0);
>   static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp8,
> @@ -388,6 +719,30 @@ static struct attribute *lm63_attributes[] = {
>   	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
>   	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
>   	&dev_attr_alarms.attr,
> +#ifdef CONFIG_SENSORS_LM63_SETUP
> +	&dev_attr_pwm1_polarity.attr,
> +	&dev_attr_fan1_enable.attr,
> +	&dev_attr_conv_rate.attr,
> +	&dev_attr_pwm1_freq.attr,
> +	&dev_attr_pwm1_auto_hyst,
> +	&sensor_dev_attr_temp2_offset.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point6_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point7_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point8_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point4_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point6_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point7_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point8_pwm.dev_attr.attr,
> +#endif
>   	NULL
>   };
> 
> @@ -617,6 +972,12 @@ static struct lm63_data *lm63_update_device(struct device *dev)
>   				  LM63_REG_REMOTE_HIGH_MSB) << 8)
>   				| i2c_smbus_read_byte_data(client,
>   				  LM63_REG_REMOTE_HIGH_LSB);
> +#ifdef CONFIG_SENSORS_LM63_SETUP
> +		data->temp11[3] = (i2c_smbus_read_byte_data(client,
> +				  LM63_REG_REMOTE_OFFSET_MSB) << 8)
> +				| i2c_smbus_read_byte_data(client,
> +				  LM63_REG_REMOTE_OFFSET_LSB);
> +#endif
>   		data->temp8[2] = i2c_smbus_read_byte_data(client,
>   				 LM63_REG_REMOTE_TCRIT);
>   		data->temp2_crit_hyst = i2c_smbus_read_byte_data(client,

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
