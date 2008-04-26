From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 26 Apr 2008 11:32:45 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon (dme1737): add support for
Message-Id: <20080426133245.0139d6c5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <480EC83A.6080709@gmail.com>
In-Reply-To: <480EC83A.6080709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Tue, 22 Apr 2008 22:25:14 -0700, Juerg Haefliger wrote:
> Add support for the SCH5027. The differences to the DME1737 are:
> - No support for programmable temp offsets
> - In auto mode, PWM outputs stay on min value if temp goes below low 
> threshold and can't be programmed to fully turn off
> - Different voltage scaling

This would be worth mentioning in Documentation/hwmon/dme1737. Right
now, this documentation file suggests that there are no differences
between the SCH5027 and the DME1737.

> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Review:

> 
> Index: linux/drivers/hwmon/dme1737.c
> =================================> --- linux.orig/drivers/hwmon/dme1737.c	2008-04-22 22:09:10.000000000 -0700
> +++ linux/drivers/hwmon/dme1737.c	2008-04-22 22:22:48.000000000 -0700
> @@ -1,6 +1,6 @@
>  /*
> - * dme1737.c - Driver for the SMSC DME1737, Asus A8000, and SMSC SCH311x
> - *             Super-I/O chips integrated hardware monitoring features.
> + * dme1737.c - Driver for the SMSC DME1737, Asus A8000, SMSC SCH5027 and
> + *             SCH311x Super-I/O chips integrated hardware monitoring features.
>   * Copyright (c) 2007 Juerg Haefliger <juergh@gmail.com>

+2008

>   *
>   * This driver is an I2C/ISA hybrid, meaning that it uses the I2C bus to access
> @@ -57,7 +57,7 @@
>  static const unsigned short normal_i2c[] = {0x2c, 0x2d, 0x2e, I2C_CLIENT_END};
>  
>  /* Insmod parameters */
> -I2C_CLIENT_INSMOD_1(dme1737);
> +I2C_CLIENT_INSMOD_2(dme1737, sch5027);
>  
>  /* ---------------------------------------------------------------------
>   * Registers
> @@ -163,6 +163,7 @@
>  #define DME1737_VERSTEP		0x88
>  #define DME1737_VERSTEP_MASK	0xf8
>  #define SCH311X_DEVICE		0x8c
> +#define SCH5027_VERSTEP		0x69
>  
>  /* Length of ISA address segment */
>  #define DME1737_EXTENT	2
> @@ -220,8 +221,12 @@
>  					 3300};
>  static const int IN_NOMINAL_SCH311x[] = {2500, 1500, 3300, 5000, 12000, 3300,
>  					 3300};
> +static const int IN_NOMINAL_SCH5027[] = {1125, 2250, 3300, 5000, 1125, 3300,
> +					 3300};
>  #define IN_NOMINAL(ix, type)	(((type) = dme1737) ? \
>  				IN_NOMINAL_DME1737[(ix)] : \
> +				((type) = sch5027) ? \
> +				IN_NOMINAL_SCH5027[(ix)] : \
>  				IN_NOMINAL_SCH311x[(ix)])

This works, but this will become increasingly inefficient as you add
support for new chip types. For better performance, you could either
have an array pointing to the various IN_NOMINAL arrays and access it
by index, or store a pointer to the right IN_NOMINAL array in
dme1737_data. This doesn't need to be done in this patch though, it can
be done later.

>  
>  /* Voltage input
> @@ -565,7 +570,8 @@
>  
>  	/* Sample register contents every 1 sec */
>  	if (time_after(jiffies, data->last_update + HZ) || !data->valid) {
> -		data->vid = dme1737_read(client, DME1737_REG_VID) & 0x3f;
> +		data->vid = dme1737_read(client, DME1737_REG_VID);
> +		data->vid &= (data->type = sch5027) ? 0x38 : 0x3f;

This can't be correct. VID values are at least 4 bit wide and always
right-padded. Masking with 0x38 just doesn't make sense. Can you
explain?

>  
>  		/* In (voltage) registers */
>  		for (ix = 0; ix < ARRAY_SIZE(data->in); ix++) {
> @@ -593,8 +599,10 @@
>  					DME1737_REG_TEMP_MIN(ix));
>  			data->temp_max[ix] = dme1737_read(client,
>  					DME1737_REG_TEMP_MAX(ix));
> -			data->temp_offset[ix] = dme1737_read(client,
> -					DME1737_REG_TEMP_OFFSET(ix));
> +			if (data->type != sch5027) {
> +				data->temp_offset[ix] = dme1737_read(client,
> +						DME1737_REG_TEMP_OFFSET(ix));
> +			}
>  		}
>  
>  		/* In and temp LSB registers

What about zone1_auto_point*_temp_hyst? When these files are not
created it seems to me that you could skip reading from
DME1737_REG_ZONE_HYST registers.

> @@ -1570,31 +1578,25 @@
>  	&sensor_dev_attr_temp1_max.dev_attr.attr,
>  	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp1_fault.dev_attr.attr,
> -	&sensor_dev_attr_temp1_offset.dev_attr.attr,
>  	&sensor_dev_attr_temp2_input.dev_attr.attr,
>  	&sensor_dev_attr_temp2_min.dev_attr.attr,
>  	&sensor_dev_attr_temp2_max.dev_attr.attr,
>  	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp2_fault.dev_attr.attr,
> -	&sensor_dev_attr_temp2_offset.dev_attr.attr,
>  	&sensor_dev_attr_temp3_input.dev_attr.attr,
>  	&sensor_dev_attr_temp3_min.dev_attr.attr,
>  	&sensor_dev_attr_temp3_max.dev_attr.attr,
>  	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp3_fault.dev_attr.attr,
> -	&sensor_dev_attr_temp3_offset.dev_attr.attr,
>  	/* Zones */
> -	&sensor_dev_attr_zone1_auto_point1_temp_hyst.dev_attr.attr,
>  	&sensor_dev_attr_zone1_auto_point1_temp.dev_attr.attr,
>  	&sensor_dev_attr_zone1_auto_point2_temp.dev_attr.attr,
>  	&sensor_dev_attr_zone1_auto_point3_temp.dev_attr.attr,
>  	&sensor_dev_attr_zone1_auto_channels_temp.dev_attr.attr,
> -	&sensor_dev_attr_zone2_auto_point1_temp_hyst.dev_attr.attr,
>  	&sensor_dev_attr_zone2_auto_point1_temp.dev_attr.attr,
>  	&sensor_dev_attr_zone2_auto_point2_temp.dev_attr.attr,
>  	&sensor_dev_attr_zone2_auto_point3_temp.dev_attr.attr,
>  	&sensor_dev_attr_zone2_auto_channels_temp.dev_attr.attr,
> -	&sensor_dev_attr_zone3_auto_point1_temp_hyst.dev_attr.attr,
>  	&sensor_dev_attr_zone3_auto_point1_temp.dev_attr.attr,
>  	&sensor_dev_attr_zone3_auto_point2_temp.dev_attr.attr,
>  	&sensor_dev_attr_zone3_auto_point3_temp.dev_attr.attr,
> @@ -1609,6 +1611,25 @@
>  	.attrs = dme1737_attr,
>  };
>  
> +/* The following struct holds misc attributes, which are not available in all
> + * chips. Their creation depends on the chip type which is determined during
> + * module load. */
> +static struct attribute *dme1737_misc_attr[] = {
> +	/* Temperatures */
> +	&sensor_dev_attr_temp1_offset.dev_attr.attr,
> +	&sensor_dev_attr_temp2_offset.dev_attr.attr,
> +	&sensor_dev_attr_temp3_offset.dev_attr.attr,
> +	/* Zones */
> +	&sensor_dev_attr_zone1_auto_point1_temp_hyst.dev_attr.attr,
> +	&sensor_dev_attr_zone2_auto_point1_temp_hyst.dev_attr.attr,
> +	&sensor_dev_attr_zone3_auto_point1_temp_hyst.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group dme1737_misc_group = {
> +	.attrs = dme1737_misc_attr,
> +};
> +
>  /* The following structs hold the PWM attributes, some of which are optional.
>   * Their creation depends on the chip configuration which is determined during
>   * module load. */
> @@ -1618,7 +1639,6 @@
>  	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_ramp_rate.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_auto_channels_zone.dev_attr.attr,
> -	&sensor_dev_attr_pwm1_auto_pwm_min.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
>  	NULL
> @@ -1629,7 +1649,6 @@
>  	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
>  	&sensor_dev_attr_pwm2_ramp_rate.dev_attr.attr,
>  	&sensor_dev_attr_pwm2_auto_channels_zone.dev_attr.attr,
> -	&sensor_dev_attr_pwm2_auto_pwm_min.dev_attr.attr,
>  	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
>  	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
>  	NULL
> @@ -1640,7 +1659,6 @@
>  	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
>  	&sensor_dev_attr_pwm3_ramp_rate.dev_attr.attr,
>  	&sensor_dev_attr_pwm3_auto_channels_zone.dev_attr.attr,
> -	&sensor_dev_attr_pwm3_auto_pwm_min.dev_attr.attr,
>  	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
>  	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
>  	NULL
> @@ -1667,6 +1685,15 @@
>  	{ .attrs = dme1737_pwm6_attr },
>  };
>  
> +/* The following struct holds misc PWM attributes, which are not available in
> + * all chips. Their creation depends on the chip type which is determined
> + * during module load. */
> +static struct attribute *dme1737_pwm_misc_attr[] = {
> +	&sensor_dev_attr_pwm1_auto_pwm_min.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_pwm_min.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_pwm_min.dev_attr.attr,
> +};
> +
>  /* The following structs hold the fan attributes, some of which are optional.
>   * Their creation depends on the chip configuration which is determined during
>   * module load. */
> @@ -1722,31 +1749,23 @@
>  	{ .attrs = dme1737_fan6_attr },
>  };
>  
> -/* The permissions of all of the following attributes are changed to read-
> +/* The permissions of the following zone attributes are changed to read-
>   * writeable if the chip is *not* locked. Otherwise they stay read-only. */
> -static struct attribute *dme1737_misc_chmod_attr[] = {
> -	/* Temperatures */
> -	&sensor_dev_attr_temp1_offset.dev_attr.attr,
> -	&sensor_dev_attr_temp2_offset.dev_attr.attr,
> -	&sensor_dev_attr_temp3_offset.dev_attr.attr,
> -	/* Zones */
> -	&sensor_dev_attr_zone1_auto_point1_temp_hyst.dev_attr.attr,
> +static struct attribute *dme1737_zone_chmod_attr[] = {
>  	&sensor_dev_attr_zone1_auto_point1_temp.dev_attr.attr,
>  	&sensor_dev_attr_zone1_auto_point2_temp.dev_attr.attr,
>  	&sensor_dev_attr_zone1_auto_point3_temp.dev_attr.attr,
> -	&sensor_dev_attr_zone2_auto_point1_temp_hyst.dev_attr.attr,
>  	&sensor_dev_attr_zone2_auto_point1_temp.dev_attr.attr,
>  	&sensor_dev_attr_zone2_auto_point2_temp.dev_attr.attr,
>  	&sensor_dev_attr_zone2_auto_point3_temp.dev_attr.attr,
> -	&sensor_dev_attr_zone3_auto_point1_temp_hyst.dev_attr.attr,
>  	&sensor_dev_attr_zone3_auto_point1_temp.dev_attr.attr,
>  	&sensor_dev_attr_zone3_auto_point2_temp.dev_attr.attr,
>  	&sensor_dev_attr_zone3_auto_point3_temp.dev_attr.attr,
>  	NULL
>  };
>  
> -static const struct attribute_group dme1737_misc_chmod_group = {
> -	.attrs = dme1737_misc_chmod_attr,
> +static const struct attribute_group dme1737_zone_chmod_group = {
> +	.attrs = dme1737_zone_chmod_attr,
>  };
>  
>  /* The permissions of the following PWM attributes are changed to read-
> @@ -1757,7 +1776,6 @@
>  	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_ramp_rate.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_auto_channels_zone.dev_attr.attr,
> -	&sensor_dev_attr_pwm1_auto_pwm_min.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
>  	NULL
>  };
> @@ -1766,7 +1784,6 @@
>  	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
>  	&sensor_dev_attr_pwm2_ramp_rate.dev_attr.attr,
>  	&sensor_dev_attr_pwm2_auto_channels_zone.dev_attr.attr,
> -	&sensor_dev_attr_pwm2_auto_pwm_min.dev_attr.attr,
>  	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
>  	NULL
>  };
> @@ -1775,7 +1792,6 @@
>  	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
>  	&sensor_dev_attr_pwm3_ramp_rate.dev_attr.attr,
>  	&sensor_dev_attr_pwm3_auto_channels_zone.dev_attr.attr,
> -	&sensor_dev_attr_pwm3_auto_pwm_min.dev_attr.attr,
>  	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
>  	NULL
>  };
> @@ -1875,9 +1891,17 @@
>  		if (data->has_pwm & (1 << ix)) {
>  			sysfs_remove_group(&dev->kobj,
>  					   &dme1737_pwm_group[ix]);
> +			if (data->type != sch5027 && ix < 4) {
> +				sysfs_remove_file(&dev->kobj,
> +						  dme1737_pwm_misc_attr[ix]);
> +			}

dme1737_pwm_misc_attr[3] doesn't exist, so you should use
"&& ix < 3" in the test above. I agree that "data->has_pwm & (1 << 3)"
is always false in the current state of things, so it doesn't change
anything right now, but it would still feel safer.

>  		}
>  	}
>  
> +	if (data->type != sch5027) {
> +		sysfs_remove_group(&dev->kobj, &dme1737_misc_group);
> +	}
> +
>  	sysfs_remove_group(&dev->kobj, &dme1737_group);
>  
>  	if (!data->client.driver) {
> @@ -1901,6 +1925,13 @@
>  		goto exit_remove;
>  	}
>  
> +	/* Create misc sysfs attributes */
> +	if ((data->type != sch5027) &&
> +	    (err = sysfs_create_group(&dev->kobj,
> +				      &dme1737_misc_group))) {
> +		goto exit_remove;
> +	}
> +
>  	/* Create fan sysfs attributes */
>  	for (ix = 0; ix < ARRAY_SIZE(dme1737_fan_group); ix++) {
>  		if (data->has_fan & (1 << ix)) {
> @@ -1918,6 +1949,11 @@
>  						&dme1737_pwm_group[ix]))) {
>  				goto exit_remove;
>  			}
> +			if (data->type != sch5027 && ix < 4 &&

Same here.

> +			    (err = sysfs_create_file(&dev->kobj,
> +						dme1737_pwm_misc_attr[ix]))) {
> +				goto exit_remove;
> +			}
>  		}
>  	}
>  
> @@ -1927,16 +1963,27 @@
>  		dev_info(dev, "Device is locked. Some attributes "
>  			 "will be read-only.\n");
>  	} else {
> -		/* Change permissions of standard sysfs attributes */
> -		dme1737_chmod_group(dev, &dme1737_misc_chmod_group,
> +		/* Change permissions of zone sysfs attributes */
> +		dme1737_chmod_group(dev, &dme1737_zone_chmod_group,
>  				    S_IRUGO | S_IWUSR);
>  
> +		/* Change permissions of misc sysfs attributes */
> +		if (data->type != sch5027) {
> +			dme1737_chmod_group(dev, &dme1737_misc_group,
> +					    S_IRUGO | S_IWUSR);
> +		}
> +
>  		/* Change permissions of PWM sysfs attributes */
>  		for (ix = 0; ix < ARRAY_SIZE(dme1737_pwm_chmod_group); ix++) {
>  			if (data->has_pwm & (1 << ix)) {
>  				dme1737_chmod_group(dev,
>  						&dme1737_pwm_chmod_group[ix],
>  						S_IRUGO | S_IWUSR);
> +				if (data->type != sch5027 && ix < 4) {
> +					dme1737_chmod_file(dev,
> +						dme1737_pwm_misc_attr[ix],
> +						S_IRUGO | S_IWUSR);
> +				}

And here.

>  			}
>  		}
>  
> @@ -2095,9 +2142,10 @@
>  	dme1737_sio_enter(sio_cip);
>  
>  	/* Check device ID
> -	 * The DME1737 can return either 0x78 or 0x77 as its device ID. */
> +	 * The DME1737 can return either 0x78 or 0x77 as its device ID.
> +	 * The SCH5027 returns 0x89 as its device ID. */
>  	reg = force_id ? force_id : dme1737_sio_inb(sio_cip, 0x20);
> -	if (!(reg = 0x77 || reg = 0x78)) {
> +	if (!(reg = 0x77 || reg = 0x78 || reg = 0x89)) {
>  		err = -ENODEV;
>  		goto exit;
>  	}
> @@ -2166,15 +2214,23 @@
>  		company = dme1737_read(client, DME1737_REG_COMPANY);
>  		verstep = dme1737_read(client, DME1737_REG_VERSTEP);
>  
> -		if (!((company = DME1737_COMPANY_SMSC) &&
> -		      ((verstep & DME1737_VERSTEP_MASK) = DME1737_VERSTEP))) {
> +		if (company = DME1737_COMPANY_SMSC &&
> +		    (verstep & DME1737_VERSTEP_MASK) = DME1737_VERSTEP) {
> +			kind = dme1737;
> +		} else if (company = DME1737_COMPANY_SMSC &&
> +			   verstep = SCH5027_VERSTEP) {
> +			kind = sch5027;
> +		} else {
>  			err = -ENODEV;
>  			goto exit_kfree;
>  		}
>  	}
>  
> -	kind = dme1737;
> -	name = "dme1737";
> +	if (kind = dme1737) {
> +		name = "dme1737";
> +	} else {
> +		name = "sch5027";
> +	}
>  	data->type = kind;

kind could be 0 (driver loaded with the "force" parameter.) In this
case you are using the name "sch5027", but with the feature set of the
DME1737 and the voltage scaling of the SCH311x. That's pretty confusing
isn't it? I suggest that you instead treat force as equivalent to
force_dme1737, as you were doing before.

>  
>  	/* Fill in the remaining client fields and put it into the global
> @@ -2187,8 +2243,9 @@
>  		goto exit_kfree;
>  	}
>  
> -	dev_info(dev, "Found a DME1737 chip at 0x%02x (rev 0x%02x).\n",
> -		 client->addr, verstep);
> +	dev_info(dev, "Found a %s chip at 0x%02x (rev 0x%02x).\n",
> +		 kind = sch5027 ? "SCH5027" : "DME1737", client->addr,
> +		 verstep);
>  
>  	/* Initialize the DME1737 chip */
>  	if ((err = dme1737_init_device(dev))) {
> Index: linux/Documentation/hwmon/dme1737
> =================================> --- linux.orig/Documentation/hwmon/dme1737	2008-04-22 22:02:40.000000000 -0700
> +++ linux/Documentation/hwmon/dme1737	2008-04-22 22:15:48.000000000 -0700
> @@ -10,6 +10,11 @@
>      Prefix: 'sch311x'
>      Addresses scanned: none, address read from Super-I/O config space
>      Datasheet: http://www.nuhorizons.com/FeaturedProducts/Volume1/SMSC/311x.pdf
> +  * SMSC SCH5027
> +    Prefix: 'sch5027'
> +    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
> +    Datasheet: Provided by SMSC upon request and under NDA
> +
>  

One less blank line?

</nitpicking>

>  Authors:
>      Juerg Haefliger <juergh@gmail.com>
> @@ -27,33 +32,31 @@
>  			following boards:
>  			- VIA EPIA SN18000
>  
> -Note that there is no need to use this parameter if the driver loads without
> -complaining. The driver will say so if it is necessary.
> -
>  
>  Description
>  -----------
>  
>  This driver implements support for the hardware monitoring capabilities of the
> -SMSC DME1737 and Asus A8000 (which are the same) and SMSC SCH311x Super-I/O
> -chips. These chips feature monitoring of 3 temp sensors temp[1-3] (2 remote
> -diodes and 1 internal), 7 voltages in[0-6] (6 external and 1 internal) and up
> -to 6 fan speeds fan[1-6]. Additionally, the chips implement up to 5 PWM
> -outputs pwm[1-3,5-6] for controlling fan speeds both manually and
> +SMSC DME1737 and Asus A8000 (which are the same), SMSC SCH5027, and SMSC
> +SCH311x Super-I/O chips. These chips feature monitoring of 3 temp sensors
> +temp[1-3] (2 remote diodes and 1 internal), 7 voltages in[0-6] (6 external and
> +1 internal) and up to 6 fan speeds fan[1-6]. Additionally, the chips implement
> +up to 5 PWM outputs pwm[1-3,5-6] for controlling fan speeds both manually and
>  automatically.
>  
> -For the DME1737 and A8000, fan[1-2] and pwm[1-2] are always present. Fan[3-6]
> -and pwm[3,5-6] are optional features and their availability depends on the
> -configuration of the chip. The driver will detect which features are present
> -during initialization and create the sysfs attributes accordingly.
> +For the DME1737, A8000 and SCH5027, fan[1-2] and pwm[1-2] are always present.
> +Fan[3-6] and pwm[3,5-6] are optional features and their availability depends on
> +the configuration of the chip. The driver will detect which features are
> +present during initialization and create the sysfs attributes accordingly.
>  
>  For the SCH311x, fan[1-3] and pwm[1-3] are always present and fan[4-6] and
>  pwm[5-6] don't exist.
>  
> -The hardware monitoring features of the DME1737 and A8000 are only accessible
> -via SMBus, while the SCH311x only provides access via the ISA bus. The driver
> -will therefore register itself as an I2C client driver if it detects a DME1737
> -or A8000 and as a platform driver if it detects a SCH311x chip.
> +The hardware monitoring features of the DME1737, A8000, and SCH5027 are only
> +accessible via SMBus, while the SCH311x only provides access via the ISA bus.
> +The driver will therefore register itself as an I2C client driver if it detects
> +a DME1737, A8000, or SCH5027 and as a platform driver if it detects a SCH311x
> +chip.
>  
>  
>  Voltage Monitoring
> Index: linux/drivers/hwmon/Kconfig
> =================================> --- linux.orig/drivers/hwmon/Kconfig	2008-04-22 22:02:40.000000000 -0700
> +++ linux/drivers/hwmon/Kconfig	2008-04-22 22:15:48.000000000 -0700
> @@ -549,8 +549,8 @@
>  	select HWMON_VID
>  	help
>  	  If you say yes here you get support for the hardware monitoring
> -	  and fan control features of the SMSC DME1737 (and compatibles
> -	  like the Asus A8000) and SCH311x Super-I/O chips.
> +	  and fan control features of the SMSC DME1737, SCH311x, SCH5027, and
> +	  Asus A8000 Super-I/O chips.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called dme1737.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
