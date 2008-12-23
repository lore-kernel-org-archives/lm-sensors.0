From: Daimonos Tereutes <tereutes@nainwak.com>
Date: Tue, 23 Dec 2008 11:43:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add a driver for the
Message-Id: <4950CEE3.5090303@nainwak.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,
I'm using the patch for ADT7475 since the begining on an ASUS M2N32 WS
Professional without problem.

Here is the output with kernel 2.6.27-gentoo-r7 and your latest patch:

acpitz-virtual-0
Adapter: Virtual device
temp1:       +40.0=B0C  (crit =3D +75.0=B0C)

adt7475-i2c-0-2e
Adapter: SMBus nForce2 adapter at 1c00
+3.3V:            +3.29 V  (min =3D  +0.00 V, max =3D  +4.38 V)
Chassis Fan 3:      0 RPM  (min =3D    0 RPM)
Chassis Fan 4:      0 RPM  (min =3D    0 RPM)
Power Supply Fan:   0 RPM  (min =3D    0 RPM)
Chassis Fan 5:      0 RPM  (min =3D    0 RPM)
ADT7475 Temp:     +47.5=B0C  (low  =3D -63.0=B0C, high =3D +191.0=B0C)
                           (crit =3D +100.0=B0C, hyst =3D +96.0=B0C)

it8716-isa-0290
Adapter: ISA adapter
VCore:         +1.26 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+3.3V:         +3.28 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+5V:           +4.95 V  (min =3D  +0.00 V, max =3D  +6.85 V)
+12V:         +12.03 V  (min =3D  +0.00 V, max =3D +16.32 V)
-12V:          +1.82 V  (min =3D  +0.00 V, max =3D  +2.04 V)
5VSB:          +4.95 V  (min =3D  +0.00 V, max =3D  +6.85 V)
VBat:          +3.12 V
CPU Fan:      2436 RPM  (min =3D 3245 RPM)  ALARM
Chassis Fan 1:   0 RPM  (min =3D 3245 RPM)  ALARM
Chassis Fan 2:   0 RPM  (min =3D    0 RPM)
CPU Temp:      +47.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
MB Temp:       +38.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
Chassis Temp:  +40.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
cpu0_vid:     +1.550 V

k8temp-pci-00c3
Adapter: PCI adapter
core0 temp0: +45.0=B0C
core0 temp1: +44.0=B0C
core1 temp0: +46.0=B0C
core1 temp1: +41.0=B0C


All fans are present but are regulated either by motherboard's QFAN or other
integrated thermistor. I can read their speed only when temp is over 50=B0C=
 what
is quite rare.

Regards,
Fran=E7ois

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
