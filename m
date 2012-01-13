From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jan 2012 08:10:08 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm63) Update documentation to reflect update-interval support
Message-Id: <20120113091008.7adfbb54@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326407015-7181-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326407015-7181-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 12 Jan 2012 14:23:34 -0800, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/lm63 |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/lm63 b/Documentation/hwmon/lm63
> index 337f7f4..f96eed1 100644
> --- a/Documentation/hwmon/lm63
> +++ b/Documentation/hwmon/lm63
> @@ -61,9 +61,9 @@ PWM modes: manual and automatic. Automatic mode is not fully implemented yet
>  (you cannot define your custom PWM/temperature curve), and mode change isn't
>  supported either.
>  
> -The lm63 driver will not update its values more frequently than every
> -second; reading them more often will do no harm, but will return 'old'
> -values.
> +The lm63 driver will not update its values more frequently than configured with
> +the update_interval sysfs attribute; reading them more often will do no harm,
> +but will return 'old' values.
>  
>  The LM64 is effectively an LM63 with GPIO lines. The driver does not
>  support these GPIO lines at present.

Folded into the patch adding the update_interval sysfs attribute,
thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
