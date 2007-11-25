From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 25 Nov 2007 17:47:26 +0000
Subject: Re: [lm-sensors] [RFC,
Message-Id: <20071125184726.484f12db@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1195932344-15551-1-git-send-email-hvr@gnu.org>
In-Reply-To: <1195932344-15551-1-git-send-email-hvr@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Herbert,

On Sat, 24 Nov 2007 20:25:44 +0100, Herbert Valerio Riedel wrote:
> This controller can be found on the D-Link DNS-323 for instance,
> where it is to be configured via static i2c_board_info in the
> board-specific mach-orion/dns323-setup.c; this driver supports only
> the new-style driver model.
> 
> Signed-off-by: Herbert Valerio Riedel <hvr@gnu.org>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
> wrt to the previous g760a patch, this one is significantly smaller, since I
> removed all legacy code; I also changed the pwm1 sysfs file to reflect the 
> convention of 0x00 being lowest  and 0xff being maximum fanspeed;
> 
> in the code I assume somehow a kind of fan-divider of 2 pulses per rotation;

That's OK, all our drivers do that.

> as that is the case on the dns323, and as the g760a has no "fan1_div" register
> in hardware, I didn't implement a virtual fan1_div sysfs object either...

fan1_div is only indirectly related to the number of pulse per
revolutions emitted by the fan. Please read:
http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/fan-divisors

> 
>  Documentation/hwmon/g760a |   37 +++++++
>  drivers/hwmon/Kconfig     |   10 ++
>  drivers/hwmon/Makefile    |    1 +
>  drivers/hwmon/g760a.c     |  260 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 308 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/g760a
>  create mode 100644 drivers/hwmon/g760a.c
> 
> diff --git a/Documentation/hwmon/g760a b/Documentation/hwmon/g760a
> new file mode 100644
> index 0000000..d3f32a5
> --- /dev/null
> +++ b/Documentation/hwmon/g760a
> @@ -0,0 +1,37 @@
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
> +The fan speed is programmed by setting the period via 'pwm1' of two
> +consecutive speed pulses. The period is defined in terms of clock
> +cycle counts of an assumed 32kHz clock source.
> +
> +Setting a period of 0 stops the fan; setting the period to 255 sets
> +fan to maximum speed.
> +
> +The measured fan rotation speed returned via 'fan1_input' is derived
> +from the measured speed pulse period by assuming again a 32kHz clock
> +source and a 2 pulse-per-revolution fan.
> +
> +The 'alarms' file provides access to the two alarm bits provided by
> +the G760A chip's status register: Bit 0 is set when the actual fan
> +speed differs more than 20% with respect to the programmed fan speed;
> +bit 1 is set when fan speed is below 1920 rpm.

This doesn't match the code (and the code is right).

Note that I think that the documentation is a bit misleading about the
conditions in which bit 1 of the alarm register is set. The chip itself
has no idea about the actual fan speed, all it knows is a number of
clock cycles per half-revolution. For a 32 kHz clock, the max register
value (255) corresponds to 1920 RPMs, but for a different clock, the
limit would be different. What the chip really report is the register
overflow, not a specific speed limit.

I invite you to export the speed limit to user-space as fan1_min
(read-only), otherwise the user might wonder what the alarm flag
corresponds to.

> + 
> +The g760a driver will not update its values more frequently than every
> +other second; reading them more often will do no harm, but will return
> +'old' values.

This doesn't match the code, which lets the user update the values every
second (and quite rightly so.)

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
> index 0000000..dc503c4
> --- /dev/null
> +++ b/drivers/hwmon/g760a.c
> @@ -0,0 +1,260 @@
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

Please add a trailing comma at the end of the last line. Rationale:
this minimizes the changes when more values need to be added later.

> +};
> +
> +#define G760A_REG_FAN_STA_RPM_OFF 0x1 /* 20% off */
> +#define G760A_REG_FAN_STA_RPM_LOW 0x2 /* below 1920rpm */
> +
> +/* register data is read (and cached) at most once per second */
> +#define G760A_UPDATE_INTERVAL (HZ)
> +
> +struct g760a_data {
> +	struct i2c_client *client;
> +	struct device *hwmon_dev;
> +	struct mutex update_lock;
> +
> +	/* board specific parameters */
> +	u32 clk; /* default 32kHz */
> +	u16 fan_div; /* default P=2 */
> +
> +	/* g760a register cache */
> +	int valid:1;
> +	unsigned long last_updated; /* In jiffies */
> +
> +	u8 set_cnt; /* PWM (period) count number; 0xff stops fan	*/
> +	u8 act_cnt; /*   formula: cnt = (CLK * 30)/(rpm * P)		*/
> +	u8 fan_sta; /* bit 0: set when actual fan speed more than %20
> +		     *   outside requested fan speed
> +		     * bit 1: set when fan speed below 1920 rpm		*/
> +};
> +
> +#define G760A_DEFAULT_CLK 32768
> +#define G760A_DEFAULT_FAN_DIV 2
> +
> +#define RPM_FROM_REG(val, clk, div) \
> +	((0x00 = (val)) ? 0 : (((clk)*30)/((val)*(div))))

I suggest using an inline function instead. Macros evaluating their
parameters more than once can be tricky.

> +
> +#define PWM_FROM_CNT(cnt)	(0xff-(cnt))
> +#define PWM_TO_CNT(pwm)		(0xff-(pwm))
> +
> +/* new-style driver model */
> +static int g760a_probe(struct i2c_client *client);
> +static int g760a_remove(struct i2c_client *client);
> +
> +static struct i2c_driver g760a_driver = {
> +	.driver = {
> +		.name	= "g760a",
> +	},
> +	.probe	= g760a_probe,
> +	.remove	= g760a_remove,
> +};

You could also move this driver declaration to the end of the file, so
that you don't need to forward-declare g760a_probe and g760a_remove.

> +
> +/* read/write wrappers */
> +static int g760a_read_value(struct i2c_client *client, enum g760a_regs reg)
> +{
> +	return i2c_smbus_read_byte_data(client, reg);
> +}
> +
> +static int g760a_write_value(struct i2c_client *client, enum g760a_regs reg,
> +			     u16 value)
> +{
> +	return i2c_smbus_write_byte_data(client, reg, value);
> +}

I can't see any value to these wrappers. Why don't you call
i2c_smbus_read_byte_data and i2c_smbus_write_byte_data directly?

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
> +		data->set_cnt = g760a_read_value(client, G760A_REG_SET_CNT);
> +		data->act_cnt = g760a_read_value(client, G760A_REG_ACT_CNT);
> +		data->fan_sta = g760a_read_value(client, G760A_REG_FAN_STA);
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
> +static ssize_t show_fan(struct device *dev, struct device_attribute *da,
> +			char *buf)
> +{
> +	struct g760a_data *data = g760a_update_client(dev);
> +	int rpm = 0;
> +
> +	mutex_lock(&data->update_lock);
> +	if (!(data->fan_sta & G760A_REG_FAN_STA_RPM_LOW))
> +		rpm = RPM_FROM_REG(data->act_cnt, data->clk, data->fan_div);
> +	mutex_unlock(&data->update_lock);
> +
> +	return sprintf(buf, "%d\n", rpm);
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
> +static ssize_t get_pwm(struct device *dev, struct device_attribute *da,
> +		       char *buf)
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
> +	struct g760a_data *data = g760a_update_client(dev);

No need to call g760a_update_client() for an attribute write,
i2c_get_clientdata() is enough.

> +
> +	const long val = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +	data->set_cnt = PWM_TO_CNT(SENSORS_LIMIT(val, 0, 255));
> +	g760a_write_value(client, G760A_REG_SET_CNT, data->set_cnt);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}

What your driver (and this chip) implements is NOT pwm1. pwm1 would be
expressing a "raw" PWM duty cycle, while what the chip does is
closed-loop fan control. This is more powerful. In our standard
interface, this corresponds to fan1_target. This is also more
user-friendly, as the fan1_target value is expressed directly in RPM.

> +
> +static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
> +static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL);
> +static DEVICE_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL);
> +
> +static struct attribute *g760a_attributes[] = {
> +	&dev_attr_pwm1.attr,
> +	&dev_attr_fan1_input.attr,
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
> +	/* setup default configuration for now */
> +	data->fan_div = G760A_DEFAULT_FAN_DIV;
> +	data->clk = G760A_DEFAULT_CLK;
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

The rest of the code looks alright to me. Pretty impressive for a first
contribution. Well done!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
