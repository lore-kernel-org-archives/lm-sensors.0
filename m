From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: New driver for MAX663x temperature sensor.
Message-Id: <20040412161709.19199053.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081775028.11592.294.camel@uganda>
In-Reply-To: <1081775028.11592.294.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Patch against 2.4 kernel.
> Simple temperature sensor chip.
> Implemented read temperature and write low/high values.
> Tested on UP ppc32.
> 
> Please review and commit.

We don't take patches for the 2.4 kernel. Marcelo doesn't want i2c
patches from us anymore.

Either go and see with Marcelo directly (good luck) or submit your
driver as a patch against our CVS lm_sensors2 repository.

A few comments BTW:

First of all: which MAX663x chips is the driver for? MAX6629-MAX6632 are
non-I2C chips according to Maxim-IC, so I guess it's MAX6633-MAX6635?

You better name your driver max6633.c (or max6634.c, since that's the
chip I suspect you are actually working with) then. We don't much like
"x" in the driver names, they tend to be confusing (you may know which
values of "x" it implies, but the newcomer doesn't). And list the
supported chips in the header. See w83781d.c for a nice example.

> + * The GNU GPL is contained in /usr/doc/copyright/GPL on a Debian
> + * system and in the file COPYING in the Linux kernel source.

This doesn't belong to kernel code IMHO.

> +static struct i2c_driver max663x_driver = {
> +	.name		= "max663x",
> +	.flags		= I2C_DF_NOTIFY,
> +	.id		= 1234,

No. Just don't give it an ID if you don't need one.

> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
> +	{
> +		printk(KERN_ERR "Adapter doesn't support functionality.\n");
> +		goto error1;
> +	}

That's not an error. As you load an i2c chip driver, all adapters will
be scanned. This may include adapters that don't support these
functionalities (and so they just can't have a MAX6633 on them). I
wouldn't even print a message.

> +	new_client->id		= 123;

No. The other drivers have a global, static variable for that. Just do
the same.

I notice that your driver has no detection mechanism at all. I agree
that the MAX6634 doesn't look like a chip that want to be identified (no
manufacturer ID registers, no chip ID register, no die/revision
registers...) but there is a common trick of checking for unused bits,
which always return 0. There are two of them in the configuration
register, and 7 more in each temperature limit register. 30 zero bits
verified is far better than no check at all.

Also, since it seems that the address pointer registers only has 3 used
bits, I would expect values to cycle every 8 registers. See lm75.c as an
example. Could you please provide an i2cdump of the chip for
confirmation (both byte and word modes)? I would then add support for
the MAX6633/4/5 and LM76 (which seems to be compatible, but has
different unused bits) to our sensors-detect script.

> +	__max663x_temp((unsigned long)new_client);

The function that reads values is usually called update. If is also
supposed to cache the read data for a reasonable amount of time
(typically 1.5 second) and it has a protecting lock. And it is usually
not called at load time (although I admit we are reconsidering in some
cases at the moment).

> +	printk("Found max663x I2C temperature sensor.\n");

KERN_INFO or KERN_DEBUG missing.

> +static inline int reg2temp(uint16_t temp)
> +{
> +	if (temp & 0x8000)
> +	{
> +		return (255 - (temp >> 7));
> +	}
> +	else
> +	{
> +		return (temp >> 7);
> +	}
> +}
> +
> +static inline uint16_t temp2reg(int temp)
> +{
> +	uint16_t reg;
> +	
> +	if (temp > 255)
> +		temp = 255;
> +	if (temp < -255)
> +		temp = -255;
> +	
> +	if (temp < 0)
> +	{
> +		reg = temp + 255;
> +		reg <<= 7;
> +		reg |= 0x8000;
> +	}
> +	else
> +	{
> +		reg = (temp << 7);
> +	}
> +
> +	return reg;
> +}

These are usually defined as macros at the top of the file, with nice
names. See exiting drivers for examples of what we expect you to do. It
is important that all drivers follow a few common guidelines so that
maintaining the whole thing (49 chip drivers so far!) is possible.

> +void max663x_temp(struct i2c_client *client, int operation, int ctl_name, int *nrels_mag, long *results)
> +{
> +	struct max663x_data *data = client->data;
> +
> +	if (operation = SENSORS_PROC_REAL_INFO)
> +		*nrels_mag = 1;
> +	else if (operation = SENSORS_PROC_REAL_READ) 
> +	{
> +		__max663x_temp((unsigned long)client);
> +
> +		results[0] = reg2temp(data->temp_max);
> +		results[1] = reg2temp(data->temp_hyst);
> +		results[2] = reg2temp(data->temp);
> +		*nrels_mag = 3;
> +	} 
> +	else if (operation = SENSORS_PROC_REAL_WRITE) 
> +	{
> +		if (*nrels_mag >= 1) 
> +		{
> +			data->temp_max = temp2reg(results[0]);
> +			i2c_smbus_write_word_data(client, MAX663x_HIGH, swap_bytes(data->temp_high));
> +		}
> +		if (*nrels_mag >= 2) 
> +		{
> +			data->temp_max = temp2reg(results[1]);
> +			i2c_smbus_write_word_data(client, MAX663x_LOW, swap_bytes(data->temp_low));
> +		}
> +	}
> +}

That's odd. Writing to the file doesn't set the same limits as the ones
returned when reading the files. Confusing to say the least. And this
also means that some limits cannot be read (low, high), and others
cannot be set (max, hyst)? Oh well, the write part of your function, is
plain broken anyway.

Either have a 5-value file and put everything in it (the lm80 and lm92
drivers do that, you would follow the order of lm92 (although the rest
of the driver is *not* a good example for you to follow)) or put, say,
max and hyst current value in the "temp" file and have one or two other
files for high and low.

> +static void __exit max663x_fini(void)
> +{
> +	i2c_del_driver(&max663x_driver);
> +}

Nice to see a french word in kernel code, still _exit is the common
suffix for that function.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
