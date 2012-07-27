From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 27 Jul 2012 18:44:27 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (acpi_power_meter) Fix build warning
Message-Id: <201207272044.27931.rjw@sisk.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1343398922-24764-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1343398922-24764-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday, July 27, 2012, Guenter Roeck wrote:
> Commit c5dec0182256361a3f823316e8fb85263f76efe7 (acpi_power_meter: Use struct
> dev_pm_ops for power management) introduced the following build warning. It is
> seen if CONFIG_PM_SLEEP is not defined.
> 
> acpi_power_meter.c:930:12: warning: acpi_power_meter_resume defined but not used
> 
> Fix it.
> 
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/hwmon/acpi_power_meter.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 563c029..23ab3c4 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -927,6 +927,8 @@ static int acpi_power_meter_remove(struct acpi_device *device, int type)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +
>  static int acpi_power_meter_resume(struct device *dev)
>  {
>  	struct acpi_power_meter_resource *resource;
> @@ -944,6 +946,8 @@ static int acpi_power_meter_resume(struct device *dev)
>  	return 0;
>  }
>  
> +#endif /* CONFIG_PM_SLEEP */
> +
>  static SIMPLE_DEV_PM_OPS(acpi_power_meter_pm, NULL, acpi_power_meter_resume);
>  
>  static struct acpi_driver acpi_power_meter_driver = {
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
