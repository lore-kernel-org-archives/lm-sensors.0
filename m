From: Wei Ni <wni@nvidia.com>
Date: Mon, 08 Jul 2013 09:36:05 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] ARM: dt: t30 cardhu: add dt entry for lm90
Message-Id: <51DA8805.50709@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372928979-26938-1-git-send-email-wni@nvidia.com> <1372928979-26938-2-git-send-email-wni@nvidia.com> <51D70483.70203@wwwdotorg.org>	<51DA6BD4.1040300@nvidia.com> <20130708095024.041a6d57@endymion.delvare>
In-Reply-To: <20130708095024.041a6d57-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

On 07/08/2013 03:50 PM, Jean Delvare wrote:
> On Mon, 8 Jul 2013 15:35:48 +0800, Wei Ni wrote:
>> On 07/06/2013 01:38 AM, Stephen Warren wrote:
>>> On 07/04/2013 03:09 AM, Wei Ni wrote:
>>>> Enable thermal sensor lm90 for t30 cardhu.
>>>
>>>> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
>>>
>>>> +		nct1008: nct1008 {
>>>> +			compatible = "lm90,nct1008";
>>>
>>> "lm90" isn't a valid vendor prefix. I believe the value you want is
>>> "onnn,nct1008". Same comment for patch 2/2.
>>
>> The lm90 doesn't support device tree very well.
> 
> I doubt it, but if this is the case, then please fix it, instead of
> working the problem around in a different place.
> 
>> In the DT, we need to
>> named as "lm90" so that the lm90 driver can be loaded,
> 
> Not that I am an expert with regards to DT, but this doesn't make any
> sense to me. AFAIK DT is about devices, not which drivers handle them.
> 
>> and we also need
>> to add "nct1008" to indicate this is the nct1008 device, so that the
>> lm90 driver can be loaded with the right i2c_device_id->driver_data.
>>
>> I set the " compatible = "lm90,nct1008" ", this is the simplest way, and
>> we doesn't need to change the lm90.c.
> 
> There's no problem with changing the lm90 driver, if this is the right
> thing to do.

Ok, I will add DT support in the lm90.c in my next version patch.

Thanks.
Wei.

> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
