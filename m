From: Kevin Zhao <yingwuzhao@gmail.com>
Date: Wed, 19 Aug 2009 09:22:50 +0000
Subject: [lm-sensors] m sensors question, on core i7, please please help
Message-Id: <691a2bf40908190222n1fa8c3c8wd13bd5be6e372ef0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi, everyone, I have this strange issue with the lm-sensors, the
output of sensors for my core i7 on ASUS p6t mobo is very wired. It
report CPU temp as 50C, way more than the core temp. Since core-temp
is normally always higher than cpu temp, as shown in windows the cpu
temp is barely 40C. This is completely unusual. I open the case the
cpu heatsink is almost cold.

The problem caused by this is that the fan is constantly running at
its maximum speed, since it "thinks" the cpu is hot. I am really
confused, is the CPU really HOT? (I doubt) or is it simply lm-sensors
is giving non-senses out put?

Is this rummer really true that core i7 runner hotter for some strange
reason in linux than in windows?
Please help, and info is appreciated.

Code:
atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:      +0.94 V  (min =3D  +0.80 V, max =3D  +1.60 V)
 +3.3 Voltage:      +3.28 V  (min =3D  +2.97 V, max =3D  +3.63 V)
 +5 Voltage:        +5.14 V  (min =3D  +4.50 V, max =3D  +5.50 V)
 +12 Voltage:      +12.19 V  (min =3D +10.20 V, max =3D +13.80 V)
CPU FAN Speed:     1171 RPM  (min =3D  600 RPM)
CHASSIS1 FAN Speed:   0 RPM  (min =3D  600 RPM)
CHASSIS2 FAN Speed:   0 RPM  (min =3D  600 RPM)
POWER FAN Speed:      0 RPM  (min =3D    0 RPM)
CPU Temperature:    +50.0=B0C  (high =3D +60.0=B0C, crit =3D +75.0=B0C)
MB Temperature:     +47.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +40.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +36.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +40.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +37.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0004
Adapter: ISA adapter
Core 4:      +40.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0005
Adapter: ISA adapter
Core 5:      +36.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0006
Adapter: ISA adapter
Core 6:      +40.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0007
Adapter: ISA adapter
Core 7:      +37.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

w83627ehf-isa-0290
Adapter: ISA adapter
Vcore:       +0.94 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:         +1.74 V  (min =3D  +0.02 V, max =3D  +0.01 V)   ALARM
AVCC:        +3.31 V  (min =3D  +2.98 V, max =3D  +3.63 V)
VCC:         +3.28 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:         +1.71 V  (min =3D  +0.00 V, max =3D  +1.06 V)   ALARM
in5:         +2.04 V  (min =3D  +0.06 V, max =3D  +1.15 V)   ALARM
in6:         +1.62 V  (min =3D  +0.13 V, max =3D  +1.02 V)   ALARM
3VSB:        +3.36 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:        +3.25 V  (min =3D  +2.70 V, max =3D  +3.30 V)
in9:         +0.00 V  (min =3D  +1.60 V, max =3D  +0.03 V)   ALARM
fan1:          0 RPM  (min =3D 21093 RPM, div =3D 64)  ALARM
fan2:       1188 RPM  (min =3D    0 RPM, div =3D 16)  ALARM
fan3:          0 RPM  (min =3D 21093 RPM, div =3D 64)  ALARM
fan4:          0 RPM  (min =3D 21093 RPM, div =3D 64)  ALARM
fan5:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
temp1:       +47.0=B0C  (high =3D  +5.0=B0C, hyst =3D +10.0=B0C)  ALARM  se=
nsor
=3D thermistor
temp2:       +50.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
temp3:        -3.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
cpu0_vid:   +0.000 V

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
