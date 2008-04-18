From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Apr 2008 16:41:44 +0000
Subject: Re: [lm-sensors] [patch 2.6.25-rc9 1/5] lm75: cleanup/reorg
Message-Id: <20080418184144.0f7bb96f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161029.23656.david-b@pacbell.net>
In-Reply-To: <200804161029.23656.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 16 Apr 2008 10:29:23 -0700, David Brownell wrote:
> Minor cleanup and reorg of the lm75 code.
>=20
>  - Kconfig provides a larger list of lm75-compatible chips
>=20
>  - A top comment now says what the driver does (!) ... as in, just
>    what sort of sensor is this??
>=20
>  - Section comments now delineate the various sections of the driver:
>    hwmon attributes, driver binding, register access, module glue.
>    One driver binding function moved out of the attribute section,
>    as did the driver struct itself.
>=20
>  - Minor tweaks to legacy probe logic:  correct a comment, and
>    remove a pointless variable.
>=20
>  - Whitespace, linelength, and comment fixes.
>=20
> This patch should include no functional changes.
>=20
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/hwmon/Kconfig |   13 +++++-
>  drivers/hwmon/lm75.c  |   97 +++++++++++++++++++++++++++----------------=
-------
>  2 files changed, 63 insertions(+), 47 deletions(-)

The following patch in Mark's tree:
http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.6.git;a=3Dcommit;h=
=A617156848e99b93660f0da08fc401661d5cddbf
conflicts with this patch. You'll have to adjust your patch so that it
applies cleanly on top of Mark's tree (shouldn't be difficult.)

Over than that, I had already reviewed this patch and it looked OK to
me. Additional comments while I'm here:

>=20
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -379,9 +379,16 @@ config SENSORS_LM75
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

It seems you can add the Philips (NXP) LM75A to the list.

> =20
>  	  The DS75 and DS1775 in 10- to 12-bit precision modes will require
>  	  a force module parameter. The driver will not handle the extra

In fact almost all chips above (except the original NatSemi LM75) need a
force module parameter.

> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -30,14 +30,19 @@
>  #include "lm75.h"
> =20
> =20
> -/* Addresses to scan */
> +/*
> + * This driver handles the LM75 and compatible digital temperature senso=
rs.
> + * Compatibles include at least the DS75, DS1775, MCP980x, STDS75, TCN75,
> + * TMP100, TMP101, TMP75, TMP175, and TMP275.
> + */
> +
> +/* Addresses scanned by legacy style driver binding */
>  static const unsigned short normal_i2c[] =3D { 0x48, 0x49, 0x4a, 0x4b, 0=
x4c,
>  					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
> =20
> -/* Insmod parameters */
> +/* Insmod parameters (only for legacy style driver binding) */
>  I2C_CLIENT_INSMOD_1(lm75);
> =20
> -/* Many LM75 constants specified below */
> =20
>  /* The LM75 registers */
>  #define LM75_REG_CONF		0x01
> @@ -50,9 +55,9 @@ static const u8 LM75_REG_TEMP[3] =3D {
>  /* Each client has this additional data */
>  struct lm75_data {
>  	struct i2c_client	client;
> -	struct device *hwmon_dev;
> +	struct device		*hwmon_dev;
>  	struct mutex		update_lock;
> -	char			valid;		/* !=3D0 if following fields are valid */
> +	char			valid;		/* !=3D0 if registers are valid */
>  	unsigned long		last_updated;	/* In jiffies */
>  	u16			temp[3];	/* Register values,
>  						   0 =3D input
> @@ -60,23 +65,15 @@ struct lm75_data {
>  						   2 =3D hyst */
>  };
> =20
> -static int lm75_attach_adapter(struct i2c_adapter *adapter);
> -static int lm75_detect(struct i2c_adapter *adapter, int address, int kin=
d);
>  static void lm75_init_client(struct i2c_client *client);
> -static int lm75_detach_client(struct i2c_client *client);
>  static int lm75_read_value(struct i2c_client *client, u8 reg);
>  static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value=
);
>  static struct lm75_data *lm75_update_device(struct device *dev);
> =20
> =20
> -/* This is the driver that will be inserted */
> -static struct i2c_driver lm75_driver =3D {
> -	.driver =3D {
> -		.name	=3D "lm75",
> -	},
> -	.attach_adapter	=3D lm75_attach_adapter,
> -	.detach_client	=3D lm75_detach_client,
> -};
> +/*----------------------------------------------------------------------=
-*/
> +
> +/* sysfs attributes for hwmon */
> =20
>  static ssize_t show_temp(struct device *dev, struct device_attribute *da,
>  			 char *buf)
> @@ -109,13 +106,6 @@ static SENSOR_DEVICE_ATTR(temp1_max_hyst
>  			show_temp, set_temp, 2);
>  static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
> =20
> -static int lm75_attach_adapter(struct i2c_adapter *adapter)
> -{
> -	if (!(adapter->class & I2C_CLASS_HWMON))
> -		return 0;
> -	return i2c_probe(adapter, &addr_data, lm75_detect);
> -}
> -
>  static struct attribute *lm75_attributes[] =3D {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
>  	&sensor_dev_attr_temp1_max.dev_attr.attr,
> @@ -128,6 +118,12 @@ static const struct attribute_group lm75
>  	.attrs =3D lm75_attributes,
>  };
> =20
> +/*----------------------------------------------------------------------=
-*/
> +
> +/* "Legacy" I2C driver binding */
> +
> +static struct i2c_driver lm75_driver;
> +
>  /* This function is called by i2c_probe */
>  static int lm75_detect(struct i2c_adapter *adapter, int address, int kin=
d)
>  {
> @@ -135,15 +131,14 @@ static int lm75_detect(struct i2c_adapte
>  	struct i2c_client *new_client;
>  	struct lm75_data *data;
>  	int err =3D 0;
> -	const char *name =3D "";
> =20
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
>  				     I2C_FUNC_SMBUS_WORD_DATA))
>  		goto exit;
> =20
> -	/* OK. For now, we presume we have a valid client. We now create the
> -	   client structure, even though we cannot fill it completely yet.
> -	   But it allows us to access lm75_{read,write}_value. */
> +	/* OK. For now, we presume we have a valid address. We create the
> +	   client structure, even though there may be no sensor present.
> +	   But it allows us to access i2c_smbus_read_*_data() calls. */

"accessing a call" sounds strange.

>  	if (!(data =3D kzalloc(sizeof(struct lm75_data), GFP_KERNEL))) {
>  		err =3D -ENOMEM;
>  		goto exit;
> @@ -174,17 +169,17 @@ static int lm75_detect(struct i2c_adapte
>  		 || i2c_smbus_read_word_data(new_client, 5) !=3D hyst
>  		 || i2c_smbus_read_word_data(new_client, 6) !=3D hyst
>  		 || i2c_smbus_read_word_data(new_client, 7) !=3D hyst)
> -		 	goto exit_free;
> +			goto exit_free;
>  		os =3D i2c_smbus_read_word_data(new_client, 3);
>  		if (i2c_smbus_read_word_data(new_client, 4) !=3D os
>  		 || i2c_smbus_read_word_data(new_client, 5) !=3D os
>  		 || i2c_smbus_read_word_data(new_client, 6) !=3D os
>  		 || i2c_smbus_read_word_data(new_client, 7) !=3D os)
> -		 	goto exit_free;
> +			goto exit_free;
> =20
>  		/* Unused bits */
>  		if (conf & 0xe0)
> -		 	goto exit_free;
> +			goto exit_free;
> =20
>  		/* Addresses cycling */
>  		for (i =3D 8; i < 0xff; i +=3D 8)
> @@ -194,16 +189,10 @@ static int lm75_detect(struct i2c_adapte
>  				goto exit_free;
>  	}
> =20
> -	/* Determine the chip type - only one kind supported! */
> -	if (kind <=3D 0)
> -		kind =3D lm75;
> -
> -	if (kind =3D lm75) {
> -		name =3D "lm75";
> -	}
> +	/* NOTE: we treat "force=3D..." and "force_lm75=3D..." the same. */
> +	strlcpy(new_client->name, "lm75", I2C_NAME_SIZE);
> =20
>  	/* Fill in the remaining client fields and put it into the global list =
*/
> -	strlcpy(new_client->name, name, I2C_NAME_SIZE);
>  	data->valid =3D 0;
>  	mutex_init(&data->update_lock);
> =20
> @@ -213,7 +202,7 @@ static int lm75_detect(struct i2c_adapte
> =20
>  	/* Initialize the LM75 chip */
>  	lm75_init_client(new_client);
> -=09
> +
>  	/* Register sysfs hooks */
>  	if ((err =3D sysfs_create_group(&new_client->dev.kobj, &lm75_group)))
>  		goto exit_detach;
> @@ -236,6 +225,13 @@ exit:
>  	return err;
>  }
> =20
> +static int lm75_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	if (!(adapter->class & I2C_CLASS_HWMON))
> +		return 0;
> +	return i2c_probe(adapter, &addr_data, lm75_detect);
> +}
> +
>  static int lm75_detach_client(struct i2c_client *client)
>  {
>  	struct lm75_data *data =3D i2c_get_clientdata(client);
> @@ -246,9 +242,21 @@ static int lm75_detach_client(struct i2c
>  	return 0;
>  }
> =20
> +static struct i2c_driver lm75_driver =3D {
> +	.driver =3D {
> +		.name	=3D "lm75",
> +	},
> +	.attach_adapter	=3D lm75_attach_adapter,
> +	.detach_client	=3D lm75_detach_client,
> +};
> +
> +/*----------------------------------------------------------------------=
-*/
> +
> +/* register access */
> +
>  /* All registers are word-sized, except for the configuration register.
> -   LM75 uses a high-byte first convention, which is exactly opposite to
> -   the usual practice. */
> + * LM75 uses a high-byte first convention (not the SMBus convention).
> + */

This is the part which conflicts with my own cleanup patch. Basically
my patch does exactly what you were doing here, so you can just drop
this part of your patch.

>  static int lm75_read_value(struct i2c_client *client, u8 reg)
>  {
>  	if (reg =3D LM75_REG_CONF)
> @@ -257,9 +265,6 @@ static int lm75_read_value(struct i2c_cl
>  		return swab16(i2c_smbus_read_word_data(client, reg));
>  }
> =20
> -/* All registers are word-sized, except for the configuration register.
> -   LM75 uses a high-byte first convention, which is exactly opposite to
> -   the usual practice. */
>  static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value)
>  {
>  	if (reg =3D LM75_REG_CONF)
> @@ -302,6 +307,10 @@ static struct lm75_data *lm75_update_dev
>  	return data;
>  }
> =20
> +/*----------------------------------------------------------------------=
-*/
> +
> +/* module glue */
> +
>  static int __init sensors_lm75_init(void)
>  {
>  	return i2c_add_driver(&lm75_driver);


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
