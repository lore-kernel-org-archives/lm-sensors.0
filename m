From: Moebius <moebius20@free.fr>
Date: Wed, 21 Nov 2007 21:52:51 +0000
Subject: Re: [lm-sensors] how to choose the right sensor with an asus
Message-Id: <4744A8B3.7030003@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <47447DA9.3090701@free.fr>
In-Reply-To: <47447DA9.3090701@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Bonsoir,

Another thing, I just do not understand the reason why I get 4 values=20
for both two cores when I launch sensors :

moebius@mamachine:~$ sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
               -5=B0C
Core0 Temp:
               -9=B0C
Core1 Temp:
               +5=B0C
Core1 Temp:
              -12=B0C

it8716-isa-0290
Adapter: ISA adapter
VCore:     +1.02 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VDDR:      +3.31 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
+5V:       +4.84 V  (min =3D  +0.00 V, max =3D  +6.85 V)
+12V:     +11.46 V  (min =3D  +0.00 V, max =3D +16.32 V)
in5:       +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
in6:       +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
5VSB:      +4.73 V  (min =3D  +0.00 V, max =3D  +6.85 V)
VBat:      +2.91 V
fan1:     3068 RPM  (min =3D 3245 RPM)                   ALARM
fan2:        0 RPM  (min =3D 3245 RPM)                   ALARM
fan3:     1666 RPM  (min =3D    0 RPM)
temp1:       +17=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =3D=
 diode
temp2:       +32=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =3D=
=20
thermistor
temp3:       +25=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =3D=
=20
thermistor
vid:      +0.000 V

Rather mysterious, isn't it ?

cordialement,

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
