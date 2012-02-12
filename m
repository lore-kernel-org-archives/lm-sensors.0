From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Feb 2012 09:30:43 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <20120212103043.3c76f370@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chris,

On Sat, 11 Feb 2012 22:00:39 -0500, Chris wrote:
> Moved Fan Pulse per revolution into a loop so that both channel 1 and
> channel 2 get set, instead of just channel 1

You are right that the code is broken. However your fix is
unnecessarily expensive, as you end up setting data->ppr twice. What
needs to be moved inside the loop is the register write and only that.

Note that this bug wasn't spotted earlier because i (and err, for that
matter) are initialized at the beginning of the function when they
did not have to. I guess I will never repeat that enough: do not
initialize variables "just in case", or gcc can no longer help you when
you get things wrong.

Also note that I find it highly discussable that the driver initializes
the chip with arbitrary values in the absence of platform data. The
usual policy of hwmon drivers is to leave the chip untouched by
default, assuming that the hardware defaults or firmware/BIOS settings
are OK. Here some configuration bits are even set to 0 simply because
simple register writes are used instead of read-modify-write cycles.
I'm not even sure if this is intended.

> Signed-off-by: Chris D Schimp <silverchris@gmail.com>
> 
> ---
> diff -uprN -X vanilla/linux-3.2.5/Documentation/dontdiff
> vanilla/linux-3.2.5/drivers/hwmon/max6639.c
> devel/linux-3.2.5/drivers/hwmon/max6639.c
> --- vanilla/linux-3.2.5/drivers/hwmon/max6639.c	2012-02-06
> 12:47:00.000000000 -0500
> +++ devel/linux-3.2.5/drivers/hwmon/max6639.c	2012-02-11
> 21:40:02.399127171 -0500
> @@ -439,25 +439,24 @@ static int max6639_init_client(struct i2
>  	if (err)
>  		goto exit;
> 
> -	/* Fans pulse per revolution is 2 by default */
> -	if (max6639_info && max6639_info->ppr > 0 &&
> -			max6639_info->ppr < 5)
> -		data->ppr = max6639_info->ppr;
> -	else
> -		data->ppr = 2;
> -	data->ppr -= 1;
> -	err = i2c_smbus_write_byte_data(client,
> -			MAX6639_REG_FAN_PPR(i),
> -			data->ppr << 5);
> -	if (err)
> -		goto exit;
> -
>  	if (max6639_info)
>  		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
>  	data->rpm_range = rpm_range;
> 
>  	for (i = 0; i < 2; i++) {
> 
> +		/* Fans pulse per revolution is 2 by default */
> +		if (max6639_info && max6639_info->ppr > 0 &&
> +				max6639_info->ppr < 5)
> +			data->ppr = max6639_info->ppr;
> +		else
> +			data->ppr = 2;
> +		data->ppr -= 1;
> +		err = i2c_smbus_write_byte_data(client,
> +			MAX6639_REG_FAN_PPR(i),
> +			data->ppr << 5);

I think there is a second bug here. According to the datasheet the
shift should be 6 not 5. I'm not sure how this managed to go unnoticed
so far. Maybe there is another bug somewhere in the driver? I see that
FAN_FROM_REG() takes data->ppr as a parameter, which it should not
according to the datasheet. If the PPR setting is set correctly for the
fan being used, then it doesn't show in the formula:

Tachometer count value = internal clock frequency * 60 / actual RPM

where internal clock frequency = fan rpm range / 2, so:

Actual RPM = fan rpm range * 30 / tachometer count value

> +		if (err)
> +			goto exit;
>  		/* Fans config PWM, RPM */
>  		err = i2c_smbus_write_byte_data(client,
>  			MAX6639_REG_FAN_CONFIG1(i),

Assuming I am correct, can you please send two patches, one clearing
the initialization of i and moving the write to MAX6639_REG_FAN_PPR(i)
inside the loop, and a second one fixing the bit shift and the
definition of FAN_FROM_REG?

Note that data->ppr will be unused at this point, so it might as well
be dropped, a local variable will be enough.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
