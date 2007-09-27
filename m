From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 27 Sep 2007 19:43:28 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc8 1/3] lm75: cleanups (no
Message-Id: <20070927214328.462c8c46@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925051533.38DF9239408@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070925051533.38DF9239408@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Mon, 24 Sep 2007 22:15:34 -0700, David Brownell wrote:
> Minor cleanup and reorg of the lm75 code.
> 
>  - Kconfig provides a larger list of lm75-compatible chips, which
>    should help people avoid writing Yet Another LM75 Driver.
> 
>  - A top comment now says what the driver does (!) ... as in, just
>    what kind of sensor is this??
> 
>  - Section comments now delineate the various sections of the driver:
>    hwmon attributes, driver binding, register access, module glue.
>    One driver binding function moved out of the attribute section,
>    as did the driver struct itself.
> 
>  - Minor tweaks to legacy probe logic:  correct a comment, and
>    remove a pointless variable.

That variable and the seemingly useless construct around it were there
for the day we would add more "kinds" to the driver. Each kind has its
own prefix and possibly its own behavior, and can be either detected or
forced using a module parameter. Your change removes this possibility.
Admittedly, we did not use it for years, but I find it strange that you
decide to clean this up at the exact same moment you add support for
more variants of the chip with additional features (12-bit resolution,
etc.) which precisely could lead us to add new kinds.

> 
>  - Remove assignment of driver.id = I2C_DRIVERID_LM75.  Such values
>    are unused and pointless.

True, but then you have to remove its definition from
include/linux/i2c-id.h as well, otherwise potential out-of-tree users
won't have a chance to notice the change.

> 
>  - Whitespace and linelength fixes.
> 
> This patch should include no functional changes.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/hwmon/Kconfig |   13 +++++--
>  drivers/hwmon/lm75.c  |   89 ++++++++++++++++++++++++++++----------------------
>  2 files changed, 60 insertions(+), 42 deletions(-)

Review:

> --- a/drivers/hwmon/Kconfig	2007-09-24 21:03:06.000000000 -0700
> +++ b/drivers/hwmon/Kconfig	2007-09-24 21:59:26.000000000 -0700
> @@ -301,9 +301,16 @@ config SENSORS_LM75
>  	tristate "National Semiconductor LM75 and compatibles"
>  	depends on I2C
>  	help
> -	  If you say yes here you get support for National Semiconductor LM75
> -	  sensor chips and clones: Dallas Semiconductor DS75 and DS1775 (in
> -	  9-bit precision mode), and TelCom (now Microchip) TCN75.
> +	  If you say yes here you get support for one common type of
> +	  temperature sensor chip, with models including:
> +
> +		- Dallas Semiconductor DS75 and DS1775
> +		- Maxim MAX6625 and MAX6626
> +		- Microchip MCP980x
> +		- National Semiconductor LM75
> +		- ST Microelectronics STDS75
> +		- TelCom (now Microchip) TCN75
> +		- Texas Instruments TMP100, TMP101, TMP75, TMP175, TMP275
>  
>  	  The DS75 and DS1775 in 10- to 12-bit precision modes will require
>  	  a force module parameter. The driver will not handle the extra
> --- a/drivers/hwmon/lm75.c	2007-09-24 21:03:06.000000000 -0700
> +++ b/drivers/hwmon/lm75.c	2007-09-24 21:59:35.000000000 -0700
> @@ -30,14 +30,19 @@
>  #include "lm75.h"
>  
>  
> -/* Addresses to scan */
> +/*
> + * This driver handles the LM75 and compatible digital temperature sensors.
> + * Compatibles include at least the DS75, DS1775, LM75, MCP980x, STDS75,

I am glad to learn that the LM75 is compatible with itself ;)

> + * TCN75, TMP100, TMP101, TMP75, TMP175, and TMP275.
> + */
> +
> +/* Addresses scanned by legacy style driver binding */
>  static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
>  					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
>  
> -/* Insmod parameters */
> +/* Insmod parameters (only for legacy style driver binding) */

Strictly speaking, this comment and similar ones belong to the next
patch, as there's no other binding style in this driver for now.

>  I2C_CLIENT_INSMOD_1(lm75);
>  
> -/* Many LM75 constants specified below */
>  
>  /* The LM75 registers */
>  #define LM75_REG_CONF		0x01
> @@ -50,9 +55,9 @@ static const u8 LM75_REG_TEMP[3] = {
>  /* Each client has this additional data */
>  struct lm75_data {
>  	struct i2c_client	client;
> -	struct device *hwmon_dev;
> +	struct device		*hwmon_dev;
>  	struct mutex		update_lock;
> -	char			valid;		/* !=0 if following fields are valid */
> +	char			valid;		/* !=0 if registers are valid */
>  	unsigned long		last_updated;	/* In jiffies */
>  	u16			temp[3];	/* Register values,
>  						   0 = input
> @@ -60,24 +65,15 @@ struct lm75_data {
>  						   2 = hyst */
>  };
>  
> -static int lm75_attach_adapter(struct i2c_adapter *adapter);
> -static int lm75_detect(struct i2c_adapter *adapter, int address, int kind);
>  static void lm75_init_client(struct i2c_client *client);
> -static int lm75_detach_client(struct i2c_client *client);
>  static int lm75_read_value(struct i2c_client *client, u8 reg);
>  static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value);
>  static struct lm75_data *lm75_update_device(struct device *dev);
>  
>  
> -/* This is the driver that will be inserted */
> -static struct i2c_driver lm75_driver = {
> -	.driver = {
> -		.name	= "lm75",
> -	},
> -	.id		= I2C_DRIVERID_LM75,
> -	.attach_adapter	= lm75_attach_adapter,
> -	.detach_client	= lm75_detach_client,
> -};
> +/*-----------------------------------------------------------------------*/
> +
> +/* sysfs attributes for hwmon */
>  
>  static ssize_t show_temp(struct device *dev, struct device_attribute *da,
>  			 char *buf)
> @@ -110,13 +106,6 @@ static SENSOR_DEVICE_ATTR(temp1_max_hyst
>  			show_temp, set_temp, 2);
>  static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
>  
> -static int lm75_attach_adapter(struct i2c_adapter *adapter)
> -{
> -	if (!(adapter->class & I2C_CLASS_HWMON))
> -		return 0;
> -	return i2c_probe(adapter, &addr_data, lm75_detect);
> -}
> -
>  static struct attribute *lm75_attributes[] = {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
>  	&sensor_dev_attr_temp1_max.dev_attr.attr,
> @@ -129,6 +118,12 @@ static const struct attribute_group lm75
>  	.attrs = lm75_attributes,
>  };
>  
> +/*-----------------------------------------------------------------------*/
> +
> +/* "Legacy" I2C driver binding */
> +
> +static struct i2c_driver lm75_driver;
> +
>  /* This function is called by i2c_probe */
>  static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
>  {
> @@ -136,14 +131,13 @@ static int lm75_detect(struct i2c_adapte
>  	struct i2c_client *new_client;
>  	struct lm75_data *data;
>  	int err = 0;
> -	const char *name = "";
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
>  				     I2C_FUNC_SMBUS_WORD_DATA))
>  		goto exit;
>  
> -	/* OK. For now, we presume we have a valid client. We now create the
> -	   client structure, even though we cannot fill it completely yet.
> +	/* OK. For now, we presume we have a valid address. We create the
> +	   client structure, even though there may be no sensor present.
>  	   But it allows us to access lm75_{read,write}_value. */

Can you please fix this last comment as well? We don't use
lm75_{read,write}_value at this point but
i2c_smbus_read_{byte,word}_data.

>  	if (!(data = kzalloc(sizeof(struct lm75_data), GFP_KERNEL))) {
>  		err = -ENOMEM;
> @@ -175,17 +169,17 @@ static int lm75_detect(struct i2c_adapte
>  		 || i2c_smbus_read_word_data(new_client, 5) != hyst
>  		 || i2c_smbus_read_word_data(new_client, 6) != hyst
>  		 || i2c_smbus_read_word_data(new_client, 7) != hyst)
> -		 	goto exit_free;
> +			goto exit_free;
>  		os = i2c_smbus_read_word_data(new_client, 3);
>  		if (i2c_smbus_read_word_data(new_client, 4) != os
>  		 || i2c_smbus_read_word_data(new_client, 5) != os
>  		 || i2c_smbus_read_word_data(new_client, 6) != os
>  		 || i2c_smbus_read_word_data(new_client, 7) != os)
> -		 	goto exit_free;
> +			goto exit_free;
>  
>  		/* Unused bits */
>  		if (conf & 0xe0)
> -		 	goto exit_free;
> +			goto exit_free;
>  
>  		/* Addresses cycling */
>  		for (i = 8; i < 0xff; i += 8)
> @@ -195,16 +189,10 @@ static int lm75_detect(struct i2c_adapte
>  				goto exit_free;
>  	}
>  
> -	/* Determine the chip type - only one kind supported! */
> -	if (kind <= 0)
> -		kind = lm75;
> -
> -	if (kind = lm75) {
> -		name = "lm75";
> -	}
> +	/* NOTE: we treat "force=..." and "force_lm75=..." the same. */
> +	strlcpy(new_client->name, "lm75", I2C_NAME_SIZE);
>  
>  	/* Fill in the remaining client fields and put it into the global list */
> -	strlcpy(new_client->name, name, I2C_NAME_SIZE);
>  	data->valid = 0;

This one can go away, as data has been kzalloc'ed.

>  	mutex_init(&data->update_lock);
>  
> @@ -214,7 +202,7 @@ static int lm75_detect(struct i2c_adapte
>  
>  	/* Initialize the LM75 chip */
>  	lm75_init_client(new_client);
> -	
> +
>  	/* Register sysfs hooks */
>  	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm75_group)))
>  		goto exit_detach;
> @@ -237,6 +225,13 @@ exit:
>  	return err;
>  }
>  
> +static int lm75_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	if (!(adapter->class & I2C_CLASS_HWMON))
> +		return 0;
> +	return i2c_probe(adapter, &addr_data, lm75_detect);
> +}
> +
>  static int lm75_detach_client(struct i2c_client *client)
>  {
>  	struct lm75_data *data = i2c_get_clientdata(client);
> @@ -247,6 +242,18 @@ static int lm75_detach_client(struct i2c
>  	return 0;
>  }
>  
> +static struct i2c_driver lm75_driver = {
> +	.driver = {
> +		.name	= "lm75",
> +	},
> +	.attach_adapter	= lm75_attach_adapter,
> +	.detach_client	= lm75_detach_client,
> +};
> +
> +/*-----------------------------------------------------------------------*/
> +
> +/* register access */
> +
>  /* All registers are word-sized, except for the configuration register.
>     LM75 uses a high-byte first convention, which is exactly opposite to
>     the usual practice. */

This comment could be fixed as well: high-byte first _is_ the usual
practice, even though the SMBus specification says low-byte first.

> @@ -303,6 +310,10 @@ static struct lm75_data *lm75_update_dev
>  	return data;
>  }
>  
> +/*-----------------------------------------------------------------------*/
> +
> +/* module glue */
> +
>  static int __init sensors_lm75_init(void)
>  {
>  	return i2c_add_driver(&lm75_driver);
> 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
