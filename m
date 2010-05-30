From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 30 May 2010 15:08:34 +0000
Subject: Re: [lm-sensors] PMBus support in Linux
Message-Id: <20100530150834.GA24472@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1275063391.2631.137.camel@groeck-laptop>
 <20100529023401.GB12507@pengutronix.de>
 <20100529044239.GA19155@ericsson.com>
 <20100529085301.GA14982@pengutronix.de>
 <20100529153312.GA20814@ericsson.com>
 <20100529154741.GB7572@pengutronix.de>
 <20100529171229.GA21284@ericsson.com>
 <20100530041507.GA20222@pengutronix.de>
In-Reply-To: <20100530041507.GA20222-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On Sun, May 30, 2010 at 12:15:07AM -0400, Wolfram Sang wrote:
> > > So, the approach I see (unless I miss something) would be writing an
> > > hwmon-I2C-driver named pmbus-devices.c or so which covers the generic
> > > functionality and provides some hooks for manufacturer extensions, if those are
> > > necessary? (Altough I'd hope a number of devices would be covered by the
> > > generic driver) Makes sense?
> > > 
> > That would be one option. It would require either a register() API call, or a table
> > of supported chips, or a combination of both, to identify how many channels
> > (or pages, in PMBus terminology) per chip are supported and to identify supported
> > objects/registers.
> 
> I am missing the details here, i.e. what data is needed to describe a device
> and is the data static or can it be retrieved/updated at runtime. A decision
> between tables[] or register() or both depends probably on that.
> 
It _may_ be possible to detect the supported commands (ie sensors per page/phase)
reliably using the QUERY command, but I do not feel comfortable doing the same
to determine the number of pages and phases supported.

I'll have to see once I get my hands on actual HW what can be detected reliably 
and what has to be configured.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
