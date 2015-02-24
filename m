From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 24 Feb 2015 09:31:04 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (it87) Add feature flags for fans count and 16-bit fan configura
Message-Id: <20150224103104.1208bd2e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423858433-1416-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1423858433-1416-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 13 Feb 2015 12:13:51 -0800, Guenter Roeck wrote:
> Fans 4-5 are not supported on all chips and revisions. Also, 16-bit fan
> counters only need to be enabled on older chips. Provide feature flags

"older chips" doesn't really match the reality, considering that the
rather recent IT8781F, IT8782F and IT8783F chips need it. Presumably
they are based on an old design but from a user and market perspective
that doesn't make them old chips.

> to simplify adding support for new chips.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/it87.c | 70 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index ed25e4b..0e1758f 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -252,79 +252,87 @@ struct it87_devices {
>  #define FEAT_TEMP_OFFSET	(1 << 4)
>  #define FEAT_TEMP_PECI		(1 << 5)
>  #define FEAT_TEMP_OLD_PECI	(1 << 6)
> +#define FEAT_FAN16_CONFIG	(1 << 7)	/* Need to enable 16-bit fans */
> +#define FEAT_FIVE_FANS		(1 << 8)	/* Supports five fans */
>  
>  static const struct it87_devices it87_devices[] = {
>  	[it87] = {
>  		.name = "it87",
> -		.features = FEAT_OLD_AUTOPWM,	/* may need to overwrite */
> +		.features = FEAT_OLD_AUTOPWM | FEAT_FAN16_CONFIG,
> +						/* may need to overwrite */
>  	},
>  	[it8712] = {
>  		.name = "it8712",
> -		.features = FEAT_OLD_AUTOPWM,	/* may need to overwrite */
> +		.features = FEAT_OLD_AUTOPWM | FEAT_FAN16_CONFIG,
> +						/* may need to overwrite */
>  	},

This is incorrect, early IT8705F and IT8712F chips did not support
16-bit fans so it could not be (and didn't have to be) configured.
FEAT_FAN16_CONFIG should be added dynamically in it87_probe() together
with FEAT_16BIT_FANS for the newer IT8705F and IT8712F chips.

(Yes I realize it makes no difference in practice because
FEAT_FAN16_CONFIG has no effect without FEAT_16BIT_FANS, but being
conceptually correct doesn't hurt and it could even save someone a
headache in the future.)

>  	[it8716] = {
>  		.name = "it8716",
> -		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET,
> +		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
> +		  | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
>  	},
>  	[it8718] = {
>  		.name = "it8718",
>  		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
> -		  | FEAT_TEMP_OLD_PECI,
> +		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
>  		.old_peci_mask = 0x4,
>  	},
>  	[it8720] = {
>  		.name = "it8720",
>  		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
> -		  | FEAT_TEMP_OLD_PECI,
> +		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
>  		.old_peci_mask = 0x4,
>  	},
>  	[it8721] = {
>  		.name = "it8721",
>  		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
> -		  | FEAT_TEMP_OFFSET | FEAT_TEMP_OLD_PECI | FEAT_TEMP_PECI,
> +		  | FEAT_TEMP_OFFSET | FEAT_TEMP_OLD_PECI | FEAT_TEMP_PECI
> +		  | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
>  		.peci_mask = 0x05,
>  		.old_peci_mask = 0x02,	/* Actually reports PCH */
>  	},
>  	[it8728] = {
>  		.name = "it8728",
>  		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
> -		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
> +		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_FIVE_FANS,
>  		.peci_mask = 0x07,
>  	},
>  	[it8771] = {
>  		.name = "it8771",
>  		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
>  		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
> -					/* PECI: guesswork */
> -					/* 12mV ADC (OHM) */
> -					/* 16 bit fans (OHM) */
> +				/* PECI: guesswork */
> +				/* 12mV ADC (OHM) */
> +				/* 16 bit fans (OHM) */
> +				/* three fans, always 16 bit (guesswork) */
>  		.peci_mask = 0x07,
>  	},
>  	[it8772] = {
>  		.name = "it8772",
>  		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
>  		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
> -					/* PECI (coreboot) */
> -					/* 12mV ADC (HWSensors4, OHM) */
> -					/* 16 bit fans (HWSensors4, OHM) */
> +				/* PECI (coreboot) */
> +				/* 12mV ADC (HWSensors4, OHM) */
> +				/* 16 bit fans (HWSensors4, OHM) */
> +				/* three fans, always 16 bit (datasheet) */
>  		.peci_mask = 0x07,
>  	},
>  	[it8781] = {
>  		.name = "it8781",
>  		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
> -		  | FEAT_TEMP_OLD_PECI,
> +		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG,
>  		.old_peci_mask = 0x4,
>  	},
>  	[it8782] = {
>  		.name = "it8782",
>  		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
> -		  | FEAT_TEMP_OLD_PECI,
> +		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG,
>  		.old_peci_mask = 0x4,
>  	},
>  	[it8783] = {
>  		.name = "it8783",
>  		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
> -		  | FEAT_TEMP_OLD_PECI,
> +		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG,
>  		.old_peci_mask = 0x4,
>  	},
>  	[it8603] = {
> @@ -345,6 +353,9 @@ static const struct it87_devices it87_devices[] = {
>  #define has_temp_old_peci(data, nr) \
>  				(((data)->features & FEAT_TEMP_OLD_PECI) && \
>  				 ((data)->old_peci_mask & (1 << nr)))
> +#define has_fan16_config(data)	(has_16bit_fans(data) && \
> +				 ((data)->features & FEAT_FAN16_CONFIG))

The has_16bit_fans() check is no longer needed it you do the proposed
change above.

> +#define has_five_fans(data)	((data)->features & FEAT_FIVE_FANS)
>  
>  struct it87_sio_data {
>  	enum chips type;
> @@ -2130,7 +2141,7 @@ static int it87_probe(struct platform_device *pdev)
>  	case it8712:
>  		if (sio_data->revision >= 0x08) {
>  			data->features &= ~FEAT_OLD_AUTOPWM;
> -			data->features |= FEAT_16BIT_FANS;
> +			data->features |= FEAT_16BIT_FANS | FEAT_FIVE_FANS;
>  		}
>  		break;
>  	default:
> @@ -2463,9 +2474,8 @@ static void it87_init_device(struct platform_device *pdev)
>  	}
>  	data->has_fan = (data->fan_main_ctrl >> 4) & 0x07;
>  
> -	/* Set tachometers to 16-bit mode if needed, IT8603E (and IT8728F?)
> -	 * has it by default */
> -	if (has_16bit_fans(data) && data->type != it8603) {
> +	/* Set tachometers to 16-bit mode if needed. */

Trailing dot should be omitted for consistency with the surrounding
comments.

> +	if (has_fan16_config(data)) {

If I read the changes properly, we were executing the code below on all
16-bit fan capable chips except the IT8603E before, and now you also
exclude the IT8728F, the IT8771E and the IT8772E. This may or may not
be correct, but it definitely should NOT happen in this patch. Adding
feature flags to make the core more readable is great but it should not
come with hidden changes in code behavior.

(For the IT8772E and IT8728F this change seems correct according to the
datasheets, I can't say for the IT8771E as I have no datasheet.)

>  		tmp = it87_read_value(data, IT87_REG_FAN_16BIT);
>  		if (~tmp & 0x07 & data->has_fan) {
>  			dev_dbg(&pdev->dev,
> @@ -2473,17 +2483,15 @@ static void it87_init_device(struct platform_device *pdev)
>  			it87_write_value(data, IT87_REG_FAN_16BIT,
>  					 tmp | 0x07);
>  		}
> -		/*
> -		 * IT8705F, IT8781F, IT8782F, and IT8783E/F only support
> -		 * three fans.
> -		 */
> -		if (data->type != it87 && data->type != it8781 &&
> -		    data->type != it8782 && data->type != it8783) {
> -			if (tmp & (1 << 4))
> -				data->has_fan |= (1 << 3); /* fan4 enabled */
> -			if (tmp & (1 << 5))
> -				data->has_fan |= (1 << 4); /* fan5 enabled */
> -		}
> +	}
> +
> +	/* Check for additional fans */
> +	if (has_five_fans(data)) {
> +		tmp = it87_read_value(data, IT87_REG_FAN_16BIT);

This makes us read the same register twice, but I suppose this is a
reasonable to price to pay for cleaner code, so no objection from me.

> +		if (tmp & (1 << 4))
> +			data->has_fan |= (1 << 3); /* fan4 enabled */
> +		if (tmp & (1 << 5))
> +			data->has_fan |= (1 << 4); /* fan5 enabled */
>  	}
>  
>  	/* Fan input pins may be used for alternative functions */


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
