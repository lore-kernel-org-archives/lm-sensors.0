From: Harald Judt <h.judt@gmx.at>
Date: Mon, 22 Oct 2012 15:03:45 +0000
Subject: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <50856051.5070803@gmx.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

After resuming from suspend or hibernation, the Vbat value is reported=20
to be 0.0. Before that, it reported the correct value. Min/max values=20
are wrong too.

Linux-3.6.2, ASRock Z77 Extreme4 BIOS v1.80.

Before suspend:
nct6776-isa-0290
Adapter: ISA adapter
Vcore:         +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:           +1.84 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
AVCC:          +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:         +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:           +1.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in5:           +1.68 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:          +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:          +3.31 V  (min =3D  +2.70 V, max =3D  +3.63 V)
fan1:            0 RPM  (min =3D    0 RPM)  ALARM
fan2:         1289 RPM  (min =3D    0 RPM)  ALARM
fan3:          724 RPM  (min =3D    0 RPM)  ALARM
fan4:          661 RPM  (min =3D    0 RPM)  ALARM
fan5:         1076 RPM  (min =3D    0 RPM)  ALARM
SYSTIN:        +37.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor=20
=3D thermistor
CPUTIN:        +28.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D=20
thermistor
AUXTIN:        +33.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D=20
thermistor
PECI Agent 0:  +32.0=B0C
cpu0_vid:     +0.000 V
intrusion0:   ALARM
intrusion1:   ALARM

After resuming:
nct6776-isa-0290
Adapter: ISA adapter
Vcore:         +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:           +1.84 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
AVCC:          +3.34 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
+3.3V:         +3.34 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in4:           +1.03 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in5:           +1.68 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:          +3.47 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
Vbat:          +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
fan1:            0 RPM  (min =3D    0 RPM)  ALARM
fan2:         1271 RPM  (min =3D    0 RPM)  ALARM
fan3:          734 RPM  (min =3D    0 RPM)  ALARM
fan4:          673 RPM  (min =3D    0 RPM)  ALARM
fan5:         1093 RPM  (min =3D    0 RPM)  ALARM
SYSTIN:        +36.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor=20
=3D thermistor
CPUTIN:        +26.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D=20
thermistor
AUXTIN:        +33.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D=20
thermistor
PECI Agent 0:  +30.0=B0C
cpu0_vid:     +0.000 V
intrusion0:   ALARM
intrusion1:   ALARM

Reloading the module helps. Of course, a fresh boot too ;-)

Harald

--=20
`Experience is the best teacher.'

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
