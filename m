From: Wei Ni <wni@nvidia.com>
Date: Wed, 05 Mar 2014 03:07:23 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/3] ARM: tegra: dalmore: add thermal zones for nct1008
Message-Id: <531694EB.50906@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393932664-13319-1-git-send-email-wni@nvidia.com>
 <1393932664-13319-4-git-send-email-wni@nvidia.com>
 <53164E78.5010708@wwwdotorg.org> <20140304222357.GA6125@roeck-us.net>
 <53168C5B.6070003@nvidia.com> <531692D2.6040204@wwwdotorg.org>
In-Reply-To: <531692D2.6040204-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On 03/05/2014 10:58 AM, Stephen Warren wrote:
> On 03/04/2014 07:30 PM, Wei Ni wrote:
>> On 03/05/2014 06:23 AM, Guenter Roeck wrote:
>>> On Tue, Mar 04, 2014 at 03:06:48PM -0700, Stephen Warren wrote:
>>>> On 03/04/2014 04:31 AM, Wei Ni wrote:
>>>>> Add dt node to describe the thermal zone for the nct1008.
>>>>>
>>>>> Change-Id: I0256836e52d73ec282574e4fd91df52958936e35
>>>>
>>>> ???????
>>>>
>>> I think this is for one of those open-source sites out there
>>> which count open source contributions. Not Ohloh, but similar.
>>> You have to specify that Change-Id to have it associate your
>>> name with the patch.
>>
>> It's so sorry, I'm working for chromiumos, this change-id is generated
>> by gerrit, I should remove it.
>>
>>>
>>> Guenter
>>>
>>>>> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
>>>>
>>>>> +	thermal-zones {
>>>>> +		nct1008-local {
>>>>> +			polling-delay-passive = <2000>; /* milliseconds */
>>>>
>>>> Nothing can possible make use of this node, since there's no compatible
>>>> value or anything else like that to bind a driver to it.
>>
>> We have special Tskin driver that estimator skin temperature based on
>> nct1008 local and remote sensors.
> 
> Where? Anything that gets added to the upstream kernel DT files must be
> supported by a driver and binding in the upstream kernel.

I didn't submit the Tskin driver yet, but the of-thermal framework can
parse this node, and create thermal zone devices.

Thanks.
Wei.

> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
