From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Jan 2008 15:45:48 +0000
Subject: Re: [lm-sensors] [RFC,
Message-Id: <20080110164548.0f0f22b5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Herbert,

Sorry for the late answer, I was very busy in late December, and then I
took two weeks of vacation.

On Mon, 17 Dec 2007 10:36:44 +0100, Herbert Valerio Riedel wrote:
> On Sun, 2007-11-25 at 18:47 +0100, Jean Delvare wrote:
> > fan1_div is only indirectly related to the number of pulse per
> > revolutions emitted by the fan. Please read:
> > http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/fan-divisors
> 
> I found the description to be a bit misleading btw:
> 
> 
>         So changing the fan divisor will NOT change the nominal RPM
>         reading, it will only affect the minimum and maximum readings
>         and the accuracy of the readings.
>         ...
>         The actual formula is RPM = (60 * 22500) / (count * divisor)
>         
> 
> ...to me it seems, that changing 'divisor' does change the 'RPM' value
> (if 'count' stays the same)... :-)

The idea is precisely that count does _not_ stay the same. When you
change the divisor register value, the chip changes the way it measures
the fan speed and as a result the count register value will change.

> however, I've tried to incorporate your comments (the way I understood
> them :-), see below

Here's my review:

> This controller can be found on the D-Link DNS-323 for instance,
> where it is to be configured via static i2c_board_info in the
> board-specific mach-orion/dns323-setup.c; this driver supports only
> the new-style driver model.
> 
> Signed-off-by: Herbert Valerio Riedel <hvr@gnu.org>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
>  Documentation/hwmon/g760a |   39 ++++++
>  drivers/hwmon/Kconfig     |   10 ++
>  drivers/hwmon/Makefile    |    1 +
>  drivers/hwmon/g760a.c     |  296 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 346 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/g760a
>  create mode 100644 drivers/hwmon/g760a.c
> 
> diff --git a/Documentation/hwmon/g760a b/Documentation/hwmon/g760a
> new file mode 100644
> index 0000000..3aa700a
> --- /dev/null
> +++ b/Documentation/hwmon/g760a
> @@ -0,0 +1,39 @@
> +Kernel driver g760a
> +=========> +
> +Supported chips:
> +  * Global Mixed-mode Technology Inc. G760A
> +    Prefix: 'g760a'
> +    Datasheet: Publicly available at the GMT website
> +      http://www.gmt.com.tw/datasheet/g760a.pdf
> +
> +Author: Herbert Valerio Riedel <hvr@gnu.org>
> +
> +Description
> +-----------
> +
> +The GMT G760A Fan Speed PWM Controller is connected directly to a fan
> +and performs closed-loop control of the fan speed.
> +
> +The fan speed is programmed by setting the desired target speed via
> +`fan1_target` in rpm which is rounded up to the next supported rpm value;

Please avoid mixing regular single quotes and backquotes in the same
document.

RPM

> +a rpm value of -1 requests the maximum speed (i.e. pwm duty cycle of 100%).

I don't think that you want to do that. It's not very intuitive and not
part of our standard interface either. If the user wants the max speed,
he/she can write an arbitrarily high RPM value (e.g. 10000) and the
driver will pick the higher possible value.

> +For convenience it's also possible to programm the controller via `pwm1`
> +(setting pwm1 to 0 stops the fan; 255 sets fan to maximum speed), which still 
> +performs closed-loop control.

That's indeed convenient, although it could also be a bit confusing.
But as long as the pwmconfig and fancontrol scripts cannot deal with
closed-loop control mode, I admit that having the pwm1 file will be
very handy. That's one more reason to not implement -1 as a special
value for fan1_target: the same effect can be achieved in a standard
manner by writing 255 to pwm1.

> +
> +The measured fan rotation speed returned via 'fan1_input' is derived
> +from the measured speed pulse period by assuming again a 32kHz clock
> +source and a N=2 pulse-per-revolution fan via the the formula
> +rpm = (clk * 30)/(clk_counts * N). `fan1_min` contains the lowest possible
> +rpm value that can be reported by the controller.

It might be worth documenting that fan1_min is read-only. Other chips
implement the fan minimum as a changeable value, the user might be
surprised.

> +
> +The 'fan1_alarm' file provides access to the alarm bit provided by
> +the G760A chip's status register: Its value is 1 when the actual fan

its

> +speed differs more than 20% with respect to the programmed fan speed; 
> +otherwise 0.

That's not correct as it doesn't match the standard sysfs interface.
fan1_alarm should be raised when fan1_input is less than fan1_min, that
is, it corresponds to G760A_REG_FAN_STA_RPM_LOW, not
G760A_REG_FAN_STA_RPM_OFF.

For G760A_REG_FAN_STA_RPM_OFF, we do not yet have a standard sysfs file
name, but "fan1_target_alarm" would probably do. Feel tree to implement
this and document it in sysfs-interface.

> + 
> +The g760a driver will not update its reported values more frequently
> +than every second; reading them more often will do no harm, but will return
> +'old' values.
> +
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a0445be..6ce8c12 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -291,6 +291,16 @@ config SENSORS_FSCHMD
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called fschmd.
>  
> +config SENSORS_G760A
> +	tristate "GMT G760A"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Global Mixed-mode
> +	  Technology Inc G760A fan speed pwm controller chips.

PWM

> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called g760a.
> +
>  config SENSORS_GL518SM
>  	tristate "Genesys Logic GL518SM"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 55595f6..93d78a8 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_SENSORS_F75375S)	+= f75375s.o
>  obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
>  obj-$(CONFIG_SENSORS_FSCHMD)	+= fschmd.o
>  obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o
> +obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
>  obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
>  obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
> diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
> new file mode 100644
> index 0000000..4bc5a7e
> --- /dev/null
> +++ b/drivers/hwmon/g760a.c
> @@ -0,0 +1,296 @@
> +/*
> +    g760a - Driver for the Global Mixed-mode Technology Inc. G760A
> +	    fan speed PWM controller chip
> +
> +    Copyright (C) 2007  Herbert Valerio Riedel <hvr@gnu.org>
> +
> +    Complete datasheet is available at GMT's website:
> +      http://www.gmt.com.tw/datasheet/g760a.pdf
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; either version 2 of the License, or
> +    (at your option) any later version.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/sysfs.h>
> +
> +enum g760a_regs {
> +	G760A_REG_SET_CNT = 0x00,
> +	G760A_REG_ACT_CNT = 0x01,
> +	G760A_REG_FAN_STA = 0x02
> +};
> +
> +#define G760A_REG_FAN_STA_RPM_OFF 0x1 /* >+-20% off */

"> +/-20% off" would be more readable.

> +#define G760A_REG_FAN_STA_RPM_LOW 0x2 /* below fan1_min */
> +
> +/* register data is read (and cached) at most once per second */
> +#define G760A_UPDATE_INTERVAL (HZ)
> +
> +struct g760a_data {
> +	struct i2c_client *client;
> +	struct device *hwmon_dev;
> +	struct mutex update_lock;
> +
> +	/* g760a register cache */
> +	int valid:1;
> +	unsigned long last_updated; /* In jiffies */
> +
> +	u8 set_cnt; /* closed loop count number; 0xff stops fan	*/
> +	u8 act_cnt; /*   formula: cnt = (CLK * 30)/(rpm * P) */
> +	u8 fan_sta; /* bit 0: set when actual fan speed more than %20

20%

> +		     *   outside requested fan speed
> +		     * bit 1: set when fan speed causes counter overflow
> +		     */
> +};
> +
> +#define G760A_DEFAULT_CLK 32768
> +#define G760A_DEFAULT_FAN_DIV 1

That's pretty confusing, even if the computation is right in the end.
The default fan div is 2 not 1!

> +#define G760A_DEFAULT_FAN_MIN g760a_rpm_from_reg(0xff)
> +
> +static inline int g760a_rpm_from_reg(unsigned regval)
> +{
> +	if (!regval)
> +		return -1;
> +	return (G760A_DEFAULT_CLK*15)/(regval*G760A_DEFAULT_FAN_DIV);
> +}
> +
> +static inline u8 g760a_rpm_to_reg(unsigned rpm)

unsigned long

> +{
> +	unsigned regval;
> +
> +	if (!rpm)
> +		return 0xff; /* turn off */
> +	regval = (G760A_DEFAULT_CLK*15)/(rpm*G760A_DEFAULT_FAN_DIV);
> +	return SENSORS_LIMIT(regval, 0x00, 0xfe);

0x00 does not correspond to a valid speed, so that would rather be:
	return SENSORS_LIMIT(regval, 0x01, 0xfe);

> +}
> +
> +#define PWM_FROM_CNT(cnt)	(0xff-(cnt))
> +#define PWM_TO_CNT(pwm)		(0xff-(pwm))
> +
> +/****************************************************************************
> + * sysfs attributes
> + */
> +
> +static struct g760a_data *g760a_update_client(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g760a_data *data = i2c_get_clientdata(client);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->last_updated + G760A_UPDATE_INTERVAL)
> +	    || !data->valid) {
> +		dev_dbg(&client->dev, "Starting g760a update\n");
> +
> +		data->set_cnt = i2c_smbus_read_byte_data(client,
> +							 G760A_REG_SET_CNT);
> +		data->act_cnt = i2c_smbus_read_byte_data(client,
> +							 G760A_REG_ACT_CNT);
> +		data->fan_sta = i2c_smbus_read_byte_data(client,
> +							 G760A_REG_FAN_STA);
> +
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return data;
> +}
> +
> +static ssize_t show_fan_input(struct device *dev, struct device_attribute *da,
> +			      char *buf)
> +{
> +	struct g760a_data *data = g760a_update_client(dev);
> +	int rpm = 0;
> +
> +	mutex_lock(&data->update_lock);
> +	if (!(data->fan_sta & G760A_REG_FAN_STA_RPM_LOW))
> +		rpm = g760a_rpm_from_reg(data->act_cnt);
> +	mutex_unlock(&data->update_lock);
> +
> +	return sprintf(buf, "%d\n", rpm);
> +}
> +
> +static ssize_t show_fan_target(struct device *dev, struct device_attribute *da,
> +			       char *buf)
> +{
> +	struct g760a_data *data = g760a_update_client(dev);
> +	int rpm = 0;

Useless initialization.

> +
> +	mutex_lock(&data->update_lock);
> +	rpm = (0xff = data->set_cnt) ? 0 : g760a_rpm_from_reg(data->set_cnt);
> +	mutex_unlock(&data->update_lock);
> +
> +	return sprintf(buf, "%d\n", rpm);
> +}
> +
> +static ssize_t set_fan_target(struct device *dev, struct device_attribute *da,
> +			      const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g760a_data *data = i2c_get_clientdata(client);
> +
> +	const long val = simple_strtol(buf, NULL, 10);

unsigned long and simple_strtoul().

> +
> +	mutex_lock(&data->update_lock);
> +	data->set_cnt = g760a_rpm_to_reg(val);
> +	i2c_smbus_write_byte_data(client, G760A_REG_SET_CNT, data->set_cnt);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_fan_alarm(struct device *dev, struct device_attribute *da,
> +			      char *buf)
> +{
> +	struct g760a_data *data = g760a_update_client(dev);
> +
> +	int fan_alarm = (data->fan_sta & G760A_REG_FAN_STA_RPM_OFF) ? 1 : 0;
> +
> +	return sprintf(buf, "%d\n", fan_alarm);
> +}
> +
> +static ssize_t show_fan_min(struct device *dev, struct device_attribute *da,
> +			    char *buf)
> +{
> +	return sprintf(buf, "%d\n", G760A_DEFAULT_FAN_MIN);
> +}
> +
> +
> +static ssize_t show_pwm(struct device *dev, struct device_attribute *da,
> +			char *buf)
> +{
> +	struct g760a_data *data = g760a_update_client(dev);
> +
> +	return sprintf(buf, "%d\n", PWM_FROM_CNT(data->set_cnt));
> +}
> +
> +static ssize_t set_pwm(struct device *dev, struct device_attribute *da,
> +		       const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g760a_data *data = i2c_get_clientdata(client);
> +
> +	const long val = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +	data->set_cnt = PWM_TO_CNT(SENSORS_LIMIT(val, 0, 255));
> +	i2c_smbus_write_byte_data(client, G760A_REG_SET_CNT, data->set_cnt);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm);
> +static DEVICE_ATTR(fan1_target, S_IWUSR | S_IRUGO, show_fan_target,
> +		   set_fan_target);
> +static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input, NULL);
> +static DEVICE_ATTR(fan1_min, S_IRUGO, show_fan_min, NULL);
> +static DEVICE_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL);
> +
> +static struct attribute *g760a_attributes[] = {
> +	&dev_attr_pwm1.attr,
> +	&dev_attr_fan1_target.attr,
> +	&dev_attr_fan1_input.attr,
> +	&dev_attr_fan1_min.attr,
> +	&dev_attr_fan1_alarm.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group g760a_group = {
> +	.attrs = g760a_attributes,
> +};
> +
> +/****************************************************************************
> + * new-style driver model code
> + */
> +
> +static int g760a_probe(struct i2c_client *client)
> +{
> +	struct g760a_data *data;
> +	int err;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EIO;
> +
> +	data = kzalloc(sizeof(struct g760a_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, data);
> +
> +	data->client = client;
> +	mutex_init(&data->update_lock);
> +
> +	/* Register sysfs hooks */
> +	err = sysfs_create_group(&client->dev.kobj, &g760a_group);
> +	if (err)
> +		goto error_sysfs_create_group;
> +
> +	data->hwmon_dev = hwmon_device_register(&client->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		err = PTR_ERR(data->hwmon_dev);
> +		goto error_hwmon_device_register;
> +	}
> +
> +	return 0;
> +
> +error_hwmon_device_register:
> +	sysfs_remove_group(&client->dev.kobj, &g760a_group);
> +error_sysfs_create_group:
> +	kfree(data);
> +	i2c_set_clientdata(client, NULL);
> +
> +	return err;
> +}
> +
> +static int g760a_remove(struct i2c_client *client)
> +{
> +	struct g760a_data *data = i2c_get_clientdata(client);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&client->dev.kobj, &g760a_group);
> +	kfree(data);
> +	i2c_set_clientdata(client, NULL);
> +
> +	return 0;
> +}
> +
> +static struct i2c_driver g760a_driver = {
> +	.driver = {
> +		.name	= "g760a",
> +	},
> +	.probe	= g760a_probe,
> +	.remove	= g760a_remove,
> +};
> +
> +/* module management */
> +
> +static int __init g760a_init(void)
> +{
> +	return i2c_add_driver(&g760a_driver);
> +}
> +
> +static void __exit g760a_exit(void)
> +{
> +	i2c_del_driver(&g760a_driver);
> +}
> +
> +MODULE_AUTHOR("Herbert Valerio Riedel <hvr@gnu.org>");
> +MODULE_DESCRIPTION("GMT G760A driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(g760a_init);
> +module_exit(g760a_exit);

All the rest looks fine to me now. Please send an updated version and
I'll ack it. I invite you to test your driver with lm-sensors 3.0, if
your sysfs interface is correct it should work well.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
