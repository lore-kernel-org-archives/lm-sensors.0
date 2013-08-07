From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 07 Aug 2013 10:59:18 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (acpi_power_meter) Fix incorrect placement of __initdata
Message-Id: <52022886.2000402@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/07/2013 02:47 AM, Sachin Kamat wrote:
> __initdata should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Darrick J. Wong <djwong@us.ibm.com>
> ---
>   drivers/hwmon/acpi_power_meter.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 6351aba..d7d9b2f 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -970,7 +970,7 @@ static int __init enable_cap_knobs(const struct dmi_system_id *d)
>   	return 0;
>   }
>
> -static struct dmi_system_id __initdata pm_dmi_table[] = {
> +static struct dmi_system_id pm_dmi_table[] __initdata = {
>   	{
>   		enable_cap_knobs, "IBM Active Energy Manager",
>   		{
>
Applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
