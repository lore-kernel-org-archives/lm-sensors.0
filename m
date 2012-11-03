From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 Nov 2012 19:59:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for AMDTSI, and restrict sensor type configuratio
Message-Id: <20121103205945.5db907f4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351820480-8998-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351820480-8998-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu,  1 Nov 2012 18:41:20 -0700, Guenter Roeck wrote:
> Add support to detect and report AMDTSI temperature sensor types.
> Only enable PECI and AMDTSI sensor selection if the chip is configured
> for it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Applies on top of the previously submitted patches.
> Only tested with IT8728F and Intel CPU.
> 
>  drivers/hwmon/it87.c |   58 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 52 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index 6a1410b..362ba60 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -331,6 +331,7 @@ struct it87_data {
>  	u16 features;
>  	u8 peci_mask;
>  	u8 old_peci_mask;
> +	u8 ext_temp_type;	/* external temperature sensor type (5 or 6) */
>  
>  	unsigned short addr;
>  	const char *name;
> @@ -643,7 +644,7 @@ static ssize_t show_temp_type(struct device *dev, struct device_attribute *attr,
>  
>  	if ((has_temp_peci(data, nr) && (reg >> 6 = nr + 1))
>  	    || (has_temp_old_peci(data, nr) && (extra & 0x80)))
> -		return sprintf(buf, "6\n");  /* Intel PECI */
> +		return sprintf(buf, "%u\n", data->ext_temp_type);

In theory you need an explicit cast to unsigned int (or unsigned short
with %hu).

>  	if (reg & (1 << nr))
>  		return sprintf(buf, "3\n");  /* thermal diode */
>  	if (reg & (8 << nr))
> @@ -667,24 +668,26 @@ static ssize_t set_temp_type(struct device *dev, struct device_attribute *attr,
>  	reg = it87_read_value(data, IT87_REG_TEMP_ENABLE);
>  	reg &= ~(1 << nr);
>  	reg &= ~(8 << nr);
> -	if (has_temp_peci(data, nr) && (reg >> 6 = nr + 1 || val = 6))
> +	if (has_temp_peci(data, nr) && (reg >> 6 = nr + 1 ||
> +					val = data->ext_temp_type))
>  		reg &= 0x3f;
>  	extra = it87_read_value(data, IT87_REG_TEMP_EXTRA);
> -	if (has_temp_old_peci(data, nr) && ((extra & 0x80) || val = 6))
> +	if (has_temp_old_peci(data, nr) && ((extra & 0x80) ||
> +					    val = data->ext_temp_type))
>  		extra &= 0x7f;
>  	if (val = 2) {	/* backwards compatibility */
>  		dev_warn(dev,
>  			 "Sensor type 2 is deprecated, please use 4 instead\n");
>  		val = 4;
>  	}
> -	/* 3 = thermal diode; 4 = thermistor; 6 = Intel PECI; 0 = disabled */
> +	/* 3 = thermal diode; 4 = thermistor; 5/6 = AMDTSI/PECI; 0 = disabled */
>  	if (val = 3)
>  		reg |= 1 << nr;
>  	else if (val = 4)
>  		reg |= 8 << nr;
> -	else if (has_temp_peci(data, nr) && val = 6)
> +	else if (has_temp_peci(data, nr) && val = data->ext_temp_type)
>  		reg |= (nr + 1) << 6;
> -	else if (has_temp_old_peci(data, nr) && val = 6)
> +	else if (has_temp_old_peci(data, nr) && val = data->ext_temp_type)
>  		extra |= 0x80;
>  	else if (val != 0)
>  		return -EINVAL;
> @@ -1988,6 +1991,7 @@ static int __devinit it87_probe(struct platform_device *pdev)
>  	int err = 0, i;
>  	int enable_pwm_interface;
>  	int fan_beep_need_rw;
> +	u8 reg;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
>  	if (!devm_request_region(&pdev->dev, res->start, IT87_EC_EXTENT,
> @@ -2030,6 +2034,48 @@ static int __devinit it87_probe(struct platform_device *pdev)
>  		break;
>  	}
>  
> +	if (data->features & FEAT_TEMP_OLD_PECI) {
> +		reg = it87_read_value(data, IT87_REG_VID);
> +		switch ((reg >> 4) & 0x07) {
> +		case 0x0:
> +		default:
> +			data->features &> +			  ~(FEAT_TEMP_OLD_PECI | FEAT_TEMP_PECI);
> +			break;
> +		case 0x3:	/* PCH (IT8721F) */
> +			if (data->features & FEAT_TEMP_PECI) {
> +				data->features &= ~FEAT_TEMP_PECI;
> +				data->ext_temp_type = 6;
> +			} else {
> +				data->features &= ~FEAT_TEMP_OLD_PECI;
> +			}
> +			break;
> +		case 0x4:	/* AMDTSI */
> +			data->ext_temp_type = 5;
> +			break;

The IT8782 and IT8783 datasheets I have suggest that AMDTSI isn't
supported on these two chips.

> +		case 0x5:	/* SST slave */
> +		case 0x6:	/* PECI */
> +		case 0x7:	/* SST host */

I am having a hard time finding information about SST. Is it a variant
of PECI, an Intel-only thing? Do you have documentation?

> +			if (data->features & FEAT_TEMP_PECI)
> +				data->features &= ~FEAT_TEMP_OLD_PECI;
> +			data->ext_temp_type = 6;
> +			break;
> +		}
> +	} else if (data->features & FEAT_TEMP_PECI) {
> +		/* Only support PECI for now */
> +		reg = it87_read_value(data, IT87_REG_VID);
> +		switch ((reg >> 4) & 0x03) {
> +		case 0x0:	/* disabled */
> +			data->features &= ~FEAT_TEMP_PECI;
> +			break;
> +		case 0x1:	/* SST slave */
> +		case 0x2:	/* PECI */
> +		case 0x3:	/* SST host */
> +			data->ext_temp_type = 6;
> +			break;
> +		}
> +	}

The more I look at the code above, the more I suspect that you should
have made PCH PECI a separate feature from FEAT_TEMP_OLD_PECI. I'm
sure it would make the code a lot clearer and less fragile too. Your
code makes the assumption that FEAT_TEMP_PECI + FEAT_TEMP_OLD_PECI <=>
FEAT_TEMP_OLD_PECI relates to PCH, which happens to be the case today
but that's just a coincidence and that could change in the future. I
couldn't find any bug in the code above but it took me a long time to
read it, understand it and make sure it was correct. That doesn't seem
right.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
