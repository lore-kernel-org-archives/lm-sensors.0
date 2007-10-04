From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 04 Oct 2007 20:59:58 +0000
Subject: Re: [lm-sensors] [PATCH 3/3 RESEND 2] hwmon/dme1737: add sch311x
Message-Id: <20071004225958.7c650e23@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0710012121s3298e13fn406408797a9fbcca@mail.gmail.com>
In-Reply-To: <191fb4ca0710012121s3298e13fn406408797a9fbcca@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Mon, 1 Oct 2007 21:21:38 -0700, Juerg Haefliger wrote:
> This patch adds support for the SMSC SCH3112, SCH3114, and SCH3116 Super-I/O
> chips. These chips feature identical hardware monitoring capabilites with the
> exception that some of the fan inputs and pmw outputs don't exist.
> 
> The hardware monitoring features of the SCH311x chips can only be accessed via
> the ISA bus. The driver therefore registers as a platform driver, if such a
> chip is detected.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Two comments on this second iteration:

> Index: linux-2.6/drivers/hwmon/dme1737.c
> =================================> --- linux-2.6.orig/drivers/hwmon/dme1737.c	2007-10-01 21:09:31.000000000 -0700
> +++ linux-2.6/drivers/hwmon/dme1737.c	2007-10-01 21:10:11.000000000 -0700
> @@ -1,12 +1,13 @@
>  /*
> - * dme1737.c - driver for the SMSC DME1737 and Asus A8000 Super-I/O chips
> - *             integrated hardware monitoring features.
> + * dme1737.c - Driver for the SMSC DME1737, Asus A8000, and SMSC SCH311x
> + *             Super-I/O chips integrated hardware monitoring features.
>   * Copyright (c) 2007 Juerg Haefliger <juergh@gmail.com>
>   *
> - * This driver is based on the LM85 driver. The hardware monitoring
> - * capabilities of the DME1737 are very similar to the LM85 with some
> - * additional features. Even though the DME1737 is a Super-I/O chip, the
> - * hardware monitoring registers are only accessible via SMBus.
> + * This driver is an I2C/ISA hybrid, meaning that it registers as an I2C client
> + * driver if a DME1737 (or A8000) is found and as an I2C client *and* platform
> + * driver if a SCH311x chip is found. Both types of chips have very similar

Still not true: the i2c driver is always registered, even if no
supported chip is found (as is the case for all i2c drivers, by
design). Maybe you can rephrase this to focus more on how the different
supported devices are accessed, than on what driver type is registered.

> + * hardware monitoring capabilities but differ in the way they can be accessed,
> + * either via I2C or ISA.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by

> +static ssize_t show_name(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct dme1737_data *data = dme1737_update_device(dev);
> +
> +	return sprintf(buf, "%s\n", data->client.name);
> +}

You do not need to update the device register cache to get the device
name: it's not read from the registers. It matters because the name
attribute is read by libsensors at initialization time, and you do not
want to read all the registers values when you don't need any. So you
can just use dev_get_drvdata() instead of dme1737_update_device().

All the rest looks OK to me, except that I had to replace all
occurrences of class_dev by hwmon_dev, as for the first patch.

Please update and resend.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
