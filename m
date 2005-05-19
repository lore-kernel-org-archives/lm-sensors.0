From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: lm83 driver ported to linux 2.6
Message-Id: <20030929201021.GK1845@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030929213648.5ebc26bd.khali@linux-fr.org>
In-Reply-To: <20030929213648.5ebc26bd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 29, 2003 at 09:36:48PM +0200, Jean Delvare wrote:
> 
> Hi Greg,
> 
> Here is a first try of porting my lm83 driver to linux 2.6. Not sure
> it's all perfect, but it at least compiles and loads/unloads. I have no
> hardware for testing, so I can't do much more. Could you please take a
> look and tell me if it's OK for you?

Comments are below.

> BTW, I'm a bit disappointed by the new sysfs interface. Where I had 3
> callback functions with procfs, I now have 15. They are shorter for
> sure, still 15 is much for such a simple driver. The fact that you need
> macros to define them shows IMHO that there's something wrong there
> (although I don't know what and have no real suggestion for
> improvement).

If you don't like registering all of the different files, look into
using sysfs_create_group() and sysfs_remove_group().  It makes large
numbers of attributes a bit easier to deal with.

And yes, it is a bit bigger than procfs, but the coding interface is a
_lot_ simpler, and we are enforcing the "1 file - 1 value" rule, which
is a good thing :)

> + * Copyright (c) 2003  Jean Delvare <khali@linux-fr.org>
                 ^- should be "(C)" to be legal.  So says the lawyers
		 who know these things.

> +/*
> + * The LM83 registers
> + * Manufacturer ID is 0x01 for National Semiconductor.
> + */
> +
> +#define LM83_REG_R_MAN_ID        0xFE

No tabs used here or in any of the other #defines.

> +static struct i2c_driver lm83_driver = {
> +	.owner          = THIS_MODULE,
> +	.name           = "lm83",
> +	.id             = I2C_DRIVERID_LM83,
> +	.flags          = I2C_DF_NOTIFY,
> +	.attach_adapter = lm83_attach_adapter,
> +	.detach_client  = lm83_detach_client
> +};

Use tabs here before the '=' and put a ',' after lm83_detach_client to
make any future changes not involve changing that line.

> +/*
> + * The following function does more than just detection. If detection
> + * succeeds, it also registers the new chip.
> + */
> +
> +static int lm83_detect(struct i2c_adapter *adapter, int address,
> +	int kind)

No extra line between comments and the function, please.

> +	if (kind < 0) /* detection */
> +	{

Ick, please put the '{' back up on the if line.  Read
Documetation/CodingStyle for more info on this.

> +#ifdef DEBUG
> +			printk("lm83.o: LM83 detection failed at 0x%02x.\n",
> +				address);
> +#endif

Just make this a dev_dbg() call and get rid of the #ifdef.

> +	if (kind <= 0) /* identification */
> +	{
> +		u8 man_id, chip_id;
> +
> +		man_id = i2c_smbus_read_byte_data(new_client, LM83_REG_R_MAN_ID);
> +		chip_id = i2c_smbus_read_byte_data(new_client, LM83_REG_R_CHIP_ID);
> +		if (man_id = 0x01) /* National Semiconductor */
> +		{
> +			if (chip_id = 0x03)
> +			{
> +				kind = lm83;
> +				name = "lm83";
> +			}
> +		}
> +
> +		if (kind <= 0) /* identification failed */
> +		{
> +			dev_info(&adapter->dev,
> +				"Unsupported chip (man_id=0x%02X, chip_id=0x%02X).\n",
> +				man_id, chip_id);
> +			goto exit_free;
> +		}
> +	}

As there is only 1 "kind" supported by this driver, this whole logic can
be simplified a bunch.  Just check the man_id and chip_id and then exit
out if it doesn't match.


> +	device_create_file(&new_client->dev, &dev_attr_temp_input1);
> +	device_create_file(&new_client->dev, &dev_attr_temp_input2);
> +	device_create_file(&new_client->dev, &dev_attr_temp_input3);
> +	device_create_file(&new_client->dev, &dev_attr_temp_input4);
> +	device_create_file(&new_client->dev, &dev_attr_temp_max1);
> +	device_create_file(&new_client->dev, &dev_attr_temp_max2);
> +	device_create_file(&new_client->dev, &dev_attr_temp_max3);
> +	device_create_file(&new_client->dev, &dev_attr_temp_max4);
> +	device_create_file(&new_client->dev, &dev_attr_temp_crit);
> +	device_create_file(&new_client->dev, &dev_attr_alarms);
> +
> +	/*
> +	 * Initialize the LM83 chip
> +	 */
> +
> +	lm83_init_client(new_client);

You should probably initialize the chip before registering it with the
i2c core as it can be queried right then before this call could be
finished.


> diff -ruN linux-2.6.0-test6/include/linux/i2c-id.h linux-2.6.0-test6-khali/include/linux/i2c-id.h
> --- linux-2.6.0-test6/include/linux/i2c-id.h	Sun Sep 28 17:43:40 2003
> +++ linux-2.6.0-test6-khali/include/linux/i2c-id.h	Sun Sep 28 22:54:01 2003
> @@ -153,6 +153,7 @@
>  #define I2C_DRIVERID_FS451 1037
>  #define I2C_DRIVERID_W83627HF 1038
>  #define I2C_DRIVERID_LM85 1039
> +#define I2C_DRIVERID_LM83 1040

What do we do with these ids?

Anyway, very nice job.  With those minor fixes I'd be glad to add it to
the 2.6 kernel tree.

thanks,

greg k-h
