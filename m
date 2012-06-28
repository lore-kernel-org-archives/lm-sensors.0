From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 28 Jun 2012 18:57:12 +0000
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Message-Id: <20120628185712.GA20159@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FEA4C10.2060904@googlemail.com>
 <20120627171505.GB12712@roeck-us.net>
 <4FEB90A8.8050901@googlemail.com>
 <20120628052032.GA16364@roeck-us.net>
 <4FEC4092.7090104@googlemail.com>
 <20120628171209.GB7283@roeck-us.net>
 <4FEC96B7.50500@googlemail.com>
In-Reply-To: <4FEC96B7.50500@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Zintakis <michael.zintakis@googlemail.com>
Cc: lm-sensors@lm-sensors.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thu, Jun 28, 2012 at 06:39:03PM +0100, Michael Zintakis wrote:

[ ... ]

> >Problem is most likely that the BIOS does not "kick-start" the fan(s),
> >and the chip does not have a register to set a "start fan" pwm value (other
> >chips such as the NCT677X do have a register for that purpose).
> Yep, that seems to be the case indeed.
> 
> > So you may
> >be stuck with your manual method if you want to keep the fan running at speeds
> >lower than pwm0.
> Would it be possible for such feature to be implemented in the
> f71882fg driver? Most of the stuff which is done with my bash script
> will be very easy to implement in the driver as it involves nothing
> more than playing with the registry values and adding a bit of logic
> to it. Would that be possible?
> 
No, that is not in the scope of a kernel driver. You could use fancontrol(8),
but that would mean you have to switch to manual fan control (from chip
perspective).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
