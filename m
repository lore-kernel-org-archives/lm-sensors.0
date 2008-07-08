From: Ben Hutchings <bhutchings@solarflare.com>
Date: Tue, 08 Jul 2008 13:13:27 +0000
Subject: Re: [lm-sensors] [PATCH] max664x: New driver for Maxim
Message-Id: <20080708131325.GG28029@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080609111352.GC11300@solarflare.com>
In-Reply-To: <20080609111352.GC11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Ben,
> 
> On Mon, 9 Jun 2008 12:13:53 +0100, Ben Hutchings wrote:
> > 
> > Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
> > ---
> >  drivers/hwmon/Kconfig   |   10 ++
> >  drivers/hwmon/Makefile  |    1 +
> >  drivers/hwmon/max664x.c |  355 +++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/max664x.h |   92 ++++++++++++
> >  4 files changed, 458 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/hwmon/max664x.c
> >  create mode 100644 include/linux/max664x.h
> 
> First of all: please rename the driver to max6646. We don't use "x" in
> hwmon driver names, because this tends to get confusing: your driver
> doesn't support the MAX6640, MAX6641, etc. chips while the max664x
> "mask" suggests it would. So the rule is to pick the name of the first
> supported chip as the driver name.
> 
> Second preliminary note: these chips look suspiciously similar to the
> LM90, ADM1032 and MAX6657 chips which are supported by the lm90 driver.

You're right, it is very similar.

> Are you certain that you need a new driver for them? I've still
> reviewed your driver, but my feeling is that it may be less work for
> you to add support for the new chips to the lm90 driver, than to fix
> your new driver. As far as I can see the only significant difference is
> the encoding of the temperatures (signed vs. unsigned), and support for
> that kind of difference has been added to the lm90 driver a few weeks
> ago.

There are a few other differences:
- no remote offset
- no extended precision for remote limits
- extended precision for local temperature
- one-shot conversion and fault queue

But overall it looks similar enough that it would be easier to update lm90.

> You can look at my pending lm90 patches here:
>   http://jdelvare.pck.nerim.net/sensors/lm90/

I will do when I have the time.

> I also have parallel work to support new-style i2c devices with this
> driver (same as for the lm87 driver, this will be merged in 2.6.27-rc1):
>   http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/hwmon-lm90-convert-to-new-style.patch
> 
> Can you please also send me a dump of one of these chips? I keep a
> collection of hwmon chip dumps, it helps me when reviewing a driver or
> testing changes I make to the driver later on. You can take a dump of
> the chip using the i2c-dev driver and the i2cdump user-space tool, part
> of the i2c-tools package.

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 26 26 80 00 07 5a 00 5f 00 00 00 00 00 00 00 00    &&?.?Z._........
10: a0 60 60 60 60 60 60 60 00 7d 7d 7d 7d 7d 7d 7d    ?```````.}}}}}}}
20: 5a 0a 86 86 86 86 86 86 86 86 86 86 86 86 86 86    Z???????????????
30: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
40: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
50: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
60: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
70: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
80: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
90: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
a0: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
b0: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
c0: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
d0: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
e0: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
f0: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 4d 59    ??????????????MY

The only valid register addresses are 00-11, 19, 20-22, fe-ff.

[...]
> > +
> > +struct max664x_data {
> > +	struct device *hwmon_dev;
> > +	struct mutex update_lock;
> > +	int valid;
> > +	unsigned long last_updated; /* in jiffies */
> > +	struct max664x_settings set;
> > +	struct max664x_values val;
> > +};
> > +
> > +#define TEMP_FROM_REG(val) ((val) * 1000)
> > +#define TEMP_TO_REG(val) ((val) / 1000)
> 
> This lacks proper rounding.

So should this be
	#define TEMP_TO_REG(val) (((val) + 500) / 1000)
(or a similar expression in an inline function)?

> > +#define PERIOD_FROM_RATE_REG(val) (16000 >> min_t(int, val, 6))
> > +#define PERIOD_TO_RATE_REG(val) SENSORS_LIMIT(7 - ffs(val / 250), 0, 6)
> 
> Note that in general we try to move away from macros. Using (possibly
> inline) functions for these conversions is preferred, as it is more
> readable and lets the compiler do type checks. And less error-prone:
> your macros lack some parentheses.
 
Sorry, I was following the style I saw.

[...]
> > +static ssize_t show_temp_crit_hyst(struct device *dev,
> > +				   struct device_attribute *attr, char *buf)
> > +{
> > +	struct max664x_data *data = max664x_update_device(dev);
> > +	return sprintf(buf, "%u\n", TEMP_FROM_REG(data->set.temp_overt_hyst));
> > +}
> > +
> > +static ssize_t
> > +set_temp_crit_hyst(struct device *dev, struct device_attribute *attr,
> > +		   const char *buf, size_t count)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct max664x_data *data = i2c_get_clientdata(client);
> > +	long val = simple_strtol(buf, NULL, 10);
> > +	u8 reg_val = TEMP_TO_REG(val);
> > +
> > +	mutex_lock(&data->update_lock);
> > +	data->set.temp_overt_hyst = reg_val;
> > +	i2c_smbus_write_byte_data(client, MAX664X_REG_HYS, reg_val);
> > +	mutex_unlock(&data->update_lock);
> > +	return count;
> > +}
> 
> This violates the standard. All temperature values in sysfs should be
> absolute, not relative.

So how is hysteresis supposed to be shown?

[...]
> > +int max664x_read_status(struct i2c_client *client)
> > +{
> > +	return i2c_smbus_read_byte_data(client, MAX664X_REG_RSL);
> > +}
> > +EXPORT_SYMBOL(max664x_read_status);
> 
> I fail to see the point of making this separate from max6646_get_values
> (or whatever it ends up being called)?

Because it's read-clear.

[...]
> > +/* Status register */
> > +#define MAX664X_STATUS_IOT	(1 << 0)
> > +#define MAX664X_STATUS_EOT	(1 << 1)
> > +#define MAX664X_STATUS_FAULT	(1 << 2)
> > +#define MAX664X_STATUS_RLOW	(1 << 3)
> > +#define MAX664X_STATUS_RHIGH	(1 << 4)
> > +#define MAX664X_STATUS_LLOW	(1 << 5)
> > +#define MAX664X_STATUS_LHIGH	(1 << 6)
> > +#define MAX664X_STATUS_BUSY	(1 << 7)
> > +
> > +#define MAX664X_TEMP_INT	0
> > +#define MAX664X_TEMP_EXT	1
> 
> Nice defines... but not used in your driver.

They should be useful for clients.

> This raises the question
> of how useful they are. Not much IMHO, as each channel can be used for
> something different depending on how the chip is used.

I don't understand.  One temperature sensor is built into the chip
(local/internal) and the other must be added (remote/external).

[...]
> Note that I don't expect this API you just defined to live long. It's
> completely hardware-specific and will show up its limitations quickly as
> more drivers will offer similar interfaces, and I suspect the users
> will ask for some level of abstraction.  We have a nice, standard sysfs
> interface by now, so going back to hardware-specific definitions on the
> kernel side sounds pretty wrong.

The sysfs interface is great for generalised abstracted monitoring.  There
is no need to add that abstraction for kernel clients that support specific
boards, and I don't see what other use there would be for this in-kernel.

> That being said, I do not have the time to work on such a standard
> specification at the moment, nor do I think that it makes sense to
> specify anything until we have at least 3 drivers offering a similar
> interface and 3 users thereof. So I am fine with taking your API for
> now, as long as you realize that it is very likely temporary only.

OK.

I've taken your other comments on board and will look into merging with
lm90 at some point.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
