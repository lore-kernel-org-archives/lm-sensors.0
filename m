From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Feb 2009 12:21:29 +0000
Subject: Re: [lm-sensors] AMD 690G motherboards?
Message-Id: <20090208132129.3918e344@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1LUlss-0003yf-U8@mendel.bio.caltech.edu>
In-Reply-To: <E1LUlss-0003yf-U8@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 04 Feb 2009 09:49:58 -0800, David Mathog wrote:
> (was "AMD 689G motherboards?" originally, sorry about the typo)
>=20
> > If anybody has configured lm_sensors on a similar 690G board
> > I would appreciate some pointers.
>=20
> More details. =20
>=20
> In the BIOS one sees:
> CPU fan 3139 RPM
> System Temp 32C
> System Fan 0 RPM
>=20
> The Room temp is about 20C, so no way any measured temperature
> below that is real, and from the BIOS, anything below 32C is suspect.
> In the sensors output below the first "acpitz-virtual-0" sensor seems to
> be entirely spurious, and all of the k8temp-pci measurements bogus as
> well.  (This is a single CPU, dual core machine.)  The it8716 device is
> the only one with a few values which seem to be in range, some possibly
> by chance, and the only one which looks spot on is Fan1 for CPU fan.
>=20
> Here is the full output of "sensors"
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +8.0 =B0C  (crit =3D +75.0 =B0C)                 =20

Apparently the ACPI thermal zone reads the temperature from the
IT8716F's temp1, but it happens to be incorrect. Note that accessing
the sensors from both ACPI and native drivers is dangerous, so you
should load either thermal or it87 but not both.

> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +10.0 =B0C                                   =20
> Core0 Temp:   +0.0 =B0C                                   =20
> Core1 Temp:   -4.0 =B0C                                   =20
> Core1 Temp:   +1.0 =B0C                                   =20

Please see:
http://www.lm-sensors.org/ticket/2278
Executive summary: K8 rev. F+ hardware sensors are unreliable, fix in
2.6.29 will make the readings look better but still not perfect.

> it8716-isa-0228
> Adapter: ISA adapter
> VCore:       +1.25 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
> VDDR:        +1.23 V  (min =3D  +1.28 V, max =3D  +1.68 V)   ALARM
> +3.3V:       +1.89 V  (min =3D  +2.78 V, max =3D  +3.78 V)   ALARM
> +5V:         +4.89 V  (min =3D  +4.49 V, max =3D  +5.48 V)  =20
> +12V:        +4.86 V  (min =3D  +9.98 V, max =3D +13.95 V)   ALARM
> in5:         +2.48 V  (min =3D  +0.58 V, max =3D  +1.34 V)   ALARM
> in6:         +1.81 V  (min =3D  +1.04 V, max =3D  +1.36 V)   ALARM
> 5VSB:        +4.73 V  (min =3D  +4.49 V, max =3D  +5.48 V)  =20
> VBat:        +3.02 V
> fan1:       3139 RPM  (min =3D   10 RPM)
> fan2:          0 RPM  (min =3D   10 RPM)  ALARM
> fan3:          0 RPM  (min =3D    0 RPM)
> temp1:        +8.0 =B0C  (low  =3D +127.0 =B0C, high =3D +75.0 =B0C)  sen=
sor =3D thermal diode
> temp2:       +33.0 =B0C  (low  =3D +127.0 =B0C, high =3D +75.0 =B0C)  sen=
sor =3D transistor
> temp3:        -8.0 =B0C  (low  =3D +127.0 =B0C, high =3D +75.0 =B0C)  sen=
sor =3D transistor
> cpu0_vid:   +1.000 V

temp3 is probably unconnected and can be ignored. temp2 is apparently
what your BIOS reports as "System Temp". The fact that the BIOS doesn't
report any other temperature suggests that the motherboard vendor knows
that all other temperature sources are invalid or unreliable.

If you have Windows on the machine and the vendor provides a tool for
hardware monitoring, you may want to give it a try and see if you get
better results. You may also contact the vendor support and ask them
for additional information. But I suspect this is a hardware problem
and not much can be done at the software level. If temp1 climbs on CPU
load then you can add an arbitrary offset to that value and consider it
a rough approximation of your CPU temperature.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
