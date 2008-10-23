From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 23 Oct 2008 09:36:06 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] Allow it87.c to handle IT8720
Message-Id: <20081023113606.5aeef522@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FF7DA8.3020902@Spaggiari.org>
In-Reply-To: <48FF7DA8.3020902@Spaggiari.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean-Marc,

Thanks for the update.

On Wed, 22 Oct 2008 15:23:20 -0400, Jean-Marc Spaggiari wrote:
> Allow it87.c to handle IT8720 chipset like IT8718 in order to
> retrieve voltage, temperatures and fans speed from sensors
> tools. Also updating the related documentation.
> 
> 
> Signed-off-by: Jean-Marc Spaggiari <jean-marc@spaggiari.org>
> 
> --- ./drivers/hwmon/it87.c.orig	2008-10-18 13:57:22.000000000 -0400
> +++ ./drivers/hwmon/it87.c	2008-10-22 08:38:18.000000000 -0400
> @@ -14,6 +14,7 @@
>                IT8712F  Super I/O chip w/LPC interface
>                IT8716F  Super I/O chip w/LPC interface
>                IT8718F  Super I/O chip w/LPC interface
> +	      IT8720F  Super I/O chip w/LPC interface
>                IT8726F  Super I/O chip w/LPC interface
>                Sis950   A clone of the IT8705F
>  
> @@ -52,7 +53,7 @@
>  
>  #define DRVNAME "it87"
>  
> -enum chips { it87, it8712, it8716, it8718 };
> +enum chips { it87, it8712, it8716, it8718, it8720 };
>  
>  static unsigned short force_id;
>  module_param(force_id, ushort, 0);
> @@ -113,6 +114,7 @@ superio_exit(void)
>  #define IT8705F_DEVID 0x8705
>  #define IT8716F_DEVID 0x8716
>  #define IT8718F_DEVID 0x8718
> +#define IT8720F_DEVID 0x8720
>  #define IT8726F_DEVID 0x8726
>  #define IT87_ACT_REG  0x30
>  #define IT87_BASE_REG 0x60
> @@ -984,6 +986,9 @@ static int __init it87_find(unsigned sho
>  	case IT8726F_DEVID:
>  		sio_data->type = it8716;
>  		break;
> +	case IT8720F_DEVID:
> +		sio_data->type = it8720;
> +		break;
>  	case IT8718F_DEVID:
>  		sio_data->type = it8718;
>  		break;
> @@ -1017,7 +1022,8 @@ static int __init it87_find(unsigned sho
>  		int reg;
>  
>  		superio_select(GPIO);
> -		if (chip_type = it8718)
> +		if ((chip_type = it8718) ||
> +		    (chip_type = it8720))
>  			sio_data->vid_value = superio_inb(IT87_SIO_VID_REG);
>  
>  		reg = superio_inb(IT87_SIO_PINX2_REG);
> @@ -1063,6 +1069,7 @@ static int __devinit it87_probe(struct p
>  		"it8712",
>  		"it8716",
>  		"it8718",
> +		"it8720",
>  	};
>  
>  	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> @@ -1603,7 +1610,7 @@ static void __exit sm_it87_exit(void)
>  
>  MODULE_AUTHOR("Chris Gauthron, "
>  	      "Jean Delvare <khali@linux-fr.org>");
> -MODULE_DESCRIPTION("IT8705F/8712F/8716F/8718F/8726F, SiS950 driver");
> +MODULE_DESCRIPTION("IT8705F/8712F/8716F/8718F/8720F/8726F, SiS950 driver");
>  module_param(update_vbat, bool, 0);
>  MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
>  module_param(fix_pwm_polarity, bool, 0);

I am surprised. Compared to the previous version of your patch, some
occurrences of the data->type = it8720 test have been _removed_. For
example, in has_16bit_fans(), and also once in it87_probe(). You did
not really mean to revert these changes, did you?

> --- ./Documentation/hwmon/it87.orig	2008-10-22 08:44:09.000000000 -0400
> +++ ./Documentation/hwmon/it87	2008-10-22 08:50:33.000000000 -0400
> @@ -26,6 +26,10 @@ Supported chips:
>      Datasheet: Publicly available at the ITE website
>                 http://www.ite.com.tw/product_info/file/pc/IT8718F_V0.2.zip
>                 http://www.ite.com.tw/product_info/file/pc/IT8718F_V0%203_(for%20C%20version).zip
> +  * IT8720F
> +    Prefix: 'it8720'
> +    Addresses scanned: from Super I/O config space (8 I/O ports)
> +    Datasheet: Not yet publicly available.
>    * SiS950   [clone of IT8705F]
>      Prefix: 'it87'
>      Addresses scanned: from Super I/O config space (8 I/O ports)
> @@ -71,7 +75,7 @@ Description
>  -----------
>  
>  This driver implements support for the IT8705F, IT8712F, IT8716F,
> -IT8718F, IT8726F and SiS950 chips.
> +IT8718F, IT8720F, IT8726F and SiS950 chips.
>  
>  These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
>  joysticks and other miscellaneous stuff. For hardware monitoring, they
> @@ -84,19 +88,19 @@ the IT8716F and late IT8712F have 6. The
>  though, so the functionality may not be available on a given system.
>  The driver dumbly assume it is there.
>  
> -The IT8718F also features VID inputs (up to 8 pins) but the value is
> -stored in the Super-I/O configuration space. Due to technical limitations,
> +The IT8718F and IT8720F also features VID inputs (up to 8 pins) but the value
> +is stored in the Super-I/O configuration space. Due to technical limitations,
>  this value can currently only be read once at initialization time, so
>  the driver won't notice and report changes in the VID value. The two
>  upper VID bits share their pins with voltage inputs (in5 and in6) so you
>  can't have both on a given board.
>  
> -The IT8716F, IT8718F and later IT8712F revisions have support for
> +The IT8716F, IT8718F, IT8720F and later IT8712F revisions have support for
>  2 additional fans. The additional fans are supported by the driver.
>  
> -The IT8716F and IT8718F, and late IT8712F and IT8705F also have optional
> -16-bit tachometer counters for fans 1 to 3. This is better (no more fan
> -clock divider mess) but not compatible with the older chips and
> +The IT8716F, IT8718F and IT8720F, and late IT8712F and IT8705F also have
> +optional 16-bit tachometer counters for fans 1 to 3. This is better (no more
> +fan clock divider mess) but not compatible with the older chips and
>  revisions. The 16-bit tachometer mode is enabled by the driver when one
>  of the above chips is detected.
>  
> @@ -122,7 +126,7 @@ zero'; this is important for negative vo
>  inputs can measure voltages between 0 and 4.08 volts, with a resolution of
>  0.016 volt. The battery voltage in8 does not have limit registers.
>  
> -The VID lines (IT8712F/IT8716F/IT8718F) encode the core voltage value:
> +The VID lines (IT8712F/IT8716F/IT8718F/IT8720F) encode the core voltage value:
>  the voltage level your processor should work with. This is hardcoded by
>  the mainboard and/or processor itself. It is a value in volts.
>  
> --- ./drivers/hwmon/Kconfig.orig	2008-10-22 08:50:52.000000000 -0400
> +++ ./drivers/hwmon/Kconfig	2008-10-22 08:51:56.000000000 -0400
> @@ -389,7 +389,8 @@ config SENSORS_IT87
>  	select HWMON_VID
>  	help
>  	  If you say yes here you get support for ITE IT8705F, IT8712F,
> -	  IT8716F, IT8718F and IT8726F sensor chips, and the SiS960 clone.
> +	  IT8716F, IT8718F, IT8720F and IT8726F sensor chips, and the
> +	  SiS960 clone.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called it87.

All the rest looks OK to me now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
