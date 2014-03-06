From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 06 Mar 2014 17:59:44 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/3] ARM: tegra: dalmore: add thermal zones for nct1008
Message-Id: <5318B790.8090808@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393932664-13319-1-git-send-email-wni@nvidia.com> <1393932664-13319-4-git-send-email-wni@nvidia.com>
In-Reply-To: <1393932664-13319-4-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On 03/04/2014 04:31 AM, Wei Ni wrote:
> Add dt node to describe the thermal zone for the nct1008.

> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts

> +	thermal-zones {
> +		nct1008-local {
> +			polling-delay-passive = <2000>; /* milliseconds */
> +			polling-delay = <0>; /* milliseconds */

A delay of 0 implies that software continually polls this zone, thus
consuming an entire CPU. Is this really what you want?

> +
> +			thermal-sensors = <&nct1008 0>;
> +		};

This zone (and the other) is missing the required (per the binding
documentation) trips and cooling-maps sub-nodes.

I've also sent a query in response to the thermal-zones binding so see
whether or not it can be fixed so that software doesn't bind against the
node name, but rather against a compatible property like almost
everything else. Let's see what the response is there before reposting
this patch.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
