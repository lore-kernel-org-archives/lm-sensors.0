From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 02 Feb 2014 20:50:53 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adm1021) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20140202215053.6544c48f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1391362768-27750-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1391362768-27750-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sun,  2 Feb 2014 09:39:28 -0800, Guenter Roeck wrote:
> Simplify code, reduce code size, and attach hwmon attributes to
> hwmon device.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/adm1021.c |   70 ++++++++++++++++-------------------------------
>  1 file changed, 23 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
> index 29dd9f7..f340ea2 100644
> --- a/drivers/hwmon/adm1021.c
> +++ b/drivers/hwmon/adm1021.c
> (...)
> @@ -412,15 +412,15 @@ static int adm1021_detect(struct i2c_client *client,
>  static int adm1021_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> +	struct device *dev = &client->dev;
>  	struct adm1021_data *data;
> -	int err;
> +	struct device *hwmon_dev;
>  
> -	data = devm_kzalloc(&client->dev, sizeof(struct adm1021_data),
> -			    GFP_KERNEL);
> +	data = devm_kzalloc(dev, sizeof(struct adm1021_data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> -	i2c_set_clientdata(client, data);
> +	data->client = client;
>  	data->type = id->driver_data;
>  	mutex_init(&data->update_lock);
>  
> @@ -428,29 +428,16 @@ static int adm1021_probe(struct i2c_client *client,
>  	if (data->type != lm84 && !read_only)
>  		adm1021_init_client(client);
>  
> -	/* Register sysfs hooks */
> -	err = sysfs_create_group(&client->dev.kobj, &adm1021_group);
> -	if (err)
> -		return err;
> -
> -	if (data->type != lm84) {
> -		err = sysfs_create_group(&client->dev.kobj, &adm1021_min_group);
> -		if (err)
> -			goto error;
> -	}
> +	data->groups[0] = &adm1021_group;
> +	if (data->type != lm84)
> +		data->groups[1] = &adm1021_min_group;
>  
> -	data->hwmon_dev = hwmon_device_register(&client->dev);
> -	if (IS_ERR(data->hwmon_dev)) {
> -		err = PTR_ERR(data->hwmon_dev);
> -		goto error;
> -	}
> +	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> +							   data, data->groups);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);

Why not return PTR_ERR_OR_ZERO?

>  
>  	return 0;
> -
> -error:
> -	sysfs_remove_group(&client->dev.kobj, &adm1021_min_group);
> -	sysfs_remove_group(&client->dev.kobj, &adm1021_group);
> -	return err;
>  }

Everything else looks good.

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
