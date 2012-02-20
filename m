From: Roland Stigge <stigge@antcom.de>
Date: Mon, 20 Feb 2012 23:06:41 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <4F42D201.5060908@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 20/02/12 23:44, Chris wrote:
> Fix variable intializations in max6639_init_client
> Signed-off-by: Chris D Schimp <silverchris <at> gmail.com>

Also looks good.

Acked-by: Roland Stigge <stigge@antcom.de>

> ---
> 
> diff -uprN -X a/Documentation/dontdiff a/drivers/hwmon/max6639.c
> b/drivers/hwmon/max6639.c
> --- a/drivers/hwmon/max6639.c	2012-02-06 12:47:00.000000000 -0500
> +++ b/drivers/hwmon/max6639.c	2012-02-20 17:40:36.821422457 -0500
> @@ -429,16 +429,15 @@ static int max6639_init_client(struct i2
>  	struct max6639_data *data = i2c_get_clientdata(client);
>  	struct max6639_platform_data *max6639_info >  		client->dev.platform_data;
> -	int i = 0;
> +	int i;
>  	int rpm_range = 1; /* default: 4000 RPM */
> -	int err = 0;
> +	int err;
> 
>  	/* Reset chip to default values, see below for GCONFIG setup */
>  	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
>  				  MAX6639_GCONFIG_POR);
>  	if (err)
>  		goto exit;
> -
>  	/* Fans pulse per revolution is 2 by default */
>  	if (max6639_info && max6639_info->ppr > 0 &&
>  			max6639_info->ppr < 5)
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
