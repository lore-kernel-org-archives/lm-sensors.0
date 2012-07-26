From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Jul 2012 21:14:50 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (jc42) Simplify hysteresis mask
Message-Id: <20120726211450.GA16713@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120726221347.478d4cd7@endymion.delvare>
In-Reply-To: <20120726221347.478d4cd7@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jul 26, 2012 at 10:13:47PM +0200, Jean Delvare wrote:
> Define JC42_CFG_HYST_MASK as the mask _before_ shifting instead of
> after shifting. This simplifies the current code slightly, and will
> simplify the code to come even more.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/jc42.c |   13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> --- linux-3.5.orig/drivers/hwmon/jc42.c	2012-07-26 22:02:32.000000000 +0200
> +++ linux-3.5/drivers/hwmon/jc42.c	2012-07-26 22:04:46.911073234 +0200
> @@ -57,7 +57,7 @@ static const unsigned short normal_i2c[]
>  #define JC42_CFG_EVENT_LOCK	(1 << 7)
>  #define JC42_CFG_SHUTDOWN	(1 << 8)
>  #define JC42_CFG_HYST_SHIFT	9
> -#define JC42_CFG_HYST_MASK	0x03
> +#define JC42_CFG_HYST_MASK	(0x03 << 9)
>  

Since we have JC42_CFG_HYST_SHIFT, might as well use it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
