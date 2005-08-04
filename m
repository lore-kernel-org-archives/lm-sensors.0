From: tero.saarni@gmail.com (Tero Saarni)
Date: Thu, 04 Aug 2005 18:24:21 +0000
Subject: [lm-sensors] SMBus not detected on SiS 964 south bridge
Message-Id: <dctehc$g25$2@sea.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have SiS 964 south bridge on DFI 661FX-MLV (rev. C)
motherboard [1].

SMBus does not get detected by default so I tried to add
PCI_DEVICE_ID_SI_964 to pci_ids.h and drivers/pci/quirks.c.

I now get "Enabling SiS 96x SMBus." in kernel log i.e. quirks.c
now seems to try enable SMBus but lspci still doesn't show SMBus.
See the output below.

Any ideas what went wrong?

kernel 2.6.12-gentoo-r6   (I've enabled all i2c related)
sensors version 2.9.1 with libsensors version 2.9.1
south bridge: SiS 964
sensor chip: ITE IT8707F


Thanks in advance!

--=20
Tero

[1]=20
http://www.dfi.com.tw/Product/xx_product_spec_details_r_us.jsp?PRODUCT_ID'3=
7&CATEGORY_TYPE=3DMB&SITE=3DUS


lspci -vvv -xxx
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS]=20
661FX/M661FX/M661MX Host (rev 11)
         Subsystem: Silicon Integrated Systems [SiS] 661FX/M661FX/M661MX=20
Host
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32
         Region 0: Memory at e8000000 (32-bit, non-prefetchable)
         Capabilities: [c0] AGP version 3.5
                 Status: RQ2 Iso- ArqSz=3D2 Cal=3D3 SBA+ ITACoh- GART64-=20
HTrans- 64bit- FW- AGP3+ Rate=3Dx4,x8
                 Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit-=
=20
FW- Rate=3D<none>
00: 39 10 61 06 07 00 10 22 11 00 00 06 00 20 80 00
10: 00 00 00 e8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 61 06
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: fc 09 01 83 43 43 0c 0a 2b b7 0c 00 12 d7 20 86
60: 6b 00 6c 00 91 81 e7 82 01 10 e0 00 68 00 80 00
70: 0f 90 00 80 02 00 08 80 00 00 00 00 02 07 01 44
80: 22 67 30 03 81 00 04 2b 00 00 00 01 00 00 00 1e
90: 00 00 00 00 40 00 00 00 b0 86 27 02 00 00 00 13
a0: a5 64 77 42 03 03 01 33 41 aa 2c 30 44 01 e0 01
b0: 00 00 00 80 c1 01 20 00 0c 68 30 35 00 00 b0 00
c0: 02 00 35 00 0b 4e 00 1f 00 00 00 00 00 00 00 00
d0: e0 00 00 00 30 0f 01 00 00 00 00 00 00 00 00 88
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 18 15 00 00 00 00 aa aa 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown=20
device 0003 (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency2
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: ef000000-ef0fffff
         Prefetchable memory behind bridge: e0000000-e7ffffff
         Expansion ROM at 0000d000 [disabled] [size=3D4K]
         BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 39 10 03 00 07 01 20 00 00 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 d0 d0 20 20
20: 00 ef 00 ef 00 e0 f0 e7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0e 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 22 42 30 02 09 ff ff 01 60 60 aa 10 01 00 00 23
e0: 23 67 15 a0 00 00 00 00 55 30 55 e5 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS964 [MuTIOL=20
Media IO] (rev 36)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
00: 39 10 64 09 0f 00 00 02 36 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 93 85 8b 83 8a 40 3d dd 10 00 00 00 11 20 04 03
50: 11 28 02 01 60 0c 20 0b a9 04 12 00 4d 17 00 00
60: 85 8a 8b 89 ff c1 10 12 09 80 00 46 97 00 00 14
70: 00 00 ff ff 00 10 03 2c 20 00 20 80 02 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 1f 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 00 1e 00 00 00 00 0f 90 00 00 00 00 00 41
d0: 20 0d 00 01 22 62 30 00 85 00 04 2b aa aa aa aa
e0: 40 00 00 d8 7c 00 44 00 00 00 00 00 00 00 00 00
f0: 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]=20
(rev 01) (prog-if 80 [Master])
         Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE=20
Controller (A,B step)
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 128
         Interrupt: pin ? routed to IRQ 16
         Region 0: I/O ports at <unassigned>
         Region 1: I/O ports at <unassigned>
         Region 2: I/O ports at <unassigned>
         Region 3: I/O ports at <unassigned>
         Region 4: I/O ports at 4000 [size=16]
         Capabilities: [58] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 39 10 13 55 05 00 10 02 01 80 01 01 00 80 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 01 40 00 00 00 00 00 00 00 00 00 00 39 10 13 55
30: 00 00 00 00 58 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 20 00 06 00 00 00 00 00
50: 92 21 93 a1 2a 96 c4 d0 01 00 02 80 00 00 00 00
60: fb aa fb aa 00 00 00 00 a0 00 00 00 00 00 00 00
70: 56 23 06 04 00 60 1c 1e 00 60 1c 1e 00 60 1c 1e
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems=20
[SiS] Sound Controller (rev a0)
         Subsystem: DFI Inc: Unknown device 1001
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (13000ns min, 2750ns max)
         Interrupt: pin C routed to IRQ 3
         Region 0: I/O ports at e000
         Region 1: I/O ports at e100 [size=128]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrentUmA=20
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 39 10 12 70 05 00 90 02 a0 00 01 04 00 20 00 00
10: 01 e0 00 00 01 e1 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 bd 15 01 10
30: 00 00 00 00 48 00 00 00 00 00 00 00 03 03 34 0b
40: 04 00 00 00 00 00 00 00 01 00 42 c6 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0=20
Controller (rev 0f) (prog-if 10 [OHCI])
         Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (20000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 20
         Region 0: Memory at ef121000 (32-bit, non-prefetchable)
00: 39 10 01 70 07 00 80 02 0f 10 03 0c 08 20 80 00
10: 00 10 12 ef 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 01 70
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 50
40: 00 00 00 00 5c ac 01 00 3f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0=20
Controller (rev 0f) (prog-if 10 [OHCI])
         Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (20000ns max), cache line size 08
         Interrupt: pin B routed to IRQ 21
         Region 0: Memory at ef122000 (32-bit, non-prefetchable)
00: 39 10 01 70 07 00 80 02 0f 10 03 0c 08 20 00 00
10: 00 20 12 ef 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 01 70
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 50
40: 00 00 00 00 5c ac 01 00 3f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0=20
Controller (rev 0f) (prog-if 10 [OHCI])
         Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (20000ns max), cache line size 08
         Interrupt: pin C routed to IRQ 22
         Region 0: Memory at ef123000 (32-bit, non-prefetchable)
00: 39 10 01 70 07 00 80 02 0f 10 03 0c 08 20 00 00
10: 00 30 12 ef 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 01 70
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 03 00 50
40: 00 00 00 00 5c ac 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0=20
Controller (prog-if 20 [EHCI])
         Subsystem: Silicon Integrated Systems [SiS] USB 2.0 Controller
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (20000ns max)
         Interrupt: pin D routed to IRQ 23
         Region 0: Memory at ef126000 (32-bit, non-prefetchable)
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent75mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 39 10 02 70 06 00 90 02 00 20 03 0c 00 20 00 00
10: 00 60 12 ef 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 02 70
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 04 00 50
40: 20 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 c9 00 00 00 00 0a 00 00 21 00 00 00 00
60: 20 20 ff 01 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 00 00 00 00 08 c0 00 00 d7 3f 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:04.0 Ethernet controller: Silicon Integrated Systems [SiS]=20
SiS900 PCI Fast Ethernet (rev 90)
         Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100=20
Ethernet Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (13000ns min, 2750ns max)
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at e200
         Region 1: Memory at ef120000 (32-bit, non-prefetchable) [size=3D4K]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 39 10 00 09 07 00 90 02 90 00 00 02 00 20 00 00
10: 01 e2 00 00 00 00 12 ef 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 00 09
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 34 0b
40: 01 00 02 fe 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:05.0 RAID bus controller: Silicon Integrated Systems [SiS] RAID=20
bus controller 180 SATA/PATA  [SiS] (rev 01) (prog-if 85)
         Subsystem: Silicon Integrated Systems [SiS] RAID bus controller=20
180 SATA/PATA  [SiS]
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 128
         Interrupt: pin A routed to IRQ 17
         Region 0: I/O ports at e300
         Region 1: I/O ports at e400 [size=3D4]
         Region 2: I/O ports at e500 [size=3D8]
         Region 3: I/O ports at e600 [size=3D4]
         Region 4: I/O ports at e700 [size=16]
         Region 5: I/O ports at e800 [size=128]
         Capabilities: [58] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 39 10 80 01 05 00 30 02 01 85 04 01 00 80 00 00
10: 01 e3 00 00 01 e4 00 00 01 e5 00 00 01 e6 00 00
20: 01 e7 00 00 01 e8 00 00 00 00 00 00 39 10 80 01
30: 00 00 00 00 58 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 92 00 92 00 00 00 c4 15 01 00 02 80 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: ba 33 72 c0 ba 33 72 40 00 00 00 00 00 00 00 00
90: 08 00 00 00 00 00 00 00 cc 04 0c 10 c0 05 c0 05
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 13 01 00 00 03 00 1d 00 00 03 00 00 00 00 00 00
d0: 00 00 00 00 01 00 18 00 00 03 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0e.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI=20
Video and Audio Decoder (rev 05)
         Subsystem: Hauppauge computer works Inc.: Unknown device 9002
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (5000ns min, 13750ns max), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at ec000000 (32-bit, non-prefetchable)
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: f1 14 00 88 06 00 90 02 05 00 00 04 08 20 80 00
10: 00 00 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 70 00 02 90
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 14 37
40: 30 1f 1f 15 03 4c 00 00 00 00 00 00 01 00 22 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0e.2 Multimedia controller: Conexant CX23880/1/2/3 PCI Video and=20
Audio Decoder [MPEG Port] (rev 05)
         Subsystem: Hauppauge computer works Inc.: Unknown device 9002
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (1500ns min, 22000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at ed000000 (32-bit, non-prefetchable)
         Capabilities: [4c] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: f1 14 02 88 06 00 90 02 05 00 80 04 08 20 80 00
10: 00 00 00 ed 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 70 00 02 90
30: 00 00 00 00 4c 00 00 00 00 00 00 00 0b 01 06 58
40: 30 1f 1f 15 00 00 00 00 00 00 00 00 01 00 22 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0e.4 Multimedia controller: Conexant: Unknown device 8804 (rev 05)
         Subsystem: Hauppauge computer works Inc.: Unknown device 9002
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (1500ns min, 63750ns max), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at ee000000 (32-bit, non-prefetchable)
         Capabilities: [4c] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: f1 14 04 88 06 00 90 02 05 00 80 04 08 20 80 00
10: 00 00 00 ee 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 70 00 02 90
30: 00 00 00 00 4c 00 00 00 00 00 00 00 0b 01 06 ff
40: 30 1f 1f 15 00 00 00 00 00 00 00 00 01 00 22 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0f.0 Multimedia video controller: Brooktree Corporation Bt878=20
Video Capture (rev 11)
         Subsystem: Hauppauge computer works Inc. WinTV Series
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (4000ns min, 10000ns max)
         Interrupt: pin A routed to IRQ 3
         Region 0: Memory at ef124000 (32-bit, prefetchable)
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 9e 10 6e 03 06 00 90 02 11 00 00 04 00 20 80 00
10: 08 40 12 ef 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 70 00 eb 13
30: 00 00 00 00 44 00 00 00 00 00 00 00 03 01 10 28
40: 00 00 00 00 03 4c 00 00 00 00 00 00 01 00 22 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0f.1 Multimedia controller: Brooktree Corporation Bt878 Audio=20
Capture (rev 11)
         Subsystem: Hauppauge computer works Inc. WinTV Series
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (1000ns min, 63750ns max)
         Interrupt: pin A routed to IRQ 3
         Region 0: Memory at ef125000 (32-bit, prefetchable)
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 9e 10 78 08 06 00 90 02 11 00 80 04 00 20 80 00
10: 08 50 12 ef 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 70 00 eb 13
30: 00 00 00 00 44 00 00 00 00 00 00 00 03 01 04 ff
40: 00 00 00 00 03 4c 00 00 00 00 00 00 01 00 22 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]=20
661/741/760 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
         Subsystem: Silicon Integrated Systems [SiS]=20
[M]661xX/[M]741[GX]/[M]760 PCI/AGP VGA Adapter
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 5
         BIST result: 00
         Region 0: Memory at e0000000 (32-bit, prefetchable)
         Region 1: Memory at ef000000 (32-bit, non-prefetchable) [size=128K]
         Region 2: I/O ports at d000 [size=128]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Capabilities: [50] AGP version 3.0
                 Status: RQ%6 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-=20
HTrans- 64bit- FW- AGP3+ Rate=3Dx4,x8
                 Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit-=
=20
FW- Rate=3D<none>
00: 39 10 30 63 03 00 30 02 00 00 00 03 00 00 00 80
10: 08 00 00 e0 00 00 00 ef 01 d0 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 30 63
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00
40: 01 50 02 06 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 00 30 00 0b 02 00 ff 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




lspci -n
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0000:00:00.0 Class 0600: 1039:0661 (rev 11)
0000:00:01.0 Class 0604: 1039:0003
0000:00:02.0 Class 0601: 1039:0964 (rev 36)
0000:00:02.5 Class 0101: 1039:5513 (rev 01)
0000:00:02.7 Class 0401: 1039:7012 (rev a0)
0000:00:03.0 Class 0c03: 1039:7001 (rev 0f)
0000:00:03.1 Class 0c03: 1039:7001 (rev 0f)
0000:00:03.2 Class 0c03: 1039:7001 (rev 0f)
0000:00:03.3 Class 0c03: 1039:7002
0000:00:04.0 Class 0200: 1039:0900 (rev 90)
0000:00:05.0 Class 0104: 1039:0180 (rev 01)
0000:00:0e.0 Class 0400: 14f1:8800 (rev 05)
0000:00:0e.2 Class 0480: 14f1:8802 (rev 05)
0000:00:0e.4 Class 0480: 14f1:8804 (rev 05)
0000:00:0f.0 Class 0400: 109e:036e (rev 11)
0000:00:0f.1 Class 0480: 109e:0878 (rev 11)
0000:01:00.0 Class 0300: 1039:6330
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


sensors-detect output
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.

  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Sorry, no PCI bus adapters found.

We will now try to load each adapter module in turn.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

  To continue, we need module `i2c-dev' to be loaded.
  If it is built-in into your kernel, you can safely skip this.
  i2c-dev is not loaded. Do you want to load it now? (YES/no):
  Module loaded succesfully.

  We are now going to do the adapter probings. Some adapters may hang=20
halfway
  through; we can't really help that. Also, some chips will be double=20
detected;
  we choose the one with the highest confidence value in that case.
  If you found that the adapter hung after probing a certain address,=20
you can
  specify that address to remain unprobed. That often
  includes address 0x69 (clock chip).

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x8707)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x8707)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x8707)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x87)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x87)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x87)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x87)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x87)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x87)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x87)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (0x8707)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (skipping family)

  Sorry, no chips were detected.
  Either your sensors are not supported, or they are
  connected to an I2C bus adapter that we do not support.
  See doc/FAQ, doc/lm_sensors-FAQ.html, or
  http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
  (FAQ #4.24.3) for further information.
  If you find out what chips are on your board, see
  http://secure.netroedge.com/~lm78/newdrivers.html for driver status.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



