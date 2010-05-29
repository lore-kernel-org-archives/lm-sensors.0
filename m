From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 29 May 2010 15:33:12 +0000
Subject: Re: [lm-sensors] PMBus support in Linux
Message-Id: <20100529153312.GA20814@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1275063391.2631.137.camel@groeck-laptop>
 <20100529023401.GB12507@pengutronix.de>
 <20100529044239.GA19155@ericsson.com>
 <20100529085301.GA14982@pengutronix.de>
In-Reply-To: <20100529085301.GA14982-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On Sat, May 29, 2010 at 04:53:01AM -0400, Wolfram Sang wrote:
> > If there is no activity yet, question is if I should write individual drivers or 
> > if I should define a PMBus infrastructure on top of i2c/smbus first.
> > Any thoughts on which approach would be more likely to be accepted into the kernel ?
> 
> Did I get this correct: The plan is to support PMBus-devices and let them
> report their data in a hwmon-compatible-way?
> 
Yes.

> (If so, did you already check how well PMBus data maps to the
> hwmon-sysfs-interface?)
> 
Yes. PMBus uses i2c as transport, so it can use the existing i2c/smbus infrastructure. 
Data reported is voltage, temperature, current, power, and fan data as available
from the individual chip. Chips support a chip dependent number of channels.
Values reported are typically in the form of X = Y * 2^N, ie there is a mantissa
and an exponent.

So I would say it maps pretty well; I don't really see a substantial difference
to other HW monitoring chips in that respect. Key difference may be that PMBus devices 
typically also have a control component, but I don't have plans to implement that,
at least not for now.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
