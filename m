From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Jun 2012 14:18:13 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (acpi_power_meter) Cleanup and optimizations
Message-Id: <20120621161813.08f491a4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1340284120-17897-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1340284120-17897-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 21 Jun 2012 06:08:40 -0700, Guenter Roeck wrote:
> An unsigned value can not be smaller than 0. Remove the check for it.
> Use DIV_ROUND_CLOSEST for divide operations converting milli-degrees C into
> degrees C. Limit maximum accepted trip point temperature to INT_MAX.
> 
> This patch fixes Coverity #115214: Unsigned compared against 0
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> 
> v2: Use DIV_ROUND_CLOSEST
>     Return error if entered temperature is larger than INT_MAX
>     Notes: Did not use clamping since driver elsewhere returns errors for out-of-range values. 
> 	   Further limit checks are done by ACPI code.
> 
>  drivers/hwmon/acpi_power_meter.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 34ad5a2..9a0821f1 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -237,7 +237,7 @@ static ssize_t set_cap(struct device *dev, struct device_attribute *devattr,
>  	if (res)
>  		return res;
>  
> -	temp /= 1000;
> +	temp = DIV_ROUND_CLOSEST(temp, 1000);
>  	if (temp > resource->caps.max_cap || temp < resource->caps.min_cap)
>  		return -EINVAL;
>  	arg0.integer.value = temp;
> @@ -307,8 +307,8 @@ static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
>  	if (res)
>  		return res;
>  
> -	temp /= 1000;
> -	if (temp < 0)
> +	temp = DIV_ROUND_CLOSEST(temp, 1000);
> +	if (temp > INT_MAX)
>  		return -EINVAL;
>  
>  	mutex_lock(&resource->lock);

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
