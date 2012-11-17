From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Sat, 17 Nov 2012 09:19:34 +0000
Subject: Re: [lm-sensors] Getting alarms using lm-sensors
Message-Id: <201211170919.qAH9JZBR009498@mx3.lsn.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201211160616.qAG6GnV2010183@mx3.lsn.net>
In-Reply-To: <201211160616.qAG6GnV2010183@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Saturday, November 17, 2012 2:13 AM
> To: Leslie Rhorer
> Cc: 'Guenter Roeck'; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] Getting alarms using lm-sensors
>=20
> On Fri, 16 Nov 2012 22:45:05 -0600, Leslie Rhorer wrote:
> > > > > > SB:                 +1.30 V  (min =3D  +0.99 V, max =3D  +1.21 =
V)
> >
> > > > > > MB Temperature:     +45.0=B0C  (high =3D +45.0=B0C, crit =3D +9=
5.0=B0C)
> >
> >
> > > k10temp is the AMD CPU temperature as reported by the CPU itself. It
> isn't
> > > really accurate. acpitz-virtual is, as the name says, a virtual
> device.
> > > acpitx is short for "ACPI thermal zone". It may also reflect the CPU
> > > temperature, but I don't know for sure.
> > >
> > > Guenter
> >
> > 	OK, thanks once again.  I guess I will ignore them.  I hope you
> > don't mind me asking all these questions, but I do have a couple more.
> Note
> > the two reports above.  Where is the sensors routine getting its limit
> > values?  Both the SouthBridge voltage and the chip array temperature are
> > reported out of bounds, yet I am not overclocking, at all.  The manual
> says
> > the motherboard offers legitimate OC values of 1.10, 1.12, 1.14, 1.16,
> 2.98,
> > and 3.00 VDC.  Given that, I shouldn't think 1.3V would be out of
> bounds.
>=20
> The limits are set by the BIOS itself. Note that ATK0110 is a virtual

	"Limits" in terms of what?  The chip apparently does not have any
alarming capability.  Do you mean the text is produced by the BIOS?  Odd,
indeed, if so, since the text inside the BIOS utility is quite different.

> Given that (0.99 + 1.21) / 2 =3D 1.10, it seems clear to me that the
> nominal value for SB is supposed to be 1.10 V. This is also in line
> with the documented OC values of 1.10, 1.12, 1.14 and 1.16 V. The

	The documentation just takes a shortcut.  There are a ton of
available values in the setup utility, starting with 1.10V and going al the
way to 3.0V in .02V increments.  I did select a value of 1.24V in the BIOS,
but the output of `sensors` does not reflect any change.  That may be
because overclocking is disabled, however.

> documented values of 2.98 and 3.00 V OTOH are odd... You never
> overclock a nominal voltage to more than +25%. I can't actually believe
> that your BIOS offers to overclock +1.10V to +3.00V.

Those are the selectable values.


> So it is well possible that you have a real problem here. It would be
> interesting to see if another user with the same board sees similar
> values. If not, maybe your PSU has an issue or you have wrong settings
> in your BIOS. You may also look for a BIOS update, as the ATK0110 ACPI
> code comes with the BIOS.

The latest BIOS released by the manufacturer is installed - 2702 released
05/30/2011.  It is an Asus Crosshair II Formula motherboard.

> This is an UTF8 vs. non-UTF8 issue. You are running "sensors" with an

I thought it was something like that.

> UTF8 locale, but the e-mail you send apparently lacks proper encoding
> information. This can be solved in two ways: either set the locale to
> non-UTF8 when you run "sensors" (LANG=3Den_US sensors), or add some
> encoding parameter to the mail command (my version claims utf-8 to be
> the default but apparently that's not your case.)

I don't see anything obvious in the man page, but I will look through the
config files, or perhaps I can specify the language coding when I run mail.
OTOH, in actuality, the use of the degree symbol is incorrect.  The term
45.0=B0C implies a DIFFERENCE in temperature of 45=B0C between two bodies. =
 The
absolute temperature is referenced as 45C.  Thus, there is a huge difference
between 45C and 45K (273.15=B0), but 45=B0C and 45=B0K mean precisely the s=
ame
thing.

Anyway, thanks, again.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
