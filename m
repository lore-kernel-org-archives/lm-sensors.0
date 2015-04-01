From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 01 Apr 2015 06:59:23 +0000
Subject: Re: [lm-sensors] [PATCH 05/15] hwmon: (it87) Add support for IT8790E
Message-Id: <20150401085923.582047f5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427697235-23566-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1427697235-23566-6-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sun, 29 Mar 2015 23:33:45 -0700, Guenter Roeck wrote:
> IT8790E is a super-IO chip with three fan tachometers. It is mostly
> compatible to IT8728E.

IT8728F, not E. That being said, the IT8728F supports 5 fans, so the
IT8790E seems rather similar to the IT8786E? They are treated exactly
the same AFAICS.

> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/it87 | 13 ++++++++++---
>  drivers/hwmon/Kconfig    |  4 ++--
>  drivers/hwmon/it87.c     | 14 +++++++++++++-
>  3 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
> index 19fbe775ae10..64ea41f017c1 100644
> --- a/Documentation/hwmon/it87
> +++ b/Documentation/hwmon/it87
> @@ -58,6 +58,10 @@ Supported chips:
>      Prefix: 'it8786'
>      Addresses scanned: from Super I/O config space (8 I/O ports)
>      Datasheet: Not publicly available
> +  * IT8790E
> +    Prefix: 'it8790'
> +    Addresses scanned: from Super I/O config space (8 I/O ports)
> +    Datasheet: Not publicly available
>    * SiS950   [clone of IT8705F]
>      Prefix: 'it87'
>      Addresses scanned: from Super I/O config space (8 I/O ports)
> @@ -102,9 +106,10 @@ motherboard models.
>  Description
>  -----------
>  
> -This driver implements support for the IT8603E, IT8623E, IT8705F, IT8712F,
> -IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E, IT8771E,
> -IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E, and SiS950 chips.
> +This driver implements support for the IT8603E, IT8623E, IT8705F,
> +IT8712F, IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
> +IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E, IT8790E, and SiS950
> +chips.
>  
>  These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
>  joysticks and other miscellaneous stuff. For hardware monitoring, they
> @@ -145,6 +150,8 @@ The IT8603E/IT8623E is a custom design, hardware monitoring part is similar to
>  IT8728F. It only supports 16-bit fan mode, the full speed mode of the
>  fan is not supported (value 0 of pwmX_enable).
>  
> +The IT8790E supports up to three fans. 16-bit fan mode is always enabled.
> +

For consistency with the rest of the chip feature descriptions, I'd
write "3 fans".

>  Temperatures are measured in degrees Celsius. An alarm is triggered once
>  when the Overtemperature Shutdown limit is crossed.
>  
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index ec711af5697a..929d30e2047e 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -600,8 +600,8 @@ config SENSORS_IT87
>  	help
>  	  If you say yes here you get support for ITE IT8705F, IT8712F,
>  	  IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
> -	  IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E,
> -	  and IT8603E sensor chips, and the SiS950 clone.
> +	  IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E, IT8790E,
> +	  IT8603E, and IT8623E sensor chips, and the SiS950 clone.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called it87.
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index 2b41a598cee7..01a021172121 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -27,6 +27,7 @@
>   *            IT8782F  Super I/O chip w/LPC interface
>   *            IT8783E/F Super I/O chip w/LPC interface
>   *            IT8786E  Super I/O chip w/LPC interface
> + *            IT8790E  Super I/O chip w/LPC interface
>   *            Sis950   A clone of the IT8705F
>   *
>   *  Copyright (C) 2001 Chris Gauthron
> @@ -68,7 +69,7 @@
>  #define DRVNAME "it87"
>  
>  enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8771,
> -	     it8772, it8781, it8782, it8783, it8786, it8603 };
> +	     it8772, it8781, it8782, it8783, it8786, it8790, it8603 };
>  
>  static unsigned short force_id;
>  module_param(force_id, ushort, 0);
> @@ -154,6 +155,7 @@ static inline void superio_exit(void)
>  #define IT8786E_DEVID 0x8786
>  #define IT8603E_DEVID 0x8603
>  #define IT8623E_DEVID 0x8623
> +#define IT8790E_DEVID 0x8790

I'd move this declaration right after IT8786E_DEVID for consistency.

>  #define IT87_ACT_REG  0x30
>  #define IT87_BASE_REG 0x60
>  
> @@ -359,6 +361,13 @@ static const struct it87_devices it87_devices[] = {
>  		.peci_mask = 0x07,
>  		.suffix = "E",
>  	},
> +	[it8790] = {
> +		.name = "it8790",
> +		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
> +		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_IN7_INTERNAL,
> +		.peci_mask = 0x07,
> +		.suffix = "E",
> +	},
>  	[it8603] = {
>  		.name = "it8603",
>  		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
> @@ -1834,6 +1843,9 @@ static int __init it87_find(unsigned short *address,
>  	case IT8786E_DEVID:
>  		sio_data->type = it8786;
>  		break;
> +	case IT8790E_DEVID:
> +		sio_data->type = it8790;
> +		break;
>  	case IT8603E_DEVID:
>  	case IT8623E_DEVID:
>  		sio_data->type = it8603;

Looks good otherwise.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
