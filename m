From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 24 Feb 2015 10:07:38 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: (it87) Add feature flag for VID support
Message-Id: <20150224110738.638657a7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423858433-1416-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1423858433-1416-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 13 Feb 2015 12:13:52 -0800, Guenter Roeck wrote:
> Newer chips don't typically support VID inputs or control.
> Add a feature flag for VID support to simplify adding support for
> new chips.

I like the idea. One comment below.

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/it87.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index 0e1758f..1754bef 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -254,6 +254,7 @@ struct it87_devices {
>  #define FEAT_TEMP_OLD_PECI	(1 << 6)
>  #define FEAT_FAN16_CONFIG	(1 << 7)	/* Need to enable 16-bit fans */
>  #define FEAT_FIVE_FANS		(1 << 8)	/* Supports five fans */
> +#define FEAT_VID		(1 << 9)	/* Set if chip supports VID */
>  
>  static const struct it87_devices it87_devices[] = {
>  	[it87] = {
> @@ -263,23 +264,23 @@ static const struct it87_devices it87_devices[] = {
>  	},
>  	[it8712] = {
>  		.name = "it8712",
> -		.features = FEAT_OLD_AUTOPWM | FEAT_FAN16_CONFIG,skip_vid
> +		.features = FEAT_OLD_AUTOPWM | FEAT_FAN16_CONFIG | FEAT_VID,
>  						/* may need to overwrite */
>  	},
>  	[it8716] = {
>  		.name = "it8716",
> -		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
> +		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET | FEAT_VID
>  		  | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
>  	},
>  	[it8718] = {
>  		.name = "it8718",
> -		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
> +		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET | FEAT_VID
>  		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
>  		.old_peci_mask = 0x4,
>  	},
>  	[it8720] = {
>  		.name = "it8720",
> -		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
> +		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET | FEAT_VID
>  		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
>  		.old_peci_mask = 0x4,
>  	},
> @@ -356,6 +357,7 @@ static const struct it87_devices it87_devices[] = {
>  #define has_fan16_config(data)	(has_16bit_fans(data) && \
>  				 ((data)->features & FEAT_FAN16_CONFIG))
>  #define has_five_fans(data)	((data)->features & FEAT_FIVE_FANS)
> +#define has_vid(data)		((data)->features & FEAT_VID)
>  
>  struct it87_sio_data {
>  	enum chips type;
> @@ -1825,19 +1827,17 @@ static int __init it87_find(unsigned short *address,
>  	if (sio_data->type != it8603)
>  		sio_data->skip_in |= (1 << 9);
>  
> -	/* Read GPIO config and VID value from LDN 7 (GPIO) */
> -	if (sio_data->type = it87) {
> -		/* The IT8705F doesn't have VID pins at all */
> +	if (!(it87_devices[sio_data->type].features & FEAT_VID))
>  		sio_data->skip_vid = 1;
>  
> +	/* Read GPIO config and VID value from LDN 7 (GPIO) */
> +	if (sio_data->type = it87) {
>  		/* The IT8705F has a different LD number for GPIO */
>  		superio_select(5);
>  		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
>  	} else if (sio_data->type = it8783) {
>  		int reg25, reg27, reg2a, reg2c, regef;
>  
> -		sio_data->skip_vid = 1;	/* No VID */
> -
>  		superio_select(GPIO);
>  
>  		reg25 = superio_inb(IT87_SIO_GPIO1_REG);
> @@ -1903,7 +1903,6 @@ static int __init it87_find(unsigned short *address,
>  	} else if (sio_data->type = it8603) {
>  		int reg27, reg29;
>  
> -		sio_data->skip_vid = 1;	/* No VID */
>  		superio_select(GPIO);
>  
>  		reg27 = superio_inb(IT87_SIO_GPIO3_REG);
> @@ -1939,16 +1938,7 @@ static int __init it87_find(unsigned short *address,
>  		superio_select(GPIO);
>  
>  		reg = superio_inb(IT87_SIO_GPIO3_REG);
> -		if (sio_data->type = it8721 || sio_data->type = it8728 ||
> -		    sio_data->type = it8771 || sio_data->type = it8772 ||
> -		    sio_data->type = it8781 || sio_data->type = it8782) {
> -			/*
> -			 * IT8721F/IT8758E, IT8728F, IT8772F, IT8781F, and
> -			 * IT8782F don't have VID pins at all, not sure about
> -			 * the IT8771F.
> -			 */
> -			sio_data->skip_vid = 1;
> -		} else {
> +		if (!sio_data->skip_vid) {
>  			/* We need at least 4 VID pins */
>  			if (reg & 0x0f) {
>  				pr_info("VID is disabled (pins used for GPIO)\n");
> @@ -1969,8 +1959,7 @@ static int __init it87_find(unsigned short *address,
>  		if (reg & (1 << 2))
>  			sio_data->skip_fan |= (1 << 1);
>  
> -		if ((sio_data->type = it8718 || sio_data->type = it8720)
> -		 && !(sio_data->skip_vid))
> +		if (!sio_data->skip_vid)
>  			sio_data->vid_value = superio_inb(IT87_SIO_VID_REG);

You shouldn't change this condition in this patch. Only the IT8718F and
IT8720F need to read the VID value from the Super-I/O configuration
space at initialization time. The IT8712F and IT8716F read it from the
hardware monitoring registers at run time. According to the datasheets,
reading it from the Super-I/O configuration space at initialization
time should work on the newer IT8712F and all IT8716F, but probably not
on the older IT8712F as they do not have this register.

Now you can argue that the value will be overwritten later anyway so it
doesn't matter, and you may prefer to simplify the code at the expense
of one extra I/O. Why not, but this should be implemented and discussed
in a different patch.

>  
>  		reg = superio_inb(IT87_SIO_PINX2_REG);

If you remove the last change, you can add:

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
