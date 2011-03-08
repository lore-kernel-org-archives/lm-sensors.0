From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 08 Mar 2011 14:45:01 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for Texas
Message-Id: <20110308144500.GA17162@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110302185718.3c0e06dc@endymion.delvare>
In-Reply-To: <20110302185718.3c0e06dc@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Emiliano,

On Tue, Mar 08, 2011 at 05:04:20AM -0500, Emiliano Carnati wrote:
> Hi Dirk,
> thanks for your work!
> 
> I've used your code in my system and it works fine, except for a small bug when the
> code checks for the end of conversion flag (it should be negated)
> 
If this is really a bug, there should be two patches - one for the bug fix,
the other for ads1115 support.

> I've extended it to work with ADS1115 (the 16 bit version) and below there
> is the "patch of patch v4"
> 
Couple of comments below.

> I hope it would be useful for someone else.
> 
> Thanks again
> 
> Emiliano.
> 
> <<<<<< start of patch >>>>>>
> diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
> index 4572024..6025a90 100644
> --- a/drivers/hwmon/ads1015.c
> +++ b/drivers/hwmon/ads1015.c
> @@ -53,6 +53,12 @@ struct ads1015_data {
>   struct mutex update_lock; /* mutex protect updates */
>   struct attribute *attr_table[ADS1015_CONFIG_CHANNELS + 1];
>   struct attribute_group attr_group;
> + int   id;
> +};
> +
> +enum ads1015_num_id {
> + ADS1015 = 0,
> + ADS1115,
>  };

We commonly use lowercase here.

> 
>  static s32 ads1015_read_reg(struct i2c_client *client, unsigned int reg)
> @@ -78,6 +84,7 @@ static int ads1015_read_value(struct i2c_client *client, unsigned int channel,
>   unsigned int k;
>   struct ads1015_data *data = i2c_get_clientdata(client);
>   int res;
> + int msec;
> 
>   mutex_lock(&data->update_lock);
> 
> @@ -89,6 +96,14 @@ static int ads1015_read_value(struct i2c_client *client, unsigned int channel,
>   pga = (config >> 9) & 0x0007;
>   fullscale = fullscale_table[pga];
> 
> + /* for ADS1115, get the conversion time */
> + if(data->id = ADS1115)
> + {
> +  msec = (config >> 5) & 0x0007;
> +  msec = 128 >> msec;
> + }
> + else
> +  msec = 1;

Please follow Linux coding style.
	(Location of { }, and use { } in both branches of if/else)

>   /* set channel and start single conversion */
>   config &= ~(0x0007 << 12);
>   config |= (1 << 15) | (1 << 8) | (channel & 0x0007) << 12;
> @@ -98,12 +113,12 @@ static int ads1015_read_value(struct i2c_client *client, unsigned int channel,
>   if (res < 0)
>    goto err_unlock;
>   for (k = 0; k < 5; ++k) {
> -  schedule_timeout(msecs_to_jiffies(1));
> +  schedule_timeout(msecs_to_jiffies(msec));
>    res = ads1015_read_reg(client, ADS1015_CONFIG);
>    if (res < 0)
>     goto err_unlock;
>    config = res;
> -  if (config & (1 << 15))
> +  if (~(config) & (1 << 15))

Again, please follow Linux coding style (no unnecessary () )

>     break;
>   }
>   if (k = 5) {
> @@ -118,7 +133,10 @@ static int ads1015_read_value(struct i2c_client *client, unsigned int channel,
> 
>   mutex_unlock(&data->update_lock);
> 
> - *value = DIV_ROUND_CLOSEST(conversion * fullscale, 0x7ff0);
> + if(data->id = ADS1115)
> +  *value = DIV_ROUND_CLOSEST(conversion * fullscale, 0x7fff);
> + else
> +  *value = DIV_ROUND_CLOSEST(conversion * fullscale, 0x7ff0);
> 
>   return 0;
> 
> @@ -133,7 +151,7 @@ static ssize_t show_in(struct device *dev, struct device_attribute *da,
>  {
>   struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>   struct i2c_client *client = to_i2c_client(dev);
> - int in;
> + int in = 0;
>   int res;
> 
>   res = ads1015_read_value(client, attr->index, &in);
> @@ -239,7 +257,9 @@ static int ads1015_probe(struct i2c_client *client,
>    err = PTR_ERR(data->hwmon_dev);
>    goto exit_remove;
>   }
> -
> +
> + data->id = id->driver_data;
> +
>   return 0;
> 
>  exit_remove:
> @@ -251,7 +271,8 @@ exit:
>  }
> 
>  static const struct i2c_device_id ads1015_id[] = {
> - { "ads1015", 0 },
> + { "ads1015", ADS1015 },
> + { "ads1115", ADS1115 },
>   { }
>  };
>  MODULE_DEVICE_TABLE(i2c, ads1015_id);
> <<<<<< end of patch >>>>>>
> 
> -----------------------------
> 
> Emiliano Carnati

> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
