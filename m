From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 22 Aug 2008 15:01:43 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] lm87: Restore original configuration
Message-Id: <20080822170143.02b34f27@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080820201533.GN7908@solarflare.com>
In-Reply-To: <20080820201533.GN7908@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Wed, 20 Aug 2008 21:15:33 +0100, Ben Hutchings wrote:
> This means that if we have to start the monitor when probed, we also
> stop it on removal.

Looks OK to me, with only one suggestion:

> 
> Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
> ---
>  drivers/hwmon/lm87.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
> index 0fecbfd..695f5f2 100644
> --- a/drivers/hwmon/lm87.c
> +++ b/drivers/hwmon/lm87.c
> @@ -199,6 +199,7 @@ struct lm87_data {
>  	unsigned long last_updated; /* In jiffies */
>  
>  	u8 channel;		/* register value */
> +	u8 config;		/* original register value */
>  
>  	u8 in[8];		/* register value */
>  	u8 in_max[8];		/* register value */
> @@ -832,6 +833,7 @@ exit_remove:
>  	sysfs_remove_group(&new_client->dev.kobj, &lm87_group);
>  	sysfs_remove_group(&new_client->dev.kobj, &lm87_group_opt);
>  exit_free:
> +	lm87_write_value(new_client, LM87_REG_CONFIG, data->config);
>  	kfree(data);
>  exit:
>  	return err;
> @@ -840,12 +842,11 @@ exit:
>  static void lm87_init_client(struct i2c_client *client)
>  {
>  	struct lm87_data *data = i2c_get_clientdata(client);
> -	u8 config;
>  
>  	data->channel = lm87_read_value(client, LM87_REG_CHANNEL_MODE);
> +	data->config = lm87_read_value(client, LM87_REG_CONFIG);

Would you mind if I add "& 0x6f"? Bits 4 and 7 trigger an action when
you write to them, and self clear. Thus I think we want to make sure
that we will never write 1 to them accidentally. It shouldn't make a
difference in practice, but it feels safer to me that way.

>  
> -	config = lm87_read_value(client, LM87_REG_CONFIG);
> -	if (!(config & 0x01)) {
> +	if (!(data->config & 0x01)) {
>  		int i;
>  
>  		/* Limits are left uninitialized after power-up */
> @@ -869,9 +870,9 @@ static void lm87_init_client(struct i2c_client *client)
>  	}
>  
>  	/* Make sure Start is set and INT#_Clear is clear */
> -	if ((config & 0x09) != 0x01)
> +	if ((data->config & 0x09) != 0x01)
>  		lm87_write_value(client, LM87_REG_CONFIG,
> -				 (config & 0x77) | 0x01);
> +				 (data->config & 0x77) | 0x01);
>  }
>  
>  static int lm87_remove(struct i2c_client *client)
> @@ -882,6 +883,7 @@ static int lm87_remove(struct i2c_client *client)
>  	sysfs_remove_group(&client->dev.kobj, &lm87_group);
>  	sysfs_remove_group(&client->dev.kobj, &lm87_group_opt);
>  
> +	lm87_write_value(client, LM87_REG_CONFIG, data->config);
>  	kfree(data);
>  	return 0;
>  }
> 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
