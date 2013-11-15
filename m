From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 Nov 2013 07:20:02 +0000
Subject: Re: [lm-sensors] [PATCH v5 3/3] Documentation: dt: hwmon: add OF document for LM90
Message-Id: <20131115082002.196b4149@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1381137940-22608-1-git-send-email-wni@nvidia.com>
	<1381137940-22608-4-git-send-email-wni@nvidia.com>
	<20131114133320.00ad70c0@endymion.delvare>
	<5285772E.2090700@nvidia.com>
In-Reply-To: <5285772E.2090700-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 15 Nov 2013 09:21:50 +0800, Wei Ni wrote:
> On 11/14/2013 08:33 PM, Jean Delvare wrote:
> > Hi Wei,
> > 
> > On Mon, 7 Oct 2013 17:25:40 +0800, Wei Ni wrote:
> >> Add OF document for LM90 in Documentation/devicetree/.
> ...
> >> +
> >> +Example LM90 node:
> >> +
> >> +temp-sensor {
> >> +	compatible = "onnn,nct1008";
> >> +	reg = <0x4c>;
> >> +	vcc-supply = <&palmas_ldo6_reg>;
> >> +	interrupt-parent = <&gpio>;
> >> +	interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
> >> +}
> > 
> > Looks good to me, just one question: is it OK that interrupt-parent is
> > not described in the document? Is it supposed to be a standard property?
> 
> As Stephen said in this series v3:
> "I believe it's common not to document this, since it's implicitly
> supported as part of any node that is an interrupt source."
> This is a standard property.

Perfect, thanks for the clarification.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
