From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Sep 2008 17:29:20 +0000
Subject: Re: [lm-sensors] [PATCH] i2c: add support for MAX1618 in MAX1619
Message-Id: <200809161929.21072.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080916133542.GA2072@www.tglx.de>
In-Reply-To: <20080916133542.GA2072@www.tglx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Sebastian,

Le mardi 16 septembre 2008, Sebastian Siewior a =E9crit=A0:
> From: Tobias Himmer <tobias@himmer-online.de>
>=20
> The difference between MAX1619 and MAX1618 is that the latter has only one
> measurement register.
>=20
> Tested-by: Sebastian Siewior <bigeasy@linutronix.de>
> Signed-off-by: Tobias Himmer <tobias@himmer-online.de>
> ---
> This patch was done by Tobias some time ago but he was not able to test
> it because of -ENODEV. I tested this against Linus' current tree. The
> last commit (of the max1618 driver) in linux-next of today is the same
> as in Linus' tree.
>=20
>  drivers/hwmon/Kconfig   |    5 +-
>  drivers/hwmon/max1619.c |  185 ++++++++++++++++++++++++++++++++---------=
------
>  2 files changed, 129 insertions(+), 61 deletions(-)

Your patch is way too big for what it is doing. All you really need
to do to have MAX1618 support is prevent the driver from creating the
temp1* files in sysfs for this chip. This can be done very easily by
having two attribute groups, one for temp1 and one for temp2.

>=20
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index d402e8d..67dda87 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -541,10 +541,11 @@ config SENSORS_LM93
>  	  will be called lm93.
> =20
>  config SENSORS_MAX1619
> -	tristate "Maxim MAX1619 sensor chip"
> +	tristate "Maxim MAX1619 / MAX1618 sensor chip"
>  	depends on I2C
>  	help
> -	  If you say yes here you get support for MAX1619 sensor chip.
> +	  If you say yes here you get support for MAX1619 and MAX1618
> +	  sensor chips.
> =20
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called max1619.
> diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
> index 1ab1cac..c3f4480 100644
> --- a/drivers/hwmon/max1619.c
> +++ b/drivers/hwmon/max1619.c
> @@ -3,12 +3,15 @@
>   *             monitoring
>   * Copyright (C) 2003-2004 Alexey Fisher <fishor@mail.ru>
>   *                         Jean Delvare <khali@linux-fr.org>
> + *                         Tobias Himmer <tobias@himmer-online.de>
>   *
>   * Based on the lm90 driver. The MAX1619 is a sensor chip made by Maxim.
> - * It reports up to two temperatures (its own plus up to
> - * one external one). Complete datasheet can be
> - * obtained from Maxim's website at:
> + * It reports up to two temperatures (its own plus up to one external on=
e).
> + * This driver will also work on the MAX1618, a stripped down version wi=
th
> + * only one (external) temperature source.
> + * Complete datasheets can be obtained from Maxim's website at:
>   *   http://pdfserv.maxim-ic.com/en/ds/MAX1619.pdf
> + *   http://pdfserv.maxim-ic.com/en/ds/MAX1618.pdf
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -44,7 +47,7 @@ static const unsigned short normal_i2c[] =3D {
>   * Insmod parameters
>   */
> =20
> -I2C_CLIENT_INSMOD_1(max1619);
> +I2C_CLIENT_INSMOD_2(max1619, max1618);
> =20
>  /*
>   * The MAX1619 registers
> @@ -93,6 +96,7 @@ static struct max1619_data *max1619_update_device(struc=
t device *dev);
> =20
>  static const struct i2c_device_id max1619_id[] =3D {
>  	{ "max1619", max1619 },
> +	{ "max1618", max1618 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, max1619_id);
> @@ -116,35 +120,50 @@ static struct i2c_driver max1619_driver =3D {
>  struct max1619_data {
>  	struct device *hwmon_dev;
>  	struct mutex update_lock;
> +	const struct attribute_group *group;
> +	kernel_ulong_t kind; /* max1619 or max1618 */

Why not "enum chips"?

>  	char valid; /* zero until following fields are valid */
>  	unsigned long last_updated; /* in jiffies */
> =20
>  	/* registers values */
> -	u8 temp_input1; /* local */
> -	u8 temp_input2, temp_low2, temp_high2; /* remote */
> -	u8 temp_crit2;
> -	u8 temp_hyst2;
> -	u8 alarms;=20
> +	u8 local;
> +	u8 remote;
> +	u8 remote_low, remote_high;
> +	u8 remote_crit, remote_hyst;
> +	u8 alarms;
>  };

This change seems pointless and doesn't belong to this patch anyway.

> =20
>  /*
>   * Sysfs stuff
>   */
> =20
> +static ssize_t show_temp1_input(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct max1619_data *data =3D max1619_update_device(dev);
> +	return sprintf(buf, "%d\n", TEMP_FROM_REG((data->kind =3D max1618) ?
> +						data->remote : data->local));
> +}

You are making things more complex for the sole purpose of having
the max1618's single temperature sensor named temp1 instead of temp2.
We don't do that usually. We don't really care how the inputs are
numbered. If anything, it makes more sense to have the MAX1618 and
MAX1619 have the same number for their external sensor, so that the
same user-space configuration can support both chips, in case a
vendor is switching from one type to the other for any reason.

So, just let the max1618's sensor be named temp2, and your patch
will be a lot simpler.

> +
> +static ssize_t show_temp2_input(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct max1619_data *data =3D max1619_update_device(dev);
> +	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->remote));
> +}
> +
>  #define show_temp(value) \
>  static ssize_t show_##value(struct device *dev, struct device_attribute =
*attr, char *buf) \
>  { \
>  	struct max1619_data *data =3D max1619_update_device(dev); \
>  	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value)); \
>  }
> -show_temp(temp_input1);
> -show_temp(temp_input2);
> -show_temp(temp_low2);
> -show_temp(temp_high2);
> -show_temp(temp_crit2);
> -show_temp(temp_hyst2);
> -
> -#define set_temp2(value, reg) \
> +show_temp(remote_low);
> +show_temp(remote_high);
> +show_temp(remote_crit);
> +show_temp(remote_hyst);
> +
> +#define set_temp(value, reg) \
>  static ssize_t set_##value(struct device *dev, struct device_attribute *=
attr, const char *buf, \
>  	size_t count) \
>  { \
> @@ -158,11 +177,10 @@ static ssize_t set_##value(struct device *dev, stru=
ct device_attribute *attr, co
>  	mutex_unlock(&data->update_lock); \
>  	return count; \
>  }
> -
> -set_temp2(temp_low2, MAX1619_REG_W_REMOTE_LOW);
> -set_temp2(temp_high2, MAX1619_REG_W_REMOTE_HIGH);
> -set_temp2(temp_crit2, MAX1619_REG_W_REMOTE_CRIT);
> -set_temp2(temp_hyst2, MAX1619_REG_W_TCRIT_HYST);
> +set_temp(remote_low, MAX1619_REG_W_REMOTE_LOW);
> +set_temp(remote_high, MAX1619_REG_W_REMOTE_HIGH);
> +set_temp(remote_crit, MAX1619_REG_W_REMOTE_CRIT);
> +set_temp(remote_hyst, MAX1619_REG_W_TCRIT_HYST);
> =20
>  static ssize_t show_alarms(struct device *dev, struct device_attribute *=
attr, char *buf)
>  {
> @@ -178,22 +196,50 @@ static ssize_t show_alarm(struct device *dev, struc=
t device_attribute *attr,
>  	return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
>  }
> =20
> -static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
> -static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input2, NULL);
> -static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_low2,
> -	set_temp_low2);
> -static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_high2,
> -	set_temp_high2);
> -static DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp_crit2,
> -	set_temp_crit2);
> -static DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_temp_hyst2,
> -	set_temp_hyst2);
> +/* These are for both - MAX1619 and MAX1618 */
> +static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp1_input, NULL);
>  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
> +
> +/* These are just for MAX1619 */
> +static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp2_input, NULL);
> +static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_remote_low,
> +		   set_remote_low);
> +static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_remote_high,
> +		   set_remote_high);
> +static DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_remote_crit,
> +		   set_remote_crit);
> +static DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_remote_hyst,
> +		   set_remote_hyst);
>  static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 1=
);
>  static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);
>  static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
>  static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
> =20
> +/* These are just for MAX1618 */
> +static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_remote_low,
> +		   set_remote_low);
> +static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_remote_high,
> +		   set_remote_high);
> +static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_alarm, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 4);
> +
> +static struct attribute *max1618_attributes[] =3D {
> +	&dev_attr_temp1_input.attr,
> +	&dev_attr_temp1_min.attr,
> +	&dev_attr_temp1_max.attr,
> +
> +	&dev_attr_alarms.attr,
> +	&sensor_dev_attr_temp1_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group max1618_group =3D {
> +	.attrs =3D max1618_attributes,
> +};
> +
>  static struct attribute *max1619_attributes[] =3D {
>  	&dev_attr_temp1_input.attr,
>  	&dev_attr_temp2_input.attr,
> @@ -256,14 +302,24 @@ static int max1619_detect(struct i2c_client *new_cl=
ient, int kind,
> =20
>  	if (kind <=3D 0) { /* identification */
>  		u8 man_id, chip_id;
> -=09
> +

Coding style clean-ups are better submitted separately.

>  		man_id =3D i2c_smbus_read_byte_data(new_client,
>  			 MAX1619_REG_R_MAN_ID);
>  		chip_id =3D i2c_smbus_read_byte_data(new_client,
>  			  MAX1619_REG_R_CHIP_ID);
> -	=09
> -		if ((man_id =3D 0x4D) && (chip_id =3D 0x04))
> -			kind =3D max1619;
> +
> +		if (man_id =3D 0x4D) {
> +			switch (chip_id) {
> +			case 0x04:
> +				kind =3D max1619;
> +				strlcpy(info->type, "max1619", I2C_NAME_SIZE);
> +				break;
> +			case 0x02:
> +				kind =3D max1618;
> +				strlcpy(info->type, "max1618", I2C_NAME_SIZE);
> +				break;
> +			}
> +		}
> =20
>  		if (kind <=3D 0) { /* identification failed */
>  			dev_info(&adapter->dev,
> @@ -273,8 +329,6 @@ static int max1619_detect(struct i2c_client *new_clie=
nt, int kind,
>  		}
>  	}
> =20
> -	strlcpy(info->type, "max1619", I2C_NAME_SIZE);
> -
>  	return 0;
>  }
> =20

You are breaking the various "force" module parameters here. Forced
chips won't have a name so their devices won't possibly be
instantiated.

> @@ -298,7 +352,15 @@ static int max1619_probe(struct i2c_client *new_clie=
nt,
>  	max1619_init_client(new_client);
> =20
>  	/* Register sysfs hooks */
> -	if ((err =3D sysfs_create_group(&new_client->dev.kobj, &max1619_group)))
> +	if (id->driver_data =3D max1618) {
> +		data->group =3D &max1618_group;
> +		data->kind =3D max1618;
> +	} else {
> +		data->group =3D &max1619_group;
> +		data->kind =3D max1619;
> +	}
> +	err =3D sysfs_create_group(&new_client->dev.kobj, data->group);
> +	if (err)
>  		goto exit_free;
> =20
>  	data->hwmon_dev =3D hwmon_device_register(&new_client->dev);
> @@ -310,7 +372,7 @@ static int max1619_probe(struct i2c_client *new_clien=
t,
>  	return 0;
> =20
>  exit_remove_files:
> -	sysfs_remove_group(&new_client->dev.kobj, &max1619_group);
> +	sysfs_remove_group(&new_client->dev.kobj, data->group);
>  exit_free:
>  	kfree(data);
>  exit:
> @@ -337,7 +399,7 @@ static int max1619_remove(struct i2c_client *client)
>  	struct max1619_data *data =3D i2c_get_clientdata(client);
> =20
>  	hwmon_device_unregister(data->hwmon_dev);
> -	sysfs_remove_group(&client->dev.kobj, &max1619_group);
> +	sysfs_remove_group(&client->dev.kobj, data->group);
> =20
>  	kfree(data);
>  	return 0;
> @@ -352,21 +414,25 @@ static struct max1619_data *max1619_update_device(s=
truct device *dev)
> =20
>  	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
>  		dev_dbg(&client->dev, "Updating max1619 data.\n");
> -		data->temp_input1 =3D i2c_smbus_read_byte_data(client,
> -					MAX1619_REG_R_LOCAL_TEMP);
> -		data->temp_input2 =3D i2c_smbus_read_byte_data(client,
> -					MAX1619_REG_R_REMOTE_TEMP);
> -		data->temp_high2 =3D i2c_smbus_read_byte_data(client,
> -					MAX1619_REG_R_REMOTE_HIGH);
> -		data->temp_low2 =3D i2c_smbus_read_byte_data(client,
> -					MAX1619_REG_R_REMOTE_LOW);
> -		data->temp_crit2 =3D i2c_smbus_read_byte_data(client,
> -					MAX1619_REG_R_REMOTE_CRIT);
> -		data->temp_hyst2 =3D i2c_smbus_read_byte_data(client,
> -					MAX1619_REG_R_TCRIT_HYST);
> -		data->alarms =3D i2c_smbus_read_byte_data(client,
> -					MAX1619_REG_R_STATUS);
> -
> +		switch (data->kind) {
> +		default:
> +			data->local =3D i2c_smbus_read_byte_data(
> +				client, MAX1619_REG_R_LOCAL_TEMP);
> +			data->remote_crit =3D i2c_smbus_read_byte_data(
> +				client, MAX1619_REG_R_REMOTE_CRIT);
> +			data->remote_hyst =3D i2c_smbus_read_byte_data(
> +				client, MAX1619_REG_R_TCRIT_HYST);
> +		/* fallthrough */
> +		case max1618:
> +			data->remote =3D i2c_smbus_read_byte_data(
> +				client, MAX1619_REG_R_REMOTE_TEMP);
> +			data->remote_high =3D i2c_smbus_read_byte_data(
> +				client, MAX1619_REG_R_REMOTE_HIGH);
> +			data->remote_low =3D i2c_smbus_read_byte_data(
> +				client, MAX1619_REG_R_REMOTE_LOW);
> +			data->alarms =3D i2c_smbus_read_byte_data(
> +				client, MAX1619_REG_R_STATUS);
> +		}
>  		data->last_updated =3D jiffies;
>  		data->valid =3D 1;
>  	}

I doubt this works at all. The "default" test will always succeed,
so all the registers will be read for both the max1618 and max1619.

> @@ -386,9 +452,10 @@ static void __exit sensors_max1619_exit(void)
>  	i2c_del_driver(&max1619_driver);
>  }
> =20
> -MODULE_AUTHOR("Alexey Fisher <fishor@mail.ru> and "
> -	"Jean Delvare <khali@linux-fr.org>");
> -MODULE_DESCRIPTION("MAX1619 sensor driver");
> +MODULE_AUTHOR("Alexey Fisher <fishor@mail.ru>, "
> +	"Jean Delvare <khali@linux-fr.org>, "
> +	"Tobias Himmer <tobias@himmer-online.de>");
> +MODULE_DESCRIPTION("MAX1619 / MAX1618 sensor driver");
>  MODULE_LICENSE("GPL");
> =20
>  module_init(sensors_max1619_init);



--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
