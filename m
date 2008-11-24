From: "Jon Hewer" <jonhewer@gmail.com>
Date: Mon, 24 Nov 2008 09:27:08 +0000
Subject: [lm-sensors] Gigabyte GA-MA69G-S3H it8716 temperatures?
Message-Id: <d76c7b8f0811240127y1e8d1f5etdc5dd76fd0b5b29@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

The output of sensors for my Gigabyte GA-MA69G-S3H motherboard is as follow=
s:

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:   -6.0=B0C
Core0 Temp:   +1.0=B0C
Core1 Temp:   -8.0=B0C
Core1 Temp:   -5.0=B0C

it8716-isa-0228
Adapter: ISA adapter
VCore:       +1.18 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VDDR:        +1.94 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+3.3V:       +3.25 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+5V:         +4.92 V  (min =3D  +0.00 V, max =3D  +6.85 V)
+12V:       +12.10 V  (min =3D  +0.00 V, max =3D +16.32 V)
in5:         +3.14 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in6:         +0.10 V  (min =3D  +0.00 V, max =3D  +4.08 V)
5VSB:        +4.92 V  (min =3D  +0.00 V, max =3D  +6.85 V)
VBat:        +3.10 V
fan1:       1341 RPM  (min =3D    0 RPM)
fan2:       1002 RPM  (min =3D    0 RPM)
temp1:       +33.0=B0C  (low  =3D +127.0=B0C, high =3D +60.0=B0C)  sensor =
=3D transistor
temp2:       +25.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
=3D transistor
temp3:       +19.0=B0C  (low  =3D +127.0=B0C, high =3D +60.0=B0C)  sensor =
=3D thermal diode
cpu0_vid:   +1.200 V

Firstly, I am trying to identify the three temperature readings
returned by the it8716 module.  I have checked the sensors.conf and
there is a note saying that it is motherboard specific.  I have
contacted the manufacturer of my motherboard, but they haven't been
able to help.

Has anybody else been able to identify which readings these are?  I'm
guessing temp1=3Dnorthbridge, temp2=3Dcpu and temp3=3Dsystem...

Secondly, the core temps returned by the k8temp module look a bit odd.
 Am I just misunderstanding these readings, or do I need to tweak my
conf?

Cheers,
Jon

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
