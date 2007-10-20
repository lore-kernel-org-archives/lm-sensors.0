From: Juergen Bausa <Juergen.Bausa@web.de>
Date: Sat, 20 Oct 2007 19:39:32 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <1711707355@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


> -----Urspr=FCngliche Nachricht-----
> Von: Jean Delvare <khali@linux-fr.org>

> On Wed, 17 Oct 2007 21:53:42 -0700, Juerg Haefliger wrote:
> > On 10/17/07, Jean Delvare <khali@linux-fr.org> wrote:
> > > On Wed, 17 Oct 2007 12:43:16 -0700, Juerg Haefliger wrote:
> > > > Aha, this is an error as a result of a dme1737 initiated write. 0x1a
> > > > means "SMBus Busy". So the dme1737 driver is colliding with somethi=
ng
> > > > else in the system that tries to talk to a chip on the same bus.
> > >
> > > This can only happen on a multi-master I2C bus, which is rather rare =
on
> > > consumer PCs. Juergen, do you have detailed technical documentation
> > > about your system? It would be interesting to find out what chip the
> > > other master is talking to. If it's the DME1737 chip, this could lead
> > > to problems.
> >=20
> > Hmm... What about ACPI? Couldn't it interfere with the dme1737 module
> > by going after the same resources.
>=20
> It could, but I just can't think of a valid reason why ACPI wouldn't
> use the nForce2 SMBus controller itself.
>=20
> Are you certain that the "busy" error code means that the *bus* is
> busy? Doesn't it rather mean that the *nForce SMBus controller* itself
> is busy (i.e. the previous command is still being processed)? The latter
> would indeed suggest that ACPI is running SMBus transactions in our
> back, which would be a problem. At least, if the SMBus controller lets
> us know, we'll avoid corruption, but bad things can still happen.
>=20
> Juergen, if you load the "thermal" driver and look
> in /proc/acpi/thermal_zone, do you see a temperature reported, with the
> same value as one of the DME1737 temperature channels?
>=20

Yes, I see a temperature, but its not the same.

lisa:/home/jba# cat /proc/acpi/thermal_zone/THRM/temperature
temperature:             40 C
lisa:/home/jba# sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
             +44=B0C
Core0 Temp:
             +46=B0C
Core1 Temp:
             +52=B0C
Core1 Temp:
             +49=B0C

dme1737-i2c-0-2e
Adapter: SMBus nForce2 adapter at 4c00
V5stby:    +0.00 V  (min =3D  +0.00 V, max =3D  +6.64 V)  ALARM
Vccp:      +1.09 V  (min =3D  +0.00 V, max =3D  +2.99 V)
V3.3:      +3.27 V  (min =3D  +0.00 V, max =3D  +4.38 V)
V5:        +4.93 V  (min =3D  +0.00 V, max =3D  +6.64 V)
V12:      +11.78 V  (min =3D  +0.00 V, max =3D +15.94 V)
V3.3stby:  +3.28 V  (min =3D  +0.00 V, max =3D  +4.38 V)
Vbat:      +2.98 V  (min =3D  +0.00 V, max =3D  +4.38 V)
Int Temp:    +32=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
CPU Temp:    +30=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
CPU_Fan:     0 RPM  (min =3D    0 RPM)
ERROR: Can't get fan3 data!
ERROR: Can't get fan5 data!
ERROR: Can't get fan6 data!
CPU_PWM:     0      (enable =3D 1, freq =3D  25000 Hz)
ERROR: Can't get pwm5 data!
ERROR: Can't get pwm6 data!
cpu0_vid: +1.550 V  (VRM Version 2.4)

lisa:/home/jba#                       =20



> If you unload the "thermal" driver, do the dme1737 write errors go away?

I will try this. I am not sure, but dont think thermal was loaded.

>=20
> > > Assuming that "busy" means that the nForce chip did not even attempt =
to
> > > send the message (or lost arbitration, which is equivalent), this
> > > specific error could be handled in i2c-nforce2, by retrying. The
> > > problem is that you have to decide how many times you retry, and how
> > > much time you wait between retries (there doesn't seem to be a way to
> > > test if the SMBus is busy before trying, right?)
> >=20
> > The i2c-nforce2 driver already spins for 10 msecs before deciding to
> > give up. I'd just retry once after that and see what happens.
>=20
> Depends on what kernel Juergen is running. Oleg Ryjkov has submitted

lisa:/home/jba# uname -r
2.6.18-5-k7

Its a stock debian etch kernel.

> interesting patches that clean up this part of the i2c-nforce2 driver:
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmitdiff;hA53549734cbdba24e9cf5eb200b70b7b1572e15
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmitdiff;h=D49584c4a37c7228e7778bcb60f79e7a08472fa8
> These are already in Linus' tree for 2.6.24.
>=20


Juergen
_______________________________________________________________________
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 3 Monate
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/?mc=022220


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
