From: Punit Agrawal <punit.agrawal@arm.com>
Date: Thu, 13 Aug 2015 14:28:45 +0000
Subject: Re: [lm-sensors] [PATCH v2 10/10] arm64: dts: Create SoC thermal zone for Juno
Message-Id: <9hh1tf7i7oi.fsf@e105922-lin.cambridge.arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com>
	<1438615378-14241-11-git-send-email-punit.agrawal@arm.com>
	<20150812155500.GW20890@e106497-lin.cambridge.arm.com>
In-Reply-To: <20150812155500.GW20890@e106497-lin.cambridge.arm.com> (Liviu
	Dudau's message of "Wed, 12 Aug 2015 16:55:00 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>

Hi Liviu,

Thanks for having a look.

Liviu Dudau <Liviu.Dudau@arm.com> writes:

> On Mon, Aug 03, 2015 at 04:22:58PM +0100, Punit Agrawal wrote:
>> Setup a thermal zone driven by the SoC temperature sensor on Juno
>> r0. Create passive trip points and bind them to cpufreq cooling
>> devices that support the power extensions.
>
> Hi Punit,
>
>> 
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  arch/arm64/boot/dts/arm/juno.dts | 50 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
>> index d2e67f3..664961c 100644
>> --- a/arch/arm64/boot/dts/arm/juno.dts
>> +++ b/arch/arm64/boot/dts/arm/juno.dts
>> @@ -9,6 +9,7 @@
>>  /dts-v1/;
>>  
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/thermal/thermal.h>
>>  
>>  / {
>>  	model = "ARM Juno development board (r0)";
>> @@ -90,6 +91,8 @@
>>  			next-level-cache = <&A57_L2>;
>>  			clocks = <&scpi_dvfs 0>;
>>  			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>> +			#cooling-cells = <2>;
>> +			dynamic-power-coefficient = <530>;
>
> The Documentation/devicetree/bindings/thermal/thermal.txt document describes two additional
> required properties, cooling-min-state and cooling-max-state which are missing here.
>

The bindings do suggest that the cooling-*-state are required but I
couldn't find any code making use of this property.

I'll send a patch with the next version making those properties
optional.

>>  		};
>>  
>>  		A57_1: cpu@1 {
>> @@ -100,6 +103,8 @@
>>  			next-level-cache = <&A57_L2>;
>>  			clocks = <&scpi_dvfs 0>;
>>  			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>> +			#cooling-cells = <2>;
>> +			dynamic-power-coefficient = <530>;
>>  		};
>>  
>>  		A53_0: cpu@100 {
>> @@ -110,6 +115,8 @@
>>  			next-level-cache = <&A53_L2>;
>>  			clocks = <&scpi_dvfs 1>;
>>  			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>> +			#cooling-cells = <2>;
>> +			dynamic-power-coefficient = <140>;
>>  		};
>>  
>>  		A53_1: cpu@101 {
>> @@ -120,6 +127,8 @@
>>  			next-level-cache = <&A53_L2>;
>>  			clocks = <&scpi_dvfs 1>;
>>  			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>> +			#cooling-cells = <2>;
>> +			dynamic-power-coefficient = <140>;
>>  		};
>>  
>>  		A53_2: cpu@102 {
>> @@ -130,6 +139,8 @@
>>  			next-level-cache = <&A53_L2>;
>>  			clocks = <&scpi_dvfs 1>;
>>  			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>> +			#cooling-cells = <2>;
>> +			dynamic-power-coefficient = <140>;
>>  		};
>>  
>>  		A53_3: cpu@103 {
>> @@ -140,6 +151,8 @@
>>  			next-level-cache = <&A53_L2>;
>>  			clocks = <&scpi_dvfs 1>;
>>  			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>> +			#cooling-cells = <2>;
>> +			dynamic-power-coefficient = <140>;
>>  		};
>>  
>>  		A57_L2: l2-cache0 {
>> @@ -167,5 +180,42 @@
>>  				     <&A53_3>;
>>  	};
>>  
>> +	thermal-zones {
>> +		soc_thermal {
>> +			polling-delay = <1000>;
>> +			polling-delay-passive = <100>;
>> +			sustainable-power = <2500>;
>> +
>> +			thermal-sensors = <&scpi_sensors0 3>;
>> +
>> +			trips {
>> +				threshold: trip-point@0 {
>
> You also need a reg= property if you have the @index thing.
>

Having looked at the examples, I don't need to have the @index for the
trip points. I'll update in the next version.

Thanks,
Punit

> Best regards,
> Liviu
>
>> +					temperature = <55000>;
>> +					hysteresis = <1000>;
>> +					type = "passive";
>> +				};
>> +				target: trip-point@1 {
>> +					temperature = <65000>;
>> +					hysteresis = <1000>;
>> +					type = "passive";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&target>;
>> +					cooling-device = <&A53_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +					contribution = <2048>;
>> +				};
>> +				map1 {
>> +					trip = <&target>;
>> +					cooling-device = <&A57_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +					contribution = <1024>;
>> +				};
>> +
>> +			};
>> +		};
>> +	};
>> +
>>  	#include "juno-base.dtsi"
>>  };
>> -- 
>> 2.1.4
>> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
