From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 18 Feb 2009 21:34:28 +0000
Subject: Re: [lm-sensors] w83793 driver for RHEL 5.2 x86_64
Message-Id: <499C7EE4.5070200@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

Please CC the lm-sensors list.

Well the new version is in Linux kernel 2.6.20. Please try with some more n=
ew=20
version of kernel. What motherboard model/manufacturer it is?

In the meanwhile please can you try as root:

rmmod w83793
modprobe i2c-dev
i2cdump 0 0x2f

It should dump raw register data of the chip.

Thanks,
Rudolf



maluyao napsal(a):
> Hi
>=20
> I'm using RHEL 5.3 X86_64.The kernel version is 2.6.18-128.el5. The=20
> lm_sensors is  3.0.2 and/or 2.10.7-4.el5.
>=20
> I got a drvier code from here :
> http://jdelvare.pck.nerim.net/sensors/w83793/
>=20
> This driver works not so fine because  some of temperature show me -1=B0C=
 =20
> sometimes.
> for example:
>=20
> w83793-i2c-0-2f
> Adapter: SMBus I801 adapter at 1100
> CPU1 Temp:    -1.8=B0C  (high =3D  -1.0=B0C, hyst =3D  -1.0=B0C)  ALARM  =
sensor =3D=20
> Intel PECI
> CPU2 Temp:    -1.8=B0C  (high =3D  -1.0=B0C, hyst =3D  -1.0=B0C)  ALARM  =
sensor =3D=20
> Intel PECI
> temp3:        -1.8=B0C  (high =3D  -1.0=B0C, hyst =3D  -1.0=B0C)  ALARM  =
sensor =3D=20
> Intel PECI
> temp4:        -1.8=B0C  (high =3D  -1.0=B0C, hyst =3D  -1.0=B0C)  ALARM  =
sensor =3D=20
> Intel PECI
> temp5:        -1.0=B0C  (high =3D  -1.0=B0C, hyst =3D  -1.0=B0C)  ALARM  =
sensor =3D=20
> thermistor
> beep_enable:enabled
>=20
>=20
> Have you have  new driver for this version of Linux Kernel ?
>=20
> Best Regards
>=20
> maluyao@gmail.com <mailto:maluyao@gmail.com>
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
