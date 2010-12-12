From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 12 Dec 2010 21:04:54 +0000
Subject: Re: [lm-sensors] powerX_alarm sysfs attribute
Message-Id: <20101212210454.GA22807@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101209165858.GA521@ericsson.com>
In-Reply-To: <20101209165858.GA521@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 12, 2010 at 03:17:20PM -0500, Jean Delvare wrote:
> On Sun, 12 Dec 2010 11:49:40 -0800, Guenter Roeck wrote:
> > On Sun, Dec 12, 2010 at 12:10:16PM -0500, Jean Delvare wrote:
> > > On Thu, 9 Dec 2010 08:58:58 -0800, Guenter Roeck wrote:
> > > > I see a number of options:
> > > > 
> > > > 1) Introduce powerX_max as unenforced "max" attribute, in addition to powerX_cap.
> > > >    1a) Introduce powerX_cap_alarm to reflect alarms associated with powerX_cap,
> > > >        introduce powerX_max_alarm, and redefine the semantics of powerX_alarm 
> > > >        to include all possible alarms
> > > >    1b) Redefine semantics of powerX_alarm to include all possible reasons for
> > > >        power alarms.
> > > > 
> > > > 2) Redefine the semantics of powerX_cap to include unenforced maximum power.
> > > >    Redefine powerX_alarm to include all possible reasons for alarms.
> > > > 
> > > > My preferred solution would be 1) with 1b), though 2) would be fine for me as well.
> > > > Any thoughts / comments ? 
> > > 
> > > 1) (both a and b) is fine with me. 2) not so, as the _cap name gets
> > > confusing then.
> > > 
> > > I don't think that _cap should have existed in the first place. Just
> > > because something happens when a limit is exceeded is no good reason to
> > > rename that limit to something else. But now that it's there, I guess
> > > it will be difficult to get rid of it.
> > > 
> > The functionality is supported by some devices, though. The PMBus spec has a register
> > to set the power limit, and PMBus devices supporting it are expected to limit power
> > output if the cap is reached. This is in addition to a separate register, which sets the 
> > power max alarm limit (and creates an alarm if that limit is exceeded). So I'll
> > have the need for both _cap and _max.
> 
> Which basically means that _cap should have been named _crit. For
> example, it is fairly common for temperature sensors to take action
> (e.g. speeding up fans or throttling the CPU) when the critical limit
> is exceeded. But again, now that it's there, I guess we have to live
> with it :(
> 
For PMBus, I have the following registers

Register		Attribute	Meaning
POWER_MAX		powerX_cap	Set enforced maximum power
POUT_OP_WARN_LIMIT	powerX_warn	Causes warning that output power is high
POUT_OP_FAULT_LIMIT	powerX_crit	Causes output overpower fault
					Response is configurable (none, shutdown, retry, disable)

At least in this respect, the meaning of "cap" is different to the meaning of "crit".

> As I read it, 1b) is a subset of 1a). 1b) is enough to fix the current
> wording, and 1a) can be done if some chips need it.
> 
Agreed. PMBus devices have separate flags for all three conditions, so I think
I'll introduce powerX_cap_alarm, powerX_max_alarm, and powerX_crit_alarm.

Which reminds me - would it make sense to introduce attributes to be able to configure
a reaction to a critical condition ? That would be useful to have for PMBus devices,
and some other chips as well - for example, the smm665 also has a configurable reaction
to such conditions.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
