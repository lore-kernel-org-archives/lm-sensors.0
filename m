From: Jean Delvare <jdelvare@suse.de>
Date: Sat, 22 Feb 2014 13:32:20 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (lm95245) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20140222143220.317afb24@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1391747559-7601-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1391747559-7601-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu,  6 Feb 2014 20:32:39 -0800, Guenter Roeck wrote:
> Simplify code, reduce code size, and attach hwmon attributes
> to hwmon device.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm95245.c |   80 +++++++++++++++--------------------------------
>  1 file changed, 26 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
> index c58d431..482ce14 100644
> --- a/drivers/hwmon/lm95245.c
> +++ b/drivers/hwmon/lm95245.c
> (...)
> @@ -149,7 +149,7 @@ static struct lm95245_data *lm95245_update_device(struct device *dev)
>  		+ msecs_to_jiffies(data->interval)) || !data->valid) {
>  		int i;
>  
> -		dev_dbg(&client->dev, "Updating lm95245 data.\n");
> +		dev_dbg(dev, "Updating lm95245 data.\n");

Or just kill it, it's a mostly pointless debug message anyway.

>  		for (i = 0; i < ARRAY_SIZE(lm95245_reg_address); i++)
>  			data->regs[i]
>  			  = i2c_smbus_read_byte_data(client,
> (...)
> @@ -286,8 +286,8 @@ static ssize_t set_crit_hyst(struct device *dev, struct device_attribute *attr,
>  			     const char *buf, size_t count)
>  {
>  	struct lm95245_data *data = lm95245_update_device(dev);
> -	struct i2c_client *client = to_i2c_client(dev);
>  	int index = to_sensor_dev_attr(attr)->index;
> +	struct i2c_client *client = data->client;

I'm curious why you're swapping these lines? I can't find a rationale
for it, and it makes the patch (very slightly) larger.

>  	unsigned long val;
>  	long hyst;
>  
> (...)
> @@ -468,49 +463,27 @@ static void lm95245_init_client(struct i2c_client *client)
>  	}
>  }
>  
> -static int lm95245_probe(struct i2c_client *new_client,
> +static int lm95245_probe(struct i2c_client *client,
>                          const struct i2c_device_id *id)

Halleluiah.

All the rest looks alright.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
