From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 07 Aug 2013 07:45:46 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm90) Add power control
Message-Id: <5201FB2A.2010806@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375858358-15070-1-git-send-email-wni@nvidia.com> <1375858358-15070-2-git-send-email-wni@nvidia.com> <1375860442.896960598@f427.i.mail.ru>
In-Reply-To: <1375860442.896960598@f427.i.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Wei Ni <wni@nvidia.com>, khali@linux-fr.org, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, MLongnecker@nvidia.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/07/2013 12:27 AM, Alexander Shiyan wrote:
>> The device lm90 can be controlled by the vdd rail.
>> Adding the power control support to power on/off the vdd rail.
>> And make sure that power is enabled before accessing the device.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>   drivers/hwmon/lm90.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++
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
>

Good question. Browsing through other regulator_enable calls,
I don't see a similar delay anywhere else, so one should assume
that this is not necessary.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
