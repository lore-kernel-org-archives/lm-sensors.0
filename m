From: George Joseph <george.joseph@fairview5.com>
Date: Tue, 08 Jul 2008 00:07:29 +0000
Subject: Re: [lm-sensors] patch: asc7621 driver bug fixes
Message-Id: <1215475649.5795.30.camel@ernie.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <486F7926.6000304@kenm.demon.co.uk>
In-Reply-To: <486F7926.6000304@kenm.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 2008-07-07 at 17:05 -0600, Ken Milmore wrote:
> George,
>=20
> Thanks for incorporating those changes so quickly!
>=20
> I'm afraid I didn't completely understand your new priority list code at
> first glance.  I will have to stare at it a bit longer until it sinks
> in! :-)
>=20
> One thing that comes immediately to mind is that I think this
> table-stuffing should be done right up front, in a call from
> sm_asc7621_init(), not from asc7621_init_client().  Isn't
> asc7621_init_client called once for each aSC7621 *chip* that is
> detected?  If there are several chips (multi-CPU board?), then we don't
> want to repeat the table initialisation for each of them.

Ah.  I hand't even considered multiple chips.  I haven't heard of such
an implementation but you're correct in that I should handle it.  I'll
move it to the module init code.

>=20
> Another minor glitch is that I think you must be adding register address
> 0 to the read lists, even though we don't need it (because 0 appears in
> all the empty entries of the msb and lsb arrays).  I'm sure this can
> easily be worked around, though.

We still need to read it at least once because it has the pwm auto zone
assignments I let the first default 0 in the msb or lsb arrays take care
of it.  If you dump the array after it's loaded you'll see 0x20, 0x13
(in0) then 0x00 (because it's the default of the unused msb/lsb) then
0x21, 0x18 (in1), etc.  That's the only place 0x00 appears.

Am I missing something?

>=20
> Just to look at this from an alternative POV, I knocked up a read-only
> asc7621 mini-driver which doesn't use the table-driven paradigm (see
> patch).  It only supports the main inputs and alarms, but it could be
> very easily extended to cover about 90% of the functionality of the
> driver just by adding the required show_... functions,
> SENSOR_DEVICE_ATTR lines, and register reads.  For the remaining 10%, I
> realise that some of the PWM control knobs would be fiddly to implement,
> as they access bits of registers spattered all over the place.  I
> suppose that is what made you go down the table-driven design route in
> the first place.  Anyway, this is just FYI; I'm not trying to get you to
> alter course if you are happy with the existing design.

It's always that last 10% that gets you. :)

When I started the driver last year, I cloned one of the LM* drivers and
it worked just fine for the basic stuff just by modifying the chip and
manfacturer id.  Then I thought if I'm going to do a driver for this
thing, I probably should expose as much of the chip's functionality as I
could.   With 98 registers to read and 160+ sysfs entries to create
though, =EF=BB=BFI quickly realized it would be impossible to code and main=
tain
the driver using the existing paradigms.  Hence the table driven
approach.  The details of the registers and sysfs entries are all in one
easy-to-read table.

I think at this point the approach will have to stand unless it's going
to prevent acceptance of the driver.  If it is going to be an issue I
think I'm just going to have to give up on it for a while.  I only have
limited windows of time to work on it.

Please keep the comments and critiques coming though!!

george

> Cheers,
>=20
> Ken.
>=20
>=20
> George Joseph wrote:
> > Here's the patch against 2.6.25.10.
> >
> > signed-off-by: George Joseph <George.joseph@fairview5.com>
> >
> > Ken, look at the new implementation of the priority registers.  It's st=
ill a loop initialization but it does get run only once at driver load.  Wi=
th 98 registers of interest, I'm concerned that creating additional static =
arrays will make it hard to figure out what's going on.
> >
> > george
> >
> >
> >> -----Original Message-----
> >> From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-=
sensors.org] On Behalf Of George
> >> Joseph
> >> Sent: Sunday, July 06, 2008 4:18 PM
> >> To: Ken Milmore; Hans de Goede
> >> Cc: lm-sensors@lm-sensors.org
> >> Subject: Re: [lm-sensors] patch: asc7621 driver bug fixes
> >>
> >> New patch will follow tomorrow ( I need to update my build environment=
).  Other comments in line...
> >>
> >>> -----Original Message-----
> >>> From: Ken Milmore [mailto:ken@kenm.demon.co.uk]
> >>> Sent: Sunday, July 06, 2008 10:49 AM
> >>> To: Hans de Goede
> >>> Cc: George Joseph; lm-sensors@lm-sensors.org
> >>> Subject: Re: [lm-sensors] patch: asc7621 driver bug fixes
> >>>
> >>> Hans / George,
> >>>
> >>> Although things are shaping up nicely, I think there is still quite a=
 bit left to do to completely
> >>> review the driver.
> >>>
> >>> The aSC7621 appears to have a lot of bells and whistles for closed lo=
op temperature control etc. and
> >>> George has tried to support as much of this feature set as possible. =
 Unfortunately that means
> >> there's
> >>> quite a lot to review - I haven't really looked at PWM control yet.
> >>>
> >>> In any case, a few more things have come to light:
> >>>
> >>> 1.  In my last posting I wasn't completely sure if my "patch #2" was =
a good idea or not.  Having
> >>> looked at the Andigilog specs, I have become convinced that it will b=
e necessary after all.  The
> >> main
> >>> problem is with the two-byte registers.  To get the read-locking to w=
ork, the MSB and LSB must be
> >> read
> >>> together, one after the other (although it is unimportant which one i=
s read first!).  So it is
> >>> necessary to sequence the reads so that the two-byte registers are ha=
ndled correctly.  My patch will
> >>> correct this problem, although as I have said, I think that other, cl=
eaner solutions may be
> >> possible.
> >>
> >> Yep, my goof.  I thought I had this accounted for but it must have bee=
n in a earlier version of the
> >> driver.  I solved it in the client_init code without creating a static=
 array.  It only gets run once
> >> at module load and it solves the msb-lsb issue.
> >>
> >>> 2.  The voltage scaling used in the driver appears to be slightly off=
 from the nominal values given
> >> in
> >>> the spec.  To get the scaling exactly right, it is necessary to use a=
 "muldiv" scheme which I've
> >>> included in the patch (see below).
> >> Yep, fixed.
> >>
> >>> 3.  I fixed a problem in store_fan16() whereby it wasn't possible to =
set the minimum fan RPM to
> >> zero.
> >>> The aSC7621 explicitly allows this, and of course it is useful to pre=
vent spurious alarms for fans
> >>> which are missing or stopped.
> >> Yep, fixed.
> >>
> >>> The attached patch rolls up all my changes so far.  It applies agains=
t George's original patch of 29
> >>> May.  It includes all the bug fixes from my last submission, the volt=
age scaling and fan fixes
> >>> mentioned above and some tidying up of the high and low priority regi=
ster lists.
> >> All patches applied except for the register priorities and ordering wh=
ich I fixed keeping the existing
> >> paradigm.
> >>
> >>>
> >>> To sum up, by now I'm very happy with the following functions of the =
driver:
> >>>
> >>> * Reading of voltages, fans and temperatures.
> >>>
> >>> * Setting of alarm limits and display of alarms.
> >>>
> >>> The following areas still need to be reviewed and perhaps improved:
> >>>
> >>> * PWM control.  A few scary lookup tables in the code that I don't un=
derstand yet!
> >> Yeah, unfortunately, I can't think of a better way to translate what t=
he chip exposes to the sysfs
> >> specs.  Input definitely welcome.
> >>
> >>> * The miscellaneous configuration knobs (Input selection, PECI config=
 etc).  I haven't tested these.
> >> Actually, pay particular attention to PECI.  On my Conroes and Wolfdal=
es, one of the peci temps
> >> (temp5_input) appears to be the elusive and undocumented Tjmax. :)
> >>
> >>> * I think there is space for improvement in how the low-priority regi=
ster list is handled.  A full
> >>> minute between updates is probably too long.
> >> Easy enough to change.  I was just copying from the other drivers.  Le=
t me know what makes sense.
> >>
> >>> I hope this is of some use.  I will try to look at reviewing the rema=
ining parts of the driver as
> >> time
> >>> allows.
> >> Absolutely.  Keep sending feedback.
> >>
> >>> George, I'd appreciate your feedback on my patches so far; I realise =
you might want to approach some
> >>> of these changes differently to the way I've done them.
> >> Patches are great and I appreciate the time you're putting into the re=
view!!
> >>
> >> george
> >>
> >>
> >>> Best wishes,
> >>>
> >>> Ken.
> >>>
> >>>
> >>> Hans de Goede wrote:
> >>>> Ken Milmore wrote:
> >>>>> George,
> >>>>>
> >>>>> Here are some suggested bug fixes for the asc7621 driver source whi=
ch
> >>>>> you posted to lm_sensors on 29 May.
> >>>>> (http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023257.h=
tm
> >>>>> l)
> >>>>>
> >>>> Thanks for doing this, I promised George to review this driver, but
> >>>> sofar haven't gotten around to doing this. Any chance you could do a
> >>>> complete review of it (or have you already done so, it sure looks th=
at
> >>>> way :)
> >>>>
> >>>> George, I assume you will post a new version of your patch soon with
> >>>> these fixes incorperated?
> >>>>
> >>>> Regards,
> >>>>
> >>>> Hans
> >>>>
> >>
> >> _______________________________________________
> >> lm-sensors mailing list
> >> lm-sensors@lm-sensors.org
> >> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
