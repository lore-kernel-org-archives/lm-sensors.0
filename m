From: gooly@gmx.at
Date: Wed, 24 Oct 2007 13:50:07 +0000
Subject: [lm-sensors] Probably wrong numbers for my Mainboard: MSI 945GT
Message-Id: <200710241550.07758.gooly@gmx.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,
installing sensors for my MSI 945GT Speedster for Intels Dou Core Mobil=20
CPU. The url of all sys--files is this one:
http://global.msi.com.tw/index.php?func=3Dproddesc&prod_no$3&maincat_no=3D1

Please find the output of sensors below. Some mumbers seem to be not=20
correct. The installation was without any problems.
I have fesh installed SuSE 10.3 but the 32-bit (not 64):
	2.6.22.5-31-default, i686

If you want me to perform certain tests or you need further=20
information - please tell me.


w83627ehf-isa-0290
Adapter: ISA adapter
VCore:     +0.94 V  (min =3D  +0.00 V, max =3D  +1.74 V)=20
in1:      +12.25 V  (min =3D  +2.85 V, max =3D +12.94 V)=20
AVCC:      +3.26 V  (min =3D  +4.06 V, max =3D  +0.74 V) ALARM
3VCC:      +3.26 V  (min =3D  +0.99 V, max =3D  +0.05 V) ALARM
in4:       +1.52 V  (min =3D  +1.38 V, max =3D  +0.37 V) ALARM
in5:       +1.71 V  (min =3D  +0.60 V, max =3D  +0.74 V) ALARM
in6:       +3.43 V  (min =3D  +1.36 V, max =3D  +3.81 V)=20
VSB:       +3.23 V  (min =3D  +3.42 V, max =3D  +2.96 V) ALARM
VBAT:      +3.06 V  (min =3D  +1.62 V, max =3D  +2.83 V) ALARM
in9:       +1.86 V  (min =3D  +1.75 V, max =3D  +1.46 V) ALARM
Case Fan: 1506 RPM  (min =3D  193 RPM, div =3D 64)
CPU Fan:  1054 RPM  (min =3D  172 RPM, div =3D 64)
Aux Fan:   811 RPM  (min =3D    0 RPM, div =3D 64)
fan5:        0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM
Sys Temp:    +35 =B0C  (high =3D  -119 =B0C, hyst =3D  -100 =B0C)   ALARM
CPU Temp:  +38.0 =B0C  (high =3D +80.0 =B0C, hyst =3D +75.0 =B0C) =20
AUX Temp:  +35.5 =B0C  (high =3D +80.0 =B0C, hyst =3D +75.0 =B0C) =20

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +33 =B0C  (high =3D  +100 =B0C)                  =20

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +36 =B0C  (high =3D  +100 =B0C)                  =20

Regards,
Carl

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
