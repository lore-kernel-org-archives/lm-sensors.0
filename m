From: Punit Agrawal <punit.agrawal@arm.com>
Date: Fri, 14 Aug 2015 12:44:31 +0000
Subject: Re: [lm-sensors] [PATCH v2 10/10] arm64: dts: Create SoC thermal zone for Juno
Message-Id: <9hhlhdeghu8.fsf@e105922-lin.cambridge.arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com>
	<1438615378-14241-11-git-send-email-punit.agrawal@arm.com>
	<20150812155500.GW20890@e106497-lin.cambridge.arm.com>
	<9hh1tf7i7oi.fsf@e105922-lin.cambridge.arm.com>
	<9hhsi7mgi44.fsf@e105922-lin.cambridge.arm.com>
In-Reply-To: <9hhsi7mgi44.fsf@e105922-lin.cambridge.arm.com> (Punit Agrawal's
	message of "Fri, 14 Aug 2015 13:38:35 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Liviu Dudau <Liviu.Dudau@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>

Apologies for the duplicate, I accidentally Hit send before I finished
the reply.

Punit Agrawal <punit.agrawal@arm.com> writes:

> [ adding Eduardo, Rui for their take on OF-thermal bindings ]
>
> Punit Agrawal <punit.agrawal@arm.com> writes:
>
>> Hi Liviu,
>>
>> Thanks for having a look.
>>
>> Liviu Dudau <Liviu.Dudau@arm.com> writes:
>>
>>> On Mon, Aug 03, 2015 at 04:22:58PM +0100, Punit Agrawal wrote:
>>>> Setup a thermal zone driven by the SoC temperature sensor on Juno
>>>> r0. Create passive trip points and bind them to cpufreq cooling
>>>> devices that support the power extensions.
>>>
>>> Hi Punit,
>>>
>>>> 
>>>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>>> ---
>>>>  arch/arm64/boot/dts/arm/juno.dts | 50 ++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 50 insertions(+)
>>>> 
>>>> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
>>>> index d2e67f3..664961c 100644
>>>> --- a/arch/arm64/boot/dts/arm/juno.dts
>>>> +++ b/arch/arm64/boot/dts/arm/juno.dts
>>>> @@ -9,6 +9,7 @@
>>>>  /dts-v1/;
>>>>  
>>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +#include <dt-bindings/thermal/thermal.h>
>>>>  
>>>>  / {
>>>>  	model = "ARM Juno development board (r0)";
>>>> @@ -90,6 +91,8 @@
>>>>  			next-level-cache = <&A57_L2>;
>>>>  			clocks = <&scpi_dvfs 0>;
>>>>  			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>>>> +			#cooling-cells = <2>;
>>>> +			dynamic-power-coefficient = <530>;
>>>
>>> The Documentation/devicetree/bindings/thermal/thermal.txt document describes two additional
>>> required properties, cooling-min-state and cooling-max-state which are missing here.
>>>
>>
>> The bindings do suggest that the cooling-*-state are required but I
>> couldn't find any code making use of this property.
>>
>> I'll send a patch with the next version making those properties
>> optional.
>>
>
> On second thoughts...
>
> The question about cooling-*-state has come up in another thread as
> well [0]. I'll re-iterate the question for the thermal maintainers to
> clarify.
>
> The cooling-{max,min}-state properties are marked mandatory in the
> bindings but aren't used in the code anywhere. Can we drop those
> properties from the binding documentation? Or at the least, make them optional?
>

Let me know your preferred approach. I can include a fix in the next version.

[0] http://thread.gmane.org/gmane.linux.ports.ppc.embedded/84512/focusc339

> [...]
>
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
