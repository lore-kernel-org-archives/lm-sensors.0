From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 27 Feb 2006 14:31:46 +0000
Subject: [lm-sensors] Hardware monitoring support for SMSC 47M192/47M997
Message-Id: <DvMvWsuE.1141050706.0849140.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0602270128360.3209@Laila>
In-Reply-To: <Pine.LNX.4.63.0602270128360.3209@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hallo Hartmut,

On 2006-02-27, Hartmut Rick wrote:
>  I've seen a few inquiries about temperature and voltage
> sensor support for the SMSC Super-I/O chips for 2.6 kernels,
> but there was no clear statement about who is actually working
> on that.
>
> While waiting for support, I tried to set up a driver myself,
> and finally managed to produce the attached file 'smsc47m192.c'.

Great. Here comes my review of your (rather good) code:

> /*
>     smsc47m192.c - Not yet Part of lm_sensors, Linux kernel modules for
>                    hardware monitoring

And will never be. Linux 2.6 drivers for hardware monitoring are, well,
linux drivers. lm_sensors is only the userspace part there, so your
driver cannot be said to be part of it.

> derived from lm78.c and other chip drivers of the lm_sensors package

Hopefully derived from the other Linux 2.6 drivers and not the ones in
the lm_sensors package ;)

> #include <asm/io.h>

I don't think you need this.

> #define SMSC47M192_REG_ALARM1 0x41
> #define SMSC47M192_REG_ALARM2 0x42
> 
> #define SMSC47M192_REG_VID 0x47
> #define SMSC47M192_REG_VID4 0x49
> 
> #define SMSC47M192_REG_CONFIG 0x40
> #define SMSC47M192_REG_COMPANY_ID 0x3e
> #define SMSC47M192_REG_VERSION 0x3f

You may want to align the values (using tabs, not spaces) for improved
readability.

> /* generalised scaling with integer rounding */
> static inline int SCALE(long val, int mul, int div)
> {
>         if (val < 0)
>                 return (val * mul - div / 2) / div;
>         else
>                 return (val * mul + div / 2) / div;
> }

You are using spaces for indentation here, which is prohibited. Please
convert to tabs, here and wherever else in your code you used spaces for
indentation.

Also, typo: generaliZed.

> /* TEMP: mC (-128C to +127C)
>    REG: 1C/bit, two's complement */
> static inline s8 TEMP_TO_REG(int val)
> {
> 	int nval = SENSORS_LIMIT(val, -128000, 127000) ;
> 	return nval<0 ? (nval-500)/1000 : (nval+500)/1000;
> }

Suggestion: maybe you can use SCALE() here?

> /* For each registered SMSC47M192, we need to keep some data in memory.
>    That data is pointed to by smsc47m192_list[NR]->data. The structure
>    itself is dynamically allocated, at the same time when a new smsc47m192
>    client is allocated. */

This is a very old comment which has been copied from driver to driver
and does no more reflect the way these drivers work. Please drop.

> static struct i2c_driver smsc47m192_driver = {
> 	.owner		= THIS_MODULE,
> 	.name		= "smsc47m192",
> 	.id		= I2C_DRIVERID_SMSC47M192,

You don't need this ID, so you can simply omit it.

> 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr],nr));

Usual coding style suggests space after comma. Please fix everywhere is
needed.

> #define show_in_offset(offset)					\
> static ssize_t							\
> 	show_in##offset (struct device *dev,				\
> 			struct device_attribute *attr, char *buf)	\
> {								\
> 	return show_in(dev, buf, offset);				\
> }								\

This is the old way to do it. New drivers should use a different
approach, known as dynamic sysfs attributes, which makes it possible to
get rid of these macros and makes the drivers much smaller. Please look
at the it87 driver for an example. Basically, the new approach lets you
attach an integer value to each sysfs file you create, and you can then
retrieve and use this integer value in the sysfs callback functions.
This makes it possible to use the same callback for all 8 voltage
readings, for example.

Same holds for the temperatures channels, of course.

> static ssize_t show_temp_offset(struct device *dev, char *buf, int nr)
> {
> 	struct smsc47m192_data *data = smsc47m192_update_device(dev);
> 	return sprintf(buf, "%d\n",
>                       TEMP_FROM_REG(data->temp_offset[nr>>1]));
> }

We try to avoid that kind of trick in the kernel code. The bit shift
operation happens to work here but it's really not obvious to the
reader why. I'd much prefer an explicit "nr = 1 ? 1 : 3". Or, even
better, define 3 slots in your data structure, and leave the second one
unused. The extra byte used really isn't a problem and it'll make the
code faster and more readable. If you do that you'll have to edit
SMSC47M192_REG_TEMP_OFFSET(nr) though.

> /* Alarms */
> static ssize_t show_alarms(struct device *dev, struct device_attribute
>                            *attr, char *buf)
> {
> 	struct smsc47m192_data *data = smsc47m192_update_device(dev);
> 	return sprintf(buf, "%u\n", data->alarms);
> }
> static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);

For newer designs, we try to have one sysfs file per alarm type (here,
one for voltages and one for temperatures) with bits sorted for
userspace. That way userspace doesn't need to know about the chip
internals. Can you try to do that in your driver? You'd have one
alarms_in file and one alarms_temp file.

> static int smsc47m192_detect(struct i2c_adapter *adapter, int address, int
>                              kind)
> {
> 	struct i2c_client *new_client;

Please name it client rather than new_client to make the following code
more readable (other drivers could be "fixed" the same way.)

> 	struct smsc47m192_data *data;
> 	int err=0;

Spaces around equals sign please (same problem in other places.)

> 	new_client->flags = 0;

Not needed thanks to the kzalloc right before (other drivers need fixing
for this too.)

> 	if (	i2c_smbus_read_byte_data(new_client,
> 				SMSC47M192_REG_COMPANY_ID) = 0x55
> 		&& ((version=i2c_smbus_read_byte_data(new_client,
> 				SMSC47M192_REG_VERSION)) & 0xf0) = 0x20
> 		&& (i2c_smbus_read_byte_data(new_client,
> 				SMSC47M192_REG_VID) & 0x70) = 0x00
> 		&& (i2c_smbus_read_byte_data(new_client,
> 				SMSC47M192_REG_VID4) & 0xfe) = 0x80
> 	) {

Weird coding style :(

> 		dev_info(&adapter->dev,"found SMSC47M192 or SMSC47M997,"
> 			" version 2, stepping A%d\n",version&0x0f);

Coding style: space after comma (twice). Also, when splitting strings,
please place the middle space at the end of the first half rather than
the beginning of the second half (makes it easier to spot missing
spaces.)

> 	data->valid = 0;

Not needed either.

> 	data->vrm = 90;

Please use CPU-based detection (function is called vid_which_vrm) instead.

> ERROR3:
> 	i2c_detach_client(new_client);
> ERROR2:
> 	kfree(data);
> ERROR0:
> 	return err;
> }

Please rename these labels to something more explicit (exit_free etc.).

> static int __init sm_smsc47m192_init(void)
> {
> 	int res;
> 
> 	res = i2c_add_driver(&smsc47m192_driver);
> 	if (res)
> 		return res;
> 
> 	return 0;
> }

Can be simplified to:

static int __init smsc47m192_init(void)
{
	return i2c_add_driver(&smsc47m192_driver);
}

Also please drop the "sm_" prefix, which is a legacy of the past (I
don't even have an idea what it's supposed to mean.)

Good code overall, good work :) Please address all the minor issues I
have pointed out and if possible do the changes I suggested, and post
your work again (after some testing) as a patch, so that we can
integrate your work into the kernel quickly.

Thanks,
--
Jean Delvare

