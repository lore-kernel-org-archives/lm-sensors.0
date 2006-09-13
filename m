From: alejandro.riveira@gmail.com (Alejandro Riveira =?ISO-8859-1?Q?Fern=E1ndez?=)
Date: Wed, 13 Sep 2006 22:59:53 +0000
Subject: [lm-sensors] Module(s) ALI15** not loading
Message-Id: <1158188393.9914.5.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


        Hi I have changed my mobo, now i have an uli1697 based asrock
        AM2xli-esataII=20
       =20
        i'm seeing this in the dmesg
       =20
        ali1535_smbus 0000:00:15.1: ALI1535_smb region uninitialized - upgr=
ade BIOS?
        ali1535_smbus 0000:00:15.1: ALI1535 not detected, module not insert=
ed.
        ali15x3_smbus 0000:00:15.1: ALI15X3_smb region uninitialized - upgr=
ade BIOS or use force_addr=3D0xaddr
        ali15x3_smbus 0000:00:15.1: ALI15X3 not detected, module not insert=
ed.
       =20
        ?Does anybody has an idea of how to make it work?
       =20
       =20
        lspci -vx is:
       =20
       =20
0000:00:00.0 Host bridge: ALi Corporation: Unknown device 1697
	Flags: bus master, fast devsel, latency 0
	Capabilities: [40] #08 [00a0]
	Capabilities: [5c] #08 [a800]
	Capabilities: [68] #08 [9000]
	Capabilities: [74] #08 [8000]
	Capabilities: [7c] Message Signalled Interrupts: 64bit+ Queue=3D0/1
Enable-
00: b9 10 97 16 07 00 10 00 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: ALi Corporation: Unknown device 524b (prog-if
00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=3D0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: dc000000-deefffff
	Prefetchable memory behind bridge: c0000000-cfffffff
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=3D0/1
Enable-
	Capabilities: [58] #10 [0141]
	Capabilities: [7c] #08 [a800]
	Capabilities: [88] #08 [8825]
00: b9 10 4b 52 07 01 10 40 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 e0 e0 00 00
20: 00 dc e0 de 00 c0 f0 cf 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 0b 00

0000:00:02.0 PCI bridge: ALi Corporation: Unknown device 524c (prog-if
00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=3D0
	Prefetchable memory behind bridge: dad00000-dadfffff
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=3D0/1
Enable-
	Capabilities: [58] #10 [0141]
	Capabilities: [7c] #08 [a800]
	Capabilities: [88] #08 [8825]
00: b9 10 4c 52 06 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f0 00 00 00
20: f0 ff 00 00 d0 da d0 da 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 03 00

0000:00:03.0 PCI bridge: ALi Corporation: Unknown device 524d (prog-if
00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=3D0
	Prefetchable memory behind bridge: dae00000-daefffff
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=3D0/1
Enable-
	Capabilities: [58] #10 [0141]
	Capabilities: [7c] #08 [a800]
	Capabilities: [88] #08 [8825]
00: b9 10 4d 52 06 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 00 f0 00 00 00
20: f0 ff 00 00 e0 da e0 da 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 03 00

0000:00:04.0 PCI bridge: ALi Corporation: Unknown device 524e (prog-if
00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=3D0
	Prefetchable memory behind bridge: daf00000-daffffff
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=3D0/1
Enable-
	Capabilities: [58] #10 [0141]
	Capabilities: [7c] #08 [a800]
	Capabilities: [88] #08 [8825]
00: b9 10 4e 52 06 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 04 04 00 f0 00 00 00
20: f0 ff 00 00 f0 da f0 da 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 03 01 03 00

0000:00:11.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge
(prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency2
	Memory behind bridge: def00000-deffffff
	Secondary status: SERR
00: b9 10 49 52 07 00 00 62 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 05 05 20 f0 00 00 e2
20: f0 de f0 de f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 03 00

0000:00:12.0 Ethernet controller: ALi Corporation M5263 Ethernet
Controller (rev 60)
	Subsystem: ASRock Incorporation: Unknown device 5263
	Flags: bus master, medium devsel, latency 32, IRQ 21
	I/O ports at d800 [size%6]
	Memory at dbfefc00 (32-bit, non-prefetchable) [size%6]
	Capabilities: [50] Power Management version 2
00: b9 10 63 52 17 01 10 02 60 00 00 02 10 20 00 00
10: 01 d8 00 00 00 fc fe db 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 63 52
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 14 28

0000:00:13.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
	Subsystem: ASRock Incorporation: Unknown device 5237
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 22
	Memory at dbfee000 (32-bit, non-prefetchable) [size=3D4K]
00: b9 10 37 52 17 01 a0 02 03 10 03 0c 10 20 80 00
10: 00 e0 fe db 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 50

0000:00:13.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
	Subsystem: ASRock Incorporation: Unknown device 5237
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 23
	Memory at dbfed000 (32-bit, non-prefetchable) [size=3D4K]
00: b9 10 37 52 17 01 a0 02 03 10 03 0c 10 20 80 00
10: 00 d0 fe db 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 50

0000:00:13.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
	Subsystem: ASRock Incorporation: Unknown device 5237
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 24
	Memory at dbfec000 (32-bit, non-prefetchable) [size=3D4K]
00: b9 10 37 52 17 01 a0 02 03 10 03 0c 10 20 80 00
10: 00 c0 fe db 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 03 00 50

0000:00:13.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
(prog-if 20 [EHCI])
	Subsystem: ASRock Incorporation: Unknown device 5239
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 25
	Memory at dbfef800 (32-bit, non-prefetchable) [size%6]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [2090]
00: b9 10 39 52 16 01 b0 02 01 20 03 0c 10 20 80 00
10: 00 f8 fe db 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 39 52
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 04 10 20

0000:00:14.0 0403: ALi Corporation High Definition Audio/AC'97 Host
Controller (rev 01)
	Subsystem: ASRock Incorporation: Unknown device 0888
	Flags: bus master, medium devsel, latency 32, IRQ 27
	Memory at dbfd4000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
00: b9 10 61 54 06 01 10 02 01 00 03 04 00 20 00 00
10: 00 40 fd db 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 88 08
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 03 10 50

0000:00:15.0 ISA bridge: ALi Corporation PCI to LPC Controller (rev 10)
	Subsystem: ASRock Incorporation: Unknown device 1573
	Flags: bus master, medium devsel, latency 0
00: b9 10 73 15 0f 00 00 02 10 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 73 15
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 18

0000:00:15.1 Bridge: ALi Corporation M7101 Power Management Controller
[PMU]
	Subsystem: ASRock Incorporation: Unknown device 7101
	Flags: medium devsel
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 01 71
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:16.0 IDE interface: ALi Corporation M5229 IDE (rev c7) (prog-if
8a [Master SecP PriP])
	Subsystem: ASRock Incorporation: Unknown device 5229
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 20
	I/O ports at ff00 [size=16]
	Capabilities: [60] Power Management version 2
00: b9 10 29 52 05 00 b0 02 c7 8a 01 01 00 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 ff 00 00 00 00 00 00 00 00 00 00 49 18 29 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 01 00 00

0000:00:16.1 0106: ALi Corporation ULi M5288 SATA (prog-if 01)
	Subsystem: ASRock Incorporation: Unknown device 5288
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 20
	I/O ports at d400 [size=3D8]
	I/O ports at d000 [size=3D4]
	I/O ports at c800 [size=3D8]
	I/O ports at c400 [size=3D4]
	I/O ports at c000 [size=16]
	Memory at dbfef400 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [60] Power Management version 2
00: b9 10 88 52 17 01 b0 02 00 01 06 01 08 20 80 00
10: 01 d4 00 00 01 d0 00 00 01 c8 00 00 01 c4 00 00
20: 01 c0 00 00 00 f4 fe db 00 00 00 00 49 18 88 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 03 01 00 00

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: [80] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
	Flags: fast devsel
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
	Flags: fast devsel
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
	Flags: fast devsel
	Capabilities: [f0] #0f [0010]
00: 22 10 03 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown
device 0393 (rev a1) (prog-if 00 [VGA])
	Flags: bus master, fast devsel, latency 0, IRQ 26
	Memory at dd000000 (32-bit, non-prefetchable) [size=16M]
	Memory at c0000000 (64-bit, prefetchable) [size%6M]
	Memory at dc000000 (64-bit, non-prefetchable) [size=16M]
	I/O ports at e800 [size=128]
	Expansion ROM at deee0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=3D0/0
Enable-
	Capabilities: [78] #10 [0001]
00: de 10 93 03 07 01 10 00 a1 00 00 03 00 00 00 00
10: 00 00 00 dd 0c 00 00 c0 00 00 00 00 04 00 00 dc
20: 00 00 00 00 01 e8 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 00 00

0000:05:0a.0 Network controller: RaLink Ralink RT2500 802.11 Cardbus
Reference Card (rev 01)
	Subsystem: Unknown device 1948:3c01
	Flags: bus master, slow devsel, latency 32, IRQ 23
	Memory at deffe000 (32-bit, non-prefetchable) [size=3D8K]
	Capabilities: [40] Power Management version 2
00: 14 18 01 02 17 01 10 04 01 00 80 02 10 20 00 00
10: 00 e0 ff de 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 01 06 00 00 48 19 01 3c
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00



--=20
Pandas are still around because of "survival of the cutest". Much like
OSX.
                                                    hclyff in Slashdot
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 199 bytes
Desc: Esta parte del mensaje =3D?ISO-8859-1?Q?est=E1?=3D firmada
	digitalmente
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060914=
/8b23fdae/attachment.bin=20
