From: Daimonos Tereutes <tereutes@nainwak.com>
Date: Fri, 09 Jan 2009 16:42:40 +0000
Subject: Re: [lm-sensors] k8temp on K8 rev.F and rev.G: Testers wanted
Message-Id: <49677E80.6090206@nainwak.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060208040502070900040909"
List-Id: <lm-sensors.vger.kernel.org>
References: <20090109160702.466b8a6f@hyperion.delvare>
In-Reply-To: <20090109160702.466b8a6f@hyperion.delvare>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060208040502070900040909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jean Delvare a =E9crit :
> Hi all,
>=20
> I am done reviewing and testing Andreas' k8temp patches. After some
> reorganization I came up with the following stack:
>=20
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-k8temp-0=
1-warn-about-errata.patch
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-k8temp-0=
2-fix-wrong-sensor-selection-for-revf-revg.patch
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-k8temp-0=
3-fix-temperature-reporting-for-most-revg.patch
>=20
> These are in linux-next at the moment, and I'd like to push them to
> Linus quickly. But I do not own any rev.F nor rev.G CPU myself, so I
> couldn't really test the patches, other than ensure that they do not
> cause a regression on earlier K8 CPUs.
>=20
> So this is a call to owners of rev.F and rev.G K8 CPUs, to try these
> patches and report how they are doing. There's also a standalone
> version of the updated driver at:
>   http://jdelvare.pck.nerim.net/sensors/k8temp/
> if it is easier for you.
>=20
> Thanks,
Hello,
Seems working well on my hardware.

Thanks for the work.

--------------060208040502070900040909
Content-Type: text/plain;
 name="k8temp_2.6.27-gentoo-r7_idle.txt"
Content-Disposition: inline;
 filename="k8temp_2.6.27-gentoo-r7_idle.txt"
Content-Transfer-Encoding: quoted-printable

acpitz-virtual-0
Adapter: Virtual device
temp1:       +40.0=C2=B0C  (crit =3D +75.0=C2=B0C)                 =20

adt7475-i2c-0-2e
Adapter: SMBus nForce2 adapter at 1c00
+3.3V:            +3.20 V  (min =3D  +0.00 V, max =3D  +4.38 V)  =20
Chassis Fan 3:      0 RPM  (min =3D    0 RPM)
Chassis Fan 4:      0 RPM  (min =3D    0 RPM)
Power Supply Fan:   0 RPM  (min =3D    0 RPM)
Chassis Fan 5:      0 RPM  (min =3D    0 RPM)
ADT7475 Temp:     +40.2=C2=B0C  (low  =3D -63.0=C2=B0C, high =3D +191.0=C2=
=B0C) =20
                           (crit =3D +100.0=C2=B0C, hyst =3D +96.0=C2=B0C=
) =20

it8716-isa-0290
Adapter: ISA adapter
VCore:         +1.06 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
+3.3V:         +3.20 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
+5V:           +4.95 V  (min =3D  +0.00 V, max =3D  +6.85 V)  =20
+12V:         +12.10 V  (min =3D  +0.00 V, max =3D +16.32 V)  =20
VDDR:          +1.83 V  (min =3D  +0.00 V, max =3D  +2.04 V)  =20
5VSB:          +4.95 V  (min =3D  +0.00 V, max =3D  +6.85 V)  =20
VBat:          +3.12 V
CPU Fan:      2481 RPM  (min =3D 3245 RPM)  ALARM
Chassis Fan 1:   0 RPM  (min =3D 3245 RPM)  ALARM
Chassis Fan 2:   0 RPM  (min =3D    0 RPM)
CPU Temp:      +35.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0=
C)  sensor =3D thermistor
MB Temp:       +35.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0=
C)  sensor =3D thermistor
Chassis Temp:  +34.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0=
C)  sensor =3D thermistor
cpu0_vid:     +1.550 V

k8temp-pci-00c3
Adapter: PCI adapter
core0 temp0:  +4.0=C2=B0C                                   =20
core0 temp1:  +5.0=C2=B0C                                   =20
core1 temp0:  +8.0=C2=B0C                                   =20
core1 temp1:  -1.0=C2=B0C                                   =20


--------------060208040502070900040909
Content-Type: text/plain;
 name="k8temp_2.6.27-gentoo-r7_loaded.txt"
Content-Disposition: inline;
 filename="k8temp_2.6.27-gentoo-r7_loaded.txt"
Content-Transfer-Encoding: quoted-printable

acpitz-virtual-0
Adapter: Virtual device
temp1:       +40.0=C2=B0C  (crit =3D +75.0=C2=B0C)                 =20

adt7475-i2c-0-2e
Adapter: SMBus nForce2 adapter at 1c00
+3.3V:            +3.20 V  (min =3D  +0.00 V, max =3D  +4.38 V)  =20
Chassis Fan 3:      0 RPM  (min =3D    0 RPM)
Chassis Fan 4:      0 RPM  (min =3D    0 RPM)
Power Supply Fan:   0 RPM  (min =3D    0 RPM)
Chassis Fan 5:      0 RPM  (min =3D    0 RPM)
ADT7475 Temp:     +44.8=C2=B0C  (low  =3D -63.0=C2=B0C, high =3D +191.0=C2=
=B0C) =20
                           (crit =3D +100.0=C2=B0C, hyst =3D +96.0=C2=B0C=
) =20

it8716-isa-0290
Adapter: ISA adapter
VCore:         +1.26 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
+3.3V:         +3.20 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
+5V:           +4.95 V  (min =3D  +0.00 V, max =3D  +6.85 V)  =20
+12V:         +12.03 V  (min =3D  +0.00 V, max =3D +16.32 V)  =20
VDDR:          +1.83 V  (min =3D  +0.00 V, max =3D  +2.04 V)  =20
5VSB:          +4.95 V  (min =3D  +0.00 V, max =3D  +6.85 V)  =20
VBat:          +3.12 V
CPU Fan:      2472 RPM  (min =3D 3245 RPM)  ALARM
Chassis Fan 1:   0 RPM  (min =3D 3245 RPM)  ALARM
Chassis Fan 2:   0 RPM  (min =3D    0 RPM)
CPU Temp:      +44.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0=
C)  sensor =3D thermistor
MB Temp:       +34.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0=
C)  sensor =3D thermistor
Chassis Temp:  +41.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0=
C)  sensor =3D thermistor
cpu0_vid:     +1.550 V

k8temp-pci-00c3
Adapter: PCI adapter
core0 temp0: +24.0=C2=B0C                                   =20
core0 temp1: +24.0=C2=B0C                                   =20
core1 temp0: +23.0=C2=B0C                                   =20
core1 temp1: +20.0=C2=B0C                                   =20


--------------060208040502070900040909
Content-Type: text/plain;
 name="k8temp_2.6.27-gentoo-r7+patches_idle.txt"
Content-Disposition: inline;
	filename="k8temp_2.6.27-gentoo-r7+patches_idle.txt"
Content-Transfer-Encoding: quoted-printable

acpitz-virtual-0
Adapter: Virtual device
temp1:       +40.0=C2=B0C  (crit =3D +75.0=C2=B0C)                 =20

adt7475-i2c-0-2e
Adapter: SMBus nForce2 adapter at 1c00
+3.3V:            +3.20 V  (min =3D  +0.00 V, max =3D  +4.38 V)  =20
Chassis Fan 3:      0 RPM  (min =3D    0 RPM)
Chassis Fan 4:      0 RPM  (min =3D    0 RPM)
Power Supply Fan:   0 RPM  (min =3D    0 RPM)
Chassis Fan 5:      0 RPM  (min =3D    0 RPM)
ADT7475 Temp:     +39.5=C2=B0C  (low  =3D -63.0=C2=B0C, high =3D +191.0=C2=
=B0C) =20
                           (crit =3D +100.0=C2=B0C, hyst =3D +96.0=C2=B0C=
) =20

it8716-isa-0290
Adapter: ISA adapter
VCore:         +1.06 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
+3.3V:         +3.20 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
+5V:           +4.95 V  (min =3D  +0.00 V, max =3D  +6.85 V)  =20
+12V:         +12.10 V  (min =3D  +0.00 V, max =3D +16.32 V)  =20
VDDR:          +1.83 V  (min =3D  +0.00 V, max =3D  +2.04 V)  =20
5VSB:          +4.95 V  (min =3D  +0.00 V, max =3D  +6.85 V)  =20
VBat:          +3.12 V
CPU Fan:      2481 RPM  (min =3D 3245 RPM)  ALARM
Chassis Fan 1:   0 RPM  (min =3D 3245 RPM)  ALARM
Chassis Fan 2:   0 RPM  (min =3D    0 RPM)
CPU Temp:      +34.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0=
C)  sensor =3D thermistor
MB Temp:       +35.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0=
C)  sensor =3D thermistor
Chassis Temp:  +34.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0=
C)  sensor =3D thermistor
cpu0_vid:     +1.550 V

k8temp-pci-00c3
Adapter: PCI adapter
core0 temp0: +29.0=C2=B0C                                   =20
core0 temp1: +19.0=C2=B0C                                   =20
core1 temp0: +25.0=C2=B0C                                   =20
core1 temp1: +25.0=C2=B0C                                   =20


--------------060208040502070900040909
Content-Type: text/plain;
 name="k8temp_2.6.27-gentoo-r7+patches_loaded.txt"
Content-Disposition: inline;
	filename="k8temp_2.6.27-gentoo-r7+patches_loaded.txt"
Content-Transfer-Encoding: quoted-printable

acpitz-virtual-0
Adapter: Virtual device
temp1:       +40.0=C2=B0C  (crit =3D +75.0=C2=B0C)                 =20

adt7475-i2c-0-2e
Adapter: SMBus nForce2 adapter at 1c00
+3.3V:            +3.20 V  (min =3D  +0.00 V, max =3D  +4.38 V)  =20
Chassis Fan 3:      0 RPM  (min =3D    0 RPM)
Chassis Fan 4:      0 RPM  (min =3D    0 RPM)
Power Supply Fan:   0 RPM  (min =3D    0 RPM)
Chassis Fan 5:      0 RPM  (min =3D    0 RPM)
ADT7475 Temp:     +44.0=C2=B0C  (low  =3D -63.0=C2=B0C, high =3D +191.0=C2=
=B0C) =20
                           (crit =3D +100.0=C2=B0C, hyst =3D +96.0=C2=B0C=
) =20

it8716-isa-0290
Adapter: ISA adapter
VCore:         +1.26 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
+3.3V:         +3.20 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
+5V:           +4.95 V  (min =3D  +0.00 V, max =3D  +6.85 V)  =20
+12V:         +12.03 V  (min =3D  +0.00 V, max =3D +16.32 V)  =20
VDDR:          +1.83 V  (min =3D  +0.00 V, max =3D  +2.04 V)  =20
5VSB:          +4.95 V  (min =3D  +0.00 V, max =3D  +6.85 V)  =20
VBat:          +3.12 V
CPU Fan:      2472 RPM  (min =3D 3245 RPM)  ALARM
Chassis Fan 1:   0 RPM  (min =3D 3245 RPM)  ALARM
Chassis Fan 2:   0 RPM  (min =3D    0 RPM)
CPU Temp:      +44.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0=
C)  sensor =3D thermistor
MB Temp:       +34.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0=
C)  sensor =3D thermistor
Chassis Temp:  +41.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0=
C)  sensor =3D thermistor
cpu0_vid:     +1.550 V

k8temp-pci-00c3
Adapter: PCI adapter
core0 temp0: +44.0=C2=B0C                                   =20
core0 temp1: +39.0=C2=B0C                                   =20
core1 temp0: +43.0=C2=B0C                                   =20
core1 temp1: +43.0=C2=B0C                                   =20


--------------060208040502070900040909
Content-Type: text/plain;
 name="syslog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog.txt"

Jan  9 17:23:46 cafe k8temp 0000:00:18.3: Temperature readouts might be wrong - check erratum #141

--------------060208040502070900040909
Content-Type: text/plain;
 name="x86info.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x86info.txt"

x86info v1.23.  Dave Jones 2001-2008
Feedback to <davej@redhat.com>.

Found 2 CPUs
--------------------------------------------------------------------------
CPU #1
EFamily: 0 EModel: 6 Family: 15 Model: 107 Stepping: 2
CPU Model: Athlon 64 X2 Dual-Core (BH-G2)
Processor name string: AMD Athlon(tm) X2 Dual Core Processor BE-2350
SVM: revision 1, 64 ASIDs, lbrVirt
Address Size: 48 bits virtual, 40 bits physical
The physical package has 2 of 2 possible cores implemented.
--------------------------------------------------------------------------
CPU #2
EFamily: 0 EModel: 6 Family: 15 Model: 107 Stepping: 2
CPU Model: Athlon 64 X2 Dual-Core (BH-G2)
Processor name string: AMD Athlon(tm) X2 Dual Core Processor BE-2350
SVM: revision 1, 64 ASIDs, lbrVirt
Address Size: 48 bits virtual, 40 bits physical
The physical package has 2 of 2 possible cores implemented.
--------------------------------------------------------------------------

--------------060208040502070900040909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060208040502070900040909--
