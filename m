From: Wei Ni <wni@nvidia.com>
Date: Thu, 08 Aug 2013 09:59:28 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) Add power control
Message-Id: <52036C00.20405@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com> <520359E9.1000600@roeck-us.net> <52036920.4050808@nvidia.com> <1375955834.368114617@f197.i.mail.ru>
In-Reply-To: <1375955834.368114617-VbvbiqT9YuJsdVUOrk1QfQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

On 08/08/2013 05:57 PM, Alexander Shiyan wrote:
>> On 08/08/2013 04:42 PM, Guenter Roeck wrote:
>>> On 08/07/2013 11:56 PM, Wei Ni wrote:
>>>> The device lm90 can be controlled by the vdd rail.
>>>> Adding the power control support to power on/off the vdd rail.
>>>> And make sure that power is enabled before accessing the device.
>>>>
>>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>>> ---
>>>>   drivers/hwmon/lm90.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
> [...]
>>> I consider the messages unnecessary and confusing. You are polluting the log
>>> of pretty much every PC user who has one of the supported chips in the system,
>>> and of everyone else not using regulators for this chip.
>>
>> Ok, I will remove these codes.
>> So I will write something like:
>> if (!IS_ERR(data->lm90_reg)) {
>>     ret = regulator_enable(data->lm90_reg);
>>     if (ret < 0) {
>>         dev_err();
>>         return ret;
>>     }
>> } else {
>>     if (PTR_ERR(data->lm90_reg) = -EPROBE_DEFER)
>>         return -EPRPBE_DEFER;
>>
>>         data->lm90_reg = !!IS_ERR(data->lm90_reg);
> 
> No. You do not need this line.
> 
> Just use in remove():
> if (!IS_ERR(data->lm90_reg))
> regulator_disable(data->lm90_reg);

Oh, I see, thank you very much.

> 
> ---
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
