From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 30 Mar 2013 07:21:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp401) Fix device detection for TMP411B and TMP411C
Message-Id: <20130330082148.7df94900@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1364605110-20867-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1364605110-20867-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 29 Mar 2013 17:58:30 -0700, Guenter Roeck wrote:
> Turns out that TMP411B and TMP411C have different and unique device IDs.

Good catch.

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/tmp401.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index f4290ec..bcaeb2d 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -90,6 +90,8 @@ static const u8 TMP411_TEMP_HIGHEST_LSB[2]		= { 0x33, 0x37 };
>  #define TMP401_MANUFACTURER_ID			0x55
>  #define TMP401_DEVICE_ID			0x11
>  #define TMP411_DEVICE_ID			0x12

I'd rename TMP411_DEVICE_ID to TMP411A_DEVICE_ID for consistency.
Either way:

Acked-by: Jean Delvare <khali@linux-fr.org>

> +#define TMP411B_DEVICE_ID			0x13
> +#define TMP411C_DEVICE_ID			0x10
>  #define TMP431_DEVICE_ID			0x31
>  
>  /*
> @@ -562,6 +564,18 @@ static int tmp401_detect(struct i2c_client *client,
>  		kind = tmp401;
>  		break;
>  	case TMP411_DEVICE_ID:
> +		if (client->addr != 0x4c)
> +			return -ENODEV;
> +		kind = tmp411;
> +		break;
> +	case TMP411B_DEVICE_ID:
> +		if (client->addr != 0x4d)
> +			return -ENODEV;
> +		kind = tmp411;
> +		break;
> +	case TMP411C_DEVICE_ID:
> +		if (client->addr != 0x4e)
> +			return -ENODEV;
>  		kind = tmp411;
>  		break;
>  	case TMP431_DEVICE_ID:


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
