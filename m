From: Werner Goebl <werner.goebl@mail.mcgill.ca>
Date: Wed, 19 Dec 2007 22:24:59 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <47699A3B.9030803@mail.mcgill.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


> Shoot, the register values didn't change. So we're looking at the
> wrong thing here. Darn...
>=20
> Please run 'isadump -k 0x55 0x2e 0x2f 0x8' and 'isadump -k 0x55 0x2e
> 0x2f 0x9' and post the output. We have to look at a different logical
> device.
> And please also post the output of 'lspci -vv -nn' and the full output
> of 'sensors-detect'.
>=20
> ...juerg

Here is all the listings!
Best
Werner


sudo isadump -k 0x55 0x2e 0x2f 0x8
[sudo] password for werner:
WARNING! Running this program can cause system crashes, data loss=20
and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 8 using bank register 0x07.
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 83 0f 38 00 04 00 2e 00 00 00 00 00 10 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff ff
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

  sudo isadump -k 0x55 0x2e 0x2f 0x9
WARNING! Running this program can cause system crashes, data loss=20
and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 9 using bank register 0x07.
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 09 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 83 0f 38 00 04 00 2e 00 00 00 00 00 10 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff ff
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



sudo lspci -vv -nn
00:00.0 Host bridge [0600]: Intel Corporation 82Q963/Q965 Memory=20
Controller Hub [8086:2990] (rev 02)
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst=20
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Capabilities: [e0] Vendor Specific Information

00:02.0 VGA compatible controller [0300]: Intel Corporation=20
82Q963/Q965 Integrated Graphics Controller [8086:2992] (rev 02)=20
(prog-if 00 [VGA])
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at dfe00000 (32-bit, non-prefetchable)=20
[size=3D1M]
         Region 2: Memory at c0000000 (64-bit, prefetchable)=20
[size%6M]
         Region 4: I/O ports at ecb8 [size=3D8]
         Capabilities: [90] Message Signalled Interrupts: Mask-=20
64bit- Queue=3D0/0 Enable-
                 Address: 00000000  Data: 0000
         Capabilities: [d0] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:02.1 Display controller [0380]: Intel Corporation 82Q963/Q965=20
Integrated Graphics Controller [8086:2993] (rev 02)
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at dff00000 (32-bit, non-prefetchable)=20
[size=3D1M]
         Capabilities: [d0] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:1a.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8=20
Family) USB UHCI Contoller #4 [8086:2834] (rev 02) (prog-if 00=20
[UHCI])
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 16
         Region 4: I/O ports at ff20 [size2]

00:1a.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8=20
Family) USB UHCI Controller #5 [8086:2835] (rev 02) (prog-if 00=20
[UHCI])
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 17
         Region 4: I/O ports at ff00 [size2]

00:1a.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8=20
Family) USB2 EHCI Controller #2 [8086:283a] (rev 02) (prog-if 20=20
[EHCI])
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin C routed to IRQ 20
         Region 0: Memory at dfdfbc00 (32-bit, non-prefetchable)=20
[size=3D1K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent75mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Capabilities: [58] Debug port

00:1b.0 Audio device [0403]: Intel Corporation 82801H (ICH8=20
Family) HD Audio Controller [8086:284b] (rev 02)
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at dfdfc000 (64-bit, non-prefetchable)=20
[size=16K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrentUmA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Capabilities: [60] Message Signalled Interrupts: Mask-=20
64bit+ Queue=3D0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [70] Express Unknown type IRQ 0
                 Device: Supported: MaxPayload 128 bytes,=20
PhantFunc 0, ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: Errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed unknown, Width x0, ASPM=20
unknown, Port 0
                 Link: Latency L0s <64ns, L1 <1us
                 Link: ASPM Disabled CommClk- ExtSynch-
                 Link: Speed unknown, Width x0

00:1c.0 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family)=20
PCI Express Port 1 [8086:283f] (rev 02) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size: 64 bytes
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=3D0
         Memory behind bridge: dfc00000-dfcfffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst=20
 >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset-=20
FastB2B-
         Capabilities: [40] Express Root Port (Slot+) IRQ 0
                 Device: Supported: MaxPayload 128 bytes,=20
PhantFunc 0, ExtTag-
                 Device: Latency L0s unlimited, L1 unlimited
                 Device: Errors: Correctable+ Non-Fatal+ Fatal+=20
Unsupported+
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM=20
L0s, Port 1
                 Link: Latency L0s <256ns, L1 <4us
                 Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
                 Link: Speed 2.5Gb/s, Width x0
                 Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd-=20
HotPlug+ Surpise+
                 Slot: Number 4, PowerLimit 10.000000
                 Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet-=20
CmdCplt- HPIrq-
                 Slot: AttnInd Unknown, PwrInd Unknown, Power-
                 Root: Correctable- Non-Fatal- Fatal- PME-
         Capabilities: [80] Message Signalled Interrupts: Mask-=20
64bit- Queue=3D0/0 Enable-
                 Address: 00000000  Data: 0000
         Capabilities: [90] Subsystem: Dell Unknown device=20
[1028:01da]
         Capabilities: [a0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:1c.4 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family)=20
PCI Express Port 5 [8086:2847] (rev 02) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size: 64 bytes
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=3D0
         Memory behind bridge: dfb00000-dfbfffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst=20
 >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset-=20
FastB2B-
         Capabilities: [40] Express Root Port (Slot+) IRQ 0
                 Device: Supported: MaxPayload 128 bytes,=20
PhantFunc 0, ExtTag-
                 Device: Latency L0s unlimited, L1 unlimited
                 Device: Errors: Correctable+ Non-Fatal+ Fatal+=20
Unsupported+
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM=20
L0s, Port 5
                 Link: Latency L0s <256ns, L1 <4us
                 Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
                 Link: Speed 2.5Gb/s, Width x1
                 Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd-=20
HotPlug+ Surpise+
                 Slot: Number 0, PowerLimit 10.000000
                 Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet-=20
CmdCplt- HPIrq-
                 Slot: AttnInd Unknown, PwrInd Unknown, Power-
                 Root: Correctable- Non-Fatal- Fatal- PME-
         Capabilities: [80] Message Signalled Interrupts: Mask-=20
64bit- Queue=3D0/0 Enable-
                 Address: 00000000  Data: 0000
         Capabilities: [90] Subsystem: Dell Unknown device=20
[1028:01da]
         Capabilities: [a0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:1d.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8=20
Family) USB UHCI Controller #1 [8086:2830] (rev 02) (prog-if 00=20
[UHCI])
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 18
         Region 4: I/O ports at ff80 [size2]

00:1d.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8=20
Family) USB UHCI Controller #2 [8086:2831] (rev 02) (prog-if 00=20
[UHCI])
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 17
         Region 4: I/O ports at ff60 [size2]

00:1d.2 USB Controller [0c03]: Intel Corporation 82801H (ICH8=20
Family) USB UHCI Controller #3 [8086:2832] (rev 02) (prog-if 00=20
[UHCI])
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin C routed to IRQ 19
         Region 4: I/O ports at ff40 [size2]

00:1d.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8=20
Family) USB2 EHCI Controller #1 [8086:2836] (rev 02) (prog-if 20=20
[EHCI])
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at ff980800 (32-bit, non-prefetchable)=20
[size=3D1K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent75mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Capabilities: [58] Debug port

00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge=20
[8086:244e] (rev f2) (prog-if 01 [Subtractive decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=03, subordinate=03,=20
sec-latency2
         Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset-=20
FastB2B-
         Capabilities: [50] Subsystem: Dell Unknown device=20
[1028:01da]

00:1f.0 ISA bridge [0601]: Intel Corporation 82801HB/HR (ICH8/R)=20
LPC Interface Controller [8086:2810] (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [e0] Vendor Specific Information

00:1f.2 IDE interface [0101]: Intel Corporation 82801H (ICH8=20
Family) 4 port SATA IDE Controller [8086:2820] (rev 02) (prog-if=20
8f [Master SecP SecO PriP PriO])
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin C routed to IRQ 21
         Region 0: I/O ports at fe00 [size=3D8]
         Region 1: I/O ports at fe10 [size=3D4]
         Region 2: I/O ports at fe20 [size=3D8]
         Region 3: I/O ports at fe30 [size=3D4]
         Region 4: I/O ports at fec0 [size=16]
         Region 5: I/O ports at ecc0 [size=16]
         Capabilities: [70] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:1f.3 SMBus [0c05]: Intel Corporation 82801H (ICH8 Family)=20
SMBus Controller [8086:283e] (rev 02)
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin C routed to IRQ 21
         Region 0: Memory at dfdfbb00 (32-bit, non-prefetchable)=20
[size%6]
         Region 4: I/O ports at ece0 [size2]

00:1f.5 IDE interface [0101]: Intel Corporation 82801H (ICH8=20
Family) 2 port SATA IDE Controller [8086:2825] (rev 02) (prog-if=20
85 [Master SecO PriO])
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin C routed to IRQ 21
         Region 0: I/O ports at fe40 [size=3D8]
         Region 1: I/O ports at fe50 [size=3D4]
         Region 2: I/O ports at fe60 [size=3D8]
         Region 3: I/O ports at fe70 [size=3D4]
         Region 4: I/O ports at fed0 [size=16]
         Region 5: I/O ports at ecd0 [size=16]
         Capabilities: [70] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

02:00.0 Ethernet controller [0200]: Broadcom Corporation=20
NetXtreme BCM5754 Gigabit Ethernet PCI Express [14e4:167a] (rev 02)
         Subsystem: Dell Unknown device [1028:01da]
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at dfbf0000 (64-bit, non-prefetchable)=20
[sizedK]
         Capabilities: [48] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
         Capabilities: [50] Vital Product Data
         Capabilities: [58] Vendor Specific Information
         Capabilities: [e8] Message Signalled Interrupts: Mask-=20
64bit+ Queue=3D0/0 Enable-
                 Address: 270010008484420c  Data: 087e
         Capabilities: [d0] Express Endpoint IRQ 0
                 Device: Supported: MaxPayload 128 bytes,=20
PhantFunc 0, ExtTag+
                 Device: Latency L0s <4us, L1 unlimited
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 128 bytes, MaxReadReq 4096 bytes
                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM=20
L0s, Port 0
                 Link: Latency L0s <4us, L1 <64us
                 Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
                 Link: Speed 2.5Gb/s, Width x1





sudo sensors-detect
# sensors-detect revision 4609 (2007-07-14 09:28:39 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801H ICH8

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no):
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at ece0 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
     (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
     (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe=20
though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x830f
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some CPUs or memory controllers may also contain embedded sensors.
Do you want to scan for them? (YES/no):
AMD K8 thermal sensors...                                   No
Intel Core family thermal sensor...                         Success!
     (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp' (should be inserted):
   Detects correctly:
   * Chip `Intel Core family thermal sensor' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# Chip drivers
coretemp
#----cut here----


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
