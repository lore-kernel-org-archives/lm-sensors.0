From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 22 Aug 2008 15:20:34 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] lm87: Add support for configuration
Message-Id: <20080822172034.4c2a2b81@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080820202113.GO7908@solarflare.com>
In-Reply-To: <20080820202113.GO7908@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Wed, 20 Aug 2008 21:21:14 +0100, Ben Hutchings wrote:
> The lm87 driver normally assumes that firmware configured the chip
> correctly.  Since this is not always the case, alllow platform code to
> set the channel register value via platform_data.  All other
> configuration registers can be changed after driver initialisation.
> 
> Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
> ---
>  Documentation/hwmon/lm87 |    9 ++++-----
>  drivers/hwmon/lm87.c     |   20 +++++++++++++-------
>  2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/hwmon/lm87 b/Documentation/hwmon/lm87
> index ec27aa1..6b47b67 100644
> --- a/Documentation/hwmon/lm87
> +++ b/Documentation/hwmon/lm87
> @@ -65,11 +65,10 @@ The LM87 has four pins which can serve one of two possible functions,
>  depending on the hardware configuration.
>  
>  Some functions share pins, so not all functions are available at the same
> -time. Which are depends on the hardware setup. This driver assumes that
> -the BIOS configured the chip correctly. In that respect, it differs from
> -the original driver (from lm_sensors for Linux 2.4), which would force the
> -LM87 to an arbitrary, compile-time chosen mode, regardless of the actual
> -chipset wiring.
> +time. Which are depends on the hardware setup. This driver normally
> +assumes that firmware configured the chip correctly. Where this is not
> +the case, platform code must set the I2C client's platform_data to point
> +to a u8 value to be written to the channel register.
>  
>  For reference, here is the list of exclusive functions:
>   - in0+in5 (default) or temp3
> diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
> index 695f5f2..197a842 100644
> --- a/drivers/hwmon/lm87.c
> +++ b/drivers/hwmon/lm87.c
> @@ -21,11 +21,10 @@
>   *   http://www.national.com/pf/LM/LM87.html
>   *
>   * Some functions share pins, so not all functions are available at the same
> - * time. Which are depends on the hardware setup. This driver assumes that
> - * the BIOS configured the chip correctly. In that respect, it  differs from
> - * the original driver (from lm_sensors for Linux 2.4), which would force the
> - * LM87 to an arbitrary, compile-time chosen mode, regardless of the actual
> - * chipset wiring.
> + * time. Which are depends on the hardware setup. This driver normally
> + * assumes that firmware configured the chip correctly. Where this is not
> + * the case, platform code must set the I2C client's platform_data to point
> + * to a u8 value to be written to the channel register.
>   * For reference, here is the list of exclusive functions:
>   *  - in0+in5 (default) or temp3
>   *  - fan1 (default) or in6
> @@ -843,8 +842,15 @@ static void lm87_init_client(struct i2c_client *client)
>  {
>  	struct lm87_data *data = i2c_get_clientdata(client);
>  
> -	data->channel = lm87_read_value(client, LM87_REG_CHANNEL_MODE);
> -	data->config = lm87_read_value(client, LM87_REG_CONFIG);
> +	if (client->dev.platform_data) {
> +		data->channel = *(u8 *)client->dev.platform_data;
> +		lm87_write_value(client,
> +				 LM87_REG_CHANNEL_MODE, data->channel);
> +		data->config = 0x08; /* reset value */

I don't get the point of hard-coding this value. Why don't you read it
from the chip as you do in the no-platform-data case? This would be
more flexible and safer.

> +	} else {
> +		data->channel = lm87_read_value(client, LM87_REG_CHANNEL_MODE);
> +		data->config = lm87_read_value(client, LM87_REG_CONFIG);
> +	}
>  
>  	if (!(data->config & 0x01)) {
>  		int i;
> 

Other than that, this patch looks OK to me.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
