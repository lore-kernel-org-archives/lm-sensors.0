From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Jun 2012 15:19:23 +0000
Subject: Re: [lm-sensors] [PATCH 84/95] hwmon: (w83792d) Convert to use devm_ functions
Message-Id: <20120617171923.63dbaa4e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-85-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-85-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:24:05 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/w83792d.c |   18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
> index ffb5fdf..9d5e7a2 100644
> --- a/drivers/hwmon/w83792d.c
> +++ b/drivers/hwmon/w83792d.c
> (...)
> @@ -1448,7 +1446,7 @@ w83792d_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	/* Register sysfs hooks */
>  	err = sysfs_create_group(&dev->kobj, &w83792d_group);
>  	if (err)
> -		goto ERROR3;
> +		goto i2c_unregister;
>  
>  	/*
>  	 * Read GPIO enable register to check if pins for fan 4,5 are used as
> @@ -1493,14 +1491,11 @@ exit_remove_files:
>  	sysfs_remove_group(&dev->kobj, &w83792d_group);
>  	for (i = 0; i < ARRAY_SIZE(w83792d_group_fan); i++)
>  		sysfs_remove_group(&dev->kobj, &w83792d_group_fan[i]);
> -ERROR3:
> +i2c_unregister:

For consistency with the other label, this one would rather be named
"exit_i2c_unregister" or "exit_unregister" if you prefer it shorter.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
