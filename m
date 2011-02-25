From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Feb 2011 17:54:42 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/4] hwmon: (lm85) Use function to
Message-Id: <20110225185442.06db44a6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298654487-30232-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1298654487-30232-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 25 Feb 2011 09:21:25 -0800, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/lm85.c |   19 +++++++++++--------
>  1 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
> index 12edd5f..1a9540a 100644
> --- a/drivers/hwmon/lm85.c
> +++ b/drivers/hwmon/lm85.c
> @@ -1282,6 +1282,15 @@ static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
>  	return 0;
>  }
>  
> +static void lm85_remove_files(struct lm85_data *data, struct i2c_client *client)

It would be more usual to pass the client first and the data second.

Other than this:
Acked-by: Jean Delvare <khali@linux-fr.org>

> +{
> +	sysfs_remove_group(&client->dev.kobj, &lm85_group);
> +	if (!vid5_configured(data))
> +		sysfs_remove_group(&client->dev.kobj, &lm85_group_in4);
> +	if (data->type = emc6d100)
> +		sysfs_remove_group(&client->dev.kobj, &lm85_group_in567);
> +}
> +
>  static int lm85_probe(struct i2c_client *client,
>  		      const struct i2c_device_id *id)
>  {
> @@ -1345,10 +1354,7 @@ static int lm85_probe(struct i2c_client *client,
>  
>  	/* Error out and cleanup code */
>   err_remove_files:
> -	sysfs_remove_group(&client->dev.kobj, &lm85_group);
> -	sysfs_remove_group(&client->dev.kobj, &lm85_group_in4);
> -	if (data->type = emc6d100)
> -		sysfs_remove_group(&client->dev.kobj, &lm85_group_in567);
> +	lm85_remove_files(data, client);
>   err_kfree:
>  	kfree(data);
>  	return err;
> @@ -1358,10 +1364,7 @@ static int lm85_remove(struct i2c_client *client)
>  {
>  	struct lm85_data *data = i2c_get_clientdata(client);
>  	hwmon_device_unregister(data->hwmon_dev);
> -	sysfs_remove_group(&client->dev.kobj, &lm85_group);
> -	sysfs_remove_group(&client->dev.kobj, &lm85_group_in4);
> -	if (data->type = emc6d100)
> -		sysfs_remove_group(&client->dev.kobj, &lm85_group_in567);
> +	lm85_remove_files(data, client);
>  	kfree(data);
>  	return 0;
>  }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
