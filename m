From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Jul 2012 14:48:34 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (acpi_power_meter) Fix unintentional integer overflow
Message-Id: <20120707164834.26522aae@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1340287015-14008-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1340287015-14008-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 21 Jun 2012 06:56:53 -0700, Guenter Roeck wrote:
> Expression with two integer variables is calculated as integer before it is
> converted to u64. This may result in an integer overflow. Fix by declaring
> the constant as ULL.
> 
> This patch addresses Coverity #200596: Unintentional integer overflow.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/acpi_power_meter.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 9a0821f1..c8ac1c6 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -434,7 +434,7 @@ static ssize_t show_val(struct device *dev,
>  		if (resource->trip[attr->index - 7] < 0)
>  			return sprintf(buf, "unknown\n");
>  
> -		val = resource->trip[attr->index - 7] * 1000;
> +		val = resource->trip[attr->index - 7] * 1000ULL;
>  		break;
>  	default:
>  		BUG();

That's one way to fix it... Me, I wonder why resource->trip is an
arrays of ints, when every other power value handled by the driver is a
u64. The trip values end up feeding acpi objects in set_acpi_trip,
where 64-bit values would be handled properly. So I don't know much
about this driver and I'm not using it, but maybe making trip values
64-bit would be a better fix. Then you still have the problem of signed
vs. unsigned, as currently trip = -1 means unset, but this is probably
easy to solve.

Also note that the trip values are gathered from sysfs using kstrtoul,
so a value between 0x80000000 and 0xffffffff would be silently stored
as a negative number. Maybe worth fixing...

And I also see that kstrtoul is used for cap and avg_interval, while
they are stored as u64 in struct acpi_power_meter_resource. No overflow
here, but an arbitrary limitation on what values the user can set.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
