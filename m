From: Pawel Moll <pawel.moll@arm.com>
Date: Thu, 25 Jul 2013 16:38:14 +0000
Subject: Re: [lm-sensors] RFC: device thermal limits represented in device tree nodes
Message-Id: <1374770294.3213.35.camel@hornet>
List-Id: <lm-sensors.vger.kernel.org>
References: <51ED40E3.5020703@ti.com> <51EF3186.9060001@wwwdotorg.org>
	 <1374664745.25700.118.camel@hornet> <51EFED19.5090900@ti.com>
	 <1374768928.3213.31.camel@hornet>
In-Reply-To: <1374768928.3213.31.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Guenter Roeck <linux@roeck-us.net>, Durgadoss R <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, Wei Ni <wni@nvidia.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2013-07-25 at 17:15 +0100, Pawel Moll wrote:
> > Another way, as I mentioned in the original RFC, an option would be to
> > have the thermal_zone node not embedded in any device node. But them, we
> > would need to firmly link it to other device nodes, to describe what is
> > monitored and what is used for monitoring. 
> 
> You mean the zone nodes would live at the top level of the tree? To my
> mind the root represents the device (the board, whatever you call it),

What I wanted to say was: ... so the zone would still be embedded in a
device node :-)

Pawel



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
