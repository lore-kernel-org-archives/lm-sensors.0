From: Daniel Glaser <glaser@beeco.de>
Date: Tue, 07 Feb 2012 18:26:31 +0000
Subject: [lm-sensors] Report on ITE IT8728
Message-Id: <4F316CD7.7070709@beeco.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

for the it8728 chipset you asked to provide feedback, if the command
shown on your website works. It did, so here is the report.
The sensors3.conf looks as follows (unmodified from installer):

chip "it87-*" "it8712-*" "it8716-*" "it8718-*" "it8720-*" "it8728-*"

    label in8 "Vbat"

This is, what my console on ubuntu 11.10 gives:
$ modprobe it87 force_id=3D0x8721
$ sensors

it8721-isa-0290
Adapter: ISA adapter
in0:          +1.03 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in1:          +2.06 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in2:          +2.94 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in3:          +2.88 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in4:          +0.00 V  (min =3D  +0.00 V, max =3D  +3.06 V)  ALARM
in5:          +0.78 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in6:          +1.51 V  (min =3D  +0.00 V, max =3D  +3.06 V)
3VSB:         +3.36 V  (min =3D  +0.00 V, max =3D  +6.12 V)
Vbat:         +3.05 V
fan1:        1092 RPM  (min =3D    0 RPM)
fan2:        1049 RPM  (min =3D    0 RPM)
fan3:           0 RPM  (min =3D    0 RPM)
fan4:        1967 RPM  (min =3D    0 RPM)
temp1:        +35.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D
thermistor
temp2:        +25.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D
thermistor
temp3:        +13.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D
thermistor

Voltages: seem to be a bit wrong
Fans: look quite nice (fan3 is not installed)
Temperatures: temp1 and temp2 also look fine, but temp3 seems also to be
a bit wrong.

Hope this helps you to improve the support of this chip.

If you need anything else, I've NOT subscribed to the list, so please
take me on CC.

Thanks a lot for your great work.

- Daniel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
