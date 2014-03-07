From: Stephen Warren <swarren@wwwdotorg.org>
Date: Fri, 07 Mar 2014 04:23:39 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/3] ARM: tegra: dalmore: add thermal zones for nct1008
Message-Id: <531949CB.1000904@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393932664-13319-1-git-send-email-wni@nvidia.com> <1393932664-13319-4-git-send-email-wni@nvidia.com> <5318B790.8090808@wwwdotorg.org> <531940C5.3040102@nvidia.com>
In-Reply-To: <531940C5.3040102-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On 03/06/2014 08:45 PM, Wei Ni wrote:
> On 03/07/2014 01:59 AM, Stephen Warren wrote:
>> On 03/04/2014 04:31 AM, Wei Ni wrote:
>>> Add dt node to describe the thermal zone for the nct1008.
>>
>>> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
>>
>>> +	thermal-zones {
>>> +		nct1008-local {
>>> +			polling-delay-passive = <2000>; /* milliseconds */
>>> +			polling-delay = <0>; /* milliseconds */
>>
>> A delay of 0 implies that software continually polls this zone, thus
>> consuming an entire CPU. Is this really what you want?
> 
> No, if this delay is 0, the driver will not run polling queue, but just
> cancel it.

The binding doesn't say this. The DT needs to be written to the binding
as specified in the documentation, not to the behaviour of one
particular OS's driver.

Now, if the DT binding gets updated to explicitly document this, the DT
content above would be fine.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
