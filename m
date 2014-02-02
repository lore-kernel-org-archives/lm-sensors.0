From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 02 Feb 2014 18:02:09 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (lm63) Create attributes for LM96163 in one call
Message-Id: <20140202190209.4f9b1886@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390243126-19519-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1390243126-19519-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Mon, 20 Jan 2014 10:38:44 -0800, Guenter Roeck wrote:
> There is no need to have both an attribute group plus an individual attribute
> for LM96163. Add the attribute to the group and create all attributes with one
> call.

The idea of having groups (or single attributes) per extra feature
rather than per chip was to be able to reuse them when adding support
for a new chip implementing a subset of the extra features. It wasn't
an overlook, it was implemented that way on purpose. You can argue that
the extra complexity may never be needed, but nobody objected back
then.

Now I do understand that single attributes don't fit well with the way
you implemented devm_hwmon_device_register_with_groups(). You could
still create a group for that attribute so that you can register it
with that function. Then you only have another group to register, no
big deal.

Would that be OK for you?

> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm63.c |   25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
> index d0def50..438e612 100644
> --- a/drivers/hwmon/lm63.c
> +++ b/drivers/hwmon/lm63.c
> @@ -915,7 +915,8 @@ static struct attribute *lm63_attributes[] = {
>  	NULL
>  };
>  
> -static struct attribute *lm63_attributes_extra_lut[] = {
> +static struct attribute *lm63_attributes_lm96163[] = {
> +	&dev_attr_temp2_type.attr,
>  	&sensor_dev_attr_pwm1_auto_point9_pwm.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_auto_point9_temp.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_auto_point9_temp_hyst.dev_attr.attr,
> @@ -931,8 +932,8 @@ static struct attribute *lm63_attributes_extra_lut[] = {
>  	NULL
>  };
>  
> -static const struct attribute_group lm63_group_extra_lut = {
> -	.attrs = lm63_attributes_extra_lut,
> +static const struct attribute_group lm63_group_lm96163 = {
> +	.attrs = lm63_attributes_lm96163,
>  };
>  
>  /*
> @@ -1133,12 +1134,8 @@ static int lm63_probe(struct i2c_client *client,
>  			goto exit_remove_files;
>  	}
>  	if (data->kind = lm96163) {
> -		err = device_create_file(&client->dev, &dev_attr_temp2_type);
> -		if (err)
> -			goto exit_remove_files;
> -
>  		err = sysfs_create_group(&client->dev.kobj,
> -					 &lm63_group_extra_lut);
> +					 &lm63_group_lm96163);
>  		if (err)
>  			goto exit_remove_files;
>  	}
> @@ -1154,10 +1151,8 @@ static int lm63_probe(struct i2c_client *client,
>  exit_remove_files:
>  	sysfs_remove_group(&client->dev.kobj, &lm63_group);
>  	sysfs_remove_group(&client->dev.kobj, &lm63_group_fan1);
> -	if (data->kind = lm96163) {
> -		device_remove_file(&client->dev, &dev_attr_temp2_type);
> -		sysfs_remove_group(&client->dev.kobj, &lm63_group_extra_lut);
> -	}
> +	if (data->kind = lm96163)
> +		sysfs_remove_group(&client->dev.kobj, &lm63_group_lm96163);
>  	return err;
>  }
>  
> @@ -1168,10 +1163,8 @@ static int lm63_remove(struct i2c_client *client)
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&client->dev.kobj, &lm63_group);
>  	sysfs_remove_group(&client->dev.kobj, &lm63_group_fan1);
> -	if (data->kind = lm96163) {
> -		device_remove_file(&client->dev, &dev_attr_temp2_type);
> -		sysfs_remove_group(&client->dev.kobj, &lm63_group_extra_lut);
> -	}
> +	if (data->kind = lm96163)
> +		sysfs_remove_group(&client->dev.kobj, &lm63_group_lm96163);
>  
>  	return 0;
>  }


-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
