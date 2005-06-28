From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 28 Jun 2005 12:49:45 +0000
Subject: [lm-sensors] Re: [RFC PATCH] hwmon sysfs class, again
Message-Id: <QhWrqi62.1119955447.2910230.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050628041414.GA32087@jupiter.solarsys.private>
In-Reply-To: <20050628041414.GA32087@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

> Here are the "new and improved" hwmon sysfs class patches:
>
> http://members.dca.net/mhoffman/sensors/temp/20050627/

Looks all OK to me, except for:

> --- linux-2.6.12-git5.orig/drivers/hwmon/adm1026.c
> +++ linux-2.6.12-git5/drivers/hwmon/adm1026.c
> (...)
> @@ -1690,8 +1701,10 @@ int adm1026_detect(struct i2c_adapter *a
> (...)
>  exitfree:
> -	kfree(new_client);
> +	kfree(data);

Although this fix is correct, it would belong to
hwmon-chips-kfree-fix.patch, not hwmon-class-chips.patch.

Also, it looks to me like adm9240, smsc47m1 and smsc47b397 need the same
fix.

> --- linux-2.6.12-git5.orig/drivers/hwmon/asb100.c
> +++ linux-2.6.12-git5/drivers/hwmon/asb100.c
> (..)
> +        data->class_dev = hwmon_device_register(&new_client->dev);
> +        if (IS_ERR(data->class_dev)) {
> +                err = PTR_ERR(data->class_dev);
> +                goto ERROR3;
> +        }

Beware you are using spaces instead of tabulations here.

> --- linux-2.6.12-git5.orig/drivers/hwmon/w83781d.c
> +++ linux-2.6.12-git5/drivers/hwmon/w83781d.c
> (...)
> +ERROR4:
> +	if (NULL != data->lm75[1]) {
> +		i2c_detach_client(data->lm75[1]);
> +		kfree(data->lm75[1]);
> +	}
> +	if (NULL != data->lm75[0]) {
> +		i2c_detach_client(data->lm75[0]);
> +		kfree(data->lm75[0]);
> +	}

Please express the comparisons the other way around. I can guess why you
did it this way, but the usual style in the kernel is different and gcc
would warn you anyway.

Thanks,
--
Jean Delvare
