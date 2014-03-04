From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 04 Mar 2014 22:23:57 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/3] ARM: tegra: dalmore: add thermal zones for nct1008
Message-Id: <20140304222357.GA6125@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393932664-13319-1-git-send-email-wni@nvidia.com>
 <1393932664-13319-4-git-send-email-wni@nvidia.com>
 <53164E78.5010708@wwwdotorg.org>
In-Reply-To: <53164E78.5010708-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Tue, Mar 04, 2014 at 03:06:48PM -0700, Stephen Warren wrote:
> On 03/04/2014 04:31 AM, Wei Ni wrote:
> > Add dt node to describe the thermal zone for the nct1008.
> > 
> > Change-Id: I0256836e52d73ec282574e4fd91df52958936e35
> 
> ???????
> 
I think this is for one of those open-source sites out there
which count open source contributions. Not Ohloh, but similar.
You have to specify that Change-Id to have it associate your
name with the patch.

Guenter

> > diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
> 
> > +	thermal-zones {
> > +		nct1008-local {
> > +			polling-delay-passive = <2000>; /* milliseconds */
> 
> Nothing can possible make use of this node, since there's no compatible
> value or anything else like that to bind a driver to it.
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
