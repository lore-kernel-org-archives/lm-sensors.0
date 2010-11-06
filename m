From: Alexandros Diamantidis <adia@hellug.gr>
Date: Sat, 06 Nov 2010 00:22:59 +0000
Subject: [lm-sensors] IT8721F fan control?
Message-Id: <20101106002259.GA1871@hellug.gr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello!

I've just gotten an ASUS M4A87TD/USB3 motherboard, which has an IT8721F
chip. Although I've enabled a "silent" BIOS setting, the new system runs
its fans pretty fast and noisily, so I'm interested in controlling their
speed for quieter operation.

After a few web searches, I gather that IT8721F isn't completely
supported yet but it's being worked on - so thanks a lot for your work
on this!

Anyway, I just wanted to report that with with the new driver from
http://khali.linux-fr.org/devel/misc/it87/, sensors reports:

--------------------------------------------------------------------
k10temp-pci-00c3
Adapter: PCI adapter
temp1:       +20.0=B0C  (high =3D +70.0=B0C, crit =3D +90.0=B0C) =20

radeon-pci-0500
Adapter: PCI adapter
temp1:       +50.0=B0C                                   =20

it8721-isa-0290
Adapter: ISA adapter
in0:         +2.81 V  (min =3D  +1.08 V, max =3D  +2.22 V)   ALARM
in1:         +2.76 V  (min =3D  +0.00 V, max =3D  +0.41 V)   ALARM
in2:         +1.31 V  (min =3D  +0.71 V, max =3D  +2.69 V)  =20
+3.3V:       +3.31 V  (min =3D  +5.66 V, max =3D  +5.35 V)   ALARM
in4:         +2.47 V  (min =3D  +0.74 V, max =3D  +0.88 V)   ALARM
in5:         +1.26 V  (min =3D  +1.33 V, max =3D  +2.76 V)   ALARM
in6:         +1.69 V  (min =3D  +2.48 V, max =3D  +0.35 V)   ALARM
3VSB:        +5.35 V  (min =3D  +5.71 V, max =3D  +1.30 V)   ALARM
Vbat:        +3.38 V
fan1:       1573 RPM  (min =3D   11 RPM)
fan2:       1819 RPM  (min =3D   11 RPM)
fan3:       1229 RPM  (min =3D   12 RPM)
temp1:       +28.0=B0C  (low  =3D +62.0=B0C, high =3D -118.0=B0C)  ALARM  s=
ensor =3D thermistor
temp2:       +23.0=B0C  (low  =3D -53.0=B0C, high =3D -35.0=B0C)  sensor =
=3D thermistor
temp3:      -128.0=B0C  (low  =3D  -9.0=B0C, high =3D  -2.0=B0C)  sensor =
=3D disabled
--------------------------------------------------------------------

From dmesg:

it87: Found IT8721F chip at 0x290, revision 1
ACPI: resource it87 [io  0x0295-0x0296] conflicts with ACPI region ECRE [io=
  0x0290-0x02af pref window disabled]
ACPI: This conflict may cause random problems and system instability
ACPI: If an ACPI driver is available for this device, you should use it ins=
tead of the native driver

It seems that pwmconfig doesn't do anything... should it have worked or
is support for fan control still incomplete?

For reference, with asus_atk0110 sensors reports:

--------------------------------------------------------------------
k10temp-pci-00c3
Adapter: PCI adapter
temp1:       +21.0=B0C  (high =3D +70.0=B0C, crit =3D +90.0=B0C)

atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:     +1.31 V  (min =3D  +0.80 V, max =3D  +1.60 V)
+3.3V Voltage:     +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
+5V Voltage:       +4.93 V  (min =3D  +4.50 V, max =3D  +5.50 V)
+12V Voltage:     +12.05 V  (min =3D +10.20 V, max =3D +13.80 V)
CPU Fan Speed:    675000 RPM  (min =3D  600 RPM)
Chassis Fan Speed:1844 RPM  (min =3D  600 RPM)
Power Fan Speed:  1240 RPM  (min =3D  600 RPM)
CPU Temperature:   +29.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
MB Temperature:    +23.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)

radeon-pci-0500
Adapter: PCI adapter
temp1:       +53.0=B0C
--------------------------------------------------------------------

sensors-detect from lm-sensors 3.1.2 reports:

Probing for Super-I/O at 0x2e/0x2f
[...]
Trying family `ITE'...                                      Yes
Found unknown chip with ID 0x8721
    (logical device 4 has address 0x290, could be sensors)


Thanks again,
Alexandros

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
