From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Oct 2008 20:36:23 +0000
Subject: Re: [lm-sensors] [PATCH] Allow it87.c to handle IT8720
Message-Id: <20081007223623.684281f2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <79c9d4530810061033g3630dc2dwabb4d3c2a3f17337@mail.gmail.com>
In-Reply-To: <79c9d4530810061033g3630dc2dwabb4d3c2a3f17337@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Marc Spaggiari <jean-marc@spaggiari.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Jean-Marc,

On Mon, 6 Oct 2008 13:33:56 -0400, Jean-Marc Spaggiari wrote:
> The goal of this patch is to allow it87.c to handle IT8720 chipset
> like IT8718 in order to retreive voltage, temperatures and fans speed
> from sensors tools.
> 
> JMS
> 
> Patch also attached.
> 
> --- linux-2.6.27-rc8/drivers/hwmon/it87.c.orig  2008-10-02
> 09:04:44.000000000 -0400
> +++ linux-2.6.27-rc8/drivers/hwmon/it87.c       2008-10-06
> 13:27:08.000000000 -0400
> @@ -14,6 +14,7 @@
>               IT8712F  Super I/O chip w/LPC interface
>               IT8716F  Super I/O chip w/LPC interface
>               IT8718F  Super I/O chip w/LPC interface
> +             IT8720F  Super I/O chip w/LPC interface
>               IT8726F  Super I/O chip w/LPC interface
>               Sis950   A clone of the IT8705F
> 
> @@ -50,7 +51,7 @@
> 
>  #define DRVNAME "it87"
> 
> -enum chips { it87, it8712, it8716, it8718 };
> +enum chips { it87, it8712, it8716, it8718, it8720 };
> 
>  static unsigned short force_id;
>  module_param(force_id, ushort, 0);
> @@ -112,6 +113,7 @@ superio_exit(void)
>  #define IT8716F_DEVID 0x8716
>  #define IT8718F_DEVID 0x8718
>  #define IT8726F_DEVID 0x8726
> +#define IT8720F_DEVID 0x8720

You have an interesting notion of numeric sorting ;)

>  #define IT87_ACT_REG  0x30
>  #define IT87_BASE_REG 0x60
> 
> @@ -278,7 +280,8 @@ static inline int has_16bit_fans(const s
>        return (data->type = it87 && data->revision >= 0x03)
>            || (data->type = it8712 && data->revision >= 0x08)
>            || data->type = it8716
> -           || data->type = it8718;
> +           || data->type = it8718
> +           || data->type = it8720;
>  }
> 
>  static int it87_probe(struct platform_device *pdev);
> @@ -982,6 +985,9 @@ static int __init it87_find(unsigned sho
>        case IT8718F_DEVID:
>                sio_data->type = it8718;
>                break;
> +       case IT8720F_DEVID:
> +               sio_data->type = it8720;
> +               break;
>        case 0xffff:    /* No device at all */
>                goto exit;
>        default:
> @@ -1040,6 +1046,7 @@ static int __devinit it87_probe(struct p
>                "it8712",
>                "it8716",
>                "it8718",
> +               "it8720",
>        };
> 
>        res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> @@ -1190,7 +1197,7 @@ static int __devinit it87_probe(struct p
>        }
> 
>        if (data->type = it8712 || data->type = it8716
> -        || data->type = it8718) {
> +        || data->type = it8718 || data->type = it8720) {
>                data->vrm = vid_which_vrm();
>                /* VID reading from Super-I/O config space if available */
>                data->vid = sio_data->vid_value;
> @@ -1571,7 +1578,7 @@ static void __exit sm_it87_exit(void)
> 
>  MODULE_AUTHOR("Chris Gauthron, "
>              "Jean Delvare <khali@linux-fr.org>");
> -MODULE_DESCRIPTION("IT8705F/8712F/8716F/8718F/8726F, SiS950 driver");
> +MODULE_DESCRIPTION("IT8705F/8712F/8716F/8718F/8720F/8726F, SiS950 driver");
>  module_param(update_vbat, bool, 0);
>  MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
>  module_param(fix_pwm_polarity, bool, 0);

It seems that you missed one occurrence of it8718-specific code (in
function it87_find).

	/* Read GPIO config and VID value from LDN 7 (GPIO) */
	if (chip_type != IT8705F_DEVID) {
		int reg;

		superio_select(GPIO);
		if (chip_type = it8718)
			sio_data->vid_value = superio_inb(IT87_SIO_VID_REG);

		reg = superio_inb(IT87_SIO_PINX2_REG);
		if (reg & (1 << 0))
			pr_info("it87: in3 is VCC (+5V)\n");
		if (reg & (1 << 1))
			pr_info("it87: in7 is VCCH (+5V Stand-By)\n");
	}

You also need to update Documentation/hwmon/it87 to mention the IT8720F
as supported, as well ad drivers/hwmon/Kconfig.

Other than that - and the lack of Signed-off-by line - your patch looks
OK to me.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
