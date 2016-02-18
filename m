From: Peter Rosin <peda@lysator.liu.se>
Date: Thu, 18 Feb 2016 23:13:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads1015) Handle negative conversion values correctly
Message-Id: <56C65027.5010403@lysator.liu.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1455800872-24431-1-git-send-email-peda@lysator.liu.se>
In-Reply-To: <1455800872-24431-1-git-send-email-peda@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dirk Eibach <eibach@gdsys.de>
Cc: Peter Rosin <peda@axentia.se>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi!

Sorry for the noise, but...

On 2016-02-18 14:07, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> Make the divisor signed as DIV_ROUND_CLOSEST is undefined for negative
> dividends when the divisor is unsigned.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

...I forgot to add this to the commit message
Cc: stable@vger.kernel.org

I also didn't explicitly mention any example platform where this
bug causes real problems; it was triggered on ARM (atmel sama5d).

Cheers,
Peter

> ---
>  drivers/hwmon/ads1015.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
> index f155b8380481..2b3105c8aed3 100644
> --- a/drivers/hwmon/ads1015.c
> +++ b/drivers/hwmon/ads1015.c
> @@ -126,7 +126,7 @@ static int ads1015_reg_to_mv(struct i2c_client *client, unsigned int channel,
>  	struct ads1015_data *data = i2c_get_clientdata(client);
>  	unsigned int pga = data->channel_data[channel].pga;
>  	int fullscale = fullscale_table[pga];
> -	const unsigned mask = data->id = ads1115 ? 0x7fff : 0x7ff0;
> +	const int mask = data->id = ads1115 ? 0x7fff : 0x7ff0;
>  
>  	return DIV_ROUND_CLOSEST(reg * fullscale, mask);
>  }
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
