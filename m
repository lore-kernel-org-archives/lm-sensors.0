From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 30 Mar 2015 19:58:27 +0000
Subject: Re: [lm-sensors] [PATCH 03/15] hwmon: (it87) Introduce configuration field for chip suffix
Message-Id: <20150330215827.17bc43c7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427697235-23566-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1427697235-23566-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sun, 29 Mar 2015 23:33:43 -0700, Guenter Roeck wrote:
> ITE chips may have 'E', 'F', or both 'E' and 'F' suffixes.
> Introduce suffic configuration to the it87_devices structure
> to simplify adding new chips.

I like it, but I'm wondering if it wouldn't be even better to add the
full "nice" chip name to each entry, so that you don't have to
reconstruct it from chip_type? Granted, it would require a few more
bytes of data, but it simplifies the code and would be more flexible
too (imagine some future chip has an ID which no longer exactly match
its name...) What do you think?

> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/it87.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index 180750ef6156..bdd6b33a3b25 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -245,6 +245,7 @@ struct it87_devices {
>  	u16 features;
>  	u8 peci_mask;
>  	u8 old_peci_mask;
> +	const char * const suffix;

I'd put it right after the name field, as they have the same type and
are somewhat related. (name could be const-ified BTW, right?)

>  };
>  
>  #define FEAT_12MV_ADC		(1 << 0)
> @@ -262,28 +263,33 @@ static const struct it87_devices it87_devices[] = {
>  	[it87] = {
>  		.name = "it87",
>  		.features = FEAT_OLD_AUTOPWM,	/* may need to overwrite */
> +		.suffix = "F",
>  	},
>  	[it8712] = {
>  		.name = "it8712",
>  		.features = FEAT_OLD_AUTOPWM | FEAT_VID,
>  						/* may need to overwrite */
> +		.suffix = "F",
>  	},
>  	[it8716] = {
>  		.name = "it8716",
>  		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET | FEAT_VID
>  		  | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
> +		.suffix = "F",
>  	},
>  	[it8718] = {
>  		.name = "it8718",
>  		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET | FEAT_VID
>  		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
>  		.old_peci_mask = 0x4,
> +		.suffix = "F",
>  	},
>  	[it8720] = {
>  		.name = "it8720",
>  		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET | FEAT_VID
>  		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
>  		.old_peci_mask = 0x4,
> +		.suffix = "F",
>  	},
>  	[it8721] = {
>  		.name = "it8721",
> @@ -292,12 +298,14 @@ static const struct it87_devices it87_devices[] = {
>  		  | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
>  		.peci_mask = 0x05,
>  		.old_peci_mask = 0x02,	/* Actually reports PCH */
> +		.suffix = "F",
>  	},
>  	[it8728] = {
>  		.name = "it8728",
>  		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
>  		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_FIVE_FANS,
>  		.peci_mask = 0x07,
> +		.suffix = "F",
>  	},
>  	[it8771] = {
>  		.name = "it8771",
> @@ -308,6 +316,7 @@ static const struct it87_devices it87_devices[] = {
>  				/* 16 bit fans (OHM) */
>  				/* three fans, always 16 bit (guesswork) */
>  		.peci_mask = 0x07,
> +		.suffix = "E",
>  	},
>  	[it8772] = {
>  		.name = "it8772",
> @@ -318,36 +327,42 @@ static const struct it87_devices it87_devices[] = {
>  				/* 16 bit fans (HWSensors4, OHM) */
>  				/* three fans, always 16 bit (datasheet) */
>  		.peci_mask = 0x07,
> +		.suffix = "E",
>  	},
>  	[it8781] = {
>  		.name = "it8781",
>  		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
>  		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG,
>  		.old_peci_mask = 0x4,
> +		.suffix = "F",
>  	},
>  	[it8782] = {
>  		.name = "it8782",
>  		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
>  		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG,
>  		.old_peci_mask = 0x4,
> +		.suffix = "F",
>  	},
>  	[it8783] = {
>  		.name = "it8783",
>  		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
>  		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG,
>  		.old_peci_mask = 0x4,
> +		.suffix = "E/F",
>  	},
>  	[it8786] = {
>  		.name = "it8786",
>  		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
>  		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
>  		.peci_mask = 0x07,
> +		.suffix = "E",
>  	},
>  	[it8603] = {
>  		.name = "it8603",
>  		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
>  		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
>  		.peci_mask = 0x07,
> +		.suffix = "E",
>  	},
>  };
>  
> @@ -1841,9 +1856,8 @@ static int __init it87_find(unsigned short *address,
>  
>  	err = 0;
>  	sio_data->revision = superio_inb(DEVREV) & 0x0f;
> -	pr_info("Found IT%04x%c chip at 0x%x, revision %d\n", chip_type,
> -		chip_type = 0x8771 || chip_type = 0x8772 ||
> -		chip_type = 0x8786 || chip_type = 0x8603 ? 'E' : 'F',
> +	pr_info("Found IT%04x%s chip at 0x%x, revision %d\n", chip_type,
> +		it87_devices[sio_data->type].suffix,
>  		*address, sio_data->revision);
>  
>  	/* in8 (Vbat) is always internal */

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
