From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Mar 2013 08:33:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp401) Add support for TMP431
Message-Id: <20130325093345.76be0311@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1364017421-28279-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1364017421-28279-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 22 Mar 2013 22:43:41 -0700, Guenter Roeck wrote:
> TMP431 is compatible to TMP401.
> 
> Also add support for additional I2C addresses supported by TMP411B
> and TMP411C.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/tmp401 |   16 ++++++++++------
>  drivers/hwmon/Kconfig      |    4 ++--
>  drivers/hwmon/tmp401.c     |   11 ++++++++---
>  3 files changed, 20 insertions(+), 11 deletions(-)
> (...)
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index c85f696..763115a 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -40,9 +40,9 @@
>  #include <linux/sysfs.h>
>  
>  /* Addresses to scan */
> -static const unsigned short normal_i2c[] = { 0x4c, I2C_CLIENT_END };
> +static const unsigned short normal_i2c[] = { 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };

Without address checks in the detect function, you are accepting all
supported chips at all of these addresses. Some combinations are not
possible, so I think you should reject them in order to make false
positives less likely.

Other than this, it looks good.

Acked-by: Jean Delvare <khali@linux-fr.org>

Don't forget to update sensors-detect to map the TMP431 chip to the
tmp401 driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
