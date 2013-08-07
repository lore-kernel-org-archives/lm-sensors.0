From: Wei Ni <wni@nvidia.com>
Date: Wed, 07 Aug 2013 07:32:33 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm90) Add power control
Message-Id: <5201F811.9050602@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375858358-15070-1-git-send-email-wni@nvidia.com> <1375858358-15070-2-git-send-email-wni@nvidia.com> <1375860442.896960598@f427.i.mail.ru>
In-Reply-To: <1375860442.896960598-syZRKAW8O9ZsdVUOrk1QfQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Cc: "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

On 08/07/2013 03:27 PM, Alexander Shiyan wrote:
>> The device lm90 can be controlled by the vdd rail.
>> Adding the power control support to power on/off the vdd rail.
>> And make sure that power is enabled before accessing the device.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/hwmon/lm90.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++
> [...]
>> +	if (!data->lm90_reg) {
>> +		data->lm90_reg = regulator_get(&client->dev, "vdd");
>> +		if (IS_ERR_OR_NULL(data->lm90_reg)) {
>> +			if (PTR_ERR(data->lm90_reg) = -ENODEV)
>> +				dev_info(&client->dev,
>> +					 "No regulator found for vdd. Assuming vdd is always powered.");
>> +			else
>> +				dev_warn(&client->dev,
>> +					 "Error [%ld] in getting the regulator handle for vdd.\n",
>> +					 PTR_ERR(data->lm90_reg));
>> +			data->lm90_reg = NULL;
>> +			mutex_unlock(&data->update_lock);
>> +			return -ENODEV;
>> +		}
>> +	}
>> +	if (is_enable) {
>> +		ret = regulator_enable(data->lm90_reg);
>> +		msleep(POWER_ON_DELAY);
> 
> Can this delay be handled directly from regulator?

I think it should be handled in the device driver.
Because there have different delay time to wait devices stable.

> 
> [...]
> ---
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
