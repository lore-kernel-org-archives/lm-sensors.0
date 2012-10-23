From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Oct 2012 07:14:23 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <20121023091423.5b58e5cf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 22 Oct 2012 14:40:00 -0700, Guenter Roeck wrote:
> On Mon, Oct 22, 2012 at 05:03:45PM +0200, Harald Judt wrote:
> > Hi,
> >=20
> > After resuming from suspend or hibernation, the Vbat value is
> > reported to be 0.0. Before that, it reported the correct value.
> > Min/max values are wrong too.
> >=20
> > Linux-3.6.2, ASRock Z77 Extreme4 BIOS v1.80.
> >=20
> > Before suspend:
> > nct6776-isa-0290
> > Adapter: ISA adapter
> > Vcore:         +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > in1:           +1.84 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > AVCC:          +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > +3.3V:         +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > in4:           +1.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > in5:           +1.68 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > 3VSB:          +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> > Vbat:          +3.31 V  (min =3D  +2.70 V, max =3D  +3.63 V)
> > fan1:            0 RPM  (min =3D    0 RPM)  ALARM
> > fan2:         1289 RPM  (min =3D    0 RPM)  ALARM
> > fan3:          724 RPM  (min =3D    0 RPM)  ALARM
> > fan4:          661 RPM  (min =3D    0 RPM)  ALARM
> > fan5:         1076 RPM  (min =3D    0 RPM)  ALARM
> > SYSTIN:        +37.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALA=
RM
> > sensor =3D thermistor
> > CPUTIN:        +28.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D
> > thermistor
> > AUXTIN:        +33.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D
> > thermistor
> > PECI Agent 0:  +32.0=B0C
> > cpu0_vid:     +0.000 V
> > intrusion0:   ALARM
> > intrusion1:   ALARM
> >=20
> > After resuming:
> > nct6776-isa-0290
> > Adapter: ISA adapter
> > Vcore:         +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > in1:           +1.84 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > AVCC:          +3.34 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > +3.3V:         +3.34 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > in4:           +1.03 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > in5:           +1.68 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > 3VSB:          +3.47 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > Vbat:          +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
> > fan1:            0 RPM  (min =3D    0 RPM)  ALARM
> > fan2:         1271 RPM  (min =3D    0 RPM)  ALARM
> > fan3:          734 RPM  (min =3D    0 RPM)  ALARM
> > fan4:          673 RPM  (min =3D    0 RPM)  ALARM
> > fan5:         1093 RPM  (min =3D    0 RPM)  ALARM
> > SYSTIN:        +36.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALA=
RM
> > sensor =3D thermistor
> > CPUTIN:        +26.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D
> > thermistor
> > AUXTIN:        +33.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D
> > thermistor
> > PECI Agent 0:  +30.0=B0C
> > cpu0_vid:     +0.000 V
> > intrusion0:   ALARM
> > intrusion1:   ALARM
> >=20
> > Reloading the module helps. Of course, a fresh boot too ;-)

Reloading the module shouldn't help for limits, they are set by
user-space. Reloading the lm_sensors service instead should help.

Vbat is indeed enabled by the driver at device bind time, as well as a
few other things. In your case you report battery monitoring missing,
but other settings may be broken, for example temperature monitoring
could be stuck or overall monitoring could be disabled. Do all values
(other than Vbat) change as before? The exact effects really depend on
what the BIOS is doing to the chip at boot time and resume time.

> The driver doesn't implement suspend/resume support, so it is not very
> surprising that the limits get lost - and it looks like vbat monitoring
> is disabled by default, so that gets lost as well.
>=20
> Someone would have to submit a patch to add suspend/resume support to
> the driver ... any takers out there ?

I've been pondering this for a long time. Adding support for limit
saving and restoring to all hwmon drivers would be a significant amount
of code. An easier workaround would be to run "sensors -s" after
resume. This is what I had suggested here:
  https://bugzilla.novell.com/show_bug.cgi?id=3D580988#c3

However I am not totally happy with this either, because 1* relying on
user-space for anything related to hardware monitoring or fan control
always makes me feel a little nervous, 2* there is no guarantee that
the chip limits at suspend time match the libsensors configuration
files and 3* there are a few other settings which aren't covered by the
libsensors configuration files.

For 1* I suppose it can't be worse than the current situation where we
don't do anything at all at resume time. For 2* it should be correct in
99% of the cases. 3* is the real problem, for example if the user has a
custom script at initialization time to alter fan speeds, etc.

That being said, I'm not sure how many monitoring chips actually lose
their configuration at suspend time. My initial assumption was "most of
them" but if that was the case I presume we would have received many
more complaints than we did. The other report I had was also about a
Winbond Super-I/O chip, and these chips have an area named "Value RAM",
as opposed to actual registers. I would bet this is the part which is
lost on suspend.

So it could be that only drivers for Winbond/Nuvoton drivers need to be
taught how to save and restore values at suspend/resume. Well this is 9
drivers still, but this is only a small percentage of the whole driver
set. Plus the "Value RAM" is a contiguous area so saving and restoring
it should be very easy. I'll give it a try.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
