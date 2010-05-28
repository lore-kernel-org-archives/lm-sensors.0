From: "David Mathog" <mathog@caltech.edu>
Date: Fri, 28 May 2010 18:38:59 +0000
Subject: [lm-sensors] Gigabyte MA785GMT-UD2H
Message-Id: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Anybody have a sensors.conf for this board that works?=20

Attempting to get lm-sensors working on a Gigabyte MA785GMT-UD2H
motherboard on Ubuntu 10.04LTS.   Kernel is 2.6.32-22, lm-sensors is
3.1.2-2, and CPU is AMD Athlon(tm) II X2 240 Processor. sensors-detect
added these to /etc/modules:

 it87
 lm90

and made some comment about k10temp.  There is no k10temp module, but
there is a k8temp.  modprobe k8temp doesn't change anything though.
In any case, the output of sensors clearly isn't correct, for instance,
there are no 5V and 12V readings:

it8718-isa-0228
Adapter: ISA adapter
in0:         +1.14 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in1:         +1.60 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in2:         +3.36 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in3:         +2.99 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in4:         +3.04 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in5:         +3.36 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in6:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
in7:         +2.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
Vbat:        +3.12 V
fan1:       1662 RPM  (min =3D    0 RPM)
fan2:          0 RPM  (min =3D    0 RPM)
fan3:          0 RPM  (min =3D    0 RPM)
fan4:       1184 RPM  (min =3D    0 RPM)
temp1:       +27.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
thermistor
temp2:       +27.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
thermal diode
temp3:       +29.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
thermistor
cpu0_vid:   +1.050 V


Thanks,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
