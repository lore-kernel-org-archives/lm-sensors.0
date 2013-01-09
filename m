From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Jan 2013 21:58:00 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: Replace SENSORS_LIMIT with clamp_val
Message-Id: <20130109225800.04d0b1a1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1357750750-30512-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1357750750-30512-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, George Joseph <george.joseph@fairview5.com>, Juerg Haefliger <juergh@gmail.com>, Steve Glendinning <steve.glendinning@shawell.net>, Riku Voipio <riku.voipio@iki.fi>, Guillaume Ligneul <guillaume.ligneul@gmail.com>, "Hans J. Koch" <hjk@hansjkoch.de>, Roger Lucas <vt8231@hiddenengine.co.uk>, Marc Hulsman <m.hulsman@tudelft.nl>, Rudolf Marek <r.marek@assembler.cz>, Corentin Chary <corentin.chary@gmail.com>, Matthew Garrett <mjg@redhat.com>, platform-driver-x86@vger.kernel.org

On Wed,  9 Jan 2013 08:59:07 -0800, Guenter Roeck wrote:
> SENSORS_LIMIT and the generic clamp_val have the same functionality,
> and clamp_val is more efficient.
> 
> This patch reduces text size by 9052 bytes and bss size by 11624 bytes
> for x86_64 builds.

Wow, I like it a lot! Well done!

> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Jean Delvare <khali@linux-fr.org>

Just one thing:

> (...)
> diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
> index 1a003f7..81449a2 100644
> --- a/drivers/hwmon/lm93.c
> +++ b/drivers/hwmon/lm93.c
> @@ -371,22 +371,22 @@ static unsigned LM93_IN_FROM_REG(int nr, u8 reg)
>  static u8 LM93_IN_TO_REG(int nr, unsigned val)
>  {
>  	/* range limit */
> -	const long mV = SENSORS_LIMIT(val,
> -		lm93_vin_val_min[nr], lm93_vin_val_max[nr]);
> +	const long mv = clamp_val(val,
> +				  lm93_vin_val_min[nr], lm93_vin_val_max[nr]);
>  
>  	/* try not to lose too much precision here */
> -	const long uV = mV * 1000;
> -	const long uV_max = lm93_vin_val_max[nr] * 1000;
> -	const long uV_min = lm93_vin_val_min[nr] * 1000;
> +	const long uv = mv * 1000;
> +	const long uv_max = lm93_vin_val_max[nr] * 1000;
> +	const long uv_min = lm93_vin_val_min[nr] * 1000;
>  
>  	/* convert */
> -	const long slope = (uV_max - uV_min) /
> +	const long slope = (uv_max - uv_min) /
>  		(lm93_vin_reg_max[nr] - lm93_vin_reg_min[nr]);
> -	const long intercept = uV_min - slope * lm93_vin_reg_min[nr];
> +	const long intercept = uv_min - slope * lm93_vin_reg_min[nr];
>  
> -	u8 result = ((uV - intercept + (slope/2)) / slope);
> -	result = SENSORS_LIMIT(result,
> -			lm93_vin_reg_min[nr], lm93_vin_reg_max[nr]);
> +	u8 result = ((uv - intercept + (slope/2)) / slope);

All these case changes in variable name seem a little off-topic here,
especially for a subsystem-wide patch.

> +	result = clamp_val(result,
> +			   lm93_vin_reg_min[nr], lm93_vin_reg_max[nr]);
>  	return result;
>  }
>  
> @@ -409,13 +409,13 @@ static unsigned LM93_IN_REL_FROM_REG(u8 reg, int upper, int vid)
>   */
>  static u8 LM93_IN_REL_TO_REG(unsigned val, int upper, int vid)
>  {
> -	long uV_offset = vid * 1000 - val * 10000;
> +	long uv_offset = vid * 1000 - val * 10000;
>  	if (upper) {
> -		uV_offset = SENSORS_LIMIT(uV_offset, 12500, 200000);
> -		return (u8)((uV_offset /  12500 - 1) << 4);
> +		uv_offset = clamp_val(uv_offset, 12500, 200000);
> +		return (u8)((uv_offset /  12500 - 1) << 4);
>  	} else {
> -		uV_offset = SENSORS_LIMIT(uV_offset, -400000, -25000);
> -		return (u8)((uV_offset / -25000 - 1) << 0);
> +		uv_offset = clamp_val(uv_offset, -400000, -25000);
> +		return (u8)((uv_offset / -25000 - 1) << 0);

Same here.

>  	}
>  }
>  (...)
> @@ -2052,9 +2052,9 @@ static ssize_t store_pwm_auto_channels(struct device *dev,
>  		return err;
>  
>  	mutex_lock(&data->update_lock);
> -	data->block9[nr][LM93_PWM_CTL1] = SENSORS_LIMIT(val, 0, 255);
> +	data->block9[nr][LM93_PWM_CTL1] = clamp_val(val, 0, 255);
>  	lm93_write_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL1),
> -				data->block9[nr][LM93_PWM_CTL1]);
> +			data->block9[nr][LM93_PWM_CTL1]);

This one, while correct, also doesn't belong here IMHO.

>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
