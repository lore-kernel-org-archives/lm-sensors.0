From: Tony Lindgren <tony@atomide.com>
Date: Wed, 10 Aug 2011 12:41:02 +0000
Subject: Re: [lm-sensors] [RFC PATCH 4/6] OMAP4: Temperature sensor device
Message-Id: <20110810124102.GM1939@atomide.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
 <1312979122-5896-5-git-send-email-j-keerthy@ti.com>
 <20110810123647.GF12882@legolas.emea.dhcp.ti.com>
In-Reply-To: <20110810123647.GF12882@legolas.emea.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Felipe Balbi <balbi@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com

* Felipe Balbi <balbi@ti.com> [110810 05:31]:
> 
> On Wed, Aug 10, 2011 at 05:55:20PM +0530, Keerthy wrote:
> > +
> > +int __init omap_devinit_temp_sensor(void)
> > +{
> > +	if (!cpu_is_omap446x())
> > +		return 0;
> > +
> > +	return omap_hwmod_for_each_by_class("temperature_sensor",
> > +			temp_sensor_dev_init, NULL);
> > +}
> > +
> > +arch_initcall(omap_devinit_temp_sensor);
> 
> I really dislike people adding more and more *initcall() to their pieces
> of code. But Tony is the final Judge.

Yes how about making this just a regular device driver and have it
live under drivers/ somewhere?

Or is there some reason why this could not be a loadable module?

Regards,

Tony

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
