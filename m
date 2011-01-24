From: Audio Phile <da_audiophile@yahoo.com>
Date: Mon, 24 Jan 2011 21:41:31 +0000
Subject: Re: [lm-sensors] insane readings on Asus A7M266 motherboard
Message-Id: <377878.52986.qm@web36601.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <761574.42437.qm@web36601.mail.mud.yahoo.com>
In-Reply-To: <761574.42437.qm@web36601.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Thank you!  This absolutely solved my problem!  I do remember now having to=
 do this addition to grub2's /boot/grub/grub.conf to make it work in the pa=
st.

# sensors
as99127f-i2c-0-2d
Adapter: SMBus Via Pro adapter at e800
in0:         +1.74 V  (min =3D  +1.65 V, max =3D  +2.05 V)  =20
in1:         +2.48 V  (min =3D  +1.65 V, max =3D  +2.05 V)  =20
in2:         +3.22 V  (min =3D  +2.96 V, max =3D  +3.63 V)  =20
in3:         +2.99 V  (min =3D  +2.67 V, max =3D  +3.28 V)  =20
in4:         +3.14 V  (min =3D  +2.51 V, max =3D  +3.79 V)  =20
in5:         +0.51 V  (min =3D  +0.08 V, max =3D  +1.02 V)  =20
in6:         +0.86 V  (min =3D  +0.54 V, max =3D  +1.17 V)  =20
fan1:       2721 RPM  (min =3D 5273 RPM, div =3D 2)
fan2:          0 RPM  (min =3D 337500 RPM, div =3D 2)
fan3:          0 RPM  (min =3D   -1 RPM, div =3D 2)
temp1:       +34.0=B0C  (high =3D  +0.0=B0C, hyst =3D -128.0=B0C) =20
temp2:       +52.0=B0C  (high =3D +100.0=B0C, hyst =3D +75.0=B0C) =20
temp3:        -0.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C) =20
cpu0_vid:   +1.750 V
beep_enable:enabled


--- On Mon, 1/24/11, Jean Delvare <khali@linux-fr.org> wrote:

> The VIA Pro SMBus isn't probed, meaning that the driver
> failed to bind
> to the device. You should see some error message in the
> kernel logs
> when i2c-viapro is loaded.
>=20
> One possible cause is an ACPI resource conflict [1]. I am a
> little
> surprised as I didn't expect this kind of problem on such
> an old board.
> If this is the case, booting with
> acpi_enforce_resources=3Dlax should
> solve your problem.
>=20
> [1] http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworki=
nginkernel2.6.31
>=20
> --=20
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>=20


     =20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
