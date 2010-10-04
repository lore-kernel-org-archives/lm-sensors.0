From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 04 Oct 2010 13:15:14 +0000
Subject: Re: [lm-sensors] Compatibility report: MSI 770-G45
Message-Id: <20101004151514.798167be@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 26 Sep 2010 19:55:58 -0500, roothorick wrote:
> My primary desktop is built around an MSI 770-G45 motherboard. The BIOS
> shows three fanspeeds (CPU FAN, SYS FAN 1, SYS FAN 2), two temperatures (=
CPU
> and "System"), and four voltages (CPU Vcore, 3.3V, 5V, and 12V). My CPU i=
s a
> Phenom II; k10temp detects it uneventfully and the values given are within
> 2-3 degrees of what the BIOS says. The board has a Fintek F71889FG (or
> derivative; the driver detects it and returns valid values) but it's sitt=
ing
> in an ACPI zone...
>=20
> I'm using acpi_enforce_resources=3Dlax, and getting this in dmesg every t=
ime
> f71882 is loaded:
> [27466.942766] f71882fg: Found f71889fg chip at 0x600, revision 21
> [27466.942826] ACPI: resource f71882fg [io  0x0600-0x0607] conflicts with
> ACPI region HMOR [mem 0x00000605-0x00000606 64bit pref window]
> [27466.942833] ACPI: This conflict may cause random problems and system
> instability
> [27466.942838] ACPI: If an ACPI driver is available for this device, you
> should use it instead of the native driver

Unfortunately no ACPI driver for MSI boards. Complain to MSI and ask
them why they reserve the chip for ACPI if the current situation
doesn't make you happy.

> I'm not seeing any stability problems. What voltages I can translate are
> well within correct ranges.
>=20
> I've made an incomplete .conf for this board (with guessed voltage, and w=
ith
> it, sensors gives me this:
> f71889fg-isa-0600
> Adapter: ISA adapter
> 3.3V:          +3.36 V
> Vcore:         +0.98 V  (max =3D  +2.04 V)
> in2:           +1.08 V
> in3:           +0.90 V
> in4:           +0.58 V
> in5:           +0.38 V
> in6:           +0.29 V
> 3.3V (again?): +3.36 V

This is +3.3V Stand-By (often abbreviated 3VSB). Same as +3.3V except
that it is still up when the system if powered down.

> Vbat:          +3.28 V
> CPU:          1347 RPM
> System1:         0 RPM  ALARM
> System2:         0 RPM  ALARM
> CPU:           +30.0=B0C  (high =3D +255.0=B0C, hyst =3D +251.0=B0C)
>                         (crit =3D +255.0=B0C, hyst =3D +251.0=B0C)  senso=
r =3D Intel PECI
> System:        +33.0=B0C  (high =3D +255.0=B0C, hyst =3D +253.0=B0C)
>                         (crit =3D +255.0=B0C, hyst =3D +253.0=B0C)  senso=
r =3D transistor
>=20
> Note: Vcore (in1) jumps up to 1.4V (what my CPU is supposed to run at) wh=
en
> the processor is under load; I'm guessing this is some kind of thermal
> control feature.

This is the usual voltage and frequency scaling many modern CPU are
doing for the past 10 years or so. When idle, the frequency goes down,
and lower frequencies require lower voltages.

> There are three fan headers on the board (one 4-pin two
> 3-pin); I just don't have anything connected to two of them.
>=20
> I attached my .conf.
>=20
> Any guesses what in2-in6 may be, and the correct multipliers for them?

The chip has a 2.04 Volts ADC, which means that +5V and +12V can't be
connected directly, they need to be scaled down using external
resistors. Usually the vendor will try to scale values down to 50% or
75% of the ADC range. Here the datasheet suggests targeting 1 V. This
leads me to believe that +5V and +12V are in2 and in3 or vice versa.

in4, in5 and in6 being way below 1 V, I would guess they are not wired.
One of them could be wired to -12V with a complex scaling formula, but
recent boards tend to no longer monitor negative voltage lines, and you
don't see -12V in the BIOS, so this is probably not the case. If these
values change a lot randomly, this is a good hint that the pins are not
wired.

For +5V and +12V, I can help you figure out who is who and which
scaling factors are in use. First go into the BIOS and check which
values are reported for +5V and +12V. Stay there for a moment, and
write down all values which are shown for each. The more different
values you gather, the better.

Then go to Linux and run:
$ grep . /sys/class/hwmon/hwmon*/device/in[23]_input

Again do it several times, trying to gather different values for each
entry. Report all the numbers and we'll sort them out.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
