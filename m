From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 10 Jan 2014 23:09:49 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (sht15) add include guard
Message-Id: <52D07DBD.9060700@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1389390286-6287-1-git-send-email-vivien.didelot@savoirfairelinux.com> <1389390286-6287-2-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1389390286-6287-2-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, lm-sensors@lm-sensors.org
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com

On 01/10/2014 01:44 PM, Vivien Didelot wrote:
> Add include guard to include/linux/platform_data/sht15.h to prevent
> multiple inclusion.
>
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> ---

Applied to hwmon-next.

Thanks,
Guenter

>   include/linux/platform_data/sht15.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/platform_data/sht15.h b/include/linux/platform_data/sht15.h
> index 33e0fd2..12289c1 100644
> --- a/include/linux/platform_data/sht15.h
> +++ b/include/linux/platform_data/sht15.h
> @@ -12,6 +12,9 @@
>    * For further information, see the Documentation/hwmon/sht15 file.
>    */
>
> +#ifndef _PDATA_SHT15_H
> +#define _PDATA_SHT15_H
> +
>   /**
>    * struct sht15_platform_data - sht15 connectivity info
>    * @gpio_data:		no. of gpio to which bidirectional data line is
> @@ -31,3 +34,5 @@ struct sht15_platform_data {
>   	bool no_otp_reload;
>   	bool low_resolution;
>   };
> +
> +#endif /* _PDATA_SHT15_H */
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
