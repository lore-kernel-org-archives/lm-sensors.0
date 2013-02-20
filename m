From: Wei Ni <wni@nvidia.com>
Date: Wed, 20 Feb 2013 11:53:24 +0000
Subject: Re: [lm-sensors] [RFC PATCH 8/9] ARM: dt: t30 cardhu: add dt entry for thermal driver
Message-Id: <5124B934.3020900@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-9-git-send-email-wni@nvidia.com> <51240A95.9070007@wwwdotorg.org>
In-Reply-To: <51240A95.9070007@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02/20/2013 07:28 AM, Stephen Warren wrote:
> On 02/18/2013 04:30 AM, Wei Ni wrote:
>> Enable thermal driver in the dts file.
>> Set sensor as lm90 remote sensor, and set throttle data.
> 
>> diff --git a/Documentation/devicetree/bindings/thermal/tegra3-thermal.txt b/Documentation/devicetree/bindings/thermal/tegra3-thermal.txt
> 
> The DT documentation should be either a separate patch before the one
> which implements it in the driver, or part of the driver patch. It
> shouldn't be part of the patch which instantiates the binding in the
> board DT file.

Ok, I will do it.

> 
>> +* Nvidia Tegra30 Thermal
> 
> NVIDIA is all capitals.

Got it.

> 
> It seems like a word is missing: Thermal Management? Control/Zone?

It's better to use "NVIDIA Tegra30 Thermal Zone".

> 
>> +** Thermal node properties:
>> +
>> +- compatible : "nvidia,tegra30-thermal";
>> +- sensors: the sensor device node which we want to use in the thermal zone,
>> +  the arguments is the index of the sensor in sensor device node;
> 
> The arguments should be defined by the DT binding documentation for that
> referenced device, not by the referencing device.
> 
> DT properties that are custom defined for this binding should include
> the vendor prefix in their name. So, that'd be "nvidia,sensors". This
> may apply less if a "sensors" becomes a more generic standard, but it
> surely applies to all the other properties below.

So these properties should be introduced in the DT binding documentation
of the thermal framework.

> 
>> +- passive-delay: passive delay;
> 
> What does this mean?

This is used for the thermal framework. As you said, this should be
introduced with the framework.

> 
>> +- num-passive-trips : number of passive trip points, this is required, set
>> +  it 0 if none, if greater than 0, the following properties must be defined;
>> +- passive-trips : temperature of passive trip points;
> 
> Presumably "num-passive-trips" can be calculated simply by counting the
> number of entries in "passive-trips"?

Oh, yes, I can remove it.

> 
> Please describe what passive and active trips are; someone who just
> reads this binding document (perhaps in conjunction with some HW
> documentation and/or other binding documentation) should be able to fill
> in this binding without other knowledge.

Durgadoss's patches introduced these value in the framework
documentation, but he didn't touch the DT. So I will add it.

> 
>> +- num-active-trips: number of active trip points, this is required, set
>> +  it 0 if none, if greater than 0, the following properties must be defined;
>> +- active-trips: temperature of active trip points;
> 
> Both comments above apply here too.
> 
>> +- throt-tab-size: size of the throttle table, it's the max cooling state.
>> +- throt-tab: throttle table. the cooling state will be defined according to
>> +  this table.
> 
> Both comments above apply here too.
> 
> Also, what units are used for all these properties?

they use "int".
And according to our downstream dvfs driver, the throttle table use
"unsigned long".

> 
> Judging by the example below, this property is a list of tuples. The
> meaning of each field in the tuple needs to be explained.
> 
> What happens when the CPU/SoC needs to be throttled? Must some clock or
> voltage be lowered/limited? If so, you need properties that indicate
> which clock/voltage/... needs to be acted upon.

This table which will be used by our DVFS driver, although it didn't be
upstreamed yet. The table set clock frequency limited value with
different cooling state. When the temperature touch the different
limited value, we will set difficult cooling state, find the limited
freq from this table and pass to the dvfs driver.
I think may be this table should be set for cooling device node. This
table is only for our tegra dvfs, so I think we can parse this table in
the tegra3_cooling.c, which will be the new driver for cooling device.

> 
>> +Usually these properties are separated in board related dts files.
> 
> That's not really relevant.

Ok.

> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
