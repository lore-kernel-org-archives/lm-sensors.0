From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 16 Oct 2014 13:18:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: menf21bmc: Include linux/err.h
Message-Id: <543FC5BB.6050106@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1413464871-882-1-git-send-email-johannes.thumshirn@men.de>
In-Reply-To: <1413464871-882-1-git-send-email-johannes.thumshirn@men.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johannes Thumshirn <johannes.thumshirn@men.de>, Andreas Werner <andreas.werner@men.de>, Jean Delvare <jdelvare@suse.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 10/16/2014 06:07 AM, Johannes Thumshirn wrote:
> Include linux/err.h to get the definitions for IS_ERR() PTR_ERR() and
> ERR_PTR() used in the driver.
>
> This fixes compilation on powerpc targets.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@men.de>

Hmm, my build tests should really find that :-(

Applied, thanks

Guenter

> ---
>   drivers/hwmon/menf21bmc_hwmon.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hwmon/menf21bmc_hwmon.c b/drivers/hwmon/menf21bmc_hwmon.c
> index c92229d..afc6b58 100644
> --- a/drivers/hwmon/menf21bmc_hwmon.c
> +++ b/drivers/hwmon/menf21bmc_hwmon.c
> @@ -21,6 +21,7 @@
>   #include <linux/jiffies.h>
>   #include <linux/slab.h>
>   #include <linux/i2c.h>
> +#include <linux/err.h>
>
>   #define DRV_NAME  "menf21bmc_hwmon"
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
