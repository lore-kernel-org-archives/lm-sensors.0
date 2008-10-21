From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Oct 2008 16:23:29 +0000
Subject: Re: [lm-sensors] PATCH: f71882fg move some io access from the
Message-Id: <20081021182329.1c3a375b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FDE62B.7020607@redhat.com>
In-Reply-To: <48FDE62B.7020607@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Tue, 21 Oct 2008 16:24:43 +0200, Hans de Goede wrote:
> The f71882fg driver did some io to ioports it hadn't reserved yet in its
> find (detect) function, this patches moves this io to the probe function
> where these ports are reserved and this io belongs.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Review:

> The f71882fg driver did some io to ioports it hadn't reserved yet in its
> find (detect) function, this patches moves this io to the probe function
> where these ports are reserved and this io belongs.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> --- linux/drivers/hwmon/f71882fg.c.f71862fg	2008-10-21 15:34:41.000000000 +0200
> +++ linux/drivers/hwmon/f71882fg.c	2008-10-21 15:50:34.000000000 +0200
> @@ -1495,7 +1495,7 @@
>  {
>  	struct f71882fg_data *data;
>  	struct f71882fg_sio_data *sio_data = pdev->dev.platform_data;
> -	int err;
> +	int err = 0;
>  	u8 start_reg;
>  
>  	data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL);
> @@ -1507,12 +1507,31 @@
>  	mutex_init(&data->update_lock);
>  	platform_set_drvdata(pdev, data);
>  
> +	start_reg = f71882fg_read8(data, F71882FG_REG_START);
> +	if (!(start_reg & 0x03)) {
> +		printk(KERN_WARNING DRVNAME
> +			": Hardware monitoring not activated\n");

Please use dev_info() instead.

> +		goto exit_free;

You're returning with err = 0, which means success. So when you unload
the driver, the f71882fg_remove() function will be called and you'll
double-free your private data structure. No good.

I think you should simply return -ENODEV here.

> +	}
> +
> +	/* If it is a 71862 and the fan / pwm part is enabled sanity check
> +	   the pwm settings */
> +	if (data->type = f71862fg && (start_reg & 0x02)) {
> +		u8 reg = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
> +		if ((reg & 0x15) != 0x15) {
> +			printk(KERN_ERR DRVNAME
> +				": Invalid (reserved) pwm settings: 0x%02x\n",
> +				(unsigned int)reg);

Here again please use dev_err().

> +			err = -EIO;

This isn't actually an I/O error, I think I'd return -ENODEV as well.
Or, ideally, you could simply disable the pwm features of the driver
but still let it bind. After all, voltage, temperature and fan features
are still useful, aren't they?

> +			goto exit_free;
> +		}
> +	}
> +
>  	/* Register sysfs interface files */
>  	err = device_create_file(&pdev->dev, &dev_attr_name);
>  	if (err)
>  		goto exit_unregister_sysfs;
>  
> -	start_reg = f71882fg_read8(data, F71882FG_REG_START);
>  	if (start_reg & 0x01) {
>  		err = f71882fg_create_sysfs_files(pdev, f718x2fg_in_temp_attr,
>  					ARRAY_SIZE(f718x2fg_in_temp_attr));
> @@ -1558,7 +1577,9 @@
>  
>  exit_unregister_sysfs:
>  	f71882fg_remove(pdev); /* Will unregister the sysfs files for us */
> -
> +	return err; /* f71882fg_remove() also frees our data */
> +exit_free:
> +	kfree(data);
>  	return err;
>  }
>  
> @@ -1600,8 +1621,6 @@
>  {
>  	int err = -ENODEV;
>  	u16 devid;
> -	u8 reg;
> -	struct f71882fg_data data;
>  
>  	superio_enter(sioaddr);
>  
> @@ -1638,25 +1657,6 @@
>  	}
>  	*address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */
>  
> -	data.addr = *address;
> -	reg = f71882fg_read8(&data, F71882FG_REG_START);
> -	if (!(reg & 0x03)) {
> -		printk(KERN_WARNING DRVNAME
> -			": Hardware monitoring not activated\n");
> -		goto exit;
> -	}
> -
> -	/* If it is a 71862 and the fan / pwm part is enabled sanity check
> -	   the pwm settings */
> -	if (sio_data->type = f71862fg && (reg & 0x02)) {
> -		reg = f71882fg_read8(&data, F71882FG_REG_PWM_ENABLE);
> -		if ((reg & 0x15) != 0x15) {
> -			printk(KERN_ERR DRVNAME
> -				": Invalid (reserved) pwm settings: 0x%02x\n",
> -				(unsigned int)reg);
> -			goto exit;
> -		}
> -	}
>  	err = 0;
>  	printk(KERN_INFO DRVNAME ": Found %s chip at %#x, revision %d\n",
>  		f71882fg_names[sio_data->type],	(unsigned int)*address,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
