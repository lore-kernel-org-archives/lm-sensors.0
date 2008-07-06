From: George Joseph <George.Joseph@fairview5.com>
Date: Sun, 06 Jul 2008 22:18:28 +0000
Subject: Re: [lm-sensors] patch: asc7621 driver bug fixes
Message-Id: <F087D2902E92CF4FAB25626A04CD5DA849312598E4@s0.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <486F7926.6000304@kenm.demon.co.uk>
In-Reply-To: <486F7926.6000304@kenm.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

New patch will follow tomorrow ( I need to update my build environment).  Other comments in line...

> -----Original Message-----
> From: Ken Milmore [mailto:ken@kenm.demon.co.uk]
> Sent: Sunday, July 06, 2008 10:49 AM
> To: Hans de Goede
> Cc: George Joseph; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] patch: asc7621 driver bug fixes
>
> Hans / George,
>
> Although things are shaping up nicely, I think there is still quite a bit left to do to completely
> review the driver.
>
> The aSC7621 appears to have a lot of bells and whistles for closed loop temperature control etc. and
> George has tried to support as much of this feature set as possible.  Unfortunately that means there's
> quite a lot to review - I haven't really looked at PWM control yet.
>
> In any case, a few more things have come to light:
>
> 1.  In my last posting I wasn't completely sure if my "patch #2" was a good idea or not.  Having
> looked at the Andigilog specs, I have become convinced that it will be necessary after all.  The main
> problem is with the two-byte registers.  To get the read-locking to work, the MSB and LSB must be read
> together, one after the other (although it is unimportant which one is read first!).  So it is
> necessary to sequence the reads so that the two-byte registers are handled correctly.  My patch will
> correct this problem, although as I have said, I think that other, cleaner solutions may be possible.

Yep, my goof.  I thought I had this accounted for but it must have been in a earlier version of the driver.  I solved it in the client_init code without creating a static array.  It only gets run once at module load and it solves the msb-lsb issue.

>
> 2.  The voltage scaling used in the driver appears to be slightly off from the nominal values given in
> the spec.  To get the scaling exactly right, it is necessary to use a "muldiv" scheme which I've
> included in the patch (see below).

Yep, fixed.

>
> 3.  I fixed a problem in store_fan16() whereby it wasn't possible to set the minimum fan RPM to zero.
> The aSC7621 explicitly allows this, and of course it is useful to prevent spurious alarms for fans
> which are missing or stopped.

Yep, fixed.

>
> The attached patch rolls up all my changes so far.  It applies against George's original patch of 29
> May.  It includes all the bug fixes from my last submission, the voltage scaling and fan fixes
> mentioned above and some tidying up of the high and low priority register lists.

All patches applied except for the register priorities and ordering which I fixed keeping the existing paradigm.

>
>
> To sum up, by now I'm very happy with the following functions of the driver:
>
> * Reading of voltages, fans and temperatures.
>
> * Setting of alarm limits and display of alarms.
>
> The following areas still need to be reviewed and perhaps improved:
>
> * PWM control.  A few scary lookup tables in the code that I don't understand yet!

Yeah, unfortunately, I can't think of a better way to translate what the chip exposes to the sysfs specs.  Input definitely welcome.

>
> * The miscellaneous configuration knobs (Input selection, PECI config etc).  I haven't tested these.

Actually, pay particular attention to PECI.  On my Conroes and Wolfdales, one of the peci temps (temp5_input) appears to be the elusive and undocumented Tjmax. :)

>
> * I think there is space for improvement in how the low-priority register list is handled.  A full
> minute between updates is probably too long.

Easy enough to change.  I was just copying from the other drivers.  Let me know what makes sense.

>
> I hope this is of some use.  I will try to look at reviewing the remaining parts of the driver as time
> allows.

Absolutely.  Keep sending feedback.

>
> George, I'd appreciate your feedback on my patches so far; I realise you might want to approach some
> of these changes differently to the way I've done them.

Patches are great and I appreciate the time you're putting into the review!!

george


>
> Best wishes,
>
> Ken.
>
>
> Hans de Goede wrote:
> > Ken Milmore wrote:
> >> George,
> >>
> >> Here are some suggested bug fixes for the asc7621 driver source which
> >> you posted to lm_sensors on 29 May.
> >> (http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023257.htm
> >> l)
> >>
> >
> > Thanks for doing this, I promised George to review this driver, but
> > sofar haven't gotten around to doing this. Any chance you could do a
> > complete review of it (or have you already done so, it sure looks that
> > way :)
> >
> > George, I assume you will post a new version of your patch soon with
> > these fixes incorperated?
> >
> > Regards,
> >
> > Hans
> >
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
