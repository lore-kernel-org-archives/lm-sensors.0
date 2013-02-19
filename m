From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 19 Feb 2013 23:28:21 +0000
Subject: Re: [lm-sensors] [RFC PATCH 8/9] ARM: dt: t30 cardhu: add dt entry for thermal driver
Message-Id: <51240A95.9070007@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-9-git-send-email-wni@nvidia.com>
In-Reply-To: <1361187031-3679-9-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TZX6JHB/w77yyCwEArCW2h5@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On 02/18/2013 04:30 AM, Wei Ni wrote:
> Enable thermal driver in the dts file.
> Set sensor as lm90 remote sensor, and set throttle data.

> diff --git a/Documentation/devicetree/bindings/thermal/tegra3-thermal.txt b/Documentation/devicetree/bindings/thermal/tegra3-thermal.txt

The DT documentation should be either a separate patch before the one
which implements it in the driver, or part of the driver patch. It
shouldn't be part of the patch which instantiates the binding in the
board DT file.

> +* Nvidia Tegra30 Thermal

NVIDIA is all capitals.

It seems like a word is missing: Thermal Management? Control/Zone?

> +** Thermal node properties:
> +
> +- compatible : "nvidia,tegra30-thermal";
> +- sensors: the sensor device node which we want to use in the thermal zone,
> +  the arguments is the index of the sensor in sensor device node;

The arguments should be defined by the DT binding documentation for that
referenced device, not by the referencing device.

DT properties that are custom defined for this binding should include
the vendor prefix in their name. So, that'd be "nvidia,sensors". This
may apply less if a "sensors" becomes a more generic standard, but it
surely applies to all the other properties below.

> +- passive-delay: passive delay;

What does this mean?

> +- num-passive-trips : number of passive trip points, this is required, set
> +  it 0 if none, if greater than 0, the following properties must be defined;
> +- passive-trips : temperature of passive trip points;

Presumably "num-passive-trips" can be calculated simply by counting the
number of entries in "passive-trips"?

Please describe what passive and active trips are; someone who just
reads this binding document (perhaps in conjunction with some HW
documentation and/or other binding documentation) should be able to fill
in this binding without other knowledge.

> +- num-active-trips: number of active trip points, this is required, set
> +  it 0 if none, if greater than 0, the following properties must be defined;
> +- active-trips: temperature of active trip points;

Both comments above apply here too.

> +- throt-tab-size: size of the throttle table, it's the max cooling state.
> +- throt-tab: throttle table. the cooling state will be defined according to
> +  this table.

Both comments above apply here too.

Also, what units are used for all these properties?

Judging by the example below, this property is a list of tuples. The
meaning of each field in the tuple needs to be explained.

What happens when the CPU/SoC needs to be throttled? Must some clock or
voltage be lowered/limited? If so, you need properties that indicate
which clock/voltage/... needs to be acted upon.

> +Usually these properties are separated in board related dts files.

That's not really relevant.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
