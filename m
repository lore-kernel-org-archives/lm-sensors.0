From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: fscpos driver
Message-Id: <20050104185338.3296d72d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stefan,

> I have finally completed what appears to be a fully working version of
> the fscpos driver (see attachment). I tried to obey the i2c coding
> policies as well as the kernel coding style guidelines.

See my comments inline.

> /*
>     fscpos.c - Part of lm_sensors, Linux kernel modules for hardware monitoring
>     Copyright (C) 2004, 2005 Stefan Ott <stefan@desire.ch>

Not part of lm_sensors anymore.

> /* fan 2  */
> /* min speed for fan2 not supported */

Say whether it's not supported by the chip or by the driver.

> /* temperature 0 */
> #define FSCPOS_REG_TEMP0_ACT		0x64
> #define FSCPOS_REG_TEMP0_STATE		0x71
> 
> /* temperature 1 */
> #define FSCPOS_REG_TEMP1_ACT		0x32
> #define FSCPOS_REG_TEMP1_STATE		0x81
> 
> /* temperature 2 */
> #define FSCPOS_REG_TEMP2_ACT		0x35
> #define FSCPOS_REG_TEMP2_STATE		0x91

You might want to define static arrays instead, e.g.:
static u8 FSCPOS_REG_TEMP_ACT[] = { 0x64, 0x32, 0x35 };
Same goes for the other register sets. I guess it would make some parts
of the code more simple. Maybe too late though.

> /* Revision */
> static ssize_t show_revision(struct device *dev, char *buf)
> {
> 	struct fscpos_data *data = fscpos_update_device(dev);
> 	return sprintf(buf, "%u\n", data->revision);
> }

Is there a real use for this? You could instead simply dev_info() it at
module load time.

> /* Temperature */
> #define TEMP_FROM_REG(val)	((val - 128) * 1000)

Extra parentheses around "val" please.

> #define TEMP_INDEX_FROM_NUM(nr)	((nr) - 1)

Hm, not a very useful one. Your code would be easier to read without
this macro IMHO.

> static ssize_t set_temp_status(struct i2c_client *client, struct fscpos_data
> 			*data, const char *buf,	size_t count, int nr, int reg)
> {
> 	/* bits 2..7 reserved, 0 read only => mask with 0x02 */
> 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x02;
> 	data->temp_status[TEMP_INDEX_FROM_NUM(nr)] &= ~v;
> 	
> 	fscpos_write_value(client, reg, v);
> 	return count;
> }

Hmm, isn't it odd that a "status" file can be written to? What are the
two bits for?

> 
> /* Fans */
> #define RPM_FROM_REG(val)	(val*60)

Extra parentheses here too, and spaces for consistency.

> #define FAN_INDEX_FROM_NUM(nr)	((nr) - 1)

Still not convinced ;)

> static ssize_t set_fan_status(struct i2c_client *client, struct fscpos_data
> 			*data, const char *buf,	size_t count, int nr, int reg)
> {
> 	/* bits 0..1, 3..7 reserved => mask with 0x04 */
> 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x04;
> 	data->fan_status[nr] &= ~v;
> 
> 	fscpos_write_value(client, reg, v);
> 	return count;
> }

Same comment as above, I don't get why this file would be writable.

> static ssize_t set_fan_min(struct i2c_client *client, struct fscpos_data *data,
> 				const char *buf, size_t count, int nr, int reg)
> {
> 	data->fan_min[FAN_INDEX_FROM_NUM(nr)] = simple_strtoul(buf, NULL, 10) &
> 									0xff;

That "& 0xff" sucks. What you really want to do is check the input
against a range of vality. Also, shouldn't the value be divided by 60?

> /* Volts */
> #define VOLT_FROM_REG(val,mult)	(val*mult/255)

Parentheses please.

> static ssize_t set_wdog_preset(struct i2c_client *client, struct fscpos_data
> 				*data, const char *buf,	size_t count, int reg)
> {
> 	data->watchdog[0] = simple_strtoul(buf, NULL, 10) & 0xff;

Don't mask, check the value for validity instead.

> /* Event */
> static ssize_t show_event(struct device *dev, char *buf)
> {
> 	/* bits 5..7 reserved => mask with 0x1f */
> 	struct fscpos_data *data = fscpos_update_device(dev);
> 	return sprintf(buf, "%u\n", data->global_event & 0x9b);
> }
> 
> /* Control */
> static ssize_t show_control(struct fscpos_data *data, char *buf)
> {
> 	/* bits 1..7 reserved => mask with 0x01 */
> 	return sprintf(buf, "%u\n", data->global_control & 0x01);
> }

What are these? Do you have a use for them?

> /*
>  * Sysfs stuff
>  */
> #define create_getter(kind, sub) \
> 	static ssize_t sysfs_show_##kind##sub(struct device *dev, char *buf);\

Hmm, that extra first line is redundant, isn't it?

> 	static ssize_t sysfs_show_##kind##sub(struct device *dev, char *buf) \
> 	{ \
> 		struct fscpos_data *data = fscpos_update_device(dev); \
> 		return show_##kind##sub(data, buf); \
> 	}
> 
> #define create_getter_n(kind, offset, sub) \
> 	static ssize_t sysfs_show_##kind##offset##sub(struct device *dev, char\
> 							 		*buf);\
> 	static ssize_t sysfs_show_##kind##offset##sub(struct device *dev, char\
> 								 	*buf) \
> 	{ \
> 		struct fscpos_data *data = fscpos_update_device(dev); \
> 		return show_##kind##sub(data, buf, (offset)); \
> 	}

I think that the parentheses around "offset" are not needed.

> #define create_setter_n(kind, offset, sub, reg) \
> 	static ssize_t sysfs_set_##kind##offset##sub (struct device *dev, \
> 					const char *buf, size_t count); \
> 	static ssize_t sysfs_set_##kind##offset##sub (struct device *dev, \
> 					const char *buf, size_t count) \
> 	{ \
> 		struct i2c_client *client = to_i2c_client(dev); \
> 		struct fscpos_data *data = i2c_get_clientdata(client); \
> 		return set_##kind##sub(client,data,buf,count,(offset),reg);\
> 	}

Same here.

> #define sysfs_fan(offset, reg_status, reg_ripple, reg_min) \
> 	sysfs_fan_nomin(offset, reg_status, reg_ripple) \
> 	sysfs_rw_n(fan, _min, offset, reg_min); \

Trailing "\" is not needed.

> #define sysfs_fan_nomin(offset, reg_status, reg_ripple) \
> 	sysfs_ro_n(fan, _input, offset); \
> 	sysfs_rw_n(fan, _status, offset, reg_status); \
> 	sysfs_rw_n(fan, _ripple, offset, reg_ripple); \

Same here. Also, wouldn't it make more sense to define them the other
way around?

> #define sysfs_watchdog(reg_wdog_preset, reg_wdog_state, reg_wdog_control) \
> 	sysfs_rw(wdog, _control, reg_wdog_control); \
> 	sysfs_rw(wdog, _preset, reg_wdog_preset); \
> 	sysfs_rw(wdog, _state, reg_wdog_state); \

Same here, trailing "\" not needed.

> int fscpos_detect(struct i2c_adapter *adapter, int address, int kind)
> {
> (...)
> 	const char *client_name = "";
> (...)
> 	client_name = "fscpos";
> (...)
> 	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);

You can even get rid of the variable altogether.

>       ERROR1:
> 	kfree(data);
>       ERROR0:
> 	return err;
> }

Please left-align the label. Also, prefered names would be exit: and
exit_free:.

> static int fscpos_detach_client(struct i2c_client *client)
> {
> 	int err;
> 
> 	if ((err = i2c_detach_client(client))) {
> 		dev_err(&client->dev, "fscpos.o: Client deregistration failed,"
> 						" client not detached.\n");

"fscpos.o" is redundant here, dev_err will write it for you.

> static int fscpos_read_value(struct i2c_client *client, u8 reg)
> {
> 	dev_dbg(&client->dev, "fscpos: read reg 0x%02x\n",reg);
> 	return i2c_smbus_read_byte_data(client, reg);
> }
> 
> static int fscpos_write_value(struct i2c_client *client, u8 reg, u8 value)
> {
> 	dev_dbg(&client->dev, "fscpos: write reg 0x%02x, val 0x%02x\n", reg,
> 									value);
> 	return i2c_smbus_write_byte_data(client, reg, value);
> }

Same here, dev_dbg prints the driver name for you.

> /* Called when we have found a new FSCPOS. It should set limits, etc. */

Correct that comment. The driver should *not* set the limits (and as a
matter of fact it doesn't set them).

> static void fscpos_init_client(struct i2c_client *client)
> {
> 	struct fscpos_data *data = i2c_get_clientdata(client);
> 
> 	/* read revision from chip */
> 	data->revision =  fscpos_read_value(client,FSCPOS_REG_REVISION);
> 	/* setup missing fan2_min value */
> 	data->fan_min[2] = 0xff;

But that value is then never read... so why even have a memory slot for
it?

> static struct fscpos_data *fscpos_update_device(struct device *dev)
> {
> (...)
>                 data->last_updated = jiffies;
>                 data->valid = 1;                 

Bogus indentation here (spaces instead of tabs).

Rest look fine to me! Please correct whatever needs be, then you send
your work to Greg KH in the form of a patch against the most recent 2.6
kernel. The patch must include updated to Makefile and Kconfig. Don't
forget to CC the sensors mailing-list.

Good work! :)

If you have fixes for the 2.4 driver, please send a patch to the sensors
mailing-list.

If libsensors needs to be updated to support your new driver, a patch
will be welcome as well.

-- 
Jean Delvare
http://khali.linux-fr.org/
