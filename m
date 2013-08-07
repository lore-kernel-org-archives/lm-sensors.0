From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Date: Wed, 07 Aug 2013 08:45:05 +0000
Subject: Re: [lm-sensors] =?utf-8?q?=5BPATCH_1/2=5D_hwmon=3A_=28lm90=29_Add_po?=
Message-Id: <1375865105.562600640@f434.i.mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375858358-15070-1-git-send-email-wni@nvidia.com>
 <5201FC2C.4030908@roeck-us.net>
 <52020047.1080705@nvidia.com>
In-Reply-To: <52020047.1080705-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?UTF-8?B?V2VpIE5p?= <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: =?UTF-8?B?R3VlbnRlciBSb2Vjaw==?= <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, =?UTF-8?B?c3dhcnJlbkB3d3dkb3Rvcmcub3Jn?= <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, =?UTF-8?B?bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw==?= <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?B?bG0tc2Vuc29yc0BsbS1zZW5zb3JzLm9yZw==?= <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, =?UTF-8?B?bGludXgtdGVncmFAdmdlci5rZXJuZWwub3Jn?= <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?B?TWF0dGhldyBMb25nbmVja2Vy?= <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?B?a2hhbGlAbGludXgtZnIub3Jn?= <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, =?UTF-8?B?bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn?= <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

> On 08/07/2013 03:50 PM, Guenter Roeck wrote:
> > On 08/07/2013 12:32 AM, Wei Ni wrote:
> >> On 08/07/2013 03:27 PM, Alexander Shiyan wrote:
> >>>> The device lm90 can be controlled by the vdd rail.
> >>>> Adding the power control support to power on/off the vdd rail.
> >>>> And make sure that power is enabled before accessing the device.
> >>>>
> >>>> Signed-off-by: Wei Ni <wni@nvidia.com>
> >>>> ---
> >>>>   drivers/hwmon/lm90.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >>> [...]
> >>>> +	if (!data->lm90_reg) {
> >>>> +		data->lm90_reg = regulator_get(&client->dev, "vdd");
> >>>> +		if (IS_ERR_OR_NULL(data->lm90_reg)) {
> >>>> +			if (PTR_ERR(data->lm90_reg) = -ENODEV)
> >>>> +				dev_info(&client->dev,
> >>>> +					 "No regulator found for vdd. Assuming vdd is always powered.");
> >>>> +			else
> >>>> +				dev_warn(&client->dev,
> >>>> +					 "Error [%ld] in getting the regulator handle for vdd.\n",
> >>>> +					 PTR_ERR(data->lm90_reg));
> >>>> +			data->lm90_reg = NULL;
> >>>> +			mutex_unlock(&data->update_lock);
> >>>> +			return -ENODEV;
> >>>> +		}
> >>>> +	}
> >>>> +	if (is_enable) {
> >>>> +		ret = regulator_enable(data->lm90_reg);
> >>>> +		msleep(POWER_ON_DELAY);
> >>>
> >>> Can this delay be handled directly from regulator?
> >>
> >> I think it should be handled in the device driver.
> >> Because there have different delay time to wait devices stable.
> >>
> > 
> > Then why does no other caller of regulator_enable() need this ?
> > I don't think lm90 is so much different to other users of regulator
> > functionality.
> 
> May be I'm wrong. I noticed that in lm90 SPEC, the max of "SMBus Clock
> Low Time" is 25ms, so I supposed that it may need about 20ms to stable
> after power on.
> 
> Anyway, if I remove this delay, the driver also works fine, so I will
> remove it in my next patch.

I originally had in mind that regulator API contain own delay option.
E.g. reg-fixed-voltage && gpio-regulator contains "startup-delay-us" property.

---
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
