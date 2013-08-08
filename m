From: Wei Ni <wni@nvidia.com>
Date: Thu, 08 Aug 2013 09:26:14 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) Add power control
Message-Id: <52036436.4090608@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com> <1375944991-29182-2-git-send-email-wni@nvidia.com> <1375946022.222322391@f304.i.mail.ru>
In-Reply-To: <1375946022.222322391-uDhCb/4LxRRsdVUOrk1QfQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Cc: "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

On 08/08/2013 03:13 PM, Alexander Shiyan wrote:
>> The device lm90 can be controlled by the vdd rail.
>> Adding the power control support to power on/off the vdd rail.
>> And make sure that power is enabled before accessing the device.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/hwmon/lm90.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>
>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> [...]
>> +static void lm90_power_control(struct i2c_client *client, bool is_enable)
>> +{
>> +	struct lm90_data *data = i2c_get_clientdata(client);
>> +	int ret;
>> +
>> +	if (!data->lm90_reg)
>> +		return;
>> +
>> +	mutex_lock(&data->update_lock);
>> +
>> +	if (is_enable)
>> +		ret = regulator_enable(data->lm90_reg);
>> +	else
>> +		ret = regulator_disable(data->lm90_reg);
>> +
>> +	if (ret < 0)
>> +		dev_err(&client->dev,
>> +			"Error in %s rail vdd, error %d\n",
>> +			(is_enable) ? "enabling" : "disabling", ret);
>> +	else
>> +		dev_info(&client->dev, "success in %s rail vdd\n",
>> +			 (is_enable) ? "enabling" : "disabling");
> 
> dev_dbg() ?

As Guenter said, I will remove these messages, and remove this function,
the code will be more clean.

> 
>> +
>> +	mutex_unlock(&data->update_lock);
>> +}
>> +
>>  static int lm90_probe(struct i2c_client *client,
>>  		      const struct i2c_device_id *id)
>>  {
>> @@ -1406,6 +1434,20 @@ static int lm90_probe(struct i2c_client *client,
>>  	i2c_set_clientdata(client, data);
>>  	mutex_init(&data->update_lock);
>>  
>> +	data->lm90_reg = regulator_get(&client->dev, "vdd");
>> +	if (IS_ERR_OR_NULL(data->lm90_reg)) {
> 
> What about deferred probe?
> if (PTR_ERR(data->lm90_reg) = -EPROBE_DEFER)
> return -EPROBE_DEFER;

Oh, yes, I should add it.

> 
>> +		if (PTR_ERR(data->lm90_reg) = -ENODEV)
>> +			dev_info(&client->dev,
>> +				 "No regulator found for vdd. Assuming vdd is always powered.");
> 
> On my opinion it is unnecessary message.
> 
>> +		else
>> +			dev_warn(&client->dev,
>> +				 "Error [%ld] in getting the regulator handle for vdd.\n",
>> +				 PTR_ERR(data->lm90_reg));
> 
> Ditto.

I will remove these log messages.

> 
>> +		data->lm90_reg = NULL;
> 
> You can just use !IS_ERR(data->lm90_reg) macro in the future,
> rather than set this to NULL.

Yes, it's better, I will do it.

> 
> [...]
> 
> ---
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
