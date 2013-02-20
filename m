From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 20 Feb 2013 17:18:37 +0000
Subject: Re: [lm-sensors] [RFC PATCH 8/9] ARM: dt: t30 cardhu: add dt entry for thermal driver
Message-Id: <5125056D.7060608@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-9-git-send-email-wni@nvidia.com> <51240A95.9070007@wwwdotorg.org> <5124B934.3020900@nvidia.com>
In-Reply-To: <5124B934.3020900-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

On 02/20/2013 04:53 AM, Wei Ni wrote:
> On 02/20/2013 07:28 AM, Stephen Warren wrote:
>> On 02/18/2013 04:30 AM, Wei Ni wrote:
>>> Enable thermal driver in the dts file.
>>> Set sensor as lm90 remote sensor, and set throttle data.
>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/tegra3-thermal.txt b/Documentation/devicetree/bindings/thermal/tegra3-thermal.txt

>> Also, what units are used for all these properties?
> 
> they use "int".
> And according to our downstream dvfs driver, the throttle table use
> "unsigned long".

int and unsigned long are types, not units. Units means degrees C vs.
degrees F vs. degrees K, or Hz vs. KHz vs. MHz, etc.

>> Judging by the example below, this property is a list of tuples. The
>> meaning of each field in the tuple needs to be explained.
>>
>> What happens when the CPU/SoC needs to be throttled? Must some clock or
>> voltage be lowered/limited? If so, you need properties that indicate
>> which clock/voltage/... needs to be acted upon.
> 
> This table which will be used by our DVFS driver, although it didn't be
> upstreamed yet. The table set clock frequency limited value with
> different cooling state. When the temperature touch the different
> limited value, we will set difficult cooling state, find the limited
> freq from this table and pass to the dvfs driver.
> I think may be this table should be set for cooling device node. This
> table is only for our tegra dvfs, so I think we can parse this table in
> the tegra3_cooling.c, which will be the new driver for cooling device.

Note that I expect the answers to these questions (pretty much all the
questions I asked in response to your patch) to be included in the DT
binding documentation, not just in email.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
