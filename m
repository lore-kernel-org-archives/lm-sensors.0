From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 14 Apr 2013 07:09:59 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] hwmon: (tmp401) Drop unused defines, use BIT for bit masks
Message-Id: <20130414090959.1b49d123@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365210177-24656-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1365210177-24656-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri,  5 Apr 2013 18:02:53 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/tmp401.c |   20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index be71a3e..ef04cf8 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -54,10 +54,8 @@ enum chips { tmp401, tmp411, tmp431 };
>  #define TMP401_CONVERSION_RATE_READ		0x04
>  #define TMP401_CONVERSION_RATE_WRITE		0x0A
>  #define TMP401_TEMP_CRIT_HYST			0x21
> -#define TMP401_CONSECUTIVE_ALERT		0x22
>  #define TMP401_MANUFACTURER_ID_REG		0xFE
>  #define TMP401_DEVICE_ID_REG			0xFF
> -#define TMP411_N_FACTOR_REG			0x18
>  
>  static const u8 TMP401_TEMP_MSB[2]			= { 0x00, 0x01 };
>  static const u8 TMP401_TEMP_LSB[2]			= { 0x15, 0x10 };
> @@ -76,15 +74,15 @@ static const u8 TMP411_TEMP_HIGHEST_MSB[2]		= { 0x32, 0x36 };
>  static const u8 TMP411_TEMP_HIGHEST_LSB[2]		= { 0x33, 0x37 };
>  
>  /* Flags */
> -#define TMP401_CONFIG_RANGE		0x04
> -#define TMP401_CONFIG_SHUTDOWN		0x40
> -#define TMP401_STATUS_LOCAL_CRIT		0x01
> -#define TMP401_STATUS_REMOTE_CRIT		0x02
> -#define TMP401_STATUS_REMOTE_OPEN		0x04
> -#define TMP401_STATUS_REMOTE_LOW		0x08
> -#define TMP401_STATUS_REMOTE_HIGH		0x10
> -#define TMP401_STATUS_LOCAL_LOW		0x20
> -#define TMP401_STATUS_LOCAL_HIGH		0x40
> +#define TMP401_CONFIG_RANGE			BIT(2)
> +#define TMP401_CONFIG_SHUTDOWN			BIT(6)
> +#define TMP401_STATUS_LOCAL_CRIT		BIT(0)
> +#define TMP401_STATUS_REMOTE_CRIT		BIT(1)
> +#define TMP401_STATUS_REMOTE_OPEN		BIT(2)
> +#define TMP401_STATUS_REMOTE_LOW		BIT(3)
> +#define TMP401_STATUS_REMOTE_HIGH		BIT(4)
> +#define TMP401_STATUS_LOCAL_LOW			BIT(5)
> +#define TMP401_STATUS_LOCAL_HIGH		BIT(6)

Aren't you supposed to include either <linux/kernel.h> or
<linux/bitops.h> directly if you use BIT()?

>  /* Manufacturer / Device ID's */
>  #define TMP401_MANUFACTURER_ID			0x55

Other than this, this change looks reasonable.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
