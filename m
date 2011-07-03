From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Jul 2011 07:53:21 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (adm1275) Free allocated memory
Message-Id: <20110703095321.06d85540@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309454993-8641-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1309454993-8641-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 30 Jun 2011 10:29:51 -0700, Guenter Roeck wrote:
> Probe function did not free allocated memory if it failed. Fix it.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Good catch.

Acked-by: Jean Delvare <khali@linux-fr.org>

> ---
>  drivers/hwmon/adm1275.c |   16 +++++++++++++---
>  1 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/adm1275.c b/drivers/hwmon/adm1275.c
> index c2ee204..b9b7caf 100644
> --- a/drivers/hwmon/adm1275.c
> +++ b/drivers/hwmon/adm1275.c
> @@ -32,6 +32,7 @@ static int adm1275_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	int config;
> +	int ret;
>  	struct pmbus_driver_info *info;
>  
>  	if (!i2c_check_functionality(client->adapter,
> @@ -43,8 +44,10 @@ static int adm1275_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
> -	if (config < 0)
> -		return config;
> +	if (config < 0) {
> +		ret = config;
> +		goto err_mem;
> +	}
>  
>  	info->pages = 1;
>  	info->direct[PSC_VOLTAGE_IN] = true;
> @@ -76,7 +79,14 @@ static int adm1275_probe(struct i2c_client *client,
>  	else
>  		info->func[0] |= PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT;
>  
> -	return pmbus_do_probe(client, id, info);
> +	ret = pmbus_do_probe(client, id, info);
> +	if (ret)
> +		goto err_mem;
> +	return 0;
> +
> +err_mem:
> +	kfree(info);
> +	return ret;
>  }
>  
>  static int adm1275_remove(struct i2c_client *client)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
