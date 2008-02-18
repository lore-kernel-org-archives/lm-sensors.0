From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Feb 2008 19:50:38 +0000
Subject: Re: [lm-sensors] adt7475 support (Asus M2N-SLI Deluxe)
Message-Id: <20080218205038.59618602@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0801211406570.32720@birdbird.example.com>
In-Reply-To: <Pine.LNX.4.64.0801211406570.32720@birdbird.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Artur,

On Mon, 18 Feb 2008 20:01:09 +0100, Artur Szymiec wrote:
> Hans de Goede pisze:
> > Artur Szymiec wrote:
> >> Jordan Crouse pisze:
> >>> On 13/02/08 17:53 +0100, Artur Szymiec wrote:
> >>> =20
> >>>> Hello,
> >>>>
> >>>> I have a M2N-SLI Deluxe motherboard and
> >>>> i'm testing the Jordan Crouse patch
> >>>> (http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/02233=
8.html).
> >>>>
> >>>> Results from running sensors:
> >>>>
> >>>> 1st result:
> >>>> ADT7475-i2c-1-2e
> >>>> Adapter: SMBus nForce2 adapter at 1c40
> >>>> vccp:        +0.00 V  (min =3D  +0.00 V, max =3D  +2.99 V)   ALARM
> >>>> vcc:         +3.27 V  (min =3D  +0.00 V, max =3D  +4.28 V)
> >>>> Chasis 2:   2304 RPM  (min =3D  900 RPM)
> >>>> fan2:          0 RPM  (min =3D    0 RPM)
> >>>> fan3:          0 RPM  (min =3D    0 RPM)
> >>>> fan4:          0 RPM  (min =3D    0 RPM)
> >>>> remote1:       FAULT  (low  =3D -63.0=B0C, high =3D +191.0=B0C)  ALA=
RM
> >>>> local:       +42.5=B0C  (low  =3D +10.0=B0C, high =3D +45.0=B0C)
> >>>> remote2:       FAULT  (low  =3D -63.0=B0C, high =3D +191.0=B0C)  ALA=
RM
> >>>>
> >>>> 2nd result:
> >>>> ADT7475-i2c-1-2e
> >>>> Adapter: SMBus nForce2 adapter at 1c40
> >>>> vccp:        +0.00 V  (min =3D  +0.00 V, max =3D  +2.99 V)   ALARM
> >>>> vcc:         +3.27 V  (min =3D  +0.00 V, max =3D  +4.28 V)
> >>>> Chasis 2:   105882 RPM  (min =3D  900 RPM)
> >>>> fan2:          0 RPM  (min =3D    0 RPM)
> >>>> fan3:          0 RPM  (min =3D    0 RPM)
> >>>> fan4:          0 RPM  (min =3D    0 RPM)
> >>>> remote1:       FAULT  (low  =3D -63.0=B0C, high =3D +191.0=B0C)  ALA=
RM
> >>>> local:       +42.5=B0C  (low  =3D +10.0=B0C, high =3D +45.0=B0C)
> >>>> remote2:       FAULT  (low  =3D -63.0=B0C, high =3D +191.0=B0C)  ALA=
RM
> >>>>
> >>>> Comment:
> >>>> The results 1 and 2 are from running the sensors command one by one
> >>>> with 3 sec delay between them.
> >>>> So obviously reading from fan1 (label Chassis 2) are not correct.
> >>>> Tested with kernel 2.6.24.
> >>>>    =20
> >>> Thats unfortunate.  Is the problem easily reproducible?  Does the
> >>> bogus fan value remain forever or does it go back to a sane value
> >>> on the next read?
> >>>
> >>> Jordan
> >>>
> >>>  =20
> >> Well I discovered today that
> >> this is not the ADT7475 driver but it's more general problem.
> >>
> >> Look at these:
> >>
> >> it8716-isa-0290
> >> Adapter: ISA adapter
> >> VCore:       +1.22 V  (min =3D  +4.08 V, max =3D  +4.08 V)
> >> VDDR:        +3.20 V  (min =3D  +4.08 V, max =3D  +4.08 V)
> >> +3.3V:       +0.00 V  (min =3D  +4.08 V, max =3D  +4.08 V)
> >> +5V:         +4.76 V  (min =3D  +6.85 V, max =3D  +6.85 V)
> >> +12V:       +11.46 V  (min =3D +16.32 V, max =3D +16.32 V)
> >> in5:         +0.00 V  (min =3D  +4.08 V, max =3D  +4.08 V)
> >> in6:         +0.00 V  (min =3D  +4.08 V, max =3D  +4.08 V)
> >> 5VSB:        +4.70 V  (min =3D  +6.85 V, max =3D  +6.85 V)
> >> VBat:        +2.98 V
> >> CPU Fan:    1666 RPM  (min =3D 1400 RPM)
> >> Chasis 1:   675000 RPM  (min =3D  900 RPM)
> >> CPU Temp:    +49.0=B0C  (low  =3D +10.0=B0C, high =3D +60.0=B0C)  sens=
or > >> thermal diode
> >> MB Temp:     +39.0=B0C  (low  =3D +10.0=B0C, high =3D +45.0=B0C)  sens=
or > >> transistor
> >> cpu0_vid:   +1.325 V
> >>
> >> ADT7475-i2c-1-2e
> >> Adapter: SMBus nForce2 adapter at 1c40
> >> vccp:        +0.00 V  (min =3D  +0.00 V, max =3D  +2.99 V)   ALARM
> >> vcc:         +3.27 V  (min =3D  +0.00 V, max =3D  +4.28 V)
> >> Chasis 2:   180000 RPM  (min =3D  900 RPM)
> >> fan2:          0 RPM  (min =3D    0 RPM)
> >> fan3:          0 RPM  (min =3D    0 RPM)
> >> fan4:          0 RPM  (min =3D    0 RPM)
> >> remote1:       FAULT  (low  =3D -63.0=B0C, high =3D +191.0=B0C)  ALARM
> >> local:       +42.8=B0C  (low  =3D +10.0=B0C, high =3D +45.0=B0C)
> >> remote2:       FAULT  (low  =3D -63.0=B0C, high =3D +191.0=B0C)  ALARM
> >>
> >> so both readings from it8716 and ADT7475 are wrong.What is funny that
> >> the CPU Fan reading is always ok - while for it8716 there are chances
> >> that issuing servera 'sensors' command will bring at least (one
> >> chances of five ratio) some good result
> >> (in random order) the ADT7475 shows 'always' wrong value.
> >> Tested on Debian using:
> >> libsensors3                          2.10.5-5
> >> libsensors4                         3.0.1-1
> >> lm-sensors                          3.0.1-1
> >>
> >
> > Hmm,
> >
> > Which fan headers on the board are you using, I've recevied my Asus
> > M2N-SLI Deluxe back from repair I still need to build it into a system
> > and then I can see if I can reproduce this.
> >
> > Regards,
> >
> > Hans
> >
> Dear Hans,
>=20
> I'm using :
> - CPU Fan connector
> - CHA_FAN1 - as Chasis 1 (this is connected to it8716)
> -  CHA_FAN4 - as Chassis 2 (this one is connected to adt7475)
>=20
> Connected fans to FAN1 and FAN4 types are same.

Preliminary note: fan speed control (either by PWM or DC) can easily
confuse the tachometers that measure the speed of your fans. Make sure
that fan speed control is disabled.

If two different drivers give the same kind of faulty fan speed,
including one driver that has been widely tested, I would suspect the
fans themselves. Not all fans reliably report their speed. Try
connecting a different fan model (just for testing purposes) and see if
it helps.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
