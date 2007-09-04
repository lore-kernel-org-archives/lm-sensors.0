From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 04 Sep 2007 09:06:49 +0000
Subject: Re: [lm-sensors] [PATCH] update w83791d driver with new sysfs
Message-Id: <20070904110649.63253691@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80709021541p381974dftc4f725e65d2b8189@mail.gmail.com>
In-Reply-To: <5bfe43f80709021541p381974dftc4f725e65d2b8189@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

On Mon, 3 Sep 2007 19:55:52 -0700, Charles Spirakis wrote:
> Updated based on the comments in this email thread.
> 
> Please take another look.

OK, we're getting there, but I have a few more comments:

> diff -urpN linux-2.6.23-rc1-git10/Documentation/hwmon/w83791d linux-2.6.23-rc1-git10_w83791d/Documentation/hwmon/w83791d
> --- linux-2.6.23-rc1-git10/Documentation/hwmon/w83791d	2007-07-22 13:41:00.000000000 -0700
> +++ linux-2.6.23-rc1-git10_w83791d/Documentation/hwmon/w83791d	2007-09-03 14:59:18.000000000 -0700
> @@ -75,8 +75,31 @@ Voltage sensors (also known as IN sensor
>  An alarm is triggered if the voltage has crossed a programmable minimum
>  or maximum limit.
>  
> -The bit ordering for the alarm "realtime status register" and the
> -"beep enable registers" are different.
> +The w83791d driver has two ways to access the beep_enable and alarm

There seems to be a confusion between beep_enable and beep_mask. The
feature that is replaced by individual files is beep_mask. beep_enable
is still there. The same confusion is present in the bit position table
below.

This makes me realize that the new libsensors doesn't support
beep_enable. I need to add it.

> +functionality of the chip. The first way is via legacy bitmask files in
> +sysfs named alarms and beep_mask. The second way is via the new xxx_alarm
> +and xxx_beep files as describe in the .../Documentation/hwmon/sysfs-interface.

"xxx" is probably better written "*".

s/describe/described/

s/in the/in/

> +
> +Since both methods read and write the underlying hardware, they can be used
> +interchangeably and changes in one will automatically be reflected by
> +the other. If you use the legacy bitmask method, your user-space code is
> +responsible for handling the fact that the alarm and beep_enable bitmasks

beep_mask

> +are not the same (see the table below).
> +
> +NOTE: All new code should be written to use the newer sysfs-interface
> +specification as that avoids this problem and is the preferred interface
> +going forward.
> +
> +When an alarm goes off, you can be warned by a beeping signal through your
> +computer speaker. It is possible to enable all beeping globally, or only
> +the beeping for some alarms.
> +
> +The driver only reads the chip values each 3 seconds; reading them more
> +often will do no harm, but will return 'old' values.
> +
> +Alarm bitmask vs. beep_enable bitmask
> +------------------------------------

beep_mask

> +For legacy code using the legacy alarms and beep_enable bitmask files:
>  
>  in0 (VCORE)  :  alarms: 0x000001 beep_enable: 0x000001
>  in1 (VINR0)  :  alarms: 0x000002 beep_enable: 0x002000 <= mismatch
> @@ -102,19 +125,6 @@ tart3        :  alarms: 0x040000 beep_en
>  case_open    :  alarms: 0x001000 beep_enable: 0x001000
>  user_enable  :  alarms: -------- beep_enable: 0x800000

Thanks for the documentation update.

> diff -urpN linux-2.6.23-rc1-git10/drivers/hwmon/w83791d.c linux-2.6.23-rc1-git10_w83791d/drivers/hwmon/w83791d.c
> --- linux-2.6.23-rc1-git10/drivers/hwmon/w83791d.c	2007-07-22 13:41:00.000000000 -0700
> +++ linux-2.6.23-rc1-git10_w83791d/drivers/hwmon/w83791d.c	2007-09-03 18:07:27.000000000 -0700
> @@ -2,7 +2,7 @@
>      w83791d.c - Part of lm_sensors, Linux kernel modules for hardware
>                  monitoring
>  
> -    Copyright (C) 2006 Charles Spirakis <bezaur@gmail.com>
> +    Copyright (C) 2006-2007 Charles Spirakis <bezaur@gmail.com>
>  
>      This program is free software; you can redistribute it and/or modify
>      it under the terms of the GNU General Public License as published by
> @@ -384,6 +384,82 @@ static struct sensor_device_attribute sd
>  	SENSOR_ATTR(in9_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 9),
>  };
>  
> +
> +static ssize_t show_beep(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *sensor_attr > +						to_sensor_dev_attr(attr);
> +	struct w83791d_data *data = w83791d_update_device(dev);
> +	int bitnr = sensor_attr->index;
> +
> +	return sprintf(buf, "%d\n", (data->beep_mask >> bitnr) & 1);
> +}
> +
> +static ssize_t store_beep(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *sensor_attr > +						to_sensor_dev_attr(attr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct w83791d_data *data = i2c_get_clientdata(client); \

Stray trailing backslash.

> +	int bitnr = sensor_attr->index;
> +	int bytenr = bitnr / 8;
> +	long val = simple_strtol(buf, NULL, 10) ? 1 : 0;
> +	long beep_bit = val << bitnr;
> +
> +	mutex_lock(&data->update_lock);
> +

You're missing a register read here, to refresh the value of
data->beep_mask which may be old (or even uninitialized):

	data->beep_mask &= ~(0xff << (bytenr * 8));
	data->beep_mask |= w83791d_read(client, W83791D_REG_BEEP_CTRL[bytenr])
			   << (bytenr * 8);

> +	data->beep_mask &= ~(1 << bitnr);
> +	data->beep_mask |= (beep_bit);

Parentheses are not needed. BTW this is the only place where you use
beep_bit so I'm not sure if you need a local variable.

> +
> +	w83791d_write(client, W83791D_REG_BEEP_CTRL[bytenr],
> +		(data->beep_mask >> (bytenr * 8)) & 0xff);
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}

The rest is all OK.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
