From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 31 Oct 2011 15:22:59 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (w83627ehf) Clean up probe
Message-Id: <1320074579.18747.2.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111031152004.28e9f7b8@endymion.delvare>
In-Reply-To: <20111031152004.28e9f7b8@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-10-31 at 10:20 -0400, Jean Delvare wrote:
> The probe function has grown pretty large, I think it's time for some
> cleanups, starting with these two simple ones:
> * Move temp3/in6 check for the W83667HG later in the function, where
>   it is done for all other chip types.
> * Move temperature register setting to a separate function, to avoid
>   code duplication.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Do you want to take this series, or should I take it ?

> ---
> Guenter, had you considered adding support for the NCT6775 and NCT6776
> to a separate driver? The code starts being seriously bloated :(
> 
No thoughts so far. Might be an option, but I am not sure if/when I
would have time to work on it. And I would have to get a board with
NCT6776 on it. If there are any with SandyBridge CPU, I might actually
get one ;).

>  drivers/hwmon/w83627ehf.c |   53 +++++++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 21 deletions(-)
> 
> --- linux-3.2-rc0.orig/drivers/hwmon/w83627ehf.c	2011-10-31 14:24:39.000000000 +0100
> +++ linux-3.2-rc0/drivers/hwmon/w83627ehf.c	2011-10-31 14:31:50.000000000 +0100
> @@ -1853,6 +1853,19 @@ static void w82627ehf_swap_tempreg(struc
>  }
>  
>  static void __devinit
> +w83627ehf_set_temp_reg_ehf(struct w83627ehf_data *data, int n_temp)
> +{
> +	int i;
> +
> +	for (i = 0; i < n_temp; i++) {
> +		data->reg_temp[i] = W83627EHF_REG_TEMP[i];
> +		data->reg_temp_over[i] = W83627EHF_REG_TEMP_OVER[i];
> +		data->reg_temp_hyst[i] = W83627EHF_REG_TEMP_HYST[i];
> +		data->reg_temp_config[i] = W83627EHF_REG_TEMP_CONFIG[i];
> +	}
> +}
> +
> +static void __devinit
>  w83627ehf_check_fan_inputs(const struct w83627ehf_sio_data *sio_data,
>  			   struct w83627ehf_data *data)
>  {
> @@ -1955,17 +1968,8 @@ static int __devinit w83627ehf_probe(str
>  			 || sio_data->kind = nct6775
>  			 || sio_data->kind = nct6776) ? 3 : 4;
>  
> +	/* Default to 3 temperature inputs, code below will adjust as needed */
>  	data->have_temp = 0x07;
> -	/* Check temp3 configuration bit for 667HG */
> -	if (sio_data->kind = w83667hg) {
> -		u8 reg;
> -
> -		reg = w83627ehf_read_value(data, W83627EHF_REG_TEMP_CONFIG[2]);
> -		if (reg & 0x01)
> -			data->have_temp &= ~(1 << 2);
> -		else
> -			data->in6_skip = 1;	/* either temp3 or in6 */
> -	}
>  
>  	/* Deal with temperature register setup first. */
>  	if (sio_data->kind = nct6775 || sio_data->kind = nct6776) {
> @@ -2042,16 +2046,12 @@ static int __devinit w83627ehf_probe(str
>  	} else if (sio_data->kind = w83667hg_b) {
>  		u8 reg;
>  
> +		w83627ehf_set_temp_reg_ehf(data, 4);
> +
>  		/*
>  		 * Temperature sources are selected with bank 0, registers 0x49
>  		 * and 0x4a.
>  		 */
> -		for (i = 0; i < ARRAY_SIZE(W83627EHF_REG_TEMP); i++) {
> -			data->reg_temp[i] = W83627EHF_REG_TEMP[i];
> -			data->reg_temp_over[i] = W83627EHF_REG_TEMP_OVER[i];
> -			data->reg_temp_hyst[i] = W83627EHF_REG_TEMP_HYST[i];
> -			data->reg_temp_config[i] = W83627EHF_REG_TEMP_CONFIG[i];
> -		}
>  		reg = w83627ehf_read_value(data, 0x4a);
>  		data->temp_src[0] = reg >> 5;
>  		reg = w83627ehf_read_value(data, 0x49);
> @@ -2086,12 +2086,23 @@ static int __devinit w83627ehf_probe(str
>  
>  		data->temp_label = w83667hg_b_temp_label;
>  	} else {
> +		w83627ehf_set_temp_reg_ehf(data, 3);
> +
>  		/* Temperature sources are fixed */
> -		for (i = 0; i < 3; i++) {
> -			data->reg_temp[i] = W83627EHF_REG_TEMP[i];
> -			data->reg_temp_over[i] = W83627EHF_REG_TEMP_OVER[i];
> -			data->reg_temp_hyst[i] = W83627EHF_REG_TEMP_HYST[i];
> -			data->reg_temp_config[i] = W83627EHF_REG_TEMP_CONFIG[i];
> +
> +		if (sio_data->kind = w83667hg) {
> +			u8 reg;
> +
> +			/*
> +			 * Chip supports either AUXTIN or VIN3. Try to find
> +			 * out which one.
> +			 */
> +			reg = w83627ehf_read_value(data,
> +						W83627EHF_REG_TEMP_CONFIG[2]);
> +			if (reg & 0x01)
> +				data->have_temp &= ~(1 << 2);
> +			else
> +				data->in6_skip = 1;
>  		}
>  	}
>  
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
