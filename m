From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 13 Feb 2014 10:04:04 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: (max6650) Drop error message after memory allocation failures
Message-Id: <20140213110404.1cf31cf9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392226866-25968-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392226866-25968-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 12 Feb 2014 09:41:05 -0800, Guenter Roeck wrote:
> The core code already generates an error message.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/max6650.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
> index badff94..74916e7 100644
> --- a/drivers/hwmon/max6650.c
> +++ b/drivers/hwmon/max6650.c
> @@ -656,10 +656,8 @@ static int max6650_probe(struct i2c_client *client,
>  
>  	data = devm_kzalloc(&client->dev, sizeof(struct max6650_data),
>  			    GFP_KERNEL);
> -	if (!data) {
> -		dev_err(&client->dev, "out of memory.\n");
> +	if (!data)
>  		return -ENOMEM;
> -	}
>  
>  	data->client = client;
>  	mutex_init(&data->update_lock);

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
