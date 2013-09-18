From: Joe Perches <joe@perches.com>
Date: Wed, 18 Sep 2013 20:44:50 +0000
Subject: Re: [lm-sensors] [PATCHv4 02/16] drivers: thermal: introduce device tree parser
Message-Id: <1379537090.1787.67.camel@joe-AO722>
List-Id: <lm-sensors.vger.kernel.org>
References: <1379530923-29268-1-git-send-email-eduardo.valentin@ti.com>
	 <1379536310-30000-1-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1379536310-30000-1-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 2013-09-18 at 16:31 -0400, Eduardo Valentin wrote:

> +/**
> + * of_parse_thermal_zones - parse device tree thermal data
> + *
> + * Initialization function that can be called by machine initialization
> + * code to parse thermal data and populate the thermal framework
> + * with hardware thermal zones info. This function only parses thermal zones.
> + * Cooling devices and sensor devices nodes are supposed to be parsed
> + * by their respective drivers.
> + *
> + * Return: 0 on success, proper error code otherwise
> + *
> + */
> +int __init of_parse_thermal_zones(void)
> +{
> +	struct device_node *np, *child;
> +	struct __thermal_zone *tz;
> +	struct thermal_zone_device_ops *ops;
> +
> +	np = of_find_node_by_name(NULL, "thermal-zones");
> +	if (!np) {
> +		pr_err("unable to find thermal zones\n");
> +		return 0;

return 0? This is success?

> +	}
> +
> +	for_each_child_of_node(np, child) {
> +		struct thermal_zone_device *zone;
> +		struct thermal_zone_params *tzp;
> +
> +		tz = thermal_of_build_thermal_zone(child);
> +		if (IS_ERR(tz)) {
> +			pr_err("failed to build thermal zone %ld\n",
> +			       PTR_ERR(tz));
> +			return 0;
> +		}
> +
> +		ops = kzalloc(sizeof(*ops), GFP_KERNEL);
> +		if (!ops)
> +			return 0;
> +
> +		memcpy(ops, &of_thermal_ops, sizeof(*ops));

kmemdup instead of alloc/memcpy

> +		tzp = kzalloc(sizeof(*tzp), GFP_KERNEL);
> +		if (!ops)
> +			return 0;
> +
> +		/* No hwmon because there might be hwmon drivers registering */
> +		tzp->no_hwmon = true;
> +
> +		zone = thermal_zone_device_register(child->name, tz->ntrips,
> +						    0, tz,
> +						    ops, tzp,
> +						    tz->passive_delay,
> +						    tz->polling_delay);
> +		if (IS_ERR(zone))
> +			pr_err("Failed to build %s zone %ld\n", child->name,
> +			       PTR_ERR(zone));
> +	}
> +	return 0;
> +}

All returns are 0, always successful?



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
