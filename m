From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 13 Oct 2011 23:59:50 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627ehf) Properly report thermal
Message-Id: <20111013235950.GA16967@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111013214908.2afa26d6@endymion.delvare>
In-Reply-To: <20111013214908.2afa26d6@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 13, 2011 at 03:49:08PM -0400, Jean Delvare wrote:
> The w83627ehf driver is improperly reporting thermal diode sensors as
> type 2, instead of 3. This caused "sensors" and possibly other
> monitoring tools to report these sensors as "transistor" instead of
> "thermal diode".
> 
> Furthermore, diode subtype selection (CPU vs. external) is only
> supported by the original W83627EHF/EHG. All later models only support
> CPU diode type, and some (NCT6776F) don't even have the register in
> question so we should avoid reading from it.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: stable@kernel.org

Good catch. Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/w83627ehf.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> --- linux-3.1-rc9.orig/drivers/hwmon/w83627ehf.c	2011-10-13 18:21:43.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/w83627ehf.c	2011-10-13 21:40:13.000000000 +0200
> @@ -1718,7 +1718,8 @@ static void w83627ehf_device_remove_file
>  }
>  
>  /* Get the monitoring functions started */
> -static inline void __devinit w83627ehf_init_device(struct w83627ehf_data *data)
> +static inline void __devinit w83627ehf_init_device(struct w83627ehf_data *data,
> +						   enum kinds kind)
>  {
>  	int i;
>  	u8 tmp, diode;
> @@ -1749,10 +1750,16 @@ static inline void __devinit w83627ehf_i
>  		w83627ehf_write_value(data, W83627EHF_REG_VBAT, tmp | 0x01);
>  
>  	/* Get thermal sensor types */
> -	diode = w83627ehf_read_value(data, W83627EHF_REG_DIODE);
> +	switch (kind) {
> +	case w83627ehf:
> +		diode = w83627ehf_read_value(data, W83627EHF_REG_DIODE);
> +		break;
> +	default:
> +		diode = 0x70;
> +	}
>  	for (i = 0; i < 3; i++) {
>  		if ((tmp & (0x02 << i)))
> -			data->temp_type[i] = (diode & (0x10 << i)) ? 1 : 2;
> +			data->temp_type[i] = (diode & (0x10 << i)) ? 1 : 3;
>  		else
>  			data->temp_type[i] = 4; /* thermistor */
>  	}
> @@ -2084,7 +2091,7 @@ static int __devinit w83627ehf_probe(str
>  	}
>  
>  	/* Initialize the chip */
> -	w83627ehf_init_device(data);
> +	w83627ehf_init_device(data, sio_data->kind);
>  
>  	data->vrm = vid_which_vrm();
>  	superio_enter(sio_data->sioreg);
> 
> 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
