From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Date: Wed, 07 Aug 2013 07:27:22 +0000
Subject: Re: [lm-sensors] =?utf-8?q?=5BPATCH_1/2=5D_hwmon=3A_=28lm90=29_Add_po?=
Message-Id: <1375860442.896960598@f427.i.mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375858358-15070-1-git-send-email-wni@nvidia.com>
 <1375858358-15070-2-git-send-email-wni@nvidia.com>
In-Reply-To: <1375858358-15070-2-git-send-email-wni@nvidia.com>
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
>  drivers/hwmon/lm90.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++
[...]
> +	if (!data->lm90_reg) {
> +		data->lm90_reg = regulator_get(&client->dev, "vdd");
> +		if (IS_ERR_OR_NULL(data->lm90_reg)) {
> +			if (PTR_ERR(data->lm90_reg) = -ENODEV)
> +				dev_info(&client->dev,
> +					 "No regulator found for vdd. Assuming vdd is always powered.");
> +			else
> +				dev_warn(&client->dev,
> +					 "Error [%ld] in getting the regulator handle for vdd.\n",
> +					 PTR_ERR(data->lm90_reg));
> +			data->lm90_reg = NULL;
> +			mutex_unlock(&data->update_lock);
> +			return -ENODEV;
> +		}
> +	}
> +	if (is_enable) {
> +		ret = regulator_enable(data->lm90_reg);
> +		msleep(POWER_ON_DELAY);

Can this delay be handled directly from regulator?

[...]
---
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
