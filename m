From: Alexandros Diamantidis <adia@hellug.gr>
Date: Mon, 08 Nov 2010 17:13:54 +0000
Subject: Re: [lm-sensors] IT8721F fan control?
Message-Id: <20101108171354.GA7009@hellug.gr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101106002259.GA1871@hellug.gr>
In-Reply-To: <20101106002259.GA1871@hellug.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

* Luca Tettamanti [2010-11-08 13:53]:
> > atk0110-acpi-0
> > CPU Fan Speed: =A0 =A0675000 RPM =A0(min =3D =A0600 RPM)
>=20
> There's something wrong with the reading of this fan. Can you send me
> a copy of the DSDT table (/sys/firmware/acpi/tables/DSDT)?

Oops, I hadn't noticed that!

In fact, that fan speed is usually read correctly, but intermittently
jumps to some absurd value. I don't think it's a problem of the driver,
since I see this in the BIOS "system info" screen as well. Here's an
example of the usual output:

atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:     +1.27 V  (min =3D  +0.80 V, max =3D  +1.60 V)
+3.3V Voltage:     +3.29 V  (min =3D  +2.97 V, max =3D  +3.63 V)
+5V Voltage:       +4.93 V  (min =3D  +4.50 V, max =3D  +5.50 V)
+12V Voltage:     +12.00 V  (min =3D +10.20 V, max =3D +13.80 V)
CPU Fan Speed:    1562 RPM  (min =3D  600 RPM)
Chassis Fan Speed:   0 RPM  (min =3D  600 RPM)
Power Fan Speed:  1216 RPM  (min =3D  600 RPM)
CPU Temperature:   +42.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C) =20
MB Temperature:    +29.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C) =20

For the moment I've disconnected the chassis fan because it was very
distracting.

If it's of any interest, I've put a copy of the DSDT table here:
http://users.uoa.gr/~adia/DSDT

Thanks!

Alexandros

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
