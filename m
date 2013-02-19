From: Alex Courbot <acourbot@nvidia.com>
Date: Tue, 19 Feb 2013 05:22:44 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/9] hwmon: (lm90) Register to the thermal framework
Message-Id: <51230C24.5090707@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-7-git-send-email-wni@nvidia.com>
In-Reply-To: <1361187031-3679-7-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni@nvidia.com>
Cc: "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.orgrs.org" <linux-kernel@vger.kernel.orgrs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02/18/2013 08:30 PM, Wei Ni wrote:
> Register the remote sensor to the thermal framework.
> It can support to show the temperature and read/write threshold.
>
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>   arch/arm/boot/dts/tegra30-cardhu.dtsi |    1 +
>   drivers/hwmon/lm90.c                  |  182 ++++++++++++++++++++++++++++++++-
>   2 files changed, 182 insertions(+), 1 deletion(-)

Making changes to a driver *and* a board file in the same patch? I think 
this should be separated, and the board file change preferably squashed 
with the first patch of this series, and moved right after this one.

>
> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> index 15ad1ad..3f6ab89 100644
> --- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
> +++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> @@ -279,6 +279,7 @@
>   			reg = <0x4c>;
>   			interrupt-parent = <&gpio>;
>   			interrupts = <226 0x08>; /* gpio PCC2 */
> +			#sensor-cells = <1>;
>   		};
>   	};
>
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index de5a476..0abdedc 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -91,6 +91,7 @@
>   #include <linux/sysfs.h>
>   #include <linux/interrupt.h>
>   #include <linux/of_irq.h>
> +#include <linux/thermal.h>
>
>   /*
>    * Addresses to scan
> @@ -182,6 +183,15 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
>   #define LM90_HAVE_BROKEN_ALERT	(1 << 7) /* Broken alert		*/
>
>   /*
> + * Thermal framework
> + */
> +enum lm90_thresholds {
> +	LM90_LOW_THRESHOLDS = 0,	/* threshold 0: low limits */
> +	LM90_HIGH_THRESHOLDS,		/* threshold 1: high limits */
> +	LM90_NUM_THRESHOLDS
> +};
> +
> +/*
>    * Driver data (common to all clients)
>    */
>
> @@ -377,6 +387,9 @@ struct lm90_data {
>   	s16 temp11[TEMP11_REG_NUM];
>   	u8 temp_hyst;
>   	u16 alarms; /* bitvector (upper 8 bits for max6695/96) */
> +
> +	struct thermal_sensor *ts_remote;
> +	struct thermal_sensor *ts_local;
>   };
>
>   /*
> @@ -1493,12 +1506,151 @@ static irqreturn_t lm90_irq(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>
> +static int lm90_read_remote_temp(struct thermal_sensor *ts, long *temp)
> +{
> +	struct i2c_client *client = ts->devdata;
> +	struct device *dev = &client->dev;
> +
> +	_show_temp11(dev, TEMP11_REMOTE_TEMP, (int *)temp);

As Guenter pointed, this might break. Since you introduced _show_temp11 
in a previous patch, you should revise it to take a long * as third 
argument (or even better, return a long). Or if you cannot do that for 
some reason, use a temporary int and affect temp properly (*temp = 
temp_int).

> +
> +	return 0;
> +}
> +
> +static int lm90_read_remote_threshold(struct thermal_sensor *ts, int th_index,
> +					long *val)
> +{
> +	struct i2c_client *client = ts->devdata;
> +	struct device *dev = &client->dev;
> +	int index;
> +
> +	switch (th_index) {
> +	case LM90_LOW_THRESHOLDS:
> +		/* remote low limit */
> +		index = TEMP11_REMOTE_LOW;
> +		break;
> +	case LM90_HIGH_THRESHOLDS:
> +		/* remote high limit */
> +		index = TEMP11_REMOTE_HIGH;
> +		break;
> +	default:
> +		dev_err(dev, "read remote threshold failed.\n");
> +		return -EINVAL;
> +	}
> +
> +	_show_temp11(dev, index, (int *)val);
> +
> +	return 0;
> +}
> +
> +static int lm90_write_remote_threshold(struct thermal_sensor *ts, int th_index,
> +					long val)
> +{
> +	struct i2c_client *client = ts->devdata;
> +	struct device *dev = &client->dev;
> +	int nr, index;
> +
> +	switch (th_index) {
> +	case LM90_LOW_THRESHOLDS:
> +		/* remote low limit */
> +		nr = NR_CHAN_0_REMOTE_LOW;
> +		index = TEMP11_REMOTE_LOW;
> +		break;
> +	case LM90_HIGH_THRESHOLDS:
> +		/* remote high limit */
> +		nr = NR_CHAN_0_REMOTE_HIGH;
> +		index = TEMP11_REMOTE_HIGH;
> +		break;
> +	default:
> +		dev_err(dev, "write remote threshold failed.\n");
> +		return -EINVAL;
> +	}
> +
> +	_set_temp11(dev, nr, index, val);
> +
> +	return 0;
> +}
> +
> +static struct thermal_sensor_ops remote_ops = {
> +	.get_temp = lm90_read_remote_temp,
> +	.get_threshold = lm90_read_remote_threshold,
> +	.set_threshold = lm90_write_remote_threshold,
> +};
> +
> +static int lm90_read_local_temp(struct thermal_sensor *ts, long *temp)
> +{
> +	struct i2c_client *client = ts->devdata;
> +	struct device *dev = &client->dev;
> +
> +	_show_temp11(dev, TEMP11_LOCAL_TEMP, (int *)temp);
> +
> +	return 0;
> +}
> +
> +static int lm90_read_local_threshold(struct thermal_sensor *ts, int th_index,
> +					long *val)
> +{
> +	struct i2c_client *client = ts->devdata;
> +	struct device *dev = &client->dev;
> +	int index;
> +
> +	switch (th_index) {
> +	case LM90_LOW_THRESHOLDS:
> +		/* local low limit */
> +		index = TEMP8_LOCAL_LOW;
> +		break;
> +	case LM90_HIGH_THRESHOLDS:
> +		/* local high limit */
> +		index = TEMP8_LOCAL_HIGH;
> +		break;

I think the comments are unneeded here, the macro name should be 
explicit enough.

> +	default:
> +		dev_err(dev, "read local threshold failed.\n");
> +		return -EINVAL;
> +	}
> +
> +	_show_temp8(dev, index, (int *)val);
> +
> +	return 0;
> +}
> +
> +static int lm90_write_local_threshold(struct thermal_sensor *ts, int th_index,
> +					long val)
> +{
> +	struct i2c_client *client = ts->devdata;
> +	struct device *dev = &client->dev;
> +	int index;
> +
> +	switch (th_index) {
> +	case LM90_LOW_THRESHOLDS:
> +		/* local low limit */
> +		index = TEMP8_LOCAL_LOW;
> +		break;
> +	case LM90_HIGH_THRESHOLDS:
> +		/* local high limit */
> +		index = TEMP8_LOCAL_HIGH;
> +		break;
> +	default:
> +		dev_err(dev, "write local threshold failed.\n");
> +		return -EINVAL;
> +	}
> +
> +	_set_temp8(dev, index, val);
> +
> +	return 0;
> +}
> +
> +static struct thermal_sensor_ops local_ops = {
> +	.get_temp = lm90_read_local_temp,
> +	.get_threshold = lm90_read_local_threshold,
> +	.set_threshold = lm90_write_local_threshold,
> +};
> +
>   static int lm90_probe(struct i2c_client *client,
>   		      const struct i2c_device_id *id)
>   {
>   	struct device *dev = &client->dev;
>   	struct i2c_adapter *adapter = to_i2c_adapter(dev->parent);
>   	struct lm90_data *data;
> +	struct node_args np_args;
>   	int err;
>
>   	data = devm_kzalloc(&client->dev, sizeof(struct lm90_data), GFP_KERNEL);
> @@ -1576,12 +1728,38 @@ static int lm90_probe(struct i2c_client *client,
>   				       "lm90", data);
>   		if (err < 0) {
>   			dev_err(dev, "cannot request interrupt\n");
> -			goto exit_remove_files;
> +			goto exit_unregister_hwmon;
>   		}
>   	}
>
> +	np_args.np = dev->of_node;
> +	np_args.index = 0;
> +	data->ts_remote = thermal_sensor_register("lm90_remote",
> +						LM90_NUM_THRESHOLDS,
> +						&np_args,
> +						&remote_ops, client);
> +	if (IS_ERR(data->ts_remote)) {
> +		dev_err(dev, "cannot register sensor to thermal framework\n");
> +		err = -EINVAL;

When don't you return the error code provided by 
thermal_sensor_register, e.g. err = PTR_ERR(data->ts_remote) ?

> +		goto exit_unregister_hwmon;
> +	}
> +
> +	np_args.index = 1;
> +	data->ts_local = thermal_sensor_register("lm90_local",
> +						LM90_NUM_THRESHOLDS,
> +						&np_args,
> +						&local_ops, client);
> +
> +	if (IS_ERR(data->ts_local)) {
> +		dev_err(dev, "cannot register sensor to thermal framework\n");
> +		err = -EINVAL;

Same thing here.

> +		goto exit_unregister_hwmon;
> +	}
> +
>   	return 0;
>
> +exit_unregister_hwmon:
> +	hwmon_device_unregister(data->hwmon_dev);
>   exit_remove_files:
>   	lm90_remove_files(client, data);
>   exit_restore:
> @@ -1594,6 +1772,8 @@ static int lm90_remove(struct i2c_client *client)
>   	struct lm90_data *data = i2c_get_clientdata(client);
>
>   	free_irq(client->irq, data);
> +	thermal_sensor_unregister(data->ts_remote);
> +	thermal_sensor_unregister(data->ts_local);

Ideally you would unregister your sensors in the reverse order they have 
been registered, but I'm being picky here.

Alex.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
