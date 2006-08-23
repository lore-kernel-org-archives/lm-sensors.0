From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 23 Aug 2006 06:50:28 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <20060823085028.43ca5712.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> Attached is a patch for 2.6.18-rc4 as well as the complete driver
> (w83627ehf.c). It tests the return value when device_create_file() is
> called. I would like to add sysfs_create_group() calls with another
> patch. Anyone who would like to test the patch, please do.

I see very little benefit if making two separate patches for error
checking and grouping. Both will touch the very same code. Let's get it
right at once.

Also, when sending patches to the list, please set the attachement type
to text/plain rather than application/octet-stream. It will make it way
easier for people to read it.

> Sylvain, if you are running a 2.4-series kernel, take a look at
> i2c-isa_return_attach_adapter.patch as well (in this thread). I do not
> know if this will backport to the 2.4 kernel successfully.

No, it will not. Back in 2.4 i2c-isa was considered almost as a regular
i2c adapter, and you can't prevent a chip driver from loading just
because it failed to register a client on one of the many i2c adapters
of a system. So the best we could do was to issue a warning message in
the logs.

> I have also
> attached a regression test script (w83627ehf_regression.sh) which
> matches this driver. There is not a way to script a test for the
> changes made to correctly handle device_create_file() errors, so this
> regression test is the same as previous tests.

As discussed with Jim Cromie earlier, the only thing to check is that
the list of created files is unchanged before and after the patch.

You can also simulate an error at the last file creation, to make sure
the error path is tested at least once. I did that when updating
i2c-core, i2c-dev and i2c-isa, and found a bug thanks to this. Ideally
you should even test every possible error case, if you have more time.

To the code:

> diff -ur linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c
> --- linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c	2006-08-16 15:56:34.000000000 -0700
> +++ linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c	2006-08-21 23:02:59.000000000 -0700
> @@ -621,14 +621,6 @@
>        SENSOR_ATTR(in9_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 9),
>  };
>  
> -static void device_create_file_in(struct device *dev, int i)
> -{
> -	device_create_file(dev, &sda_in_input[i].dev_attr);
> -	device_create_file(dev, &sda_in_alarm[i].dev_attr);
> -	device_create_file(dev, &sda_in_min[i].dev_attr);
> -	device_create_file(dev, &sda_in_max[i].dev_attr);
> -}

You don't actually need to get rid of these functions if you are happy
with them. You could do something like:

static int device_create_file_in(struct device *dev, int i)
{
	int err;

	if ((err = device_create_file(dev, &sda_in_input[i].dev_attr))
	 || (err = device_create_file(dev, &sda_in_alarm[i].dev_attr))
	 || (err = device_create_file(dev, &sda_in_min[i].dev_attr))
	 || (err = device_create_file(dev, &sda_in_max[i].dev_attr)))
		return err;

	return 0;
}

> @@ -1223,30 +1198,92 @@
>  		goto exit_detach;
>  	}
>  
> -  	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays); i++)
> -  		device_create_file(dev, &sda_sf3_arrays[i].dev_attr);
> +  	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays); i++) {
> +		err = device_create_file(dev, &sda_sf3_arrays[i].dev_attr);
> +		if (err) goto exit_remove;
> +	}

Coding style: "goto exit_remove" should be on its own line.

> -	for (i = 0; i < 10; i++)
> -		device_create_file_in(dev, i);
> +	for (i = 0; i < 10; i++) {
> +		err = device_create_file(dev, &sda_in_input[i].dev_attr);
> +		if (err) goto exit_remove;
> +		err = device_create_file(dev, &sda_in_alarm[i].dev_attr);
> +		if (err) goto exit_remove;
> +		err = device_create_file(dev, &sda_in_min[i].dev_attr);
> +		if (err) goto exit_remove;
> +		err = device_create_file(dev, &sda_in_max[i].dev_attr);
> +		if (err) goto exit_remove;
> +	}

You can group the tests with || so you have a single "goto exit_remove"
for the whole block (see my proposed device_create_file_in above.)

> +exit_remove:
> +	/* some entries in the following arrays may not have been used in
> +	 * device_create_file(), but device_remove_file() will ignore them */
> +	for (i = 0; i < ARRAY_SIZE(sda_temp); i++)
> +		device_remove_file(dev, &sda_temp[i].dev_attr);
> +	for (i = 5; --i; ) {

Please, don't try to be smart. It doesn't even work (you exit at i = 0
before removing the [0] files.) Use a regular for loop, thanks.

> +		if (i < 4) { /* w83627ehf only has 4 pwm */
> +			device_remove_file(dev, &sda_tolerance[i].dev_attr);
> +			device_remove_file(dev, &sda_target_temp[i].dev_attr);
> +			device_remove_file(dev, &sda_pwm_enable[i].dev_attr);
> +			device_remove_file(dev, &sda_pwm_mode[i].dev_attr);
> +			device_remove_file(dev, &sda_pwm[i].dev_attr);
> +		}
> +		device_remove_file(dev, &sda_fan_min[i].dev_attr);
> +		device_remove_file(dev, &sda_fan_div[i].dev_attr);
> +		device_remove_file(dev, &sda_fan_alarm[i].dev_attr);
> +		device_remove_file(dev, &sda_fan_input[i].dev_attr);
> +	}
> +	for (i = 10; --i; ) {
> +		device_remove_file(dev, &sda_in_max[i].dev_attr);
> +		device_remove_file(dev, &sda_in_min[i].dev_attr);
> +		device_remove_file(dev, &sda_in_alarm[i].dev_attr);
> +		device_remove_file(dev, &sda_in_input[i].dev_attr);
> +	}
> +	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
> +		device_remove_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
> +	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays); i++)
> +		device_remove_file(dev, &sda_sf3_arrays[i].dev_attr);
> +	hwmon_device_unregister(data->class_dev);
>  exit_detach:
>  	i2c_detach_client(client);
>  exit_free:

Your patch does remove the files if creation failed, however it fails
to remove them if the device is removed later.

Please provide an updated patch.

Thanks,
-- 
Jean Delvare

