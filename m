From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 19 Nov 2013 16:29:58 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <20131119162958.GB30481@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Nov 19, 2013 at 08:50:03AM +0100, Rudolf Marek wrote:
> Hi Guenter,
>=20
> Thanks for the review! Here is a re-spin.
>=20
> Add support for IT8603E.
>=20
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
>=20
Looks good to me.

Jean, I assume you'll take this one ? Or I can take it if you Ack it.

Thanks,
Guenter

> Thanks
> Rudolf
>=20
>=20
>=20

> Index: linux-3.12/Documentation/hwmon/it87
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-3.12.orig/Documentation/hwmon/it87	2=
013-11-18 23:56:09.701100351 +0100
> +++ linux-3.12/Documentation/hwmon/it87	2013-11-18 23:57:00.216465289 +01=
00
> @@ -2,6 +2,10 @@
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  Supported chips:
> +  * IT8603E
> +    Prefix: 'it8603'
> +    Addresses scanned: from Super I/O config space (8 I/O ports)
> +    Datasheet: Not publicly available
>    * IT8705F
>      Prefix: 'it87'
>      Addresses scanned: from Super I/O config space (8 I/O ports)
> @@ -90,7 +94,7 @@
>  Description
>  -----------
> =20
> -This driver implements support for the IT8705F, IT8712F, IT8716F,
> +This driver implements support for the IT8603E, IT8705F, IT8712F, IT8716=
F,
>  IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E, IT8771E, IT8772E,
>  IT8782F, IT8783E/F, and SiS950 chips.
> =20
> @@ -129,6 +133,10 @@
>  The IT8728F, IT8771E, and IT8772E are considered compatible with the IT8=
721F,
>  until a datasheet becomes available (hopefully.)
> =20
> +The IT8603E is a custom design, hardware monitoring part is similar to
> +IT8728F. It only supports 16-bit fan mode, the full speed mode of the
> +fan is not supported (value 0 of pwmX_enable).
> +
>  Temperatures are measured in degrees Celsius. An alarm is triggered once
>  when the Overtemperature Shutdown limit is crossed.
> =20
> @@ -145,10 +153,10 @@
>  maximum limit. Note that minimum in this case always means 'closest to
>  zero'; this is important for negative voltage measurements. All voltage
>  inputs can measure voltages between 0 and 4.08 volts, with a resolution =
of
> -0.016 volt (except IT8721F/IT8758E and IT8728F: 0.012 volt.) The battery
> +0.016 volt (except IT8721F/IT8758E/IT8603E and IT8728F: 0.012 volt.) The=
 battery
>  voltage in8 does not have limit registers.
> =20
> -On the IT8721F/IT8758E, IT8782F, and IT8783E/F, some voltage inputs are
> +On the IT8721F/IT8758E/IT8603E, IT8782F, and IT8783E/F, some voltage inp=
uts are
>  internal and scaled inside the chip (in7 (optional for IT8782F and IT878=
3E/F),
>  in8 and optionally in3). The driver handles this transparently so user-s=
pace
>  doesn't have to care.
> Index: linux-3.12/drivers/hwmon/it87.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-3.12.orig/drivers/hwmon/it87.c	2013-=
11-18 23:56:09.633101207 +0100
> +++ linux-3.12/drivers/hwmon/it87.c	2013-11-18 23:59:25.998632558 +0100
> @@ -10,7 +10,8 @@
>   *  This driver supports only the Environment Controller in the IT8705F =
and
>   *  similar parts.  The other devices are supported by different drivers.
>   *
> - *  Supports: IT8705F  Super I/O chip w/LPC interface
> + *  Supports: IT8603E  Super I/O chip w/LPC interface
> + *            IT8705F  Super I/O chip w/LPC interface
>   *            IT8712F  Super I/O chip w/LPC interface
>   *            IT8716F  Super I/O chip w/LPC interface
>   *            IT8718F  Super I/O chip w/LPC interface
> @@ -64,7 +65,7 @@
>  #define DRVNAME "it87"
> =20
>  enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it877=
1,
> -	     it8772, it8782, it8783 };
> +	     it8772, it8782, it8783, it8603 };
> =20
>  static unsigned short force_id;
>  module_param(force_id, ushort, 0);
> @@ -146,6 +147,7 @@
>  #define IT8772E_DEVID 0x8772
>  #define IT8782F_DEVID 0x8782
>  #define IT8783E_DEVID 0x8783
> +#define IT8306E_DEVID 0x8603
>  #define IT87_ACT_REG  0x30
>  #define IT87_BASE_REG 0x60
> =20
> @@ -315,6 +317,12 @@
>  		  | FEAT_TEMP_OLD_PECI,
>  		.old_peci_mask =3D 0x4,
>  	},
> +	[it8603] =3D {
> +		.name =3D "it8603",
> +		.features =3D FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
> +		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
> +		.peci_mask =3D 0x07,
> +	},
>  };
> =20
>  #define has_16bit_fans(data)	((data)->features & FEAT_16BIT_FANS)
> @@ -334,7 +342,7 @@
>  	u8 revision;
>  	u8 vid_value;
>  	u8 beep_pin;
> -	u8 internal;	/* Internal sensors can be labeled */
> +	u16 internal;	/* Internal sensors can be labeled */
>  	/* Features skipped based on config or DMI */
>  	u16 skip_in;
>  	u8 skip_vid;
> @@ -361,7 +369,7 @@
>  	unsigned long last_updated;	/* In jiffies */
> =20
>  	u16 in_scaled;		/* Internal voltage sensors are scaled */
> -	u8 in[9][3];		/* [nr][0]=3Din, [1]=3Dmin, [2]=3Dmax */
> +	u8 in[10][3];		/* [nr][0]=3Din, [1]=3Dmin, [2]=3Dmax */
>  	u8 has_fan;		/* Bitfield, fans enabled */
>  	u16 fan[5][2];		/* Register values, [nr][0]=FAn, [1]=3Dmin */
>  	u8 has_temp;		/* Bitfield, temp sensors enabled */
> @@ -578,6 +586,8 @@
>  			    7, 2);
> =20
>  static SENSOR_DEVICE_ATTR_2(in8_input, S_IRUGO, show_in, NULL, 8, 0);
> +static SENSOR_DEVICE_ATTR_2(in9_input, S_IRUGO, show_in, NULL, 9, 0);
> +
> =20
>  /* 3 temperatures */
>  static ssize_t show_temp(struct device *dev, struct device_attribute *at=
tr,
> @@ -734,7 +744,7 @@
>  {
>  	int ctrl =3D data->fan_main_ctrl & (1 << nr);
> =20
> -	if (ctrl =3D 0)					/* Full speed */
> +	if (ctrl =3D 0 && data->type !=3D it8603)		 /* Full speed */
>  		return 0;
>  	if (data->pwm_ctrl[nr] & 0x80)			/* Automatic mode */
>  		return 2;
> @@ -929,6 +939,10 @@
>  			return -EINVAL;
>  	}
> =20
> +	/* IT8603E does not have on/off mode */
> +	if (val =3D 0 && data->type =3D it8603)
> +		return -EINVAL;
> +
>  	mutex_lock(&data->update_lock);
> =20
>  	if (val =3D 0) {
> @@ -948,10 +962,13 @@
>  		else					/* Automatic mode */
>  			data->pwm_ctrl[nr] =3D 0x80 | data->pwm_temp_map[nr];
>  		it87_write_value(data, IT87_REG_PWM(nr), data->pwm_ctrl[nr]);
> -		/* set SmartGuardian mode */
> -		data->fan_main_ctrl |=3D (1 << nr);
> -		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL,
> -				 data->fan_main_ctrl);
> +
> +		if (data->type !=3D it8603) {
> +			/* set SmartGuardian mode */
> +			data->fan_main_ctrl |=3D (1 << nr);
> +			it87_write_value(data, IT87_REG_FAN_MAIN_CTRL,
> +					 data->fan_main_ctrl);
> +		}
>  	}
> =20
>  	mutex_unlock(&data->update_lock);
> @@ -1406,15 +1423,25 @@
>  		"3VSB",
>  		"Vbat",
>  	};
> +	static const char * const labels_it8603[] =3D {
> +		"AVCC3",
> +		"3VSB",
> +		"Vbat",
> +	};
>  	struct it87_data *data =3D dev_get_drvdata(dev);
>  	int nr =3D to_sensor_dev_attr(attr)->index;
> =20
> +	if (data->type =3D it8603)
> +		return sprintf(buf, "%s\n", labels_it8603[nr]);
> +
>  	return sprintf(buf, "%s\n", has_12mv_adc(data) ? labels_it8721[nr]
>  						       : labels[nr]);
>  }
>  static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_label, NULL, 0);
>  static SENSOR_DEVICE_ATTR(in7_label, S_IRUGO, show_label, NULL, 1);
>  static SENSOR_DEVICE_ATTR(in8_label, S_IRUGO, show_label, NULL, 2);
> +/* special AVCC3 IT8306 in9 */
> +static SENSOR_DEVICE_ATTR(in9_label, S_IRUGO, show_label, NULL, 0);
> =20
>  static ssize_t show_name(struct device *dev, struct device_attribute
>  			 *devattr, char *buf)
> @@ -1424,7 +1451,7 @@
>  }
>  static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
> =20
> -static struct attribute *it87_attributes_in[9][5] =3D {
> +static struct attribute *it87_attributes_in[10][5] =3D {
>  {
>  	&sensor_dev_attr_in0_input.dev_attr.attr,
>  	&sensor_dev_attr_in0_min.dev_attr.attr,
> @@ -1476,9 +1503,12 @@
>  }, {
>  	&sensor_dev_attr_in8_input.dev_attr.attr,
>  	NULL
> +}, {
> +	&sensor_dev_attr_in9_input.dev_attr.attr,
> +	NULL
>  } };
> =20
> -static const struct attribute_group it87_group_in[9] =3D {
> +static const struct attribute_group it87_group_in[10] =3D {
>  	{ .attrs =3D it87_attributes_in[0] },
>  	{ .attrs =3D it87_attributes_in[1] },
>  	{ .attrs =3D it87_attributes_in[2] },
> @@ -1488,6 +1518,7 @@
>  	{ .attrs =3D it87_attributes_in[6] },
>  	{ .attrs =3D it87_attributes_in[7] },
>  	{ .attrs =3D it87_attributes_in[8] },
> +	{ .attrs =3D it87_attributes_in[9] },
>  };
> =20
>  static struct attribute *it87_attributes_temp[3][6] =3D {
> @@ -1685,6 +1716,7 @@
>  	&sensor_dev_attr_in3_label.dev_attr.attr,
>  	&sensor_dev_attr_in7_label.dev_attr.attr,
>  	&sensor_dev_attr_in8_label.dev_attr.attr,
> +	&sensor_dev_attr_in9_label.dev_attr.attr,
>  	NULL
>  };
> =20
> @@ -1742,6 +1774,9 @@
>  	case IT8783E_DEVID:
>  		sio_data->type =3D it8783;
>  		break;
> +	case IT8306E_DEVID:
> +		sio_data->type =3D it8603;
> +		break;
>  	case 0xffff:	/* No device at all */
>  		goto exit;
>  	default:
> @@ -1763,11 +1798,13 @@
> =20
>  	err =3D 0;
>  	sio_data->revision =3D superio_inb(DEVREV) & 0x0f;
> -	pr_info("Found IT%04xF chip at 0x%x, revision %d\n",
> -		chip_type, *address, sio_data->revision);
> +	pr_info("Found IT%04x%c chip at 0x%x, revision %d\n", chip_type,
> +		chip_type =3D 0x8603 ? 'E' : 'F', *address,
> +		sio_data->revision);
> =20
>  	/* in8 (Vbat) is always internal */
>  	sio_data->internal =3D (1 << 2);
> +	sio_data->skip_in |=3D (1 << 9); /* No VIN9 by default */
> =20
>  	/* Read GPIO config and VID value from LDN 7 (GPIO) */
>  	if (sio_data->type =3D it87) {
> @@ -1844,7 +1881,42 @@
>  			sio_data->internal |=3D (1 << 1);
> =20
>  		sio_data->beep_pin =3D superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
> +	} if (sio_data->type =3D it8603) {
> +		int reg27, reg29;
> +
> +		sio_data->skip_vid =3D 1;	/* No VID */
> +		superio_select(GPIO);
> =20
> +		reg27 =3D superio_inb(IT87_SIO_GPIO3_REG);
> +
> +		/* Check if fan3 is there or not */
> +		if (reg27 & (1 << 6))
> +			sio_data->skip_pwm |=3D (1 << 2);
> +		if (reg27 & (1 << 7))
> +			sio_data->skip_fan |=3D (1 << 2);
> +
> +		/* Check if fan2 is there or not */
> +		reg29 =3D superio_inb(IT87_SIO_GPIO5_REG);
> +		if (reg29 & (1 << 1))
> +			sio_data->skip_pwm |=3D (1 << 1);
> +		if (reg29 & (1 << 2))
> +			sio_data->skip_fan |=3D (1 << 1);
> +
> +		sio_data->skip_in |=3D (1 << 5); /* No VIN5 */
> +		sio_data->skip_in |=3D (1 << 6); /* No VIN6 */
> +
> +		/* no fan4 */
> +		sio_data->skip_pwm |=3D (1 << 3);
> +		sio_data->skip_fan |=3D (1 << 3);
> +
> +		/* AVCC3 needs a special handling, map 0x2f to in9 */
> +		sio_data->internal |=3D (1 << 3); /* in9 has label */
> +		sio_data->skip_in &=3D ~(1 << 9); /* VIN9 mapped to 0x2f */
> +
> +		sio_data->internal |=3D (1 << 1); /* in7 is VSB */
> +		sio_data->internal |=3D (1 << 2); /* in8 is VBAT */
> +
> +		sio_data->beep_pin =3D superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
>  	} else {
>  		int reg;
>  		bool uart6;
> @@ -2072,6 +2144,9 @@
>  	/* Check PWM configuration */
>  	enable_pwm_interface =3D it87_check_pwm(dev);
> =20
> +	if (data->type =3D it8603)
> +		data->in_scaled |=3D (1 << 9); /* in9 is AVCC3 */
> +
>  	/* Starting with IT8721F, we handle scaling of internal voltages */
>  	if (has_12mv_adc(data)) {
>  		if (sio_data->internal & (1 << 0))
> @@ -2102,7 +2177,7 @@
>  	if (err)
>  		return err;
> =20
> -	for (i =3D 0; i < 9; i++) {
> +	for (i =3D 0; i < 10; i++) {
>  		if (sio_data->skip_in & (1 << i))
>  			continue;
>  		err =3D sysfs_create_group(&dev->kobj, &it87_group_in[i]);
> @@ -2202,7 +2277,7 @@
>  	}
> =20
>  	/* Export labels for internal sensors */
> -	for (i =3D 0; i < 3; i++) {
> +	for (i =3D 0; i < 4; i++) {
>  		if (!(sio_data->internal & (1 << i)))
>  			continue;
>  		err =3D sysfs_create_file(&dev->kobj,
> @@ -2383,8 +2458,8 @@
>  	}
>  	data->has_fan =3D (data->fan_main_ctrl >> 4) & 0x07;
> =20
> -	/* Set tachometers to 16-bit mode if needed */
> -	if (has_16bit_fans(data)) {
> +	/* Set tachometers to 16-bit mode if needed, IT8603E/IT8728? has it by =
default */
> +	if (has_16bit_fans(data) && data->type !=3D it8603) {
>  		tmp =3D it87_read_value(data, IT87_REG_FAN_16BIT);
>  		if (~tmp & 0x07 & data->has_fan) {
>  			dev_dbg(&pdev->dev,
> @@ -2462,6 +2537,10 @@
>  			data->in[i][2] >  				it87_read_value(data, IT87_REG_VIN_MAX(i));
>  		}
> +
> +		if (data->type =3D it8603)
> +			data->in[9][0] =3D it87_read_value(data, 0x2f);
> +
>  		/* in8 (battery) has no limit registers */
>  		data->in[8][0] =3D it87_read_value(data, IT87_REG_VIN(8));
> =20
>=20
>=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
