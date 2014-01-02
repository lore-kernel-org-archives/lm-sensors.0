From: Wei Ni <wei.nee.1977@gmail.com>
Date: Thu, 02 Jan 2014 02:55:15 +0000
Subject: Re: [lm-sensors] [PATCHv9 02/20] thermal: introduce device tree parser
Message-Id: <52C4D513.50404@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com> <1384285582-16933-3-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1384285582-16933-3-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>, swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com
Cc: wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 11/13/2013 03:46 AM, Eduardo Valentin wrote:
> ....
> +
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
> +		pr_debug("unable to find thermal zones\n");
> +		return 0; /* Run successfully on systems without thermal DT */
> +	}
> +
> +	for_each_child_of_node(np, child) {
> +		struct thermal_zone_device *zone;
> +		struct thermal_zone_params *tzp;
> +
> +		tz = thermal_of_build_thermal_zone(child);
> +		if (IS_ERR(tz)) {
> +			pr_err("failed to build thermal zone %s: %ld\n",
> +			       child->name,
> +			       PTR_ERR(tz));
> +			continue;
> +		}
> +
> +		ops = kmemdup(&of_thermal_ops, sizeof(*ops), GFP_KERNEL);
> +		if (!ops)
> +			goto exit_free;
> +
> +		tzp = kzalloc(sizeof(*tzp), GFP_KERNEL);
> +		if (!tzp) {
> +			kfree(ops);
> +			goto exit_free;
> +		}
> +
> +		/* No hwmon because there might be hwmon drivers registering */
> +		tzp->no_hwmon = true;

I think the platform driver may set the governor for the thermal zone,
so how about to add a property named as "governor",
and parse it to tzp->governor_name ?
something like:
                ret = of_property_read_string(child, "governor", &str);
                if (ret = 0)
                        if (strlen(str) < THERMAL_NAME_LENGTH)
                                strcpy(tzp->governor_name, str);

Thanks.
Wei.

> +
> +		zone = thermal_zone_device_register(child->name, tz->ntrips,
> +						    0, tz,
> +						    ops, tzp,
> +						    tz->passive_delay,
> +						    tz->polling_delay);
> +		if (IS_ERR(zone)) {
> +			pr_err("Failed to build %s zone %ld\n", child->name,
> +			       PTR_ERR(zone));
> +			kfree(tzp);
> +			kfree(ops);
> +			of_thermal_free_zone(tz);
> +			/* attempting to build remaining zones still */
> +		}
> +	}
> +
> +	return 0;
> +
> +exit_free:
> +	of_thermal_free_zone(tz);
> +
> +	/* no memory available, so free what we have built */
> +	of_thermal_destroy_zones();
> +
> +	return -ENOMEM;
> +}
> +
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
