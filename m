From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 29 May 2010 17:12:29 +0000
Subject: Re: [lm-sensors] PMBus support in Linux
Message-Id: <20100529171229.GA21284@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1275063391.2631.137.camel@groeck-laptop>
 <20100529023401.GB12507@pengutronix.de>
 <20100529044239.GA19155@ericsson.com>
 <20100529085301.GA14982@pengutronix.de>
 <20100529153312.GA20814@ericsson.com>
 <20100529154741.GB7572@pengutronix.de>
In-Reply-To: <20100529154741.GB7572-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On Sat, May 29, 2010 at 11:47:41AM -0400, Wolfram Sang wrote:
> 
> > Yes. PMBus uses i2c as transport, so it can use the existing i2c/smbus infrastructure. 
> > Data reported is voltage, temperature, current, power, and fan data as available
> > from the individual chip. Chips support a chip dependent number of channels.
> > Values reported are typically in the form of X = Y * 2^N, ie there is a mantissa
> > and an exponent.
> > 
> > So I would say it maps pretty well; I don't really see a substantial difference
> > to other HW monitoring chips in that respect. Key difference may be that PMBus devices 
> > typically also have a control component, but I don't have plans to implement that,
> > at least not for now.
> 
> I just had a glimpse, but I came to a similar conclusion. As I further
> understood, PMBus devices support a standard range of commands with the
> possibility of manufacturer extenstions.
> 
> So, the approach I see (unless I miss something) would be writing an
> hwmon-I2C-driver named pmbus-devices.c or so which covers the generic
> functionality and provides some hooks for manufacturer extensions, if those are
> necessary? (Altough I'd hope a number of devices would be covered by the
> generic driver) Makes sense?
> 
That would be one option. It would require either a register() API call, or a table
of supported chips, or a combination of both, to identify how many channels
(or pages, in PMBus terminology) per chip are supported and to identify supported
objects/registers.

The other option would be to write separate drivers (one for each chip) and not provide
a common infrastructure. Not sure if that is a good idea, though; I personally prefer
the first option.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
