From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 Mar 2009 15:06:31 +0000
Subject: Re: [lm-sensors] W83667HG driver test for in6 and temp3
Message-Id: <20090303160631.46e5c994@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Michael,

On Tue, 03 Mar 2009 09:49:39 -0500, Michael Hampton wrote:
> Jean Delvare wrote:
> > To all potential testers: I've split support for the W83667HG into 3
> > patches:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvar=
e-hwmon/hwmon-w83627ehf-01-invert-fan-pin-logic.patch
> > ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvar=
e-hwmon/hwmon-w83627ehf-02-add-support-for-w83667hg.patch
> > ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvar=
e-hwmon/hwmon-w83627ehf-03-fix-temp3-vs-in6.patch
> >
> > These patches are now in linux-next and will be merged into kernel
> > 2.6.30 if we receive positive feedback.
> >
> > Any further change should be in a new patch to be applied on top of
> > these 3 patches we already have.
> >
> > Thanks,
> >  =20
>=20
> I've applied these 3 patches against the latest Fedora 10 kernel
> 2.6.27.19-170.2.35.fc10.x86_64 and it's working, only I get temp3 (with
> an invalid value) instead of in6. The motherboard is an ASUS P6T6 WS
> Revolution.

OK, thanks for testing and reporting. OTOH, temp3 is invalid, but you
don't know if in6 would be valid, so it doesn't mean much. Is there any
temperature or voltage value shown in the BIOS which is missing in the
output of "sensors"?

Do you happen to have Windows installed on that machine for comparison
purposes?

>=20
> w83667hg-isa-0290
> Adapter: ISA adapter
> in0:         +1.34 V  (min =3D  +0.00 V, max =3D  +1.74 V) =20
> in1:         +1.70 V  (min =3D  +0.02 V, max =3D  +0.00 V)   ALARM
> in2:         +3.22 V  (min =3D  +1.02 V, max =3D  +0.26 V)   ALARM
> in3:         +3.18 V  (min =3D  +2.56 V, max =3D  +0.00 V)   ALARM
> in4:         +1.69 V  (min =3D  +0.00 V, max =3D  +1.04 V)   ALARM
> in5:         +2.04 V  (min =3D  +0.77 V, max =3D  +0.52 V)   ALARM
> in7:         +3.34 V  (min =3D  +0.02 V, max =3D  +1.34 V)   ALARM
> in8:         +3.31 V  (min =3D  +0.86 V, max =3D  +1.09 V)   ALARM
> fan1:       1917 RPM  (min =3D 1288 RPM, div =3D 8)
> fan2:       1875 RPM  (min =3D 14062 RPM, div =3D 16)  ALARM
> fan3:       1795 RPM  (min =3D 5273 RPM, div =3D 4)  ALARM
> fan4:       1875 RPM  (min =3D 1298 RPM, div =3D 8)
> fan5:       2481 RPM  (min =3D 2636 RPM, div =3D 8)  ALARM
> temp1:       +43.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +4.0=B0C)  ALARM  =
sensor > thermistor
> temp2:       +60.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
> temp3:      +127.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM  =
sensor > thermistor
> cpu0_vid:   +1.950 V


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
