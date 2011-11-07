From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Nov 2011 18:00:45 +0000
Subject: Re: [lm-sensors] [PATCH] Drivers: hwmon: it87: Add support for ITE
Message-Id: <1320688845.2309.122.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320381858.22997.YahooMailNeo@web161601.mail.bf1.yahoo.com>
In-Reply-To: <1320381858.22997.YahooMailNeo@web161601.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Frank T. Lofaro Jr." <ftlofaro@yahoo.com>
Cc: "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2011-11-04 at 00:44 -0400, Frank T. Lofaro Jr. wrote:
> This patch allows the ITE 8728 chip to be detected and used.
> The chip appears to be compatible with the 8721.
> 

Can anyone confirm that those chips are actually compatible ?

Thanks,
Guenter

Signed-off-by: Frank T. Lofaro Jr. <ftlofaro@yahoo.com>
> ---
>  drivers/hwmon/it87.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index d912649..0b21d18 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -17,6 +17,7 @@
>   *            IT8720F  Super I/O chip w/LPC interface
>   *            IT8721F  Super I/O chip w/LPC interface
>   *            IT8726F  Super I/O chip w/LPC interface
> + *            IT8728F  Super I/O chip w/LPC interface
>   *            IT8758E  Super I/O chip w/LPC interface
>   *            Sis950   A clone of the IT8705F
>   *
> @@ -135,6 +136,7 @@ static inline void superio_exit(void)
>  #define IT8720F_DEVID 0x8720
>  #define IT8721F_DEVID 0x8721
>  #define IT8726F_DEVID 0x8726
> +#define IT8728F_DEVID 0x8728
>  #define IT87_ACT_REG  0x30
>  #define IT87_BASE_REG 0x60
>  
> @@ -1603,6 +1605,7 @@ static int __init it87_find(unsigned short
> *address,
>                 sio_data->type = it8720;
>                 break;
>         case IT8721F_DEVID:
> +       case IT8728F_DEVID:
>                 sio_data->type = it8721;
>                 break;
>         case 0xffff:    /* No device at all */
> -- 
> 1.7.7.2
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
