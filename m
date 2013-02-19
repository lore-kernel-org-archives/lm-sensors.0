From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 19 Feb 2013 23:48:42 +0000
Subject: Re: [lm-sensors] [RFC PATCH 7/9] thermal: tegra30: add tegra30 thermal driver
Message-Id: <51240F5A.1060309@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-8-git-send-email-wni@nvidia.com>
In-Reply-To: <1361187031-3679-8-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni@nvidia.com>
Cc: durgadoss.r@intel.com, rui.zhang@intel.com, MLongnecker@nvidia.com, khali@linux-fr.org, devicetree-discuss@lists.ozlabs.org, linux-tegra@vger.kernel.org, lm-sensors@lm-sensors.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.orgrs.org, linux-arm-kernel@lists.infradead.org

On 02/18/2013 04:30 AM, Wei Ni wrote:
> dd Tegra30 thermal driver support. It create thermal zone with thermal
> sensors and cooling device to participate in the linux thermal management.

> diff --git a/drivers/thermal/tegra3_thermal.c b/drivers/thermal/tegra3_thermal.c

> +struct tegra_thermal_data {

That's not really "thermal data", but that "thermal zone" or "thermal
device" itself.

> +static int
> +tegra_throttle_set_cur_state(struct thermal_cooling_device *cdev,
> +				unsigned long cur_state)
> +{
> +	struct balanced_throttle *bthrot = cdev->devdata;
> +	int index;
> +
> +	mutex_lock(&cpu_throttle_lock);
> +
> +	/* TODO: we will handle the dvfs here */

That seems like rather a large TODO. We don't have any DVFS support for
Tegra yet. Is it even worth moving forward with this driver without that?

> +struct thermal_cooling_device *balanced_throttle_register(
> +		struct balanced_throttle *bthrot, char *type)

What does "balanced" mean here; isn't balanced a governor, whereas this
driver is simply providing the implementation that an arbitrary governor
would use to do its will?

This function also appears to be rather generically named. A consistent
function/symbol-name prefix of e.g. "tegra30_thermal" would be useful
throughout the file.

> +static struct tegra_thermal_data * __devinit thermal_tegra_dt_parse_pdata(
> +						struct platform_device *pdev)

I'd like some slight re-structing here.

Tegra only supports device tree now; no board files (upstream at least,
which is all that's relevant here). Hence, none of the Tegra drivers
support platform data at all after the last round of cleanup patches I
sent on Friday (most of which haven't been checked in yet). Hence, this
function is not parsing platform data out of DT, it's plain parsing
device tree.

So, can you move the devm_kzalloc of the tdata into probe() right at the
start, rename this function tegra30_thermal_parse_dt(), and call it
right after allocating "tdata" (which also is more like "tdev" or
"tzone" perhaps).

Downstream if you still need to support platform data, you can simply
copy the platform data into "tdev" rather than calling
tegra30_thermal_parse_dt(); a simple patch to carry.

> +	tdata = devm_kzalloc(&pdev->dev, sizeof(*tdata), GFP_KERNEL);
> +	if (!tdata) {
> +		dev_err(&pdev->dev, "Can't allocate platform data\n");
> +		return NULL;
> +	}
> +	memset(tdata, 0, sizeof(*tdata));

That last line is kinda the whole point of k*z*alloc...

> +
> +	ret = of_parse_phandle_with_args(np, "sensors", "#sensor-cells", 0,
> +					&args);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't get sensor.\n");
> +		return NULL;
> +	}
> +	tdata->np_args.np = args.np;
> +	tdata->np_args.index = args.args[0];

That lookup should be implemented as part of the thermal core. It
shouldn't be duplicated in every single driver.

> +	ret = of_property_read_u32(np, "passive-delay", &val);
> +	if (!ret)
> +		tdata->passive_delay = val;

The DT binding documentation doesn't say this property is optional. If
you intend it to be, the documentation should say so, and specify what
the default is if the property is missing.

> +	ret = of_property_read_u32(np, "num-passive-trips", &val);
> +	if (!ret)
> +		tdata->trip_ext.num_passive_trips = val;
> +
> +	if (tdata->trip_ext.num_passive_trips) {
> +		tdata->trip_ext.passive_trips = devm_kzalloc(&pdev->dev,
> +						sizeof(int) * val, GFP_KERNEL);

DT cells are specifically U32 not int. You probably want the driver to
use U32 instead of int to make 100% sure the range matches.

> +
> +		of_property_read_u32_array(np, "passive-trips",
> +				(u32 *)(tdata->trip_ext.passive_trips),
> +				tdata->trip_ext.num_passive_trips);

... and then you wouldn't need this cast!

> +	}

> +	of_property_read_u32_array(np, "throt-tab",
> +				(u32 *)(&tdata->tj_throttle.throt_tab),
> +				tdata->tj_throttle.throt_tab_size * 2);

What about error-handling that API call, and all the others?

> +static int tegra30_thermal_probe(struct platform_device *pdev)
> +{
> +	struct tegra_thermal_data *pdata = pdev->dev.platform_data;

Lets not support platform data at all upstream.

> +	/* Register cooling device */
> +	cdev = balanced_throttle_register(&pdata->tj_throttle, "cdev_throttle");

Is this picking specific policy ("balanced")? Should it be? What is
"cdev_throttle"?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
