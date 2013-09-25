From: Hongbo Zhang <hongbo.zhang@freescale.com>
Date: Wed, 25 Sep 2013 07:13:23 +0000
Subject: Re: [lm-sensors] [PATCHv6 02/16] drivers: thermal: introduce device tree parser
Message-Id: <52428D13.7080007@freescale.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1379537849-28425-1-git-send-email-eduardo.valentin@ti.com> <1379540136-28378-1-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1379540136-28378-1-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com, joe@perches.com, grant.likely@linaro.org, durgadoss.r@intel.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 09/19/2013 05:35 AM, Eduardo Valentin wrote:
>   
> [...]
> +
> +/***   sensor API   ***/
> +

You are introducing new concept here, the original framework and drivers 
cannot use this, right? any further plan to update original framework 
for this new feature?

> +static struct thermal_zone_device *
> +thermal_zone_of_add_sensor(struct device_node *zone,
> +			   struct device_node *sensor, void *data,
> +			   int (*get_temp)(void *, long *),
> +			   int (*get_trend)(void *, long *))
> +{
> +	struct thermal_zone_device *tzd;
> +	struct __thermal_zone *tz;
> +
> +	tzd = thermal_zone_get_zone_by_name(zone->name);
> +	if (IS_ERR(tzd))
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> [...]
> +
> +/*
> + * Here are the thermal trip types. This must
> + * match with enum thermal_trip_type at
> + * include/linux/thermal.h
> + */
> +#define THERMAL_TRIP_ACTIVE		0
> +#define THERMAL_TRIP_PASSIVE		1
> +#define THERMAL_TRIP_HOT		2
> +#define THERMAL_TRIP_CRITICAL		3
> +

These macros seem duplicated with enum thermal_trip_type in thermal.h, 
do you have further plan to merge them?
Or by using string "active",  "passive" etc in the dts, then you can 
reuse the original enum definition.

> +/* On cooling devices upper and lower limits */
> +#define THERMAL_NO_LIMIT		(-1UL)
> +
> +#endif
> [...]



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
