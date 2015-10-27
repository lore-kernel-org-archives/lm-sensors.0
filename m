From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 27 Oct 2015 01:10:08 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: ina2xx: give precedence to DT over checking for platform data.
Message-Id: <20151027011008.GB31838@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <562B7D56.3010700@roeck-us.net>
 <1445876673-32180-3-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <1445876673-32180-3-git-send-email-mtitinger@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Titinger <mtitinger@baylibre.com>
Cc: jdelvare@suse.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, Oct 26, 2015 at 05:24:33PM +0100, Marc Titinger wrote:
> when checking for the value of the shunt resistor.
> 
> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
> ---
>  drivers/hwmon/ina2xx.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index 3edd163..1946433 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -414,7 +414,6 @@ static const struct attribute_group ina226_group = {
>  static int ina2xx_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> -	struct ina2xx_platform_data *pdata;
>  	struct device *dev = &client->dev;
>  	struct ina2xx_data *data;
>  	struct device *hwmon_dev;
> @@ -425,14 +424,13 @@ static int ina2xx_probe(struct i2c_client *client,
>  	if (!data)
>  		return -ENOMEM;
>  
> -	if (dev_get_platdata(dev)) {
> -		pdata = dev_get_platdata(dev);
> -		data->rshunt = pdata->shunt_uohms;
> -	} else if (!of_property_read_u32(dev->of_node,
> -					 "shunt-resistor", &val)) {
> -		data->rshunt = val;
> -	} else {
> -		data->rshunt = INA2XX_RSHUNT_DEFAULT;
> +	if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0) {
> +		struct ina2xx_platform_data *pdata = dev_get_platdata(dev);
> +
> +		if (pdata)
> +			val = pdata->shunt_uohms;
> +		else
> +			val = INA2XX_RSHUNT_DEFAULT;
>  	}
>  
>  	/* set the device type */
> @@ -440,10 +438,11 @@ static int ina2xx_probe(struct i2c_client *client,
>  	data->config = &ina2xx_config[data->kind];
>  	data->client = client;
>  
> -	if (data->rshunt <= 0 ||
> -	    data->rshunt > data->config->calibration_factor)
> +	if (val <= 0 || val > data->config->calibration_factor)
>  		return -ENODEV;
>  
> +	data->rshunt = val;
> +

I think it would be better to rearrange the code a bit. 
The code now looks odd, with value being assigned, then the assignment
of data->kind etc, followed by checking val.

It might be better to do the assignments first, then calculate val,
and check its range immediately.

>  	ina2xx_regmap_config.max_register = data->config->registers;
>  
>  	data->regmap = devm_regmap_init_i2c(client, &ina2xx_regmap_config);
> -- 
> 1.9.1
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
