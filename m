From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 26 May 2010 12:27:57 +0000
Subject: Re: [lm-sensors] [PATCH] Add support for TMP105
Message-Id: <20100526142757.64b9fc6a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <0680EC522D0CC943BC586913CF3768C003B3357DC3@dbde02.ent.ti.com>
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B3357DC3@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 26 May 2010 14:38:44 +0530, Datta, Shubhrajyoti wrote:
> Adds the driver support for the TMP105 temperature sensor device. The
> interface is I2C.The driver supports the read of the temperature values.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/hwmon/Kconfig |    3 ++-
>  drivers/hwmon/lm75.c  |    2 ++
>  2 files changed, 4 insertions(+), 1 deletions(-)
>  mode change 100644 => 100755 drivers/hwmon/Kconfig
>  mode change 100644 => 100755 drivers/hwmon/lm75.c

Certainly not ;)

> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> old mode 100644
> new mode 100755
> index 6a9ac75..5c915e5
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -492,7 +492,8 @@ config SENSORS_LM75
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
> old mode 100644
> new mode 100755
> index 8ae2cfe..5646342
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

Patch applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
