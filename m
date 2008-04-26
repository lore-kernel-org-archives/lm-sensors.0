From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 26 Apr 2008 13:08:48 +0000
Subject: Re: [lm-sensors] [PATCH] adt7473: fix voltage conversion
Message-Id: <20080426150848.49500349@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <480E6CB1.1050800@teltonika.lt>
In-Reply-To: <480E6CB1.1050800@teltonika.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paulius,

Adding Darrick in Cc in case he missed this patch.

Could any of you please send me a dump of an ADT7473 chip for my
collection?

On Wed, 23 Apr 2008 01:54:41 +0300, Paulius Zaleckas wrote:
> Fixes voltage conversion routines.
> According to the datasheet voltage is scaled with resistors and
> value 192 is nominal voltage. 0 is 0V.
> Conversion routines taken from the lm85 driver

Together with its horrible coding style :( While copying the logic from
the lm85 driver is fine, copying the code itself isn't so. It uses
macros where (possibly inline) functions are preferred, had bad
indentation, etc...

So, can you please resend a patch that would do only the required
changes? Keep decode_volt and encode_volt as the function names, and
just change the code inside these functions. This should make for a
much nicer patch.

> 
> Signed-of-by: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>

Typo: Signed-off-by.

Review:

> diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
> index 9587869..6eeea6a 100644
> --- a/drivers/hwmon/adt7473.c
> +++ b/drivers/hwmon/adt7473.c
> @@ -317,37 +317,21 @@ out:
>  	return data;
>  }
>  
> -/*
> - * On this chip, voltages are given as a count of steps between a minimum
> - * and maximum voltage, not a direct voltage.
> +/* Conversions. Rounding and limit checking is only done on the TO_REG 
> +   variants. Note that you should be a bit careful with which arguments
> +   these macros are called: arguments may be evaluated more than once.
>   */
> -static const int volt_convert_table[][2] = {
> -	{2997, 3},
> -	{4395, 4},
> -};
> -
> -static int decode_volt(int volt_index, u8 raw)
> -{
> -	int cmax = volt_convert_table[volt_index][0];
> -	int cmin = volt_convert_table[volt_index][1];
> -	return ((raw * (cmax - cmin)) / 255) + cmin;
> -}
> -
> -static u8 encode_volt(int volt_index, int cooked)
> -{
> -	int cmax = volt_convert_table[volt_index][0];
> -	int cmin = volt_convert_table[volt_index][1];
> -	u8 x;
>  
> -	if (cooked > cmax)
> -		cooked = cmax;
> -	else if (cooked < cmin)
> -		cooked = cmin;
> +/* IN are scaled acording to built-in resistors */
> +static int adt7473_scaling[] = {  /* .001 Volts */
> +		2250, 3300
> +	};

Too many tabs.

> +#define SCALE(val,from,to)		(((val)*(to) + ((from)/2))/(from))

Would better be an inline function. There should be spaces around *
and /.

>  
> -	x = ((cooked - cmin) * 255) / (cmax - cmin);
> +#define INS_TO_REG(n,val)	\
> +		SENSORS_LIMIT(SCALE(val,adt7473_scaling[n],192),0,255)
>  
> -	return x;
> -}
> +#define INS_FROM_REG(n,val)	SCALE((val), 192, adt7473_scaling[n])
>  
>  static ssize_t show_volt_min(struct device *dev,
>  			     struct device_attribute *devattr,
> (...)

While we're here, I've read the ADT7473 datasheet and it states that
bit 5 of configuration register 2 (0x73) disables the internal
attenuator for Vccp. In that case 2.250V is no longer the nominal value
(register value 192) but the maximum value (virtually register value
256). It would be great if the adt7473 driver could handle this case,
otherwise the reported voltage value is incorrect. Maybe something for
a next patch?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
