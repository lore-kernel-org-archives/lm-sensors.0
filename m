From: Clive Messer <clive@vacuumtube.org.uk>
Date: Tue, 07 Apr 2009 17:11:32 +0000
Subject: [lm-sensors] atk0110 tested with Asus Rampage II Extreme
Message-Id: <200904071811.32265.clive@vacuumtube.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


atk0110 driver output from Asus Rampage II Extreme (Core i7 / X58)

Now that's what I call a sensor list! ;-)

[clivem@c7p6t:/etc/sensors.d]$ sensors                              =20
atk0110-acpi-0                                                      =20
Adapter: ACPI interface                                             =20
3.3V Voltage:          +3.33 V  (min =3D  +2.97 V, max =3D  +3.63 V)    =20
5V Voltage:            +4.97 V  (min =3D  +4.50 V, max =3D  +5.50 V)    =20
12V Voltage:          +11.91 V  (min =3D +10.20 V, max =3D +13.80 V)    =20
CPU Voltage:           +1.25 V  (min =3D  +0.80 V, max =3D  +1.80 V)    =20
CPU PLL Voltage:       +1.82 V  (min =3D  +1.50 V, max =3D  +2.00 V)    =20
QPI/DRAM Core Voltage: +1.39 V  (min =3D  +0.80 V, max =3D  +1.50 V)    =20
IOH Voltage:           +1.08 V  (min =3D  +0.90 V, max =3D  +1.35 V)    =20
IOH PCIE Voltage:      +1.51 V  (min =3D  +1.20 V, max =3D  +1.80 V)    =20
ICH Voltage:           +1.12 V  (min =3D  +0.90 V, max =3D  +1.35 V)    =20
ICH PCIE Voltage:      +1.51 V  (min =3D  +1.20 V, max =3D  +1.80 V)    =20
DRAM Bus Voltage:      +1.64 V  (min =3D  +1.40 V, max =3D  +1.90 V)    =20
CPU FAN Speed:        4429 RPM  (min =3D  600 RPM)                    =20
CHA_FAN1 FAN Speed:   4478 RPM  (min =3D  600 RPM)                    =20
CHA_FAN2 FAN Speed:      0 RPM  (min =3D  600 RPM)                    =20
CHA_FAN3 FAN Speed:   3015 RPM  (min =3D  600 RPM)                    =20
PWR_FAN FAN Speed:    1713 RPM  (min =3D  600 RPM)                    =20
OPT_FAN1 FAN Speed:      0 RPM  (min =3D  600 RPM)                    =20
OPT_FAN2 FAN Speed:      0 RPM  (min =3D  600 RPM)                    =20
OPT_FAN3 FAN Speed:      0 RPM  (min =3D  600 RPM)                    =20
CPU Temperature:       +36.0=B0C  (high =3D +60.0=B0C, crit =3D +65.0=B0C) =
   =20
MB Temperature:        +32.0=B0C  (high =3D +45.0=B0C, crit =3D +55.0=B0C) =
   =20
SB Temperature:        +44.0=B0C  (high =3D +65.0=B0C, crit =3D +65.0=B0C) =
   =20
NB Temperature:        +47.0=B0C  (high =3D +80.0=B0C, crit =3D +80.0=B0C) =
   =20
OPT_FAN1 Temperature:   +0.0=B0C  (high =3D +45.0=B0C, crit =3D +45.0=B0C)
OPT_FAN2 Temperature:   +0.0=B0C  (high =3D +45.0=B0C, crit =3D +45.0=B0C)
OPT_FAN3 Temperature:   +0.0=B0C  (high =3D +45.0=B0C, crit =3D +45.0=B0C)

Regards

Clive
--=20
Clive Messer <clive@vacuumtube.org.uk>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
