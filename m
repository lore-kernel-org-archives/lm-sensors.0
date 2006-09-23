From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 23 Sep 2006 10:45:01 +0000
Subject: [lm-sensors] [PATCH] w83792d - fix unchecked return codes from
Message-Id: <20060923124501.1b394744.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45146556.5020004@assembler.cz>
In-Reply-To: <45146556.5020004@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> Following patch fixes the w83792d driver. It adds error checking to 
> device_create file and also cares to destroy the files upon exit.
> 
> I will test it as soon I will get the disk back to my test machine with this 
> chip. Possible dates are: Saturday evening, Sunday and Monday for sure ;)
> Until now, compiles without warnings.

Applied, with the following fix:

> @@ -1342,12 +1428,16 @@ static int
>  w83792d_detach_client(struct i2c_client *client)
>  {
>  	struct w83792d_data *data = i2c_get_clientdata(client);
> -	int err;
> +	int err, i;
>  
>  	/* main client */
>  	if (data)
>  		hwmon_device_unregister(data->class_dev);
>  
> +	sysfs_remove_group(&client->dev.kobj, &w83792d_group);
> +	for (i = 0; i < ARRAY_SIZE(w83792d_group_fan); i++)
> +		sysfs_remove_group(&client->dev.kobj, &w83792d_group_fan[i]);
> +
>  	if ((err = i2c_detach_client(client)))
>  		return err;
>  
> 

Only the main client has the files, so the file removal should be
conditional upon "data" too.

The rest looks OK to me. Testing is still welcome nevertheless.

Thanks,
-- 
Jean Delvare

