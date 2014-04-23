From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 23 Apr 2014 15:32:06 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (lm92) Drop unnecessary forward declaration
Message-Id: <20140423173206.45af5541@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397861485-31740-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397861485-31740-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 18 Apr 2014 15:51:22 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm92.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
> index b9022db..5ca8e14 100644
> --- a/drivers/hwmon/lm92.c
> +++ b/drivers/hwmon/lm92.c
> @@ -93,9 +93,6 @@ static inline u8 ALARMS_FROM_REG(s16 reg)
>  	return reg & 0x0007;
>  }
>  
> -/* Driver data (common to all clients) */
> -static struct i2c_driver lm92_driver;
> -
>  /* Client data (each client gets its own) */
>  struct lm92_data {
>  	struct device *hwmon_dev;

Interesting :)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
