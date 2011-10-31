From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 31 Oct 2011 15:24:51 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (w83627ehf) Properly report
Message-Id: <1320074691.18747.4.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111031151923.7dd990b9@endymion.delvare>
In-Reply-To: <20111031151923.7dd990b9@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-10-31 at 10:19 -0400, Jean Delvare wrote:
> When temperature sources are PECI or AMD-SI agents, it makes no sense
> to report their type as diode or thermistor. Instead we must report
> their digital nature.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: stable@kernel.org

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

> ---
>  drivers/hwmon/w83627ehf.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> --- linux-3.2-rc0.orig/drivers/hwmon/w83627ehf.c	2011-10-31 14:21:09.000000000 +0100
> +++ linux-3.2-rc0/drivers/hwmon/w83627ehf.c	2011-10-31 14:24:39.000000000 +0100
> @@ -1812,7 +1812,14 @@ static inline void __devinit w83627ehf_i
>  		diode = 0x70;
>  	}
>  	for (i = 0; i < 3; i++) {
> -		if ((tmp & (0x02 << i)))
> +		const char *label = data->temp_label[data->temp_src[i]];
> +
> +		/* Digital source overrides analog type */
> +		if (strncmp(label, "PECI", 4) = 0)
> +			data->temp_type[i] = 6;
> +		else if (strncmp(label, "AMD", 3) = 0)
> +			data->temp_type[i] = 5;
> +		else if ((tmp & (0x02 << i)))
>  			data->temp_type[i] = (diode & (0x10 << i)) ? 1 : 3;
>  		else
>  			data->temp_type[i] = 4; /* thermistor */
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
