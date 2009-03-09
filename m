From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Mar 2009 12:17:33 +0000
Subject: Re: [lm-sensors] lm_sensors help
Message-Id: <20090309131733.134939c5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <622d3d2b0903090451v50a8614bjed6e5ba66cafebdd@mail.gmail.com>
In-Reply-To: <622d3d2b0903090451v50a8614bjed6e5ba66cafebdd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 9 Mar 2009 12:51:07 +0100, Csapl=E1r Zolt=E1n wrote:
> I would like to ask you for your help. By this time I have used lm_sensors
> modul but now I downloaded 3.1 version.
> I don't know what the problem is, but if I use the program, I get the
> following datas:
>=20
> *it8712-isa-0290
> Adapter: ISA adapter
> in0:         +1.33 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in1:         +2.59 V  (min =3D  +1.28 V, max =3D  +1.68 V)
> in2:         +3.28 V  (min =3D  +2.78 V, max =3D  +3.78 V)
> in3:         +2.94 V  (min =3D  +2.67 V, max =3D  +3.26 V)
> in4:         +2.93 V  (min =3D  +2.50 V, max =3D  +3.49 V)
> in5:         +1.01 V  (min =3D  +0.58 V, max =3D  +1.34 V)
> in6:         +2.00 V  (min =3D  +1.04 V, max =3D  +1.36 V)
> in7:         +2.34 V  (min =3D  +2.67 V, max =3D  +3.26 V)
> Vbat:        +3.23 V
> fan1:       3245 RPM  (min =3D  664 RPM, div =3D 8)
> fan2:          0 RPM  (min =3D  332 RPM, div =3D 16)
> fan3:          0 RPM  (min =3D    0 RPM, div =3D 8)
> temp1:       +40.0=B0C  (low  =3D +127.0=B0C, high =3D +96.0=B0C)  sensor=
 =3D thermal
> diode
> temp2:       +36.0=B0C  (low  =3D +127.0=B0C, high =3D +126.0=B0C)  senso=
r > transistor
> temp3:       +21.0=B0C  (low  =3D  +0.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D transistor
> cpu0_vid:   +1.088 V*
>=20
> I cannot read the labels and the usual values are missing (5V, 12V etc.)
> What could be the problem? Could you write it down exactly, how I could
> corrigate the problem?

You apparently didn't read the release notes very carefully. The
default configuration file has changed in release 3.1.0 to only include
settings which are common to all mainboards. This avoids giving the
feeling to the users that their sensors are properly configured when
they aren't. Most settings are mainboard-specific and we have no way to
know if the vendor followed the recommended wiring or not.

If you want to revert to the previous behavior, you can copy
etc/sensors.conf.eg (from the lm-sensors source tree)
to /etc/sensors3.conf. But beware that the labels and voltage scaling
you will then get may or may not match your mainboard. The right way to
go is to write a custom configuration file tailored for your mainboard
and put it into /etc/sensors.d. This is no trivial task though.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
