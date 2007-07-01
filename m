From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 01 Jul 2007 18:50:03 +0000
Subject: Re: [lm-sensors] THMC50 and ADM1022 support for 2.6 kernel
Message-Id: <20070701205003.71ae723b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark, hi Krzysztof,

A couple comments on top of what Mark already said:

On Sun, 1 Jul 2007 10:03:25 -0400, Mark M. Hoffman wrote:
> * Krzysztof Helt <krzysztof.h1@wp.pl> [2007-06-25 17:02:10 +0200]:
> > diff -urNp linux-2.6.21/Documentation/hwmon/thmc50 linux-2.6.22/Documentation/hwmon/thmc50
> > --- linux-2.6.21/Documentation/hwmon/thmc50	1970-01-01 01:00:00.000000000 +0100
> > +++ linux-2.6.22/Documentation/hwmon/thmc50	2007-06-24 22:22:56.852806945 +0200
> > @@ -0,0 +1,82 @@
> > +Kernel driver `thmc50.o'
> > +==========
Please check the other driver documentation files under
Documentation/hwmon for the correct header style.

> > +
> > +Status: Complete and some-what tested

We no longer document the status in documentation files. It gets out of
date too easily, and non-working drivers don't go into the kernel tree
anyway.

> > +
> > +Supported chips: 
> > +  * Analog Devices ADM1022
> > +    Prefix: 'adm1022'
> > +    Addresses scanned: I2C 0x2D - 0x2F
> > +    Datasheet: Publicly available at the Analog Devices website
> 
> Please provide a link, if possible.
> 
> > +  * Texas Instruments THMC50
> > +    Prefix: 'thmc50'
> > +    Addresses scanned: I2C 0x2D - 0x2F
> > +    Datasheet: Publicly available at the Texas Instruments' website
> 
> Ditto.

These address ranges don't match what the driver actually does.

> > diff -urNp linux-2.6.21/drivers/hwmon/thmc50.c linux-2.6.22/drivers/hwmon/thmc50.c
> > --- linux-2.6.21/drivers/hwmon/thmc50.c	1970-01-01 01:00:00.000000000 +0100
> > +++ linux-2.6.22/drivers/hwmon/thmc50.c	2007-06-24 22:22:56.852806945 +0200
> > @@ -0,0 +1,438 @@
> (...)
> > +/*
> > +/* Conversions. Rounding and limit checking is only done on the TO_REG

Comment is started twice.

> > +   variants. Note that you should be a bit careful with which arguments
> > +   these macros are called: arguments may be evaluated more than once.
> > +   Fixing this is just not worth it. */

Fixing it is actually very worth it, and I suggest that you turn these
macros into inline functions.

> > +#define TEMP_FROM_REG(val) ((val>127)?(val - 0x0100)*1000:val*1000)
> > +#define TEMP_TO_REG(val)   ((val<0)?0x0100+val/1000:val/1000)

Note that using signed variables would save you these ugly 0x100
offsets. See the lm90 driver for an example.

> > +
> > +/* Each client has this additional data */
> > +struct thmc50_data {
> > +	struct i2c_client client;
> > +	struct class_device *class_dev;
> > +
> > +	struct mutex update_lock;
> > +	char valid;		/* !=0 if following fields are valid */
> > +	enum chips type;
> > +	unsigned long last_updated;	/* In jiffies */
> > +
> > +	/* Register values */
> > +	u16 temp_input;
> > +	u16 temp_max;
> > +	u16 temp_hyst;
> > +	u16 remote_temp_input;
> > +	u16 remote_temp_max;
> > +	u16 remote_temp_hyst;
> > +	u16 remote_temp2_input;
> > +	u16 remote_temp2_max;
> > +	u16 remote_temp2_hyst;
> > +	u16 analog_out;
> > +	u16 config_reg;
> > +};

What's the point of using 16-bit members to store only 8-bit register
values?

> > +/* This is the driver that will be inserted */

This is a not very interesting comment ;)

> > +static struct i2c_driver thmc50_driver = {
> > +	.driver = {
> > +		.name		= "THMC50 sensor chip driver",
> 
> Should be one word, lowercase... "thmc50".
> 
> > +	},
> > +	.id		= I2C_DRIVERID_THMC50,

These IDs are unused and will be deleted someday, so you might as well
not define it.

> > +	.attach_adapter	= thmc50_attach_adapter,
> > +	.detach_client	= thmc50_detach_client,
> > +};

> > +/* This function is called by i2c_detect */

Unlikely, given that i2c_detect() no longer exists.

> > +int thmc50_detect(struct i2c_adapter *adapter, int address, int kind)
> > +{
> > +	int company;
> > +	int revision;
> > +	struct i2c_client *new_client;

I would be grateful if you could rename this to just "client".

> > +	struct thmc50_data *data;
> > +	struct device *dev;
> > +	int err = 0;
> > +	const char *type_name = "";
> > +
> > +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> 
> Some type of warning would be nice here, instead of silently failing.
> 
> > +		goto exit;

I disagree. There may be several I2C buses on the system, for example
one with no THMC50 chip and which doesn't support this functionality,
and one with a THMC50 chip and which does support this functionality.
Printing a warning when the first bus is being probed would be quite
misleading.

As a matter of fact, none of the other i2c-based hardware monitoring
drivers print error messages in this case. One driver (max6650) prints
a debugging message.

> > +/* All registers are word-sized, except for the configuration register.
> > +   THMC50 uses a high-byte first convention, which is exactly opposite to
> > +   the usual practice. */

This comment was seemingly stolen from a different driver, and doesn't
apply to the THMC50 at all!

> > +static int thmc50_read_value(struct i2c_client *client, u8 reg)
> > +{
> > +	return i2c_smbus_read_byte_data(client, reg);
> > +}
> > +
> > +/* All registers are word-sized, except for the configuration register.
> > +   THMC50 uses a high-byte first convention, which is exactly opposite to
> > +   the usual practice. */
> > +static int thmc50_write_value(struct i2c_client *client, u8 reg, u16 value)
> > +{
> > +	return i2c_smbus_write_byte_data(client, reg, value);
> > +}
> 
> You don't use this return value anywhere.  Why not make it void?

Why define these functions in the first place? You could call the
i2c_smbus_*() functions directly. If you really want to keep these
wrappers, please at least mark them inline.

> > +static void thmc50_init_client(struct i2c_client *client)
> > +{
> > +	struct thmc50_data *data = i2c_get_clientdata(client);
> > +
> > +	data->config_reg |= 0x23;
> > +	thmc50_write_value(client, THMC50_REG_CONF, data->config_reg);
> > +	data->analog_out = thmc50_read_value(client, THMC50_REG_ANALOG_OUT);
> > +	/* set up to at least 1 */
> > +	if (data->analog_out = 0 ) {
> > +		data->analog_out = 1;
> > +		thmc50_write_value(client, THMC50_REG_ANALOG_OUT, data->analog_out);
> > +	}
> > +}

Why do you change the value of the analog output? Loading a hardware
monitoring driver should NOT change the state of the system.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
