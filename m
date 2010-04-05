From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 05 Apr 2010 07:46:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adm1031) Increase update rate
Message-Id: <20100405094654.7415b00c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100330225628.GE20635@ovro.caltech.edu>
In-Reply-To: <20100330225628.GE20635@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira,

On Tue, 30 Mar 2010 15:56:28 -0700, Ira W. Snyder wrote:
> The adm1031 chip is capable of an 8 Hz update rate, configurable at runtime
> with the fan filter register. Increase the update rate to get faster
> temperature readings.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> 
> This may be a bit controversial. The ADM1031 chip may use more power at a
> higher update rate. In my (embedded) application, this doesn't matter. The
> faster update rate is more important.

If you use the automatic fan speed control capabilities, then indeed a
faster update rate can be benefical. But as you suspected, it is
somewhat controversial, due to the higher power consumption possibly
for no good reason. Also, the BIOS/firmware might have already
configured the chip and traditionally the hwmon drivers preserve these
settings as much as possible.

> Does anyone have thoughts on this? It is easy enough for me to carry
> myself, but I'd much rather have it upstream.

I wouldn't want it upstream as is. However I can think of two
alternative implementations which I would be happy with:

1* Let the adm1031 driver accept platform data, and the update rate be
part of that platform data. Then you can instantiate your device
explicitly and pass the desired update rate.

2* Expose the update frequency through sysfs, and make it writable.
After all, so many monitoring devices have a configurable update rate
that it would make sense to have a standard attribute for it. If you go
that route, we have to standardize on it first, and add it to
Documentation/hwmon/sysfs-interface. Then implement it in the adm1031
driver and possibly other drivers.

Note that both options aren't mutually exclusive, although one of them
should be enough to satisfy your need.

>  drivers/hwmon/adm1031.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
> index 1644b92..c7195cc 100644
> --- a/drivers/hwmon/adm1031.c
> +++ b/drivers/hwmon/adm1031.c
> @@ -36,6 +36,7 @@
>  #define ADM1031_REG_FAN_DIV(nr)		(0x20 + (nr))
>  #define ADM1031_REG_PWM			(0x22)
>  #define ADM1031_REG_FAN_MIN(nr)		(0x10 + (nr))
> +#define ADM1031_REG_FAN_FILTER		(0x23)
>  
>  #define ADM1031_REG_TEMP_OFFSET(nr)	(0x0d + (nr))
>  #define ADM1031_REG_TEMP_MAX(nr)	(0x14 + 4 * (nr))
> @@ -919,6 +920,9 @@ static void adm1031_init_client(struct i2c_client *client)
>  				ADM1031_CONF1_MONITOR_ENABLE);
>  	}
>  
> +	/* Increase the ADC sampling rate -- temperatures update at 8 Hz */
> +	read_val = adm1031_read_value(client, ADM1031_REG_FAN_FILTER);
> +	adm1031_write_value(client, ADM1031_REG_FAN_FILTER, read_val | 0x1C);
>  }
>  
>  static struct adm1031_data *adm1031_update_device(struct device *dev)
> @@ -929,7 +933,7 @@ static struct adm1031_data *adm1031_update_device(struct device *dev)
>  
>  	mutex_lock(&data->update_lock);
>  
> -	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
> +	if (time_after(jiffies, data->last_updated + HZ / 8)
>  	    || !data->valid) {
>  
>  		dev_dbg(&client->dev, "Starting adm1031 update\n");


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
