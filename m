From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 12 Dec 2010 23:11:59 +0000
Subject: Re: [lm-sensors] powerX_alarm sysfs attribute
Message-Id: <20101212231159.GA23141@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101209165858.GA521@ericsson.com>
In-Reply-To: <20101209165858.GA521@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 12, 2010 at 04:20:29PM -0500, Jean Delvare wrote:
> On Sun, 12 Dec 2010 13:04:54 -0800, Guenter Roeck wrote:
> > On Sun, Dec 12, 2010 at 03:17:20PM -0500, Jean Delvare wrote:
> > > Which basically means that _cap should have been named _crit. For
> > > example, it is fairly common for temperature sensors to take action
> > > (e.g. speeding up fans or throttling the CPU) when the critical limit
> > > is exceeded. But again, now that it's there, I guess we have to live
> > > with it :(
> > > 
> > For PMBus, I have the following registers
> > 
> > Register		Attribute	Meaning
> > POWER_MAX		powerX_cap	Set enforced maximum power
> > POUT_OP_WARN_LIMIT	powerX_warn	Causes warning that output power is high
> 
> powerX_warn doesn't exist in sysfs-interface. If anything, it should be
> powerX_max, to match the naming of other channel types. I'm not
> claiming these names were the best possible, but consistency is a must
> for that kind of thing.
> 
Sorry, that is what I meant. Fat fingers, and my brain was elsewhere ;).

> > POUT_OP_FAULT_LIMIT	powerX_crit	Causes output overpower fault
> > 					Response is configurable (none, shutdown, retry, disable)
> > 
> > At least in this respect, the meaning of "cap" is different to the meaning of "crit".
> 
> OK. But maybe your powerX_cap should have been powerX_crit and your
> powerX_crit should have been powerX_emergency. What really worries me
> here is that we use different attribute names for power attributes when
> I see no good reason for that.
> 
But there is a difference in meaning, isn't it ? _max, _crit, and _emergency
don't result in changing the output power mode to "limiting", while _cap does.

I see that as essential difference - while _max_, _crit_, and _emerg may cause the 
OS or the chip to shut down, that is still different to a limiting mode, where the
output voltage would be reduced dynamically such that I*V does not exceed the cap. 

> > > As I read it, 1b) is a subset of 1a). 1b) is enough to fix the current
> > > wording, and 1a) can be done if some chips need it.
> >
> > Agreed. PMBus devices have separate flags for all three conditions, so I think
> > I'll introduce powerX_cap_alarm, powerX_max_alarm, and powerX_crit_alarm.
> > 
> > Which reminds me - would it make sense to introduce attributes to be able to configure
> > a reaction to a critical condition ? That would be useful to have for PMBus devices,
> > and some other chips as well - for example, the smm665 also has a configurable reaction
> > to such conditions.
> 
> It would certainly make sense and be useful to at least have read-only
> attributes for this, yes. Letting the user change the behavior seems
> dangerous, but maybe it would be good to have too. But then we have to
> come up with a proper standard for possible actions.
> 
You are right; I might introduce the attributes as read-only at least
for the time being and see if there is any feedback.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
