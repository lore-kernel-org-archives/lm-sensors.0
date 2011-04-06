From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Apr 2011 22:54:56 +0000
Subject: Re: [lm-sensors] testing "w83627ehf" and "k10temp" on ASRock E350M1
Message-Id: <20110406225456.GB27691@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D9CA530.9030100@yandex.ru>
In-Reply-To: <4D9CA530.9030100@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Apr 06, 2011 at 01:38:56PM -0400, Aleksej Serdjukov wrote:
> Hi.
>=20
> I've got this computer with ASRock E350M1, and have no idea what the=20
> temperatures should actually be.
>=20
> This is on Debian 6.0:
> Linux 2.6.32-5-amd64 #1 SMP Mon Mar 7 21:35:22 UTC 2011 x86_64 GNU/Linux
>=20
>=20
> IIRC, UEFI Setup was showing about 52=B0C on the motherboard or chipset, =

> and 49-52 on the CPU.
>=20
> About a week ago I've installed the "w83627ehf" from=20
> <http://roeck-us.net/linux/drivers/w83627ehf/>, and saw that those=20
> temperatures don't go over 53 or 54=B0C. So I changed the UEFI setting=20
> more and more for slower fan speed (today it was 6). So the speed was=20
> about 4000, while the full speed is about 4900 and 9 is a hundred or a=20
> couple of hundred less. Temperatures didn't go over 54 (or maybe 55) =B0C=
.=20
> Idle CPU (at 800MHz thanks to Cool'n'Quiet) went down to 46=B0C more and =
more.
>=20
> Today, however, while the CPU was not loaded much, the fan appeared to=20
> be full speed again (at least according to the sensors applet).
>=20
> But the new sensors-detect was also mentioning "k10temp" (and the old=20
> one in Debian didn't work), so today I installed a new k10temp, and it=20
> showed 60=B0C for something.
>=20
> Now I have set the fan speed to full in UEFI, and here is what "sensors" =

> shows:
>=20
>=20
> nct6775-isa-0290
> Adapter: ISA adapter
> Vcore:       +1.08 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:         +1.03 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM

	Possibly 12V (*12)

> AVCC:        +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:       +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in4:         +1.39 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in5:         +1.86 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM

No idea what in4/in5 might be.

> in6:         +1.66 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM

	This one might be 5V (*3)

Guenter

> 3VSB:        +3.44 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:        +3.39 V  (min =3D  +2.70 V, max =3D  +3.30 V)   ALARM
> fan1:          0 RPM  (min =3D    0 RPM, div =3D 128)
> fan2:       4963 RPM  (min =3D    0 RPM, div =3D 8)  ALARM
> fan3:          0 RPM  (min =3D    0 RPM, div =3D 128)
> fan4:          0 RPM  (div =3D 128)
> SYSTIN:      +51.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor =3D=20
> thermistor
> CPUTIN:      +45.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> AUXTIN:       -9.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> cpu0_vid:   +0.000 V
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +58.0=B0C  (high =3D +70.0=B0C, crit =3D +75.0=B0C)
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
