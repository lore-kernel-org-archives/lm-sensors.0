From: Wei Ni <wni@nvidia.com>
Date: Wed, 05 Mar 2014 04:30:32 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/3] ARM: tegra: dalmore: add thermal zones for nct1008
Message-Id: <5316A868.7000908@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393932664-13319-1-git-send-email-wni@nvidia.com> <1393932664-13319-4-git-send-email-wni@nvidia.com> <53164E78.5010708@wwwdotorg.org> <20140304222357.GA6125@roeck-us.net> <53168C5B.6070003@nvidia.com> <531692D2.6040204@wwwdotorg.org> <531694EB.50906@nvidia.com> <531696A9.6060906@wwwdotorg.org> <5316A785.8030504@nvidia.com>
In-Reply-To: <5316A785.8030504-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On 03/05/2014 12:26 PM, Wei Ni wrote:
> On 03/05/2014 11:14 AM, Stephen Warren wrote:
>> On 03/04/2014 08:07 PM, Wei Ni wrote:
>>> On 03/05/2014 10:58 AM, Stephen Warren wrote:
>>>> On 03/04/2014 07:30 PM, Wei Ni wrote:
>>>>> On 03/05/2014 06:23 AM, Guenter Roeck wrote:
>>>>>> On Tue, Mar 04, 2014 at 03:06:48PM -0700, Stephen Warren wrote:
>>>>>>> On 03/04/2014 04:31 AM, Wei Ni wrote:
>>>>>>>> Add dt node to describe the thermal zone for the nct1008.
>>>>>>>>
>>>>>>>> Change-Id: I0256836e52d73ec282574e4fd91df52958936e35
>>>>>>>
>>>>>>> ???????
>>>>>>>
>>>>>> I think this is for one of those open-source sites out there
>>>>>> which count open source contributions. Not Ohloh, but similar.
>>>>>> You have to specify that Change-Id to have it associate your
>>>>>> name with the patch.
>>>>>
>>>>> It's so sorry, I'm working for chromiumos, this change-id is generated
>>>>> by gerrit, I should remove it.
>>>>>
>>>>>>
>>>>>> Guenter
>>>>>>
>>>>>>>> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
>>>>>>>
>>>>>>>> +	thermal-zones {
>>>>>>>> +		nct1008-local {
>>>>>>>> +			polling-delay-passive = <2000>; /* milliseconds */
>>>>>>>
>>>>>>> Nothing can possible make use of this node, since there's no compatible
>>>>>>> value or anything else like that to bind a driver to it.
>>>>>
>>>>> We have special Tskin driver that estimator skin temperature based on
>>>>> nct1008 local and remote sensors.
>>>>
>>>> Where? Anything that gets added to the upstream kernel DT files must be
>>>> supported by a driver and binding in the upstream kernel.
>>>
>>> I didn't submit the Tskin driver yet, but the of-thermal framework can
>>> parse this node, and create thermal zone devices.
>>
>> How is that possible? There's no compatible value for the of-thermal
>> framework to know that it should process this node. It's not correct for
>> the of-thermal framework to do anything like look for a node with a
>> particular name... has the DT binding for this been reviewed by any DT
>> maintainer?
> 
> Eduardo developed the of-thermal framework, and have merged in
> linux-next, it can parse the node thermal-zones, and properties, such as
> polling-delay-passive. Please check the omap.dtsi, it also has this node.

Please check Documentation/devicetree/bindings/thermal/thermal.txt

> 
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
