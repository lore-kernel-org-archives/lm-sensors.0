From: Roland Stigge <stigge@antcom.de>
Date: Tue, 21 Feb 2012 19:31:21 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (max6639) Fix PPR register initialization to set both channels
Message-Id: <4F43F109.3090900@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1329850735-9876-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1329850735-9876-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 21/02/12 19:58, Guenter Roeck wrote:
> From: Chris D Schimp <silverchris@gmail.com>
> 
> Initialize PPR register for both channels, and set correct PPR register bits.
> Also remove unnecessary variable initializations.
> 
> Signed-off-by: Chris D Schimp <silverchris@gmail.com>
> [guenter.roeck@ericsson.com: Merged two patches into one]
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Acked-by: Roland Stigge <stigge@antcom.de>

> ---
>  drivers/hwmon/max6639.c |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index 13e58a1..a6760ba 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -429,9 +429,9 @@ static int max6639_init_client(struct i2c_client *client)
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
> @@ -446,11 +446,6 @@ static int max6639_init_client(struct i2c_client *client)
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
> @@ -458,6 +453,13 @@ static int max6639_init_client(struct i2c_client *client)
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
