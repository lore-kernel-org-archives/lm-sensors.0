From: apetar@gmail.com (Petar Aleksich)
Date: Sat, 04 Nov 2006 16:47:44 +0000
Subject: [lm-sensors] sensors-detect: Found unknown chip with ID 0x8708
Message-Id: <20061104174744.2059b8b5@phearless.godzilla.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061102183140.595504b5@phearless.godzilla.com>
In-Reply-To: <20061102183140.595504b5@phearless.godzilla.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi Jean,

???? ??????, 04 ??? 2006 ? 14:27:51 +0100, Jean Delvare ??????:
> Hi Aleksic,
>=20
> On Thu, 2 Nov 2006 18:31:40 +0100, Petar Aleksich wrote:
> > I've been using lm_sensors ( i2c-i801, asb100, eeprom  ) for
> > months without any problems , recently after kernel upgrade from
> > 2.6.16 series to >=3D2.6.17 sensors-detect can't find any modules. =20
>=20
> What motherboard is this, please?

ASUS P4PE
http://www.digital-daily.com/motherboard/asus-p4pe/

> > ---------------------
> > Used:
> > sysfsutils-2.1.0
> > lm_sensors-2.10.1
> > gcc-4.4.1
> > glibc-2.4
> >=20
> > ---------------------------
> > # uname -a
> > Linux phearless 2.6.18-ck1-r1 #2 PREEMPT Thu Nov 2 13:38:21 CET 2006
> > i686 Intel(R) Celeron(R) CPU 1.70GHz GenuineIntel GNU/Linux
> > ---------------------------
> > # sensors-detect=20
> >=20
> > Do you want to scan the ISA I/O ports? (YES/no): Y
> > Probing for `National Semiconductor LM78' at 0x290...       No
> > Probing for `National Semiconductor LM78-J' at 0x290...     No
> > Probing for `National Semiconductor LM79' at 0x290...       No
> > Probing for `Winbond W83781D' at 0x290...                   No
> > Probing for `Winbond W83782D' at 0x290...                   No
> > Probing for `Winbond W83627HF' at 0x290...                  No
> > Probing for `Silicon Integrated Systems SIS5595'...         No
> > Probing for `VIA VT82C686 Integrated Sensors'...            No
> > Probing for `VIA VT8231 Integrated Sensors'...              No
> > Probing for `AMD K8 thermal sensors'...                     No
> > Probing for `IPMI BMC KCS' at 0xca0...                      No
> > Probing for `IPMI BMC SMIC' at 0xca8...                     No
> >=20
> > Some Super I/O chips may also contain sensors. We have to write to
> > standard I/O ports to probe them. This is usually safe.
> > Do you want to scan for Super I/O sensors? (YES/no): Y
> > Probing for Super-I/O at 0x2e/0x2f
> > Trying family `ITE'...                                      No
> > Trying family `National Semiconductor'...                   No
> > Trying family `SMSC'...                                     No
> > Trying family `VIA/Winbond/Fintek'...                       Yes
> > Found unknown chip with ID 0x8708
>=20
> This is unrelated with your problem, but thanks for reporting. This is
> most certainly an ITE IT8708 chip, although I'm surprised it is
> detected in the wrong family. If you have physical access to the
> system, can you please take a look and locate the Super-I/O chip to
> confirm that it is an ITE IT8708? It should look like this but with a
> different top marking:
> http://www.beareyes.net/2/lib/200603/31/007/DSCN9815.jpg

Yes it is, to be precise ITE IT8708F-A

> We don't have any documentation for this chip, I doubt it has any
> hardware monitoring features, and if it had, they would certainly not
> be used on your motherboard, as you say it has a dedicated chip for
> that (Asus ASB100 "Bach").

I can't tell if this chip has any hardware monitoring features or not,
but on kernels prior to 2.6.17 i've used ASB100 successfully.=20
HTH

> > Probing for Super-I/O at 0x4e/0x4f
> > Trying family `ITE'...                                      No
> > Trying family `National Semiconductor'...                   No
> > Trying family `SMSC'...                                     No
> > Trying family `VIA/Winbond/Fintek'...                       No
> >=20
> > Sorry, no sensors were detected.
> > Either your sensors are not supported, or they are connected to an
> > I2C or SMBus adapter that is not supported. See doc/FAQ,
> > doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
> > (FAQ #4.24.3) for further information.
> > If you find out what chips are on your board, check
> > http://www.lm-sensors.org/wiki/Devices for driver status.
> >=20
> > ----------------------------
> > # sensors -s
> > No sensors found!
> > Make sure you loaded all the kernel drivers you need.
> > Try sensors-detect to find out which these are.
> > ----------------------------
> >=20
> > # grep "I2C" /usr/src/linux-`uname -r`/.config
> >=20
> > # I2C support
> > CONFIG_I2C=3Dm
> > CONFIG_I2C_CHARDEV=3Dm
> > # I2C Algorithms
> > CONFIG_I2C_ALGOBIT=3Dm
> > CONFIG_I2C_ALGOPCF=3Dm
> > CONFIG_I2C_ALGOPCA=3Dm
> > # I2C Hardware Bus support
> > CONFIG_I2C_ALI1535=3Dm
> > CONFIG_I2C_ALI1563=3Dm
> > CONFIG_I2C_ALI15X3=3Dm
> > CONFIG_I2C_AMD756=3Dm
> > CONFIG_I2C_AMD756_S4882=3Dm
> > CONFIG_I2C_AMD8111=3Dm
> > CONFIG_I2C_ELEKTOR=3Dm
> > CONFIG_I2C_I801=3Dm
> > CONFIG_I2C_I810=3Dm
> > CONFIG_I2C_PIIX4=3Dm
> > CONFIG_I2C_ISA=3Dm
> > CONFIG_I2C_NFORCE2=3Dm
> > CONFIG_I2C_OCORES=3Dm
> > CONFIG_I2C_PARPORT=3Dm
> > CONFIG_I2C_PARPORT_LIGHT=3Dm
> > CONFIG_I2C_PROSAVAGE=3Dm
> > CONFIG_I2C_SAVAGE4=3Dm
> > CONFIG_I2C_SIS5595=3Dm
> > CONFIG_I2C_SIS630=3Dm
> > CONFIG_I2C_SIS96X=3Dm
> > CONFIG_I2C_STUB=3Dm
> > CONFIG_I2C_VIA=3Dm
> > CONFIG_I2C_VIAPRO=3Dm
> > CONFIG_I2C_VOODOO3=3Dm
> > CONFIG_I2C_PCA_ISA=3Dm
> > # Miscellaneous I2C Chip support
> > # CONFIG_I2C_DEBUG_CORE is not set
> > # CONFIG_I2C_DEBUG_ALGO is not set
> > # CONFIG_I2C_DEBUG_BUS is not set
> > # CONFIG_I2C_DEBUG_CHIP is not set
> >=20
> > -----------------------
> > # egrep "(HWM|SENSORS)" /usr/src/linux-`uname -r`/.config
> >=20
> > CONFIG_SENSORS_DS1337=3Dm
> > CONFIG_SENSORS_DS1374=3Dm
> > CONFIG_SENSORS_EEPROM=3Dm
> > CONFIG_SENSORS_PCF8574=3Dm
> > CONFIG_SENSORS_PCA9539=3Dm
> > CONFIG_SENSORS_PCF8591=3Dm
> > CONFIG_SENSORS_MAX6875=3Dm
> > CONFIG_HWMON=3Dm
> > CONFIG_HWMON_VID=3Dm
> > CONFIG_SENSORS_ABITUGURU=3Dm
> > CONFIG_SENSORS_ADM1021=3Dm
> > CONFIG_SENSORS_ADM1025=3Dm
> > CONFIG_SENSORS_ADM1026=3Dm
> > CONFIG_SENSORS_ADM1031=3Dm
> > CONFIG_SENSORS_ADM9240=3Dm
> > CONFIG_SENSORS_ASB100=3Dm
> > CONFIG_SENSORS_ATXP1=3Dm
> > CONFIG_SENSORS_DS1621=3Dm
> > CONFIG_SENSORS_F71805F=3Dm
> > CONFIG_SENSORS_FSCHER=3Dm
> > CONFIG_SENSORS_FSCPOS=3Dm
> > CONFIG_SENSORS_GL518SM=3Dm
> > CONFIG_SENSORS_GL520SM=3Dm
> > CONFIG_SENSORS_IT87=3Dm
> > CONFIG_SENSORS_LM63=3Dm
> > CONFIG_SENSORS_LM75=3Dm
> > CONFIG_SENSORS_LM77=3Dm
> > CONFIG_SENSORS_LM78=3Dm
> > CONFIG_SENSORS_LM80=3Dm
> > CONFIG_SENSORS_LM83=3Dm
> > CONFIG_SENSORS_LM85=3Dm
> > CONFIG_SENSORS_LM87=3Dm
> > CONFIG_SENSORS_LM90=3Dm
> > CONFIG_SENSORS_LM92=3Dm
> > CONFIG_SENSORS_MAX1619=3Dm
> > CONFIG_SENSORS_PC87360=3Dm
> > CONFIG_SENSORS_SIS5595=3Dm
> > CONFIG_SENSORS_SMSC47M1=3Dm
> > CONFIG_SENSORS_SMSC47M192=3Dm
> > CONFIG_SENSORS_SMSC47B397=3Dm
> > CONFIG_SENSORS_VIA686A=3Dm
> > CONFIG_SENSORS_VT8231=3Dm
> > CONFIG_SENSORS_W83781D=3Dm
> > CONFIG_SENSORS_W83791D=3Dm
> > CONFIG_SENSORS_W83792D=3Dm
> > CONFIG_SENSORS_W83L785TS=3Dm
> > CONFIG_SENSORS_W83627HF=3Dm
> > CONFIG_SENSORS_W83627EHF=3Dm
> > CONFIG_SENSORS_HDAPS=3Dm
> > # CONFIG_HWMON_DEBUG_CHIP is not set
> >=20
> > -------------
> >=20
> >  # lspci -v
> > 00:00.0 Host bridge: Intel Corporation 82845G/GL[Brookdale-G]/GE/PE
> > DRAM Controller/Host-Hub Interface (rev 02) Subsystem: ASUSTeK
> > Computer Inc. Unknown device 80b2 Flags: bus master, fast devsel,
> > latency 0 Memory at e0000000 (32-bit, prefetchable) [size%6M]
> > 	Capabilities: [e4] Vendor Specific Information
> > 	Capabilities: [a0] AGP version 2.0
> >=20
> > 00:01.0 PCI bridge: Intel Corporation 82845G/GL[Brookdale-G]/GE/PE
> > Host-to-AGP Bridge (rev 02) (prog-if 00 [Normal decode]) Flags: bus
> > master, 66MHz, fast devsel, latency 64 Bus: primary=00,
> > secondary=01, subordinate=01, sec-latency=3D0 I/O behind bridge:
> > 0000d000-0000dfff Memory behind bridge: c6800000-c7efffff
> > 	Prefetchable memory behind bridge: c8000000-dfffffff
> >=20
> > 00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
> > (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 02) (prog-if 00
> > [UHCI]) Subsystem: ASUSTeK Computer Inc. Unknown device 8089 Flags:
> > bus master, medium devsel, latency 0, IRQ 5 I/O ports at b800
> > [size2]
> >=20
> > 00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
> > (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 02) (prog-if 00
> > [UHCI]) Subsystem: ASUSTeK Computer Inc. Unknown device 8089 Flags:
> > bus master, medium devsel, latency 0, IRQ 9 I/O ports at b400
> > [size2]
> >=20
> > 00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
> > (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 02) (prog-if 00
> > [UHCI]) Subsystem: ASUSTeK Computer Inc. Unknown device 8089 Flags:
> > bus master, medium devsel, latency 0, IRQ 9 I/O ports at b000
> > [size2]
> >=20
> > 00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M)
> > USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI]) Subsystem: ASUSTeK
> > Computer Inc. Unknown device 8089 Flags: bus master, medium devsel,
> > latency 0, IRQ 11 Memory at c6000000 (32-bit, non-prefetchable)
> > [size=3D1K] Capabilities: [50] Power Management version 2
> > 	Capabilities: [58] Debug port
> >=20
> > 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 82)
> > (prog-if 00 [Normal decode]) Flags: bus master, fast devsel,
> > latency 0 Bus: primary=00, secondary=02, subordinate=02,
> > sec-latency2 I/O behind bridge: 00009000-0000afff
> > 	Memory behind bridge: c3800000-c5ffffff
> > 	Prefetchable memory behind bridge: c7f00000-c7ffffff
> >=20
> > 00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL (ICH4/ICH4-L) LPC
> > Interface Bridge (rev 02) Flags: bus master, medium devsel, latency
> > 0
> >=20
> > 00:1f.1 IDE interface: Intel Corporation 82801DB (ICH4) IDE
> > Controller (rev 02) (prog-if 8a [Master SecP PriP]) Subsystem:
> > ASUSTeK Computer Inc. Unknown device 8089 Flags: bus master, medium
> > devsel, latency 0, IRQ 9 I/O ports at <unassigned>
> > 	I/O ports at <unassigned>
> > 	I/O ports at <unassigned>
> > 	I/O ports at <unassigned>
> > 	I/O ports at f000 [size=16]
> > 	Memory at 30000000 (32-bit, non-prefetchable) [size=3D1K]
> >=20
> > 00:1f.5 Multimedia audio controller: Intel Corporation
> > 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev
> > 02) Subsystem: ASUSTeK Computer Inc. Unknown device 80b0 Flags: bus
> > master, medium devsel, latency 0, IRQ 9 I/O ports at 8800 [size%6]
> > 	I/O ports at 8400 [sized]
> > 	Memory at c3000000 (32-bit, non-prefetchable) [sizeQ2]
> > 	Memory at c2800000 (32-bit, non-prefetchable) [size%6]
> > 	Capabilities: [50] Power Management version 2
>=20
> The SMBus device is missing, it should show at address 00:1f.3. That
> explains why sensors-detect didn't find your hardware monitoring
> chips. You are most certainly affected by this change:
>=20
> http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommit;h=CE007ea59729d627f62bb5fa8c1a81e25653a0ad
>
>
> Long story short, Asus is hiding the SMBus on many boards, Linux tries
> to unhide them, but it is dangerous to do so when suspend/resume
> support is enabled, so since 2.6.17 the quirk which unhides the SMBus
> is disabled when suspend support is enabled.
>=20
> If you want your sensors back, you'll need to disable suspend support
> for now ("Sleep States" in the ACPI menu.) I know it is a regression
> for some users, but that's the only safe way until the kernel is
> taught how to replay PCI quirks on resume.
>=20
> Alternatively you can go bug Asus and ask them why they hide the SMBus
> in the first place.

Thank you, removing Sleep States from krenel did the magic thing.
My sensors are back in normal.

$ sensors
asb100-i2c-0-2d
Adapter: SMBus I801 adapter at e800
VCore 1:   +1.81 V  (min =3D  +1.39 V, max =3D  +2.08 V)      =20
+3.3V:     +3.28 V  (min =3D  +2.96 V, max =3D  +3.63 V)      =20
+5V:       +5.13 V  (min =3D  +4.49 V, max =3D  +5.51 V)      =20
+12V:     +11.13 V  (min =3D  +9.55 V, max =3D +14.41 V)      =20
-12V (reserved):
          -11.62 V  (min =3D  -0.00 V, max =3D  -0.00 V)      =20
-5V (reserved):
           -4.88 V  (min =3D  -0.00 V, max =3D  -0.00 V)      =20
CPU Fan:  3391 RPM  (min =3D   -1 RPM, div =3D 2)              ALARM
Chassis Fan:
          1997 RPM  (min =3D   -1 RPM, div =3D 4)              ALARM
Power Fan:   0 RPM  (min =3D   -1 RPM, div =3D 8)              ALARM
M/B Temp:    +31?C  (high =3D   +80?C, hyst =3D   +75?C)  =20
CPU Temp (Intel):
             +42?C  (high =3D  +100?C, hyst =3D   +90?C)  =20
Power Temp:
              -0?C  (high =3D   +60?C, hyst =3D   +50?C)  =20
CPU Temp (AMD):
             +25?C  (high =3D   +80?C, hyst =3D   +75?C)  =20
vid:      +1.750 V  (VRM Version 9.0)
alarms:  =20

=20
> > 01:00.0 VGA compatible controller: ATI Technologies Inc R420 JP
> > [Radeon X800XT] (prog-if 00 [VGA]) Subsystem: ATI Technologies Inc
> > Unknown device 0002 Flags: bus master, 66MHz, medium devsel,
> > latency 255, IRQ 5 Memory at d8000000 (32-bit, prefetchable)
> > [size=128M] I/O ports at d800 [size%6]
> > 	Memory at c7000000 (32-bit, non-prefetchable) [sizedK]
> > 	Expansion ROM at d7fe0000 [disabled] [size=128K]
> > 	Capabilities: [58] AGP version 2.0
> > 	Capabilities: [50] Power Management version 2
> >=20
> > 01:00.1 Display controller: ATI Technologies Inc R420 [X800XT-PE]
> > (Secondary) Subsystem: ATI Technologies Inc Unknown device 0003
> > 	Flags: bus master, 66MHz, medium devsel, latency 64
> > 	Memory at c8000000 (32-bit, prefetchable) [size=128M]
> > 	Memory at c6800000 (32-bit, non-prefetchable) [sizedK]
> > 	Capabilities: [50] Power Management version 2
> >=20
> > 02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
> > Controller (rev 80) (prog-if 10 [OHCI]) Subsystem: VIA Technologies,
> > Inc. IEEE 1394 Host Controller Flags: bus master, stepping, medium
> > devsel, latency 32, IRQ 9 Memory at c5800000 (32-bit,
> > non-prefetchable) [size=3D2K] I/O ports at a800 [size=128]
> > 	Capabilities: [50] Power Management version 2
> >=20
> > 02:04.0 RAID bus controller: Promise Technology, Inc. PDC20376
> > (FastTrak 376) (rev 02) Subsystem: ASUSTeK Computer Inc. A7V8X
> > motherboard Flags: bus master, 66MHz, medium devsel, latency 96,
> > IRQ 11 I/O ports at a400 [sized]
> > 	I/O ports at a000 [size=16]
> > 	I/O ports at 9800 [size=128]
> > 	Memory at c5000000 (32-bit, non-prefetchable) [size=3D4K]
> > 	Memory at c4800000 (32-bit, non-prefetchable) [size=128K]
> > 	Capabilities: [60] Power Management version 2
> >=20
> > 02:05.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702X
> > Gigabit Ethernet (rev 02) Subsystem: ASUSTeK Computer Inc. Unknown
> > device 80a9 Flags: bus master, 66MHz, medium devsel, latency 64,
> > IRQ 10 Memory at c4000000 (64-bit, non-prefetchable) [sizedK]
> > 	[virtual] Expansion ROM at c7ff0000 [disabled] [sizedK]
> > 	Capabilities: [40] PCI-X non-bridge device
> > 	Capabilities: [48] Power Management version 2
> > 	Capabilities: [50] Vital Product Data
> > 	Capabilities: [58] Message Signalled Interrupts: 64bit+
> > Queue=3D0/3 Enable-
> >=20
> > 02:0a.0 Ethernet controller: VIA Technologies, Inc. VT6105
> > [Rhine-III] (rev 86) Subsystem: D-Link System Inc DFE-530TX rev C
> > 	Flags: bus master, stepping, medium devsel, latency 32, IRQ
> > 9 I/O ports at 9400 [size%6]
> > 	Memory at c3800000 (32-bit, non-prefetchable) [size%6]
> > 	[virtual] Expansion ROM at c7f00000 [disabled] [sizedK]
> > 	Capabilities: [40] Power Management version 2
>=20


--=20
Aleksic Predrag
GPG:41FB 6E3A 418E 8752 520D D0F3 E93C D51E 9972 7570

