From: CC <ccomren@gmail.com>
Date: Wed, 25 Jan 2012 18:12:50 +0000
Subject: [lm-sensors] Unsupported sensors in AsRock Z68 Pro3-M?
Message-Id: <CAH4eiUjSqFJR056_9Jqn=AMhvjktrArsXCBfNBypVSDTck3gQQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I'm using Arch Linux with kernel 3.2.1.

 sensors-detect (all YES) came up with coretemp and w83627ehf.
However, the mainboard (in the UEFI BIOS and, judging by screenshots,
in Windows, and by the manual) can monitor a third fan, 12V, 7V and
5V.

I get spurious voltage readings from sensors, however:

nct6776-isa-0290
Adapter: ISA adapter
Vcore:         +0.75 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:           +1.87 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
AVCC:          +3.38 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:         +3.36 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:           +0.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in5:           +1.68 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:          +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:          +3.30 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
fan1:            0 RPM  (min =3D    0 RPM)  ALARM
fan2:         1419 RPM  (min =3D    0 RPM)  ALARM
SYSTIN:        +36.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM
sensor =3D thermistor
CPUTIN:        +34.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
AUXTIN:        +36.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
PECI Agent 0:  +36.0=B0C
cpu0_vid:     +2.050 V
intrusion0:   ALARM
intrusion1:   ALARM

Is the mainboard not yet supported, or do I have to configure
something differently?

--CC

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
