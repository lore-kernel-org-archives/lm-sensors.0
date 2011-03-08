From: "Eibach, Dirk" <Eibach@gdsys.de>
Date: Tue, 08 Mar 2011 11:27:52 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for Texas
Message-Id: <48D3D52125C49B43AE880038E2E5314BB5BE76@SRV101.gdsys.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110302185718.3c0e06dc@endymion.delvare>
In-Reply-To: <20110302185718.3c0e06dc@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hi Dirk,
> thanks for your work! 
>  
> I've used your code in my system and it works fine, except 
> for a small bug when the code checks for the end of 
> conversion flag (it should be negated)
>  
> I've extended it to work with ADS1115 (the 16 bit version) 
> and below there is the "patch of patch v4"
>  
> I hope it would be useful for someone else.
>  
> Thanks again
>  
> Emiliano.
>  
> <<<<<< start of patch >>>>>>

We should mention ADS1115 support in all the appropriate places. Grep
for ADS1015 to get an idea.

> diff --git a/drivers/hwmon/ads1015.c 
> b/drivers/hwmon/ads1015.c index 4572024..6025a90 100644
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

The first constant in an enumeration is 0 by default.

>  static s32 ads1015_read_reg(struct i2c_client *client, 
> unsigned int reg) @@ -78,6 +84,7 @@ static int 
> ads1015_read_value(struct i2c_client *client, unsigned int channel,
>   unsigned int k;
>   struct ads1015_data *data = i2c_get_clientdata(client);
>   int res;
> + int msec;
>  
>   mutex_lock(&data->update_lock);
>  
> @@ -89,6 +96,14 @@ static int ads1015_read_value(struct 
> i2c_client *client, unsigned int channel,
>   pga = (config >> 9) & 0x0007;
>   fullscale = fullscale_table[pga];
>  
> + /* for ADS1115, get the conversion time */ if(data->id = 
> ADS1115) {  
> + msec = (config >> 5) & 0x0007;  msec = 128 >> msec; } else  
> msec = 1;

Wouldn't it make sense to make sure msec is at least 1?

>   /* set channel and start single conversion */
>   config &= ~(0x0007 << 12);
>   config |= (1 << 15) | (1 << 8) | (channel & 0x0007) << 12; 
> @@ -98,12 +113,12 @@ static int ads1015_read_value(struct 
> i2c_client *client, unsigned int channel,
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
>     break;

Hmm, datasheet says bit 15 is 0 when device is performing a conversion
and 1 when it is finished. So exiting on Bit 15 set seems right to me
(and I verfified it works). Why do you think it should be negated?

>   }
>   if (k = 5) {
> @@ -118,7 +133,10 @@ static int ads1015_read_value(struct 
> i2c_client *client, unsigned int channel,
>  
>   mutex_unlock(&data->update_lock);
>  
> - *value = DIV_ROUND_CLOSEST(conversion * fullscale, 0x7ff0);
> + if(data->id = ADS1115)
> +  *value = DIV_ROUND_CLOSEST(conversion * fullscale, 0x7fff); else  
> + *value = DIV_ROUND_CLOSEST(conversion * fullscale, 0x7ff0);

I would find it more appropriate to store the fullscale value in
ads1015_data.

>   return 0;
>  
> @@ -133,7 +151,7 @@ static ssize_t show_in(struct device 
> *dev, struct device_attribute *da,  {
>   struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>   struct i2c_client *client = to_i2c_client(dev);
> - int in;
> + int in = 0;

No need to initialize this.

>   int res;
>  
>   res = ads1015_read_value(client, attr->index, &in); @@ 
> -239,7 +257,9 @@ static int ads1015_probe(struct i2c_client *client,
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
> 
> -----------------------------
> 
> 
> Emiliano Carnati

Cheers
Dirk



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
