From: Joe Perches <joe@perches.com>
Date: Wed, 18 Sep 2013 19:11:23 +0000
Subject: Re: [lm-sensors] [PATCHv3 02/16] drivers: thermal: introduce device tree parser
Message-Id: <1379531483.1787.55.camel@joe-AO722>
List-Id: <lm-sensors.vger.kernel.org>
References: <5239F6D8.1020907@ti.com>
	 <1379530923-29268-1-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1379530923-29268-1-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, 2013-09-18 at 15:02 -0400, Eduardo Valentin wrote:
> This patch introduces a device tree bindings for
> describing the hardware thermal behavior and limits.
> Also a parser to read and interpret the data and feed
> it in the thermal framework is presented.

trivial notes:

> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
[]
> +static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
> +				enum thermal_trend *trend)
> +{
> +	struct __thermal_zone *data = tz->devdata;
> +	long dev_trend;
> +	int r;
> +
> +	if (!data->get_trend)
> +		return -EINVAL;
> +
> +	r = data->get_trend(data->sensor_data, &dev_trend);
> +	if (r)
> +		return r;
> +
> +	if (dev_trend > 0)
> +		*trend = THERMAL_TREND_RAISING;
> +	else if (dev_trend < 0)
> +		*trend = THERMAL_TREND_DROPPING;
> +	else
> +		*trend = THERMAL_TREND_STABLE;
> +
> +	return 0;
> +}

If readings are within some non zero noise level,
perhaps stable should be returned.

> +static struct __thermal_zone *
> +thermal_of_build_thermal_zone(struct device_node *np)
> +{
> +	struct device_node *child, *gchild;
> +	struct __thermal_zone *tz;
> +	int ret, i;
> +	u32 prop;
> +
> +	if (!np) {
> +		pr_err("no thermal zone np\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
> +	if (!tz) {
> +		pr_err("not enough memory for thermal of zone\n");

Unnecessary OOM message.
All allocs without GFP_NOWARN get a dump_stack()

> +int __init of_parse_thermal_zones(void)
> +{
[]
> +		ops = kzalloc(sizeof(*ops), GFP_KERNEL);
> +		if (!ops) {
> +			pr_err("no memory available for thermal ops\n");
> +			return 0;
> +		}
> +		memcpy(ops, &of_thermal_ops, sizeof(*ops));
> +
> +		tzp = kzalloc(sizeof(*tzp), GFP_KERNEL);
> +		if (!ops) {
> +			pr_err("no memory available for thermal zone params\n");
> +			return 0;
> +		}

a couple more OOMs.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
