From: Roland Stigge <stigge@antcom.de>
Date: Mon, 20 Feb 2012 22:53:16 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <4F42CEDC.3010100@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 20/02/12 22:58, Chris wrote:
> Patch to fix PPR register initialization to set both channels
> Signed-off-by: Chris D Schimp <silverchris <at> gmail.com>

Looks good.

Acked-by: Roland Stigge <stigge@antcom.de>

> ---
> diff -uprN -X a/Documentation/dontdiff a/drivers/hwmon/max6639.c
> b/drivers/hwmon/max6639.c
> --- a/drivers/hwmon/max6639.c	2012-02-06 12:47:00.000000000 -0500
> +++ b/drivers/hwmon/max6639.c	2012-02-20 16:36:02.553668023 -0500
> @@ -438,7 +438,6 @@ static int max6639_init_client(struct i2
>  				  MAX6639_GCONFIG_POR);
>  	if (err)
>  		goto exit;
> -
>  	/* Fans pulse per revolution is 2 by default */
>  	if (max6639_info && max6639_info->ppr > 0 &&
>  			max6639_info->ppr < 5)
> @@ -446,11 +445,6 @@ static int max6639_init_client(struct i2
>  	else
>  		data->ppr = 2;
>  	data->ppr -= 1;
> -	err = i2c_smbus_write_byte_data(client,
> -			MAX6639_REG_FAN_PPR(i),
> -			data->ppr << 5);
> -	if (err)
> -		goto exit;
> 
>  	if (max6639_info)
>  		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
> @@ -458,6 +452,13 @@ static int max6639_init_client(struct i2
> 
>  	for (i = 0; i < 2; i++) {
> 
> +		/* Set Fan pulse per revolution */
> +		err = i2c_smbus_write_byte_data(client,
> +				MAX6639_REG_FAN_PPR(i),
> +				data->ppr << 6);
> +		if (err)
> +			goto exit;
> +
>  		/* Fans config PWM, RPM */
>  		err = i2c_smbus_write_byte_data(client,
>  			MAX6639_REG_FAN_CONFIG1(i),

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
