From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 06 Jan 2014 13:51:45 +0000
Subject: Re: [lm-sensors] [PATCHv9 02/20] thermal: introduce device tree parser
Message-Id: <20140106135145.GD21906@e106331-lin.cambridge.arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
 <1384285582-16933-3-git-send-email-eduardo.valentin@ti.com>
 <52C4D612.2090808@nvidia.com>
 <52C5A6CE.5060904@nvidia.com>
In-Reply-To: <52C5A6CE.5060904@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Longnecker <mlongnecker@nvidia.com>
Cc: Wei Ni <wni@nvidia.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, Pawel Moll <Pawel.Moll@arm.com>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jan 02, 2014 at 05:50:06PM +0000, Matthew Longnecker wrote:
> 
> > I think the platform driver may set governor for the thermal zone,
> > so how about to add a property named as "governor",
> > and parse it to tzp->governor_name,
> > something like:
> >                  ret = of_property_read_string(child, "governor", &str);
> >                  if (ret = 0)
> >                          if (strlen(str) < THERMAL_NAME_LENGTH)
> >                                  strcpy(tzp->governor_name, str);
> >
> > Thanks.
> > Wei.
> 
> DT is supposed to describe the hardware, right? The governor isn't 
> hardware -- it's a software control policy. On the other hand, that 
> control policy must be tuned according to the behaviors of the platform 
> hardware otherwise the system will be unstable.
> 
> Is it appropriate to be naming the governor in DT? If so, is it equally 
> appropriate to describe any governor-specific parameters in DT (even 
> though they are pure software constructs)?

The dt should be relatively static -- if the hardware doesn't change the
dt shouldn't have to.

The governers are not static. We can introduce new ones and throw away
old ones at any time. Tuning parameters can also change at any time.

I'd prefer to not have governer details described in the dt, and the
choice of governer and configuration of its tuning parameters should be
made at runtime somehow.

Thanks,
Mark.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
