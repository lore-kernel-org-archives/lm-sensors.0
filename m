From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 25 May 2010 12:21:27 +0000
Subject: Re: [lm-sensors] [RFC][PATCH] Add support for TMP105
Message-Id: <4BFBC0C7.2010401@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <0680EC522D0CC943BC586913CF3768C003B32B4012@dbde02.ent.ti.com>
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B32B4012@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On 05/25/10 13:12, Datta, Shubhrajyoti wrote:
> 
> Adds the driver support for the TMP105 temperature sensor device. The
> interface is I2C.The driver supports the read of the temperature values.
> 
Still on the wrong list... cc'ing lm-sensors...
Please check MAINTAINERS for the correct mailing list for patches.


> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/hwmon/Kconfig |    3 ++-
>  drivers/hwmon/lm75.c  |    2 ++
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a4a5352..7a137d5 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -483,7 +483,8 @@ config SENSORS_LM75
>  		- NXP's LM75A
>  		- ST Microelectronics STDS75
>  		- TelCom (now Microchip) TCN75
> -		- Texas Instruments TMP100, TMP101, TMP75, TMP175, TMP275
> +		- Texas Instruments TMP100, TMP101, TMP105, TMP75, TMP175, 
> +			TMP275
>  
>  	  This driver supports driver model based binding through board
>  	  specific I2C device tables.
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index 8ae2cfe..5646342 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -46,6 +46,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
>  	tcn75,
>  	tmp100,
>  	tmp101,
> +	tmp105,
>  	tmp175,
>  	tmp275,
>  	tmp75,
> @@ -220,6 +221,7 @@ static const struct i2c_device_id lm75_ids[] = {
>  	{ "tcn75", tcn75, },
>  	{ "tmp100", tmp100, },
>  	{ "tmp101", tmp101, },
> +	{ "tmp105", tmp105, },
>  	{ "tmp175", tmp175, },
>  	{ "tmp275", tmp275, },
>  	{ "tmp75", tmp75, },


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
