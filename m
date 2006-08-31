From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 31 Aug 2006 18:56:47 +0000
Subject: [lm-sensors] [PATCH 2.6.18-rc4-mm3] hwmon: unchecked return
Message-Id: <20060831205647.5785ba9d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060830030502.GA5104@jupiter.solarsys.private>
In-Reply-To: <20060830030502.GA5104@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> This patch fixes up some hwmon drivers so that they no longer ignore
> return status from device_create_file().  Compile-tested only.

I have an ADM1025 eval board somewhere, I'll try to resurect it
tomorrow and I'll test adm1025. I can't see why it wouldn't work
though.

Just one thing...

> --- linux-2.6.18-rc4-mm3.orig/drivers/hwmon/adm1025.c
> +++ linux-2.6.18-rc4-mm3/drivers/hwmon/adm1025.c
> @@ -315,6 +315,49 @@ static int adm1025_attach_adapter(struct
>  	return i2c_probe(adapter, &addr_data, adm1025_detect);
>  }
>  
> +static struct attribute *adm1025_attributes[] = {
> +	&dev_attr_in0_input.attr,
> +	&dev_attr_in1_input.attr,
> +	&dev_attr_in2_input.attr,
> +	&dev_attr_in3_input.attr,
> +	&dev_attr_in5_input.attr,
> +	&dev_attr_in0_min.attr,
> +	&dev_attr_in1_min.attr,
> +	&dev_attr_in2_min.attr,
> +	&dev_attr_in3_min.attr,
> +	&dev_attr_in5_min.attr,
> +	&dev_attr_in0_max.attr,
> +	&dev_attr_in1_max.attr,
> +	&dev_attr_in2_max.attr,
> +	&dev_attr_in3_max.attr,
> +	&dev_attr_in5_max.attr,
> +	&dev_attr_temp1_input.attr,
> +	&dev_attr_temp2_input.attr,
> +	&dev_attr_temp1_min.attr,
> +	&dev_attr_temp2_min.attr,
> +	&dev_attr_temp1_max.attr,
> +	&dev_attr_temp2_max.attr,
> +	&dev_attr_alarms.attr,
> +	&dev_attr_cpu0_vid.attr,
> +	&dev_attr_vrm.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group adm1025_group = {
> +	.attrs = adm1025_attributes,
> +};
> +
> +static struct attribute *adm1025_attributes_opt[] = {
> +	&dev_attr_in4_input.attr,
> +	&dev_attr_in4_min.attr,
> +	&dev_attr_in4_max.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group adm1025_group_opt = {
> +	.attrs = adm1025_attributes_opt,
> +};
> +
>  /*
>   * The following function does more than just detection. If detection
>   * succeeds, it also registers the new chip.
> @@ -415,46 +458,31 @@ static int adm1025_detect(struct i2c_ada
>  	adm1025_init_client(new_client);
>  
>  	/* Register sysfs hooks */
> -	data->class_dev = hwmon_device_register(&new_client->dev);
> -	if (IS_ERR(data->class_dev)) {
> -		err = PTR_ERR(data->class_dev);
> +	if ((err = sysfs_create_group(&new_client->dev.kobj, &adm1025_group)))
>  		goto exit_detach;
> -	}
> -
> -	device_create_file(&new_client->dev, &dev_attr_in0_input);
> -	device_create_file(&new_client->dev, &dev_attr_in1_input);
> -	device_create_file(&new_client->dev, &dev_attr_in2_input);
> -	device_create_file(&new_client->dev, &dev_attr_in3_input);
> -	device_create_file(&new_client->dev, &dev_attr_in5_input);
> -	device_create_file(&new_client->dev, &dev_attr_in0_min);
> -	device_create_file(&new_client->dev, &dev_attr_in1_min);
> -	device_create_file(&new_client->dev, &dev_attr_in2_min);
> -	device_create_file(&new_client->dev, &dev_attr_in3_min);
> -	device_create_file(&new_client->dev, &dev_attr_in5_min);
> -	device_create_file(&new_client->dev, &dev_attr_in0_max);
> -	device_create_file(&new_client->dev, &dev_attr_in1_max);
> -	device_create_file(&new_client->dev, &dev_attr_in2_max);
> -	device_create_file(&new_client->dev, &dev_attr_in3_max);
> -	device_create_file(&new_client->dev, &dev_attr_in5_max);
> -	device_create_file(&new_client->dev, &dev_attr_temp1_input);
> -	device_create_file(&new_client->dev, &dev_attr_temp2_input);
> -	device_create_file(&new_client->dev, &dev_attr_temp1_min);
> -	device_create_file(&new_client->dev, &dev_attr_temp2_min);
> -	device_create_file(&new_client->dev, &dev_attr_temp1_max);
> -	device_create_file(&new_client->dev, &dev_attr_temp2_max);
> -	device_create_file(&new_client->dev, &dev_attr_alarms);
> -	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
> -	device_create_file(&new_client->dev, &dev_attr_vrm);
>  
>  	/* Pin 11 is either in4 (+12V) or VID4 */
>  	if (!(config & 0x20)) {
> -		device_create_file(&new_client->dev, &dev_attr_in4_input);
> -		device_create_file(&new_client->dev, &dev_attr_in4_min);
> -		device_create_file(&new_client->dev, &dev_attr_in4_max);
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_in4_input))
> +		 || (err = device_create_file(&new_client->dev,
> +					&dev_attr_in4_min))
> +		 || (err = device_create_file(&new_client->dev,
> +					&dev_attr_in4_max)))
> +			goto exit_remove;
> +	}

This happens to be exactly adm1025_group_opt, so you could use
sysfs_create_group to spare a few lines of code. I see you've been
doing that for the adm1031 later, and I did the same for one of my
drivers (lm63). I even went as far as using an explicit name for that
group (lm63_group_fan1) instead of the generic ${driver}_group_opt.

> +
> +	data->class_dev = hwmon_device_register(&new_client->dev);
> +	if (IS_ERR(data->class_dev)) {
> +		err = PTR_ERR(data->class_dev);
> +		goto exit_remove;
>  	}
>  
>  	return 0;
>  
> +exit_remove:
> +	sysfs_remove_group(&new_client->dev.kobj, &adm1025_group);
> +	sysfs_remove_group(&new_client->dev.kobj, &adm1025_group_opt);
>  exit_detach:
>  	i2c_detach_client(new_client);
>  exit_free:
> @@ -511,6 +539,8 @@ static int adm1025_detach_client(struct 
>  	int err;
>  
>  	hwmon_device_unregister(data->class_dev);
> +	sysfs_remove_group(&client->dev.kobj, &adm1025_group);
> +	sysfs_remove_group(&client->dev.kobj, &adm1025_group_opt);
>  
>  	if ((err = i2c_detach_client(client)))
>  		return err;
> --- linux-2.6.18-rc4-mm3.orig/drivers/hwmon/adm1026.c
> +++ linux-2.6.18-rc4-mm3/drivers/hwmon/adm1026.c
> @@ -323,15 +323,6 @@ static int adm1026_attach_adapter(struct
>  	return i2c_probe(adapter, &addr_data, adm1026_detect);
>  }
>  
> -static int adm1026_detach_client(struct i2c_client *client)
> -{
> -	struct adm1026_data *data = i2c_get_clientdata(client);
> -	hwmon_device_unregister(data->class_dev);
> -	i2c_detach_client(client);
> -	kfree(data);
> -	return 0;
> -}
> -
>  static int adm1026_read_value(struct i2c_client *client, u8 reg)
>  {
>  	int res;
> @@ -1450,6 +1441,135 @@ static DEVICE_ATTR(temp1_auto_point2_pwm
>  static DEVICE_ATTR(temp2_auto_point2_pwm, S_IRUGO, show_auto_pwm_max, NULL);
>  static DEVICE_ATTR(temp3_auto_point2_pwm, S_IRUGO, show_auto_pwm_max, NULL);
>  
> +static struct attribute *adm1026_attributes[] = {
> +	&sensor_dev_attr_in0_input.dev_attr.attr,
> +	&sensor_dev_attr_in0_max.dev_attr.attr,
> +	&sensor_dev_attr_in0_min.dev_attr.attr,
> +	&sensor_dev_attr_in1_input.dev_attr.attr,
> +	&sensor_dev_attr_in1_max.dev_attr.attr,
> +	&sensor_dev_attr_in1_min.dev_attr.attr,
> +	&sensor_dev_attr_in2_input.dev_attr.attr,
> +	&sensor_dev_attr_in2_max.dev_attr.attr,
> +	&sensor_dev_attr_in2_min.dev_attr.attr,
> +	&sensor_dev_attr_in3_input.dev_attr.attr,
> +	&sensor_dev_attr_in3_max.dev_attr.attr,
> +	&sensor_dev_attr_in3_min.dev_attr.attr,
> +	&sensor_dev_attr_in4_input.dev_attr.attr,
> +	&sensor_dev_attr_in4_max.dev_attr.attr,
> +	&sensor_dev_attr_in4_min.dev_attr.attr,
> +	&sensor_dev_attr_in5_input.dev_attr.attr,
> +	&sensor_dev_attr_in5_max.dev_attr.attr,
> +	&sensor_dev_attr_in5_min.dev_attr.attr,
> +	&sensor_dev_attr_in6_input.dev_attr.attr,
> +	&sensor_dev_attr_in6_max.dev_attr.attr,
> +	&sensor_dev_attr_in6_min.dev_attr.attr,
> +	&sensor_dev_attr_in7_input.dev_attr.attr,
> +	&sensor_dev_attr_in7_max.dev_attr.attr,
> +	&sensor_dev_attr_in7_min.dev_attr.attr,
> +	&sensor_dev_attr_in8_input.dev_attr.attr,
> +	&sensor_dev_attr_in8_max.dev_attr.attr,
> +	&sensor_dev_attr_in8_min.dev_attr.attr,
> +	&sensor_dev_attr_in9_input.dev_attr.attr,
> +	&sensor_dev_attr_in9_max.dev_attr.attr,
> +	&sensor_dev_attr_in9_min.dev_attr.attr,
> +	&sensor_dev_attr_in10_input.dev_attr.attr,
> +	&sensor_dev_attr_in10_max.dev_attr.attr,
> +	&sensor_dev_attr_in10_min.dev_attr.attr,
> +	&sensor_dev_attr_in11_input.dev_attr.attr,
> +	&sensor_dev_attr_in11_max.dev_attr.attr,
> +	&sensor_dev_attr_in11_min.dev_attr.attr,
> +	&sensor_dev_attr_in12_input.dev_attr.attr,
> +	&sensor_dev_attr_in12_max.dev_attr.attr,
> +	&sensor_dev_attr_in12_min.dev_attr.attr,
> +	&sensor_dev_attr_in13_input.dev_attr.attr,
> +	&sensor_dev_attr_in13_max.dev_attr.attr,
> +	&sensor_dev_attr_in13_min.dev_attr.attr,
> +	&sensor_dev_attr_in14_input.dev_attr.attr,
> +	&sensor_dev_attr_in14_max.dev_attr.attr,
> +	&sensor_dev_attr_in14_min.dev_attr.attr,
> +	&sensor_dev_attr_in15_input.dev_attr.attr,
> +	&sensor_dev_attr_in15_max.dev_attr.attr,
> +	&sensor_dev_attr_in15_min.dev_attr.attr,
> +	&sensor_dev_attr_in16_input.dev_attr.attr,
> +	&sensor_dev_attr_in16_max.dev_attr.attr,
> +	&sensor_dev_attr_in16_min.dev_attr.attr,
> +	&sensor_dev_attr_fan1_input.dev_attr.attr,
> +	&sensor_dev_attr_fan1_div.dev_attr.attr,
> +	&sensor_dev_attr_fan1_min.dev_attr.attr,
> +	&sensor_dev_attr_fan2_input.dev_attr.attr,
> +	&sensor_dev_attr_fan2_div.dev_attr.attr,
> +	&sensor_dev_attr_fan2_min.dev_attr.attr,
> +	&sensor_dev_attr_fan3_input.dev_attr.attr,
> +	&sensor_dev_attr_fan3_div.dev_attr.attr,
> +	&sensor_dev_attr_fan3_min.dev_attr.attr,
> +	&sensor_dev_attr_fan4_input.dev_attr.attr,
> +	&sensor_dev_attr_fan4_div.dev_attr.attr,
> +	&sensor_dev_attr_fan4_min.dev_attr.attr,
> +	&sensor_dev_attr_fan5_input.dev_attr.attr,
> +	&sensor_dev_attr_fan5_div.dev_attr.attr,
> +	&sensor_dev_attr_fan5_min.dev_attr.attr,
> +	&sensor_dev_attr_fan6_input.dev_attr.attr,
> +	&sensor_dev_attr_fan6_div.dev_attr.attr,
> +	&sensor_dev_attr_fan6_min.dev_attr.attr,
> +	&sensor_dev_attr_fan7_input.dev_attr.attr,
> +	&sensor_dev_attr_fan7_div.dev_attr.attr,
> +	&sensor_dev_attr_fan7_min.dev_attr.attr,
> +	&sensor_dev_attr_fan8_input.dev_attr.attr,
> +	&sensor_dev_attr_fan8_div.dev_attr.attr,
> +	&sensor_dev_attr_fan8_min.dev_attr.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> +	&sensor_dev_attr_temp2_input.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max.dev_attr.attr,
> +	&sensor_dev_attr_temp2_min.dev_attr.attr,
> +	&sensor_dev_attr_temp3_input.dev_attr.attr,
> +	&sensor_dev_attr_temp3_max.dev_attr.attr,
> +	&sensor_dev_attr_temp3_min.dev_attr.attr,
> +	&sensor_dev_attr_temp1_offset.dev_attr.attr,
> +	&sensor_dev_attr_temp2_offset.dev_attr.attr,
> +	&sensor_dev_attr_temp3_offset.dev_attr.attr,
> +	&sensor_dev_attr_temp1_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_temp2_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_temp3_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_temp1_auto_point1_temp_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp2_auto_point1_temp_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp3_auto_point1_temp_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp1_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_temp2_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_temp3_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_temp1_crit.dev_attr.attr,
> +	&sensor_dev_attr_temp2_crit.dev_attr.attr,
> +	&sensor_dev_attr_temp3_crit.dev_attr.attr,
> +	&dev_attr_temp1_crit_enable.attr,
> +	&dev_attr_temp2_crit_enable.attr,
> +	&dev_attr_temp3_crit_enable.attr,
> +	&dev_attr_cpu0_vid.attr,
> +	&dev_attr_vrm.attr,
> +	&dev_attr_alarms.attr,
> +	&dev_attr_alarm_mask.attr,
> +	&dev_attr_gpio.attr,
> +	&dev_attr_gpio_mask.attr,
> +	&dev_attr_pwm1.attr,
> +	&dev_attr_pwm2.attr,
> +	&dev_attr_pwm3.attr,
> +	&dev_attr_pwm1_enable.attr,
> +	&dev_attr_pwm2_enable.attr,
> +	&dev_attr_pwm3_enable.attr,
> +	&dev_attr_temp1_auto_point1_pwm.attr,
> +	&dev_attr_temp2_auto_point1_pwm.attr,
> +	&dev_attr_temp3_auto_point1_pwm.attr,
> +	&dev_attr_temp1_auto_point2_pwm.attr,
> +	&dev_attr_temp2_auto_point2_pwm.attr,
> +	&dev_attr_temp3_auto_point2_pwm.attr,
> +	&dev_attr_analog_out.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group adm1026_group = {
> +	.attrs = adm1026_attributes,
> +};
> +
>  static int adm1026_detect(struct i2c_adapter *adapter, int address,
>  			  int kind)
>  {
> @@ -1554,145 +1674,20 @@ static int adm1026_detect(struct i2c_ada
>  	adm1026_init_client(new_client);
>  
>  	/* Register sysfs hooks */
> +	if ((err = sysfs_create_group(&new_client->dev.kobj, &adm1026_group)))
> +		goto exitdetach;
> +
>  	data->class_dev = hwmon_device_register(&new_client->dev);
>  	if (IS_ERR(data->class_dev)) {
>  		err = PTR_ERR(data->class_dev);
> -		goto exitdetach;
> +		goto exitremove;
>  	}
>  
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in0_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in0_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in1_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in1_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in1_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in2_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in2_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in2_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in3_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in3_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in3_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in4_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in4_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in4_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in5_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in5_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in5_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in6_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in6_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in6_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in7_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in7_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in7_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in8_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in8_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in8_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in9_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in9_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in9_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in10_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in10_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in10_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in11_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in11_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in11_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in12_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in12_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in12_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in13_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in13_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in13_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in14_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in14_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in14_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in15_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in15_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in15_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in16_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in16_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in16_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_div.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_div.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_div.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan4_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan4_div.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan4_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan5_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan5_div.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan5_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan6_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan6_div.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan6_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan7_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan7_div.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan7_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan8_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan8_div.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_fan8_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_max.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_min.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_offset.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_offset.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_offset.dev_attr);
> -	device_create_file(&new_client->dev, 
> -		&sensor_dev_attr_temp1_auto_point1_temp.dev_attr);
> -	device_create_file(&new_client->dev, 
> -		&sensor_dev_attr_temp2_auto_point1_temp.dev_attr);
> -	device_create_file(&new_client->dev, 
> -		&sensor_dev_attr_temp3_auto_point1_temp.dev_attr);
> -	device_create_file(&new_client->dev,
> -		&sensor_dev_attr_temp1_auto_point1_temp_hyst.dev_attr);
> -	device_create_file(&new_client->dev,
> -		&sensor_dev_attr_temp2_auto_point1_temp_hyst.dev_attr);
> -	device_create_file(&new_client->dev,
> -		&sensor_dev_attr_temp3_auto_point1_temp_hyst.dev_attr);
> -	device_create_file(&new_client->dev, 
> -		&sensor_dev_attr_temp1_auto_point2_temp.dev_attr);
> -	device_create_file(&new_client->dev, 
> -		&sensor_dev_attr_temp2_auto_point2_temp.dev_attr);
> -	device_create_file(&new_client->dev, 
> -		&sensor_dev_attr_temp3_auto_point2_temp.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_crit.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_crit.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_crit.dev_attr);
> -	device_create_file(&new_client->dev, &dev_attr_temp1_crit_enable);
> -	device_create_file(&new_client->dev, &dev_attr_temp2_crit_enable);
> -	device_create_file(&new_client->dev, &dev_attr_temp3_crit_enable);
> -	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
> -	device_create_file(&new_client->dev, &dev_attr_vrm);
> -	device_create_file(&new_client->dev, &dev_attr_alarms);
> -	device_create_file(&new_client->dev, &dev_attr_alarm_mask);
> -	device_create_file(&new_client->dev, &dev_attr_gpio);
> -	device_create_file(&new_client->dev, &dev_attr_gpio_mask);
> -	device_create_file(&new_client->dev, &dev_attr_pwm1);
> -	device_create_file(&new_client->dev, &dev_attr_pwm2);
> -	device_create_file(&new_client->dev, &dev_attr_pwm3);
> -	device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
> -	device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
> -	device_create_file(&new_client->dev, &dev_attr_pwm3_enable);
> -	device_create_file(&new_client->dev, &dev_attr_temp1_auto_point1_pwm);
> -	device_create_file(&new_client->dev, &dev_attr_temp2_auto_point1_pwm);
> -	device_create_file(&new_client->dev, &dev_attr_temp3_auto_point1_pwm);
> -	device_create_file(&new_client->dev, &dev_attr_temp1_auto_point2_pwm);
> -	device_create_file(&new_client->dev, &dev_attr_temp2_auto_point2_pwm);
> -	device_create_file(&new_client->dev, &dev_attr_temp3_auto_point2_pwm);
> -	device_create_file(&new_client->dev, &dev_attr_analog_out);
>  	return 0;

Mmmmm.... :))

>  
>  	/* Error out and cleanup code */
> +exitremove:
> +	sysfs_remove_group(&new_client->dev.kobj, &adm1026_group);
>  exitdetach:
>  	i2c_detach_client(new_client);
>  exitfree:
> @@ -1700,6 +1695,17 @@ exitfree:
>  exit:
>  	return err;
>  }
> +
> +static int adm1026_detach_client(struct i2c_client *client)
> +{
> +	struct adm1026_data *data = i2c_get_clientdata(client);
> +	hwmon_device_unregister(data->class_dev);
> +	sysfs_remove_group(&client->dev.kobj, &adm1026_group);
> +	i2c_detach_client(client);
> +	kfree(data);
> +	return 0;
> +}
> +
>  static int __init sm_adm1026_init(void)
>  {
>  	return i2c_add_driver(&adm1026_driver);

You may send an updated patch, else I'll just pick this one which is
good enough.

Thanks,
-- 
Jean Delvare

