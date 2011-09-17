From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 17 Sep 2011 16:09:04 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110917160904.GA20709@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 17, 2011 at 08:00:21AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Fri, 16 Sep 2011 12:40:34 -0700, Guenter Roeck wrote:
> > On Fri, 2011-09-16 at 15:21 -0400, Jean Delvare wrote:
> > > So our driver makes many assumptions which aren't verified in my case:
> > > 
> > > * The driver shouldn't assume that the threshold values are under his
> > >   sole control. Reading the values once at initialization time and
> > >   never again after that is not correct.
> > > 
> > > * The driver assumes that threshold0 is higher than threshold1. Looking
> > >   at the SDM, there is no such asymmetry, both thresholds are
> > >   equivalent. So my laptop's BIOS is in its own right when deciding that
> > >   threshold1 is high and threshold0 is low. Given that 0 < 1, their
> > >   decision makes even more sense than ours. It's an IBM/Lenovo Thinkpad
> > >   T60p, a pretty popular series, so we can't just ignore this problem.
> > >   A lot of users will be affected.
> > > 
> > > * The driver artificially binds the two thresholds by making one the
> > >   _hyst of the other. I see no such relation in the datasheet though,
> > >   both thresholds appear to be completely independent. I know that this
> > >   wasn't Durgadoss' original implementation and we had him change to
> > >   that, but retrospectively this seems to have been a mistake.
> > > 
> > Do you have a better idea ? In the context, the lower threshold was
> > supposed to be used to turn off thermal throttling, which in my
> > understanding matches the semantics of _hyst - ie it is the value at
> > which an alarm is turned off.
> 
> This was a driver decision, as the hardware doesn't put semantics on
> the limits. And that was not a bad decision per se, it would be OK if
> the driver had full control over the thresholds and interrupts, but as
> it turns out, that won't be the case on every machine.
> 
Agreed.

> > > I presume that my BIOS leverages the interrupts associated with the
> > > thresholds to do dynamic thermal management, either by fan speed control
> > > or by CPU throttling, or anything else, or a mix of all these.
> > > 
> > > Durgadoss, please speak up if anything I wrote above isn't correct.
> > > 
> > > This brings up a question I asked before but never got an answer to,
> > > and it seems I can't find the answer in the SDM either: where are the
> > > interrupts going? Are these by any chance SMIs which the kernel has no
> > > way to deal with?
> > > 
> > Looks like the BIOS would get those interrupts, at least on your
> > system ? Some entity must change the register contents, after all.
> 
> Yes, that's my guess as well.
> 
> > > The first 2 wrong assumptions listed above can easily get fixed. First
> > > one is fixed by always reading the values from the MSR instead of the
> > > cache. Second one is fixed by testing the threshold values at
> > > initialization time to determine which direction the BIOS went with
> > > (might be racy though.)
> > > 
> > > The last assumption however seems very difficult to fix. It would be
> > > valid to use one of the thresholds as a real low limit (e.g. to enable
> > > a heating system if the system is about to freeze, or more
> > > realistically, to enable turbo mode on low temperatures). In a way
> > > that's what my laptop's BIOS is doing, although the threshold value and
> > > presumably its effect change dynamically.
> > > 
> > > The fact that each threshold can be used for anything makes it very
> > > difficult to make them fit in our standard hwmon interface. On one
> > > machine the BIOS may expect the temperature to be below both thresholds
> > > when the system is idle, while on others it will expect that the
> > > current temperature is between the thresholds (as is the case on my
> > > laptop.) This means that there is no unique semantics attached to these
> > > thresholds, while our standard interface wants semantics attached
> > > always.
> > > 
> > > I admit I am not sure how to deal with all this. Suggestions are
> > > welcome. What I'm sure of is that we don't want to let the coretemp
> > > driver in the state it currently is... We will get a flood of user
> > > complaints or at least questions if we do.
> >
> > Me not either ... I did not expect that a "third party" would access and
> > use the values. Sounds almost as bad as the ACPI interaction with some
> > of the drivers.
> 
> Not really. Actually it sounds quite sane that the OS is not
> responsible for thermal safety of the system. It's definitely the job
> of the hardware itself, or failing that, the BIOS. Of course I would

Maybe, but I don't think we can assume or expect that this is always
the case either.

> prefer if the BIOS could just program a monitoring chip at boot time
> and leave it alone after that, but on a laptop with no such smart
> hardware monitoring chip, it makes some sense to use tricks like this.
> 
> As with ACPI interaction, the real problem isn't the BIOS poking at the
> hardware... The problem is that we often don't know if it does or not.
> 
> > Given that we don't know how the BIOS (or some other entity) uses the
> > limits, one possible solution that comes to my mind would be to extend
> > the ABI to specifically permit non-specific threshold attributes (such
> > as tempX_thresholdY). Not sure if that is a good idea, though.
> 
> This was more or less my conclusion after writing my report yesterday
> evening. Just like you, I am not sure if it is a good idea. It's always
> difficult to come up with an abstracted interface when we have a single
> device implementing it for now (although I seem to remember a recent
> new driver where 4 thresholds were needed?)
> 
Those were directional attributes, though, with a clear notion of
"triggered if value exceeds threshold or reaches it from below".

> But anyway, the current state of the coretemp driver is simply not
> good, so we have to do something. Short of a better proposal, I'd say
> yes, let's go with tempX_threshold[0-7] and their associated alarms.
> 
Alarms is tricky. Keep in mind that those thresholds are non-directional and 
trigger each time the temperature is reached, from above or from below.
Unless relationship between the threshold is well defined, such as with
<hyst, max> as we tried before, an "alarm" attribute on a single threshold
does not have a well defined meaning. An attribute named "triggered"
or similar might make more sense - something that causes a notification
if triggered and auto-resets after being read.

Still, with Durgadoss' other email, I am not sure I like where this is going.
I thought the idea was to trigger interrupts which would result in a notification
on the alarm attribute. As it is, it looks like the idea is to have the
interrupts handled by arch/x86/kernel/cpu/mcheck/therm_throt.c. If so,
I think it might be better to handle thresholds completely in the thermal
throttling code.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
