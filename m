From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 14 Aug 2006 13:02:21 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <20060814150221.61d7138a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> Added w83627hf, which should demonstrate how to do all the remaining
> hwmon drivers.  There is more (ab)use of sysfs_remove_group() here to
> make life easier.

Yeah, I like it. Your approach deals nicely with chip-dependent files
and it can be applied to all drivers as far as I can see.

> This patch was lightly tested against w83627thf.  Testing on the other
> variants supported by that driver would be nice.

I don't have any supported chip here (yet), sorry.

> --- linux-2.6.18-rc4-mm1.orig/drivers/hwmon/w83627hf.c
> +++ linux-2.6.18-rc4-mm1/drivers/hwmon/w83627hf.c

> @@ -1107,62 +1138,93 @@ static int w83627hf_detect(struct i2c_ad
>  	data->fan_min[1] = w83627hf_read_value(new_client, W83781D_REG_FAN_MIN(2));
>  	data->fan_min[2] = w83627hf_read_value(new_client, W83781D_REG_FAN_MIN(3));
>  
> -	/* Register sysfs hooks */
> -	data->class_dev = hwmon_device_register(&new_client->dev);
> -	if (IS_ERR(data->class_dev)) {
> -		err = PTR_ERR(data->class_dev);
> +	/* Register common device attributes */
> +	if ((err = sysfs_create_group(&new_client->dev.kobj, &w83627hf_group)))
>  		goto ERROR3;
> +
> +	/* Register chip-specific device attributes */
> +	if (kind != w83697hf) {
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_in1_input)))
> +			goto ERROR4;
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_in1_min)))
> +			goto ERROR4;
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_in1_max)))
> +			goto ERROR4;
>  	}

What about:

	if (kind != w83697hf) {
		if ((err = device_create_file(&new_client->dev,
					&dev_attr_in1_input))
		 || (err = device_create_file(&new_client->dev,
					&dev_attr_in1_min))
		 || (err = device_create_file(&new_client->dev,
					&dev_attr_in1_max)))
			goto ERROR4;
	}

More concise and it works just as fine, doesn't it? Same applies below.

Maybe you can also group the two (kind != w83697hf) blocks?

>  
> -	device_create_file_in(new_client, 0);
> -	if (kind != w83697hf)
> -		device_create_file_in(new_client, 1);
> -	device_create_file_in(new_client, 2);
> -	device_create_file_in(new_client, 3);
> -	device_create_file_in(new_client, 4);
>  	if (kind = w83627hf || kind = w83697hf) {
> -		device_create_file_in(new_client, 5);
> -		device_create_file_in(new_client, 6);
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_in5_input)))
> +			goto ERROR4;
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_in5_min)))
> +			goto ERROR4;
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_in5_max)))
> +			goto ERROR4;
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_in6_input)))
> +			goto ERROR4;
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_in6_min)))
> +			goto ERROR4;
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_in6_max)))
> +			goto ERROR4;
> +	}
> +
> +	if (kind != w83697hf) {
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_fan3_input)))
> +			goto ERROR4;
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_fan3_min)))
> +			goto ERROR4;
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_fan3_div)))
> +			goto ERROR4;
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_temp3_input)))
> +			goto ERROR4;
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_temp3_max)))
> +			goto ERROR4;
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_temp3_max_hyst)))
> +			goto ERROR4;
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_temp3_type)))
> +			goto ERROR4;
>  	}
> -	device_create_file_in(new_client, 7);
> -	device_create_file_in(new_client, 8);
> -
> -	device_create_file_fan(new_client, 1);
> -	device_create_file_fan(new_client, 2);
> -	if (kind != w83697hf)
> -		device_create_file_fan(new_client, 3);
> -
> -	device_create_file_temp(new_client, 1);
> -	device_create_file_temp(new_client, 2);
> -	if (kind != w83697hf)
> -		device_create_file_temp(new_client, 3);
>  
>  	if (kind != w83697hf && data->vid != 0xff) {
> -		device_create_file_vid(new_client);
> -		device_create_file_vrm(new_client);
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_cpu0_vid)))
> +			goto ERROR4;
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_vrm)))
> +			goto ERROR4;
>  	}
>  
> -	device_create_file_fan_div(new_client, 1);
> -	device_create_file_fan_div(new_client, 2);
> -	if (kind != w83697hf)
> -		device_create_file_fan_div(new_client, 3);
> -
> -	device_create_file_alarms(new_client);
> -
> -	device_create_file_beep(new_client);
> -
> -	device_create_file_pwm(new_client, 1);
> -	device_create_file_pwm(new_client, 2);
>  	if (kind = w83627thf || kind = w83637hf || kind = w83687thf)
> -		device_create_file_pwm(new_client, 3);
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_pwm3)))
> +			goto ERROR4;
>  
> -	device_create_file_sensor(new_client, 1);
> -	device_create_file_sensor(new_client, 2);
> -	if (kind != w83697hf)
> -		device_create_file_sensor(new_client, 3);
> +	data->class_dev = hwmon_device_register(&new_client->dev);
> +	if (IS_ERR(data->class_dev)) {
> +		err = PTR_ERR(data->class_dev);
> +		goto ERROR4;
> +	}
>  
>  	return 0;
>  
> +      ERROR4:
> +	sysfs_remove_group(&new_client->dev.kobj, &w83627hf_group);
> +	sysfs_remove_group(&new_client->dev.kobj, &w83627hf_group_opt);
>        ERROR3:
>  	i2c_detach_client(new_client);
>        ERROR2:

Thanks,
-- 
Jean Delvare

