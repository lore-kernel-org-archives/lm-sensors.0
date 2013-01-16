From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 16 Jan 2013 16:37:24 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (w83627ehf) Use fixed attributes for SYSTIN, CPUTIN, and AUXTIN
Message-Id: <20130116163724.GB27120@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351356061-30514-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351356061-30514-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Oct 27, 2012 at 09:40:59AM -0700, Guenter Roeck wrote:
> So far the code used dynamic temperature attributes for SYSTIN, CPUTIN, and
> AUXTIN on NCT6775/NCT6776. That has the disadvantage that the mapping of
> tempX_type and tempX_offset does not necessarily match reality, and code
> complexity is increased.
> 
> To avoid mapping problems and simplify the code, use fixed mapping instead, and
> use temp[4-9] for additional temperature sources.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Just noticed another series of pending patches.

Jean, any comments ?

Would be great to find some additional reviewers ...

Thanks,
Guenter

> ---
> This patch changes attribute names on some boards (dynamic attributes are now
> temp4 and higher), but other solutions to solve the tempX_type and tempX_offset
> problems would be more complicated. I am open to ideas, though.
> 
>  drivers/hwmon/w83627ehf.c |  100 ++++++++++++++++-----------------------------
>  1 file changed, 35 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
> index 7a6d42f..9c4af42 100644
> --- a/drivers/hwmon/w83627ehf.c
> +++ b/drivers/hwmon/w83627ehf.c
> @@ -1933,32 +1933,6 @@ static inline void __devinit w83627ehf_init_device(struct w83627ehf_data *data,
>  	}
>  }
>  
> -static void w82627ehf_swap_tempreg(struct w83627ehf_data *data,
> -				   int r1, int r2)
> -{
> -	u16 tmp;
> -
> -	tmp = data->temp_src[r1];
> -	data->temp_src[r1] = data->temp_src[r2];
> -	data->temp_src[r2] = tmp;
> -
> -	tmp = data->reg_temp[r1];
> -	data->reg_temp[r1] = data->reg_temp[r2];
> -	data->reg_temp[r2] = tmp;
> -
> -	tmp = data->reg_temp_over[r1];
> -	data->reg_temp_over[r1] = data->reg_temp_over[r2];
> -	data->reg_temp_over[r2] = tmp;
> -
> -	tmp = data->reg_temp_hyst[r1];
> -	data->reg_temp_hyst[r1] = data->reg_temp_hyst[r2];
> -	data->reg_temp_hyst[r2] = tmp;
> -
> -	tmp = data->reg_temp_config[r1];
> -	data->reg_temp_config[r1] = data->reg_temp_config[r2];
> -	data->reg_temp_config[r2] = tmp;
> -}
> -
>  static void __devinit
>  w83627ehf_set_temp_reg_ehf(struct w83627ehf_data *data, int n_temp)
>  {
> @@ -2111,12 +2085,10 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
>  		break;
>  	}
>  
> -	/* Default to 3 temperature inputs, code below will adjust as needed */
> -	data->have_temp = 0x07;
> -
>  	/* Deal with temperature register setup first. */
>  	if (sio_data->kind = nct6775 || sio_data->kind = nct6776) {
>  		int mask = 0;
> +		int dyn = 3;	/* first dynamic temperature sensor */
>  
>  		/*
>  		 * Display temperature sensor output only if it monitors
> @@ -2126,37 +2098,41 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
>  		for (i = 0; i < NUM_REG_TEMP; i++) {
>  			u8 src;
>  
> -			data->reg_temp[i] = NCT6775_REG_TEMP[i];
> -			data->reg_temp_over[i] = NCT6775_REG_TEMP_OVER[i];
> -			data->reg_temp_hyst[i] = NCT6775_REG_TEMP_HYST[i];
> -			data->reg_temp_config[i] = NCT6775_REG_TEMP_CONFIG[i];
> -
>  			src = w83627ehf_read_value(data,
>  						   NCT6775_REG_TEMP_SOURCE[i]);
>  			src &= 0x1f;
> -			if (src && !(mask & (1 << src))) {
> -				data->have_temp |= 1 << i;
> -				mask |= 1 << src;
> +
> +			if (!src || (mask & (1 << src)))
> +				continue;
> +			mask |= 1 << src;
> +
> +			/* Fixed index for SYSTIN(1), CPUTIN(2), AUXTIN(3) */
> +			if (src <= 3) {
> +				int index = src - 1;
> +
> +				data->have_temp |= (1 << index);
> +				data->reg_temp[index] = NCT6775_REG_TEMP[i];
> +				data->reg_temp_over[index]
> +				  = NCT6775_REG_TEMP_OVER[i];
> +				data->reg_temp_hyst[index]
> +				  = NCT6775_REG_TEMP_HYST[i];
> +				data->reg_temp_config[index]
> +				  = NCT6775_REG_TEMP_CONFIG[i];
> +				data->temp_src[index] = src;
> +				continue;
>  			}
>  
> -			data->temp_src[i] = src;
> +			if (dyn >= ARRAY_SIZE(data->reg_temp))
> +				continue;
> +
> +			data->reg_temp[dyn] = NCT6775_REG_TEMP[i];
> +			data->reg_temp_over[dyn] = NCT6775_REG_TEMP_OVER[i];
> +			data->reg_temp_hyst[dyn] = NCT6775_REG_TEMP_HYST[i];
> +			data->reg_temp_config[dyn] = NCT6775_REG_TEMP_CONFIG[i];
> +			data->temp_src[dyn] = src;
>  
> -			/*
> -			 * Now do some register swapping if index 0..2 don't
> -			 * point to SYSTIN(1), CPUIN(2), and AUXIN(3).
> -			 * Idea is to have the first three attributes
> -			 * report SYSTIN, CPUIN, and AUXIN if possible
> -			 * without overriding the basic system configuration.
> -			 */
> -			if (i > 0 && data->temp_src[0] != 1
> -			    && data->temp_src[i] = 1)
> -				w82627ehf_swap_tempreg(data, 0, i);
> -			if (i > 1 && data->temp_src[1] != 2
> -			    && data->temp_src[i] = 2)
> -				w82627ehf_swap_tempreg(data, 1, i);
> -			if (i > 2 && data->temp_src[2] != 3
> -			    && data->temp_src[i] = 3)
> -				w82627ehf_swap_tempreg(data, 2, i);
> +			data->have_temp |= (1 << dyn);
> +			dyn++;
>  		}
>  		if (sio_data->kind = nct6776) {
>  			/*
> @@ -2168,14 +2144,9 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
>  			 * If that is the case, disable in6, which reports VIN3.
>  			 * Otherwise disable temp3.
>  			 */
> -			if (data->temp_src[2] = 3) {
> -				u8 reg;
> -
> -				if (data->reg_temp_config[2])
> -					reg = w83627ehf_read_value(data,
> +			if (data->have_temp & (1 << 2)) {
> +				u8 reg = w83627ehf_read_value(data,
>  						data->reg_temp_config[2]);
> -				else
> -					reg = 0; /* Assume AUXTIN is used */
>  
>  				if (reg & 0x01)
>  					data->have_temp &= ~(1 << 2);
> @@ -2187,13 +2158,10 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
>  			data->temp_label = nct6775_temp_label;
>  		}
>  		data->have_temp_offset = data->have_temp & 0x07;
> -		for (i = 0; i < 3; i++) {
> -			if (data->temp_src[i] > 3)
> -				data->have_temp_offset &= ~(1 << i);
> -		}
>  	} else if (sio_data->kind = w83667hg_b) {
>  		u8 reg;
>  
> +		data->have_temp = 0x07;
>  		w83627ehf_set_temp_reg_ehf(data, 4);
>  
>  		/*
> @@ -2241,6 +2209,7 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
>  	} else if (sio_data->kind = w83627uhg) {
>  		u8 reg;
>  
> +		data->have_temp = 0x07;
>  		w83627ehf_set_temp_reg_ehf(data, 3);
>  
>  		/*
> @@ -2280,6 +2249,7 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
>  				data->have_temp_offset &= ~(1 << i);
>  		}
>  	} else {
> +		data->have_temp = 0x07;
>  		w83627ehf_set_temp_reg_ehf(data, 3);
>  
>  		/* Temperature sources are fixed */
> -- 
> 1.7.9.7
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
