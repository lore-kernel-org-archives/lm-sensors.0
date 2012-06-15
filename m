From: "Hans J. Koch" <hjk@hansjkoch.de>
Date: Fri, 15 Jun 2012 16:22:12 +0000
Subject: Re: [lm-sensors] [PATCH 61/95] hwmon: (max6650) Convert to use devm_ functions
Message-Id: <20120615162212.GC13597@local>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-62-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-62-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jun 15, 2012 at 08:23:42AM -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Cc: Hans J. Koch <hjk@hansjkoch.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: "Hans J. Koch" <hjk@hansjkoch.de>

> ---
>  drivers/hwmon/max6650.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
> index 33a8a7f..f739f83 100644
> --- a/drivers/hwmon/max6650.c
> +++ b/drivers/hwmon/max6650.c
> @@ -545,7 +545,8 @@ static int max6650_probe(struct i2c_client *client,
>  	struct max6650_data *data;
>  	int err;
>  
> -	data = kzalloc(sizeof(struct max6650_data), GFP_KERNEL);
> +	data = devm_kzalloc(&client->dev, sizeof(struct max6650_data),
> +			    GFP_KERNEL);
>  	if (!data) {
>  		dev_err(&client->dev, "out of memory.\n");
>  		return -ENOMEM;
> @@ -560,11 +561,11 @@ static int max6650_probe(struct i2c_client *client,
>  	 */
>  	err = max6650_init_client(client);
>  	if (err)
> -		goto err_free;
> +		return err;
>  
>  	err = sysfs_create_group(&client->dev.kobj, &max6650_attr_grp);
>  	if (err)
> -		goto err_free;
> +		return err;
>  	/* 3 additional fan inputs for the MAX6651 */
>  	if (data->nr_fans = 4) {
>  		err = sysfs_create_group(&client->dev.kobj, &max6651_attr_grp);
> @@ -582,8 +583,6 @@ static int max6650_probe(struct i2c_client *client,
>  		sysfs_remove_group(&client->dev.kobj, &max6651_attr_grp);
>  err_remove:
>  	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
> -err_free:
> -	kfree(data);
>  	return err;
>  }
>  
> @@ -595,7 +594,6 @@ static int max6650_remove(struct i2c_client *client)
>  	if (data->nr_fans = 4)
>  		sysfs_remove_group(&client->dev.kobj, &max6651_attr_grp);
>  	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
> -	kfree(data);
>  	return 0;
>  }
>  
> -- 
> 1.7.9.7
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
