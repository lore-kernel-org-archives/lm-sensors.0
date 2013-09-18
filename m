From: Joe Perches <joe@perches.com>
Date: Wed, 18 Sep 2013 21:04:49 +0000
Subject: Re: [lm-sensors] [PATCHv5 02/16] drivers: thermal: introduce device tree parser
Message-Id: <1379538289.1787.74.camel@joe-AO722>
List-Id: <lm-sensors.vger.kernel.org>
References: <1379536310-30000-1-git-send-email-eduardo.valentin@ti.com>
	 <1379537849-28425-1-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1379537849-28425-1-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 2013-09-18 at 16:57 -0400, Eduardo Valentin wrote:
> This patch introduces a device tree bindings for
> describing the hardware thermal behavior and limits.
> Also a parser to read and interpret the data and feed
> it in the thermal framework is presented.
[]
> +int __init of_parse_thermal_zones(void)
> +{
> +	struct device_node *np, *child;
> +	struct __thermal_zone *tz;
> +	struct thermal_zone_device_ops *ops;
[]
> +		if (!ops)
> +			return -ENOMEM;
> +
> +		tzp = kzalloc(sizeof(*tzp), GFP_KERNEL);
> +		if (!tzp)
> +			return -ENOMEM;

leaking memory when ops && !tpz

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

Still leaking memory if !zone no?

> +
> +	return 0;
> +}



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
