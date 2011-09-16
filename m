From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 16 Sep 2011 19:21:25 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110916212125.4964e938@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 16 Sep 2011 10:48:55 -0700, Guenter Roeck wrote:
> On Fri, 2011-09-16 at 13:00 -0400, Jean Delvare wrote:
> > On Mon, 12 Sep 2011 18:18:00 +0200, Jean Delvare wrote:
> > > On my Core Duo T2600, the output looks like:
> > >=20
> > > coretemp-isa-0000
> > > Core 0:      +54.0=B0C  (high =3D +47.0=B0C, hyst =3D +64.0=B0C)  ALA=
RM
> > >                       (crit =3D +100.0=B0C)
> > > Core 1:      +55.0=B0C  (high =3D +47.0=B0C, hyst =3D +64.0=B0C)  ALA=
RM
> > >                       (crit =3D +100.0=B0C)
> > >=20
> > > High at 47=B0C by default seems unreasonable, and hyst > high even mo=
re
> > > so. But at least the ALARM flags are consistent with these limits.
> >=20
> > BTW, the high and hyst values on this CPU appear to be random. Today
> > they are 89=B0C and 96=B0C. Very odd.
> >=20
> Not initialized, maybe ? Still odd, though.

Worse than this. Reloading the driver changes the values.

I think I finally understood what is going on. The threshold values are
adjusted dynamically based on the measured temperature. This is on
kernel 2.6.32 where the kernel has no clue about these thresholds, so
the only possibility I can think of is that the BIOS is doing it. And
"hyst" is consistently higher than "high", which means that the BIOS has
decided on an opposite convention to what the coretemp driver is doing.

So our driver makes many assumptions which aren't verified in my case:

* The driver shouldn't assume that the threshold values are under his
  sole control. Reading the values once at initialization time and
  never again after that is not correct.

* The driver assumes that threshold0 is higher than threshold1. Looking
  at the SDM, there is no such asymmetry, both thresholds are
  equivalent. So my laptop's BIOS is in its own right when deciding that
  threshold1 is high and threshold0 is low. Given that 0 < 1, their
  decision makes even more sense than ours. It's an IBM/Lenovo Thinkpad
  T60p, a pretty popular series, so we can't just ignore this problem.
  A lot of users will be affected.

* The driver artificially binds the two thresholds by making one the
  _hyst of the other. I see no such relation in the datasheet though,
  both thresholds appear to be completely independent. I know that this
  wasn't Durgadoss' original implementation and we had him change to
  that, but retrospectively this seems to have been a mistake.

I presume that my BIOS leverages the interrupts associated with the
thresholds to do dynamic thermal management, either by fan speed control
or by CPU throttling, or anything else, or a mix of all these.

Durgadoss, please speak up if anything I wrote above isn't correct.

This brings up a question I asked before but never got an answer to,
and it seems I can't find the answer in the SDM either: where are the
interrupts going? Are these by any chance SMIs which the kernel has no
way to deal with?

The first 2 wrong assumptions listed above can easily get fixed. First
one is fixed by always reading the values from the MSR instead of the
cache. Second one is fixed by testing the threshold values at
initialization time to determine which direction the BIOS went with
(might be racy though.)

The last assumption however seems very difficult to fix. It would be
valid to use one of the thresholds as a real low limit (e.g. to enable
a heating system if the system is about to freeze, or more
realistically, to enable turbo mode on low temperatures). In a way
that's what my laptop's BIOS is doing, although the threshold value and
presumably its effect change dynamically.

The fact that each threshold can be used for anything makes it very
difficult to make them fit in our standard hwmon interface. On one
machine the BIOS may expect the temperature to be below both thresholds
when the system is idle, while on others it will expect that the
current temperature is between the thresholds (as is the case on my
laptop.) This means that there is no unique semantics attached to these
thresholds, while our standard interface wants semantics attached
always.

I admit I am not sure how to deal with all this. Suggestions are
welcome. What I'm sure of is that we don't want to let the coretemp
driver in the state it currently is... We will get a flood of user
complaints or at least questions if we do.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
