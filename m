From: Malte Gell <malte.gell@gmx.de>
Date: Fri, 17 Dec 2010 08:11:54 +0000
Subject: [lm-sensors] identifying thermal zones
Message-Id: <201012170911.54944.malte.gell@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

I have an Acer Aspire 7736G laptop with Intel chipset. I have loaded the=20
coretemp module and ran sensors-detect.

Now, when invoking sensors I get this output:

acpitz-virtual-0
Adapter: Virtual device
temp1:       +39.0=B0C  (crit =3D +90.0=B0C)                 =20
temp2:       +39.0=B0C  (crit =3D +90.0=B0C)                 =20

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +30.0=B0C  (high =3D +85.0=B0C, crit =3D +85.0=B0C) =20

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +27.0=B0C  (high =3D +85.0=B0C, crit =3D +85.0=B0C) =20

temp1 and temp2 are probably the two cores of the Core2Duo CPU. How can I n=
ow=20
identify which thermal zone "Core 0" and "Core 1" is? I would like which pi=
ece=20
of hardware these two temperatures refer to....

I use sensors version sensors-3.1.1-3.5.x86_64.

Thanx
Malte

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
