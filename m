From: Roland Stigge <stigge@antcom.de>
Date: Fri, 18 Jul 2014 08:00:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max6639) Make normal_i2c array const
Message-Id: <53C8D405.8020303@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405670219.6632.0.camel@phoenix>
In-Reply-To: <1405670219.6632.0.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/18/2014 09:56 AM, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/hwmon/max6639.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index 70650de..dac6d85 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -35,7 +35,7 @@
>  #include <linux/i2c/max6639.h>
>  
>  /* Addresses to scan */
> -static unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> +static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
>  
>  /* The MAX6639 registers, valid channel numbers: 0, 1 */
>  #define MAX6639_REG_TEMP(ch)			(0x00 + (ch))
> 

Acked-by: Roland Stigge <stigge@antcom.de>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
