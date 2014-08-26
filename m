From: Wei Ni <wni@nvidia.com>
Date: Tue, 26 Aug 2014 02:17:29 +0000
Subject: Re: [lm-sensors] [PATCH v3 3/4] thermal: add more description for thermal-zones
Message-Id: <53FBEE39.2020001@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408948188-4181-1-git-send-email-wni@nvidia.com> <1408948188-4181-4-git-send-email-wni@nvidia.com> <20140825110711.GA12349@developer>
In-Reply-To: <20140825110711.GA12349@developer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/25/2014 07:07 PM, Eduardo Valentin wrote:
> Hello Wei Ni,
> 
> On Mon, Aug 25, 2014 at 02:29:47PM +0800, Wei Ni wrote:
>> Add more description for the "polling-delay" property.
>> Set "trips" and "cooling maps" as optional property, because
>> if missing these two sub-nodes, the thermal zone device still
>> work properly.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  Documentation/devicetree/bindings/thermal/thermal.txt | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
>> index f5db6b7..e3d3ed9 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>> @@ -136,8 +136,8 @@ containing trip nodes and one sub-node containing all the zone cooling maps.
>>  
>>  Required properties:
>>  - polling-delay:	The maximum number of milliseconds to wait between polls
>> -  Type: unsigned	when checking this thermal zone.
>> -  Size: one cell
>> +  Type: unsigned	when checking this thermal zone. If this value is 0, the
>> +  Size: one cell	driver will not run polling queue, but just cancel it.
>>  
> 
> The description above is specific to Linux kernel implementation
> nomenclature. DT description needs to be OS agnostic.
> 
>>  - polling-delay-passive: The maximum number of milliseconds to wait
>>    Type: unsigned	between polls when performing passive cooling.
>> @@ -148,14 +148,16 @@ Required properties:
>>    phandles + sensor
>>    specifier
>>  
>> +Optional property:
>>  - trips:		A sub-node which is a container of only trip point nodes
>>    Type: sub-node	required to describe the thermal zone.
>>  
>>  - cooling-maps:		A sub-node which is a container of only cooling device
>>    Type: sub-node	map nodes, used to describe the relation between trips
>> -			and cooling devices.
>> +			and cooling devices. If missing the "trips" property,
>> +			This sub-node will not be parsed, because no trips can
>> +			be bound to cooling devices.
> 
> Do you mean if the thermal zone misses the "trips" property? Actually,
> the binding describes both, cooling-maps and trips, as required
> properties. Thus, both needs to be in place to consider the thermal zone
> as a proper described zone.

I moved the "trips" and "cooling-maps" to optional property, because if
missing these two properties, the thermal zone devices still can be
registered, and the driver can work properly, it has the basic function,
can read temperature from thermal sysfs, although it doesn't have trips
and bind with cooling devices.

Thanks.
Wei.

> 
>>  
>> -Optional property:
>>  - coefficients:		An array of integers (one signed cell) containing
>>    Type: array		coefficients to compose a linear relation between
>>    Elem size: one cell	the sensors listed in the thermal-sensors property.
>> -- 
>> 1.8.1.5
>>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
