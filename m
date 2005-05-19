From: spstarr@sh0n.net (Shawn Starr)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: Strange sensors results - PIIX4 (440BX) - IBM 300PL 6892-N2U
Message-Id: <Pine.LNX.4.44.0302101103200.466-100000@coredump.sh0n.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200302092138.25839.spstarr@sh0n.net>
In-Reply-To: <200302092138.25839.spstarr@sh0n.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


The documentation reports that the machine indeed has a lm80 chip in it.
This controls the RPM of the fan speed etc. Removing the IBM check code
from the i2c-piix4 didn't break anything ;-) since i powered it off/on and
it worked fine.

This is the same result if I use the 2.7.0 drivers with the IBM check
disabled.

Yes, I ment two i2c devices ;-)

I set the fan divisor by 4 and i get RPMs but they are eratic in speed
(which may be normal according to the IBM docs which say that the RPM
speed may vary).

The documentation is available on IBM's site for the IBM 300PL series of
machines. They even mention the address of the lm80 location

Here's a mirror:

http://www.verex.at/aktion/PL300-66862-tech-manual.pdf

"The LM80 physically resides on the SMbus interface. The device address
for the LM80 is 0x50.

The Intel chipset is a PIIX4E.

What it monitors:

- System temperature sensing and fan control.
- Voltages: +5v, +12v, +3.3v, +1.5, +2.5v, -5v.
- Chassis intrusion detection even powered off.

I hope this helps you ;-)

Shawn.
 On Mon, 10 Feb 2003, Jean Delvare wrote:

>
> > After commenting out code in the i2c-piix4 code to stop it from
> > loading the driver I noticed the following odd results:
>
> Note that we take no responsabilities for what may happen to your
> hardware after that.
>
> > It appears the IBM has a lm80 chip.
> > The 'odd' thing is it reports i2c devices?
>
> Hmm, missing word, did you mean "two i2c devices"?
>
> > There are two fans on this board. the PSU fan and a special case/cpu
> > fan which only turns on when the CPU is getting hot it is usually off
> > if the machine is idle.
> >
> > sensors
> > lm80-i2c-0-28
> > Adapter: SMBus PIIX4 adapter at fe00
> > Algorithm: Non-I2C SMBus adapter
> > +5V:       +4.00 V  (min =3D  +4.74 V, max =3D  +4.74 V)   ALARM
> > VTT:       +1.72 V  (min =3D  +1.90 V, max =3D  +2.10 V)   ALARM
> > +3.3V:     +3.37 V  (min =3D  +3.13 V, max =3D  +3.46 V)
> > +Vcore:    +2.92 V  (min =3D  +1.80 V, max =3D  +1.99 V)   ALARM
> > +12V:     +11.30 V  (min =3D +11.37 V, max =3D +12.57 V)   ALARM
> > -12V:      -7.35 V  (min =3D -12.62 V, max =3D -11.41 V)   ALARM
> > -5V:       -2.67 V  (min =3D  -5.25 V, max =3D  -4.77 V)   ALARM
> > fan1:     3154 RPM  (min =3D 3000 RPM, div =3D 2)          ALARM
> > fan2:        0 RPM  (min =3D 3000 RPM, div =3D 2)          ALARM
> > temp:     +33.50 =B0C (hot:limit =3D  +6=B0C,  hysteresis =3D  +5=B0C) =
ALARM
> >          (os: limit =3D  +6=B0C,  hysteresis =3D  +5=B0C) ALARM
> >
> > lm80-i2c-0-2e
> > Adapter: SMBus PIIX4 adapter at fe00
> > Algorithm: Non-I2C SMBus adapter
> > +5V:       +5.50 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> > VTT:       +0.31 V  (min =3D  +0.00 V, max =3D  +2.02 V)   ALARM
> > +3.3V:     +3.46 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> > +Vcore:    +0.77 V  (min =3D  +0.46 V, max =3D  +3.08 V)   ALARM
> > +12V:      +7.14 V  (min =3D  +3.28 V, max =3D +12.57 V)   ALARM
> > -12V:     -12.65 V  (min =3D -12.65 V, max =3D -18.47 V)
> > -5V:       -4.75 V  (min =3D  -5.27 V, max =3D  -4.75 V)
> > fan1:     168750 RPM  (min =3D 1670 RPM, div =3D 4)          ALARM
> > fan2:     3325 RPM  (min =3D   -1 RPM, div =3D 2)
> > temp:     -39.12 =B0C (hot:limit =3D  +2=B0C,  hysteresis =3D -53=B0C) =
ALARM
> >          (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C) ALARM
> > alarms:   Board temperature input (LM75)               ALARM
>
> Most things here sound like crap. I'd suggest you try and collect some
> information about your IBM system to know which chipset it is supposed
> to have. Also, don't forget to run "sensors -s" before running "sensors"
> to make sure that the config file is used. Last, see in the BIOS if it
> shows some sensors information. It could help to know what kind of
> sensors we are looking for.
>
> You could also check wether the first lm80's fans values match the
> behavior of your physical fans (for exemple, make the CPU hot using
> cpuburn, and see if fan2 shows a value when the real fan starts).
>
> Hope it helps.
>
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
>
>
