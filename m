From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Date: Thu, 08 Aug 2013 07:13:42 +0000
Subject: Re: [lm-sensors] =?utf-8?q?=5BPATCH_v2_1/3=5D_hwmon=3A_=28lm90=29_Add?=
Message-Id: <1375946022.222322391@f304.i.mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
In-Reply-To: <1375944991-29182-2-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?UTF-8?B?V2VpIE5p?= <wni@nvidia.com>
Cc: swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-tegra@vger.kernel.org, MLongnecker@nvidia.com, linux-arm-kernel@lists.infradead.org, khali@linux-fr.org, linux@roeck-us.net

> The device lm90 can be controlled by the vdd rail.
> Adding the power control support to power on/off the vdd rail.
> And make sure that power is enabled before accessing the device.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/hwmon/lm90.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
[...]
> +static void lm90_power_control(struct i2c_client *client, bool is_enable)
> +{
> +	struct lm90_data *data = i2c_get_clientdata(client);
> +	int ret;
> +
> +	if (!data->lm90_reg)
> +		return;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (is_enable)
> +		ret = regulator_enable(data->lm90_reg);
> +	else
> +		ret = regulator_disable(data->lm90_reg);
> +
> +	if (ret < 0)
> +		dev_err(&client->dev,
> +			"Error in %s rail vdd, error %d\n",
> +			(is_enable) ? "enabling" : "disabling", ret);
> +	else
> +		dev_info(&client->dev, "success in %s rail vdd\n",
> +			 (is_enable) ? "enabling" : "disabling");

dev_dbg() ?

> +
> +	mutex_unlock(&data->update_lock);
> +}
> +
>  static int lm90_probe(struct i2c_client *client,
>  		      const struct i2c_device_id *id)
>  {
> @@ -1406,6 +1434,20 @@ static int lm90_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, data);
>  	mutex_init(&data->update_lock);
>  
> +	data->lm90_reg = regulator_get(&client->dev, "vdd");
> +	if (IS_ERR_OR_NULL(data->lm90_reg)) {

What about deferred probe?
if (PTR_ERR(data->lm90_reg) = -EPROBE_DEFER)
return -EPROBE_DEFER;

> +		if (PTR_ERR(data->lm90_reg) = -ENODEV)
> +			dev_info(&client->dev,
> +				 "No regulator found for vdd. Assuming vdd is always powered.");

On my opinion it is unnecessary message.

> +		else
> +			dev_warn(&client->dev,
> +				 "Error [%ld] in getting the regulator handle for vdd.\n",
> +				 PTR_ERR(data->lm90_reg));

Ditto.

> +		data->lm90_reg = NULL;

You can just use !IS_ERR(data->lm90_reg) macro in the future,
rather than set this to NULL.

[...]

---
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
