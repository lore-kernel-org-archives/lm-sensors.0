From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 01 Oct 2012 21:29:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads7828) add support for ADS7830
Message-Id: <20121001212940.GA30936@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349124260-28656-1-git-send-email-vivien.didelot@savoirfairelinux.com>
 <197551023.728862.1349125751841.JavaMail.root@mail.savoirfairelinux.com>
In-Reply-To: <197551023.728862.1349125751841.JavaMail.root@mail.savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: lm-sensors@lm-sensors.org, Guillaume Roguez <guillaume.roguez@savoirfairelinux.com>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, Steve Hardy <shardy@redhat.com>

On Mon, Oct 01, 2012 at 05:09:11PM -0400, Vivien Didelot wrote:
> Oops, I used the wrong address for Guenter. Here we go.
>=20
Hi Vivien,

I got it anyway, through the mailing list...

> Thanks,
> Vivien
>=20
> ----- Mail original -----
> De: "Vivien Didelot" <vivien.didelot@savoirfairelinux.com>
> =C0: lm-sensors@lm-sensors.org
> Cc: "Guillaume Roguez" <guillaume.roguez@savoirfairelinux.com>, "Guenter =
Roeck" <guenter.roeck@ericsson.com>, "Jean Delvare" <khali@linux-fr.org>, l=
inux-kernel@vger.kernel.org, "Steve Hardy" <shardy@redhat.com>, "Vivien Did=
elot" <vivien.didelot@savoirfairelinux.com>
> Envoy=E9: Lundi 1 Octobre 2012 16:44:20
> Objet: [PATCH] hwmon: (ads7828) add support for ADS7830
>=20
> From: Guillaume Roguez <guillaume.roguez@savoirfairelinux.com>
>=20
> The ADS7830 is almost the same chip, except that it does 8-bit sampling.
> This patch extends the ads7828 driver to support this device.
>=20
> Signed-off-by: Guillaume Roguez <guillaume.roguez@savoirfairelinux.com>
>=20
> Also clean the driver a bit by removing unused macros, and moving
> the driver declaration to avoid some function prototypes.
>=20
One change per patch, please. Please handle the cleanup with a separate pat=
ch.

Other than that, not sure if the changes warrant a copyright, and you can n=
ot
add a copyright for a third person (or replace a "Written by" statement wit=
h a
copyright).

Thanks,
Guenter

> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> ---
>  Documentation/hwmon/ads7828 |  12 +++-
>  drivers/hwmon/Kconfig       |   7 ++-
>  drivers/hwmon/ads7828.c     | 137 +++++++++++++++++++++++++-------------=
------
>  3 files changed, 93 insertions(+), 63 deletions(-)
>=20
> diff --git a/Documentation/hwmon/ads7828 b/Documentation/hwmon/ads7828
> index 2bbebe6..4366a87 100644
> --- a/Documentation/hwmon/ads7828
> +++ b/Documentation/hwmon/ads7828
> @@ -8,8 +8,15 @@ Supported chips:
>      Datasheet: Publicly available at the Texas Instruments website :
>                 http://focus.ti.com/lit/ds/symlink/ads7828.pdf
> =20
> +  * Texas Instruments ADS7830
> +    Prefix: 'ads7830'
> +    Addresses scanned: I2C 0x48, 0x49, 0x4a, 0x4b
> +    Datasheet: Publicly available at the Texas Instruments website:
> +               http://focus.ti.com/lit/ds/symlink/ads7830.pdf
> +
>  Authors:
>          Steve Hardy <shardy@redhat.com>
> +        Guillaume Roguez <guillaume.roguez@savoirfairelinux.com>
> =20
>  Module Parameters
>  -----------------
> @@ -24,9 +31,10 @@ Module Parameters
>  Description
>  -----------
> =20
> -This driver implements support for the Texas Instruments ADS7828.
> +This driver implements support for the Texas Instruments ADS7828, and AD=
S7830.
> =20
> -This device is a 12-bit 8-channel A-D converter.
> +The ADS7828 device is a 12-bit 8-channel A/D converter, while the ADS783=
0 does
> +8-bit sampling.
> =20
>  It can operate in single ended mode (8 +ve inputs) or in differential mo=
de,
>  where 4 differential pairs can be measured.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 83e3e9d..960c8c5 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1060,11 +1060,12 @@ config SENSORS_ADS1015
>  	  will be called ads1015.
> =20
>  config SENSORS_ADS7828
> -	tristate "Texas Instruments ADS7828"
> +	tristate "Texas Instruments ADS7828 and compatibles"
>  	depends on I2C
>  	help
> -	  If you say yes here you get support for Texas Instruments ADS7828
> -	  12-bit 8-channel ADC device.
> +	  If you say yes here you get support for Texas Instruments ADS7828 and
> +	  ADS7830 8-channel A/D converters. ADS7828 resolution is 12-bit, while
> +	  it is 8-bit on ADS7830.
> =20
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called ads7828.
> diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
> index bf3fdf4..58f28ea 100644
> --- a/drivers/hwmon/ads7828.c
> +++ b/drivers/hwmon/ads7828.c
> @@ -1,12 +1,12 @@
>  /*
> - * ads7828.c - lm_sensors driver for ads7828 12-bit 8-channel ADC
> - * (C) 2007 EADS Astrium
> + * ads7828.c - driver for TI ADS7828 8-channel A/D converter and compati=
bles
>   *
> - * This driver is based on the lm75 and other lm_sensors/hwmon drivers
> + * Copyright (C) 2007 EADS Astrium
> + * Copyright (C) Steve Hardy <shardy@redhat.com>
> + * Copyright (C) 2012 Savoir-faire Linux Inc.
> + *	Guillaume Roguez <guillaume.roguez@savoirfairelinux.com>
>   *
> - * Written by Steve Hardy <shardy@redhat.com>
> - *
> - * Datasheet available at: http://focus.ti.com/lit/ds/symlink/ads7828.pdf
> + * For further information, see the Documentation/hwmon/ads7828 file.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -34,14 +34,15 @@
>  #include <linux/mutex.h>
> =20
>  /* The ADS7828 registers */
> -#define ADS7828_NCH 8 /* 8 channels of 12-bit A-D supported */
> -#define ADS7828_CMD_SD_SE 0x80 /* Single ended inputs */
> -#define ADS7828_CMD_SD_DIFF 0x00 /* Differential inputs */
> -#define ADS7828_CMD_PD0 0x0 /* Power Down between A-D conversions */
> -#define ADS7828_CMD_PD1 0x04 /* Internal ref OFF && A-D ON */
> -#define ADS7828_CMD_PD2 0x08 /* Internal ref ON && A-D OFF */
> -#define ADS7828_CMD_PD3 0x0C /* Internal ref ON && A-D ON */
> -#define ADS7828_INT_VREF_MV 2500 /* Internal vref is 2.5V, 2500mV */
> +#define ADS7828_NCH		8	/* 8 channels supported */
> +#define ADS7828_CMD_SD_SE	0x80	/* Single ended inputs */
> +#define ADS7828_CMD_SD_DIFF	0x00	/* Differential inputs */
> +#define ADS7828_CMD_PD1		0x04	/* Internal ref OFF && A/D ON */
> +#define ADS7828_CMD_PD3		0x0C	/* Internal ref ON && A/D ON */
> +#define ADS7828_INT_VREF_MV	2500	/* Internal vref is 2.5V, 2500mV */
> +
> +/* List of supported devices */
> +enum ads7828_chips { ads7828, ads7830 };
> =20
>  /* Addresses to scan */
>  static const unsigned short normal_i2c[] =3D { 0x48, 0x49, 0x4a, 0x4b,
> @@ -57,23 +58,27 @@ module_param(vref_mv, int, S_IRUGO);
> =20
>  /* Global Variables */
>  static u8 ads7828_cmd_byte; /* cmd byte without channel bits */
> -static unsigned int ads7828_lsb_resol; /* resolution of the ADC sample l=
sb */
> =20
> -/* Each client has this additional data */
> +/**
> + * struct ads7828_data - client specific data
> + * @hwmon_dev:		The hwmon device.
> + * @update_lock:	Mutex protecting updates.
> + * @valid:		Validity flag.
> + * @last_updated:	Last updated time (in jiffies).
> + * @adc_input:		ADS7828_NCH samples.
> + * @lsb_resol:		Resolution of the A/D converter sample LSB.
> + * @read_channel:	Function used to read a channel.
> + */
>  struct ads7828_data {
>  	struct device *hwmon_dev;
> -	struct mutex update_lock; /* mutex protect updates */
> -	char valid; /* !=3D0 if following fields are valid */
> -	unsigned long last_updated; /* In jiffies */
> -	u16 adc_input[ADS7828_NCH]; /* ADS7828_NCH 12-bit samples */
> +	struct mutex update_lock;
> +	char valid;
> +	unsigned long last_updated;
> +	u16 adc_input[ADS7828_NCH];
> +	unsigned int lsb_resol;
> +	s32 (*read_channel)(const struct i2c_client *client, u8 command);
>  };
> =20
> -/* Function declaration - necessary due to function dependencies */
> -static int ads7828_detect(struct i2c_client *client,
> -			  struct i2c_board_info *info);
> -static int ads7828_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id);
> -
>  static inline u8 channel_cmd_byte(int ch)
>  {
>  	/* cmd byte C2,C1,C0 - see datasheet */
> @@ -97,8 +102,7 @@ static struct ads7828_data *ads7828_update_device(stru=
ct device *dev)
> =20
>  		for (ch =3D 0; ch < ADS7828_NCH; ch++) {
>  			u8 cmd =3D channel_cmd_byte(ch);
> -			data->adc_input[ch] =3D
> -				i2c_smbus_read_word_swapped(client, cmd);
> +			data->adc_input[ch] =3D data->read_channel(client, cmd);
>  		}
>  		data->last_updated =3D jiffies;
>  		data->valid =3D 1;
> @@ -116,8 +120,8 @@ static ssize_t show_in(struct device *dev, struct dev=
ice_attribute *da,
>  	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
>  	struct ads7828_data *data =3D ads7828_update_device(dev);
>  	/* Print value (in mV as specified in sysfs-interface documentation) */
> -	return sprintf(buf, "%d\n", (data->adc_input[attr->index] *
> -		ads7828_lsb_resol)/1000);
> +	return sprintf(buf, "%d\n",
> +		       (data->adc_input[attr->index] * data->lsb_resol) / 1000);
>  }
> =20
>  #define in_reg(offset)\
> @@ -158,31 +162,13 @@ static int ads7828_remove(struct i2c_client *client)
>  	return 0;
>  }
> =20
> -static const struct i2c_device_id ads7828_id[] =3D {
> -	{ "ads7828", 0 },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, ads7828_id);
> -
> -/* This is the driver that will be inserted */
> -static struct i2c_driver ads7828_driver =3D {
> -	.class =3D I2C_CLASS_HWMON,
> -	.driver =3D {
> -		.name =3D "ads7828",
> -	},
> -	.probe =3D ads7828_probe,
> -	.remove =3D ads7828_remove,
> -	.id_table =3D ads7828_id,
> -	.detect =3D ads7828_detect,
> -	.address_list =3D normal_i2c,
> -};
> -
>  /* Return 0 if detection is successful, -ENODEV otherwise */
>  static int ads7828_detect(struct i2c_client *client,
>  			  struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter =3D client->adapter;
>  	int ch;
> +	bool is_8bit =3D false;
> =20
>  	/* Check we have a valid client */
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_WORD_DATA))
> @@ -193,20 +179,30 @@ static int ads7828_detect(struct i2c_client *client,
>  	 * dedicated register so attempt to sanity check using knowledge of
>  	 * the chip
>  	 * - Read from the 8 channel addresses
> -	 * - Check the top 4 bits of each result are not set (12 data bits)
> +	 * - Check the top 4 bits of each result:
> +	 *   - They should not be set in case of 12-bit samples
> +	 *   - The two bytes should be equal in case of 8-bit samples
>  	 */
>  	for (ch =3D 0; ch < ADS7828_NCH; ch++) {
>  		u16 in_data;
>  		u8 cmd =3D channel_cmd_byte(ch);
>  		in_data =3D i2c_smbus_read_word_swapped(client, cmd);
>  		if (in_data & 0xF000) {
> -			pr_debug("%s : Doesn't look like an ads7828 device\n",
> -				 __func__);
> -			return -ENODEV;
> +			if ((in_data >> 8) =3D=3D (in_data & 0xFF)) {
> +				/* Seems to be an ADS7830 (8-bit sample) */
> +				is_8bit =3D true;
> +			} else {
> +				dev_dbg(&client->dev, "doesn't look like an "
> +					"ADS7828 compatible device\n");
> +				return -ENODEV;
> +			}
>  		}
>  	}
> =20
> -	strlcpy(info->type, "ads7828", I2C_NAME_SIZE);
> +	if (is_8bit)
> +		strlcpy(info->type, "ads7830", I2C_NAME_SIZE);
> +	else
> +		strlcpy(info->type, "ads7828", I2C_NAME_SIZE);
> =20
>  	return 0;
>  }
> @@ -223,6 +219,15 @@ static int ads7828_probe(struct i2c_client *client,
>  		goto exit;
>  	}
> =20
> +	/* ADS7828 uses 12-bit samples, while ADS7830 is 8-bit */
> +	if (id->driver_data =3D=3D ads7828) {
> +		data->read_channel =3D i2c_smbus_read_word_swapped;
> +		data->lsb_resol =3D (vref_mv * 1000) / 4096;
> +	} else {
> +		data->read_channel =3D i2c_smbus_read_byte_data;
> +		data->lsb_resol =3D (vref_mv * 1000) / 256;
> +	}
> +
>  	i2c_set_clientdata(client, data);
>  	mutex_init(&data->update_lock);
> =20
> @@ -247,6 +252,25 @@ exit:
>  	return err;
>  }
> =20
> +static const struct i2c_device_id ads7828_ids[] =3D {
> +	{ "ads7828", ads7828 },
> +	{ "ads7830", ads7830 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ads7828_ids);
> +
> +static struct i2c_driver ads7828_driver =3D {
> +	.class =3D I2C_CLASS_HWMON,
> +	.driver =3D {
> +		.name =3D "ads7828",
> +	},
> +	.probe =3D ads7828_probe,
> +	.remove =3D ads7828_remove,
> +	.id_table =3D ads7828_ids,
> +	.detect =3D ads7828_detect,
> +	.address_list =3D normal_i2c,
> +};
> +
>  static int __init sensors_ads7828_init(void)
>  {
>  	/* Initialize the command byte according to module parameters */
> @@ -255,9 +279,6 @@ static int __init sensors_ads7828_init(void)
>  	ads7828_cmd_byte |=3D int_vref ?
>  		ADS7828_CMD_PD3 : ADS7828_CMD_PD1;
> =20
> -	/* Calculate the LSB resolution */
> -	ads7828_lsb_resol =3D (vref_mv*1000)/4096;
> -
>  	return i2c_add_driver(&ads7828_driver);
>  }
> =20
> @@ -267,7 +288,7 @@ static void __exit sensors_ads7828_exit(void)
>  }
> =20
>  MODULE_AUTHOR("Steve Hardy <shardy@redhat.com>");
> -MODULE_DESCRIPTION("ADS7828 driver");
> +MODULE_DESCRIPTION("Driver for TI ADS7828 A/D converter and compatibles"=
);
>  MODULE_LICENSE("GPL");
> =20
>  module_init(sensors_ads7828_init);
> --=20
> 1.7.11.4
>=20
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
