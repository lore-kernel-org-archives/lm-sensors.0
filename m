From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 01 Oct 2014 12:54:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ab8500) Call kernel_power_off instead of pm_power_off
Message-Id: <20141001145405.659fa9ec@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1412095533-11301-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412095533-11301-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 30 Sep 2014 09:45:33 -0700, Guenter Roeck wrote:
> Drivers should not call pm_power_off directly; it is not guaranteed
> to be non-NULL. Call kernel_power_off instead.
> 
> Cc: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/ab8500.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/ab8500.c b/drivers/hwmon/ab8500.c
> index d844dc8..8b6a4f4 100644
> --- a/drivers/hwmon/ab8500.c
> +++ b/drivers/hwmon/ab8500.c
> @@ -6,7 +6,7 @@
>   *
>   * When the AB8500 thermal warning temperature is reached (threshold cannot
>   * be changed by SW), an interrupt is set, and if no further action is taken
> - * within a certain time frame, pm_power off will be called.
> + * within a certain time frame, kernel_power_off will be called.
>   *
>   * When AB8500 thermal shutdown temperature is reached a hardware shutdown of
>   * the AB8500 will occur.
> @@ -21,6 +21,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/power/ab8500.h>
> +#include <linux/reboot.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include "abx500.h"
> @@ -106,7 +107,7 @@ static void ab8500_thermal_power_off(struct work_struct *work)
>  
>  	dev_warn(&abx500_data->pdev->dev, "Power off due to critical temp\n");
>  
> -	pm_power_off();
> +	kernel_power_off();
>  }
>  
>  static ssize_t ab8500_show_name(struct device *dev,

I am no expert on the matter but this looks like a reasonable change.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
