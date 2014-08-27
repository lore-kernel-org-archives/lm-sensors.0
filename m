From: Wei Ni <wni@nvidia.com>
Date: Wed, 27 Aug 2014 02:31:55 +0000
Subject: Re: [lm-sensors] [PATCH v3 3/4] thermal: add more description for thermal-zones
Message-Id: <53FD431B.40501@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408948188-4181-1-git-send-email-wni@nvidia.com> <1408948188-4181-4-git-send-email-wni@nvidia.com> <20140825110711.GA12349@developer> <53FBF8F9.7070708@nvidia.com> <20140826120855.GA15219@developer>
In-Reply-To: <20140826120855.GA15219@developer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>
Cc: khali@linux-fr.org, linux@roeck-us.net, swarren@wwwdotorg.org, lm-sensors@lm-sensors.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/26/2014 08:08 PM, Eduardo Valentin wrote:
> Hi,
> 
> On Tue, Aug 26, 2014 at 11:03:21AM +0800, Wei Ni wrote:
>> On 08/25/2014 07:07 PM, Eduardo Valentin wrote:
>>> Hello Wei Ni,
>>>
>>> On Mon, Aug 25, 2014 at 02:29:47PM +0800, Wei Ni wrote:
>>>> Add more description for the "polling-delay" property.
>>>> Set "trips" and "cooling maps" as optional property, because
>>>> if missing these two sub-nodes, the thermal zone device still
>>>> work properly.
>>>>
>>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/thermal/thermal.txt | 10 ++++++----
>>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
>>>> index f5db6b7..e3d3ed9 100644
>>>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>>>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>>>> @@ -136,8 +136,8 @@ containing trip nodes and one sub-node containing all the zone cooling maps.
>>>>  
>>>>  Required properties:
>>>>  - polling-delay:	The maximum number of milliseconds to wait between polls
>>>> -  Type: unsigned	when checking this thermal zone.
>>>> -  Size: one cell
>>>> +  Type: unsigned	when checking this thermal zone. If this value is 0, the
>>>> +  Size: one cell	driver will not run polling queue, but just cancel it.
>>>>  
>>>
>>> The description above is specific to Linux kernel implementation
>>> nomenclature. DT description needs to be OS agnostic.
>>
>> Normally, the user may think a delay of 0 means that software
>> continually polls this zone, but in here it mean no polling. May be it's
>> better to add this description.
>>
> 
> Sure, I am fine adding it. Just please do not use Linux specific
> nomenclature.

Yes, you are right, I will just add "Cancel the polling if the delay is 0".

Wei.

> 
>>>
>>>>  - polling-delay-passive: The maximum number of milliseconds to wait
>>>>    Type: unsigned	between polls when performing passive cooling.
>>>> @@ -148,14 +148,16 @@ Required properties:
>>>>    phandles + sensor
>>>>    specifier
>>>>  
>>>> +Optional property:
>>>>  - trips:		A sub-node which is a container of only trip point nodes
>>>>    Type: sub-node	required to describe the thermal zone.
>>>>  
>>>>  - cooling-maps:		A sub-node which is a container of only cooling device
>>>>    Type: sub-node	map nodes, used to describe the relation between trips
>>>> -			and cooling devices.
>>>> +			and cooling devices. If missing the "trips" property,
>>>> +			This sub-node will not be parsed, because no trips can
>>>> +			be bound to cooling devices.
>>>
>>> Do you mean if the thermal zone misses the "trips" property? Actually,
>>> the binding describes both, cooling-maps and trips, as required
>>> properties. Thus, both needs to be in place to consider the thermal zone
>>> as a proper described zone.
>>>
>>>>  
>>>> -Optional property:
>>>>  - coefficients:		An array of integers (one signed cell) containing
>>>>    Type: array		coefficients to compose a linear relation between
>>>>    Elem size: one cell	the sensors listed in the thermal-sensors property.
>>>> -- 
>>>> 1.8.1.5
>>>>
>>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
