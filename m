From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 10 Jan 2014 23:09:33 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max197) add include guard
Message-Id: <52D07DAD.30105@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1389390286-6287-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1389390286-6287-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, lm-sensors@lm-sensors.org
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com

On 01/10/2014 01:44 PM, Vivien Didelot wrote:
> Add include guard to include/linux/platform_data/max197.h to prevent
> multiple inclusion.
>
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> ---

Applied to hwmon-next.

Thanks,
Guenter

>   include/linux/platform_data/max197.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/platform_data/max197.h b/include/linux/platform_data/max197.h
> index e2a41dd..8da8f94 100644
> --- a/include/linux/platform_data/max197.h
> +++ b/include/linux/platform_data/max197.h
> @@ -11,6 +11,9 @@
>    * For further information, see the Documentation/hwmon/max197 file.
>    */
>
> +#ifndef _PDATA_MAX197_H
> +#define _PDATA_MAX197_H
> +
>   /**
>    * struct max197_platform_data - MAX197 connectivity info
>    * @convert:	Function used to start a conversion with control byte ctrl.
> @@ -19,3 +22,5 @@
>   struct max197_platform_data {
>   	int (*convert)(u8 ctrl);
>   };
> +
> +#endif /* _PDATA_MAX197_H */
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
