From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 24 Feb 2015 10:41:29 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon: (it87) Add support for IT8786E
Message-Id: <20150224114129.465deede@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423858433-1416-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1423858433-1416-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas, Guenter,

On Fri, 13 Feb 2015 12:13:53 -0800, Guenter Roeck wrote:
> From: Thomas Lorblanches <zlika_ese@hotmail.com>
> 
> IT8786E is mostly compatible with IT8771 / IT8772.
> Parameters determined by testing various combinations.
> 
> Signed-off-by: Thomas Lorblanches <zlika_ese@hotmail.com>
> [Guenter Roeck: merged from github]
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/it87 |  6 +++++-
>  drivers/hwmon/Kconfig    |  4 ++--
>  drivers/hwmon/it87.c     | 19 +++++++++++++++----
>  3 files changed, 22 insertions(+), 7 deletions(-)

Not much I can say without a datasheet. Just a few minor style
comments...

> diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
> index 8e192ff..19fbe77 100644
> --- a/Documentation/hwmon/it87
> +++ b/Documentation/hwmon/it87
> @@ -54,6 +54,10 @@ Supported chips:
>      Prefix: 'it8783'
>      Addresses scanned: from Super I/O config space (8 I/O ports)
>      Datasheet: Not publicly available
> +  * IT8786E
> +    Prefix: 'it8786'
> +    Addresses scanned: from Super I/O config space (8 I/O ports)
> +    Datasheet: Not publicly available
>    * SiS950   [clone of IT8705F]
>      Prefix: 'it87'
>      Addresses scanned: from Super I/O config space (8 I/O ports)
> @@ -100,7 +104,7 @@ Description
>  
>  This driver implements support for the IT8603E, IT8623E, IT8705F, IT8712F,
>  IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E, IT8771E,
> -IT8772E, IT8781F, IT8782F, IT8783E/F, and SiS950 chips.
> +IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E, and SiS950 chips.
>  
>  These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
>  joysticks and other miscellaneous stuff. For hardware monitoring, they
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index e5bad0a..1d0988e 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -599,8 +599,8 @@ config SENSORS_IT87
>  	help
>  	  If you say yes here you get support for ITE IT8705F, IT8712F,
>  	  IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
> -	  IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F and IT8603E
> -	  sensor chips, and the SiS950 clone.
> +	  IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E,
> +	  and IT8603E sensor chips, and the SiS950 clone.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called it87.
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index 1754bef..72db56b 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -26,6 +26,7 @@
>   *            IT8781F  Super I/O chip w/LPC interface
>   *            IT8782F  Super I/O chip w/LPC interface
>   *            IT8783E/F Super I/O chip w/LPC interface
> + *            IT8786E  Super I/O chip w/LPC interface
>   *            Sis950   A clone of the IT8705F
>   *
>   *  Copyright (C) 2001 Chris Gauthron
> @@ -67,7 +68,7 @@
>  #define DRVNAME "it87"
>  
>  enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8771,
> -	     it8772, it8781, it8782, it8783, it8603 };
> +	     it8772, it8781, it8782, it8783, it8786, it8603 };
>  
>  static unsigned short force_id;
>  module_param(force_id, ushort, 0);
> @@ -150,6 +151,7 @@ static inline void superio_exit(void)
>  #define IT8781F_DEVID 0x8781
>  #define IT8782F_DEVID 0x8782
>  #define IT8783E_DEVID 0x8783
> +#define IT8786E_DEVID 0x8786
>  #define IT8603E_DEVID 0x8603
>  #define IT8623E_DEVID 0x8623
>  #define IT87_ACT_REG  0x30
> @@ -336,6 +338,12 @@ static const struct it87_devices it87_devices[] = {
>  		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG,
>  		.old_peci_mask = 0x4,
>  	},
> +	[it8786] = {
> +		.name = "it8786",
> +		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
> +		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
> +		.peci_mask = 0x07,
> +	},
>  	[it8603] = {
>  		.name = "it8603",
>  		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
> @@ -1791,6 +1799,9 @@ static int __init it87_find(unsigned short *address,
>  	case IT8783E_DEVID:
>  		sio_data->type = it8783;
>  		break;
> +	case IT8786E_DEVID:
> +		sio_data->type = it8786;
> +		break;
>  	case IT8603E_DEVID:
>  	case IT8623E_DEVID:
>  		sio_data->type = it8603;
> @@ -1818,8 +1829,8 @@ static int __init it87_find(unsigned short *address,
>  	sio_data->revision = superio_inb(DEVREV) & 0x0f;
>  	pr_info("Found IT%04x%c chip at 0x%x, revision %d\n", chip_type,
>  		chip_type = 0x8771 || chip_type = 0x8772 ||
> -		chip_type = 0x8603 ? 'E' : 'F', *address,
> -		sio_data->revision);
> +		chip_type = 0x8603 || chip_type = 0x8786 ? 'E' : 'F',

If you want to respect the order we have everywhere else, you should
check for 0x8786 before 0x8603.

> +		*address, sio_data->revision);
>  
>  	/* in8 (Vbat) is always internal */
>  	sio_data->internal = (1 << 2);
> @@ -1990,7 +2001,7 @@ static int __init it87_find(unsigned short *address,
>  		if ((reg & (1 << 1)) || sio_data->type = it8721 ||
>  		    sio_data->type = it8728 ||
>  		    sio_data->type = it8771 ||

For consistency the previous two lines should be joined.

> -		    sio_data->type = it8772)
> +		    sio_data->type = it8772 || sio_data->type = it8786)
>  			sio_data->internal |= (1 << 1);
>  
>  		/*

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
