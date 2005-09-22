From: michal.mleczko@gmail.com (=?ISO-8859-2?Q?Micha=B3_Mleczko?=)
Date: Thu, 22 Sep 2005 10:35:05 +0000
Subject: [lm-sensors] Asus Z80V/M6V i2c support
Message-Id: <318b1df00509220134f03337b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <318b1df00509211647a24cdec@mail.gmail.com>
In-Reply-To: <318b1df00509211647a24cdec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

thank you very much. I am using kernel 2.6.13. Could you give me some hints
as to where to look for the configuration registers? I would be interested
to find out more about this.

Anyway, here are the outputs:

# lspci -n
0000:00:00.0 Class 0600: 8086:2590 (rev 03)
0000:00:01.0 Class 0604: 8086:2591 (rev 03)
0000:00:1b.0 Class 0403: 8086:2668 (rev 04)
0000:00:1d.0 Class 0c03: 8086:2658 (rev 04)
0000:00:1d.1 Class 0c03: 8086:2659 (rev 04)
0000:00:1d.2 Class 0c03: 8086:265a (rev 04)
0000:00:1d.3 Class 0c03: 8086:265b (rev 04)
0000:00:1d.7 Class 0c03: 8086:265c (rev 04)
0000:00:1e.0 Class 0604: 8086:2448 (rev d4)
0000:00:1f.0 Class 0601: 8086:2641 (rev 04)
0000:00:1f.1 Class 0101: 8086:266f (rev 04)
0000:01:00.0 Class 0200: 11ab:4320 (rev 13)
0000:01:01.0 Class 0607: 1180:0476 (rev b3)
0000:01:01.1 Class 0c00: 1180:0552 (rev 08)
0000:01:01.2 Class 0805: 1180:0822 (rev 17)
0000:01:01.3 Class 0880: 1180:0592 (rev 08)
0000:01:01.4 Class 0880: 1180:0852 (rev 03)
0000:01:02.0 Class 0280: 8086:4220 (rev 05)
0000:03:00.0 Class 0300: 1002:3150

# lspci -v
0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML
Express Processor to DRAM Controller (rev 03)
Subsystem: ASUSTeK Computer Inc.: Unknown device 1882
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
Latency: 0
Capabilities: [e0] #09 [2109]

0000:00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI
Express Root Port (rev 03) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0, cache line size 08
Bus: primary=00, secondary=03, subordinate=03, sec-latency=3D0
I/O behind bridge: 0000b000-0000dfff
Memory behind bridge: fea00000-feafffff
Prefetchable memory behind bridge: cff00000-dfefffff
BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
Capabilities: [88] #0d [0000]
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=3D0/0 Enable-
Address: 00000000 Data: 0000
Capabilities: [a0] #10 [0141]

0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)
Subsystem: ASUSTeK Computer Inc.: Unknown device 10c3
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0, cache line size 08
Interrupt: pin A routed to IRQ 16
Region 0: Memory at febf8000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrentUmA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Enable-
Address: 0000000000000000 Data: 0000
Capabilities: [70] #10 [0091]

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin A routed to IRQ 19
Region 4: I/O ports at e480 [size2]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin B routed to IRQ 20
Region 4: I/O ports at e800 [size2]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin C routed to IRQ 18
Region 4: I/O ports at e880 [size2]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 04) (prog-if 00 [UHCI])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin D routed to IRQ 16
Region 4: I/O ports at ec00 [size2]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin A routed to IRQ 19
Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=3D1K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent75mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
(prog-if 01 [Subtractive decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0
Bus: primary=00, secondary=01, subordinate=02, sec-latency2
I/O behind bridge: 0000a000-0000afff
Memory behind bridge: fe900000-fe9fffff
Prefetchable memory behind bridge: 0000000060000000-0000000062f00000
BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (rev 04)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0

0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 04) (prog-if 8a [Master SecP PriP])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin A routed to IRQ 18
Region 0: I/O ports at <unassigned>
Region 1: I/O ports at <unassigned>
Region 2: I/O ports at <unassigned>
Region 3: I/O ports at <unassigned>
Region 4: I/O ports at ffa0 [size=16]

0000:01:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001
Gigabit Ethernet Controller (rev 13)
Subsystem: ASUSTeK Computer Inc. Marvell 88E8001 Gigabit Ethernet Controller
(Asus)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 64 (5750ns min, 7750ns max), cache line size 08
Interrupt: pin A routed to IRQ 18
Region 0: Memory at fe9f8000 (32-bit, non-prefetchable) [size=16K]
Region 1: I/O ports at a800 [size%6]
Expansion ROM at 62000000 [disabled] [size=128K]
Capabilities: [48] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
Capabilities: [50] Vital Product Data

0000:01:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b3)
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 168
Interrupt: pin A routed to IRQ 17
Region 0: Memory at fe900000 (32-bit, non-prefetchable) [size=3D4K]
Bus: primary=01, secondary=02, subordinate=02, sec-latency=176
Memory window 0: 60000000-61fff000 (prefetchable)
Memory window 1: 64000000-65fff000
I/O window 0: 0000a000-0000a0ff
I/O window 1: 0000a400-0000a4ff
BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
16-bit legacy interface ports at 0001

0000:01:01.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
(rev 08) (prog-if 10 [OHCI])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 64 (500ns min, 1000ns max)
Interrupt: pin B routed to IRQ 16
Region 0: Memory at fe9fd800 (32-bit, non-prefetchable) [size=3D2K]
Capabilities: [dc] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME+

0000:01:01.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host
Adapter (rev 17)
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 64
Interrupt: pin C routed to IRQ 6
Region 0: Memory at fe9fe400 (32-bit, non-prefetchable) [size%6]
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:01:01.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host
Adapter (rev 08)
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Interrupt: pin C routed to IRQ 6
Region 0: Memory at fe9fe800 (32-bit, non-prefetchable) [size%6]
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:01:01.4 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev
03)
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Interrupt: pin C routed to IRQ 6
Region 0: Memory at fe9fec00 (32-bit, non-prefetchable) [size%6]
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:01:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev
05)
Subsystem: Intel Corporation: Unknown device 2701
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 64 (750ns min, 6000ns max), cache line size 08
Interrupt: pin A routed to IRQ 17
Region 0: Memory at fe9ff000 (32-bit, non-prefetchable) [size=3D4K]
Capabilities: [dc] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-

0000:03:00.0 VGA compatible controller: ATI Technologies Inc M24 1P [Radeon
Mobility X600] (prog-if 00 [VGA])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1881
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0, cache line size 08
Interrupt: pin A routed to IRQ 5
Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
Region 1: I/O ports at d000 [size%6]
Region 2: Memory at feaf0000 (32-bit, non-prefetchable) [sizedK]
Expansion ROM at cff00000 [disabled] [size=128K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [58] #10 [0001]
Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Enable-
Address: 0000000000000000 Data: 0000

# lspci -v -v -v
0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML
Express Processor to DRAM Controller (rev 03)
Subsystem: ASUSTeK Computer Inc.: Unknown device 1882
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
Latency: 0
Capabilities: [e0] #09 [2109]

0000:00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI
Express Root Port (rev 03) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0, cache line size 08
Bus: primary=00, secondary=03, subordinate=03, sec-latency=3D0
I/O behind bridge: 0000b000-0000dfff
Memory behind bridge: fea00000-feafffff
Prefetchable memory behind bridge: cff00000-dfefffff
BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
Capabilities: [88] #0d [0000]
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=3D0/0 Enable-
Address: 00000000 Data: 0000
Capabilities: [a0] #10 [0141]

0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)
Subsystem: ASUSTeK Computer Inc.: Unknown device 10c3
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0, cache line size 08
Interrupt: pin A routed to IRQ 16
Region 0: Memory at febf8000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrentUmA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Enable-
Address: 0000000000000000 Data: 0000
Capabilities: [70] #10 [0091]

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin A routed to IRQ 19
Region 4: I/O ports at e480 [size2]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin B routed to IRQ 20
Region 4: I/O ports at e800 [size2]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin C routed to IRQ 18
Region 4: I/O ports at e880 [size2]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 04) (prog-if 00 [UHCI])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin D routed to IRQ 16
Region 4: I/O ports at ec00 [size2]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin A routed to IRQ 19
Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=3D1K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent75mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
(prog-if 01 [Subtractive decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0
Bus: primary=00, secondary=01, subordinate=02, sec-latency2
I/O behind bridge: 0000a000-0000afff
Memory behind bridge: fe900000-fe9fffff
Prefetchable memory behind bridge: 0000000060000000-0000000062f00000
BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (rev 04)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0

0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 04) (prog-if 8a [Master SecP PriP])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin A routed to IRQ 18
Region 0: I/O ports at <unassigned>
Region 1: I/O ports at <unassigned>
Region 2: I/O ports at <unassigned>
Region 3: I/O ports at <unassigned>
Region 4: I/O ports at ffa0 [size=16]

0000:01:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001
Gigabit Ethernet Controller (rev 13)
Subsystem: ASUSTeK Computer Inc. Marvell 88E8001 Gigabit Ethernet Controller
(Asus)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 64 (5750ns min, 7750ns max), cache line size 08
Interrupt: pin A routed to IRQ 18
Region 0: Memory at fe9f8000 (32-bit, non-prefetchable) [size=16K]
Region 1: I/O ports at a800 [size%6]
Expansion ROM at 62000000 [disabled] [size=128K]
Capabilities: [48] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
Capabilities: [50] Vital Product Data

0000:01:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b3)
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 168
Interrupt: pin A routed to IRQ 17
Region 0: Memory at fe900000 (32-bit, non-prefetchable) [size=3D4K]
Bus: primary=01, secondary=02, subordinate=02, sec-latency=176
Memory window 0: 60000000-61fff000 (prefetchable)
Memory window 1: 64000000-65fff000
I/O window 0: 0000a000-0000a0ff
I/O window 1: 0000a400-0000a4ff
BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
16-bit legacy interface ports at 0001

0000:01:01.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
(rev 08) (prog-if 10 [OHCI])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 64 (500ns min, 1000ns max)
Interrupt: pin B routed to IRQ 16
Region 0: Memory at fe9fd800 (32-bit, non-prefetchable) [size=3D2K]
Capabilities: [dc] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME+

0000:01:01.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host
Adapter (rev 17)
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 64
Interrupt: pin C routed to IRQ 6
Region 0: Memory at fe9fe400 (32-bit, non-prefetchable) [size%6]
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:01:01.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host
Adapter (rev 08)
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Interrupt: pin C routed to IRQ 6
Region 0: Memory at fe9fe800 (32-bit, non-prefetchable) [size%6]
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:01:01.4 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev
03)
Subsystem: ASUSTeK Computer Inc.: Unknown device 1967
Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Interrupt: pin C routed to IRQ 6
Region 0: Memory at fe9fec00 (32-bit, non-prefetchable) [size%6]
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:01:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev
05)
Subsystem: Intel Corporation: Unknown device 2701
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 64 (750ns min, 6000ns max), cache line size 08
Interrupt: pin A routed to IRQ 17
Region 0: Memory at fe9ff000 (32-bit, non-prefetchable) [size=3D4K]
Capabilities: [dc] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-

0000:03:00.0 VGA compatible controller: ATI Technologies Inc M24 1P [Radeon
Mobility X600] (prog-if 00 [VGA])
Subsystem: ASUSTeK Computer Inc.: Unknown device 1881
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0, cache line size 08
Interrupt: pin A routed to IRQ 5
Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
Region 1: I/O ports at d000 [size%6]
Region 2: Memory at feaf0000 (32-bit, non-prefetchable) [sizedK]
Expansion ROM at cff00000 [disabled] [size=128K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [58] #10 [0001]
Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Enable-
Address: 0000000000000000 Data: 0000

# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
0680-068f : pnp 00:07
0800-0803 : PM1a_EVT_BLK
0804-0805 : PM1a_CNT_BLK
0808-080b : PM_TMR
0810-0815 : ACPI CPU throttle
0828-082f : GPE0_BLK
a000-afff : PCI Bus #01
a000-a0ff : PCI CardBus #02
a400-a4ff : PCI CardBus #02
a800-a8ff : 0000:01:00.0
a800-a8ff : SysKonnect SK-98xx
b000-dfff : PCI Bus #03
d000-d0ff : 0000:03:00.0
e480-e49f : 0000:00:1d.0
e480-e49f : uhci_hcd
e800-e81f : 0000:00:1d.1
e800-e81f : uhci_hcd
e880-e89f : 0000:00:1d.2
e880-e89f : uhci_hcd
ec00-ec1f : 0000:00:1d.3
ec00-ec1f : uhci_hcd
ffa0-ffaf : 0000:00:1f.1
ffa0-ffa7 : ide0
ffa8-ffaf : ide1

# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000f0000-000fffff : System ROM
00100000-5ffbffff : System RAM
00100000-003b9e55 : Kernel code
003b9e56-004aa3e7 : Kernel data
5ffc0000-5ffcefff : ACPI Tables
5ffcf000-5fffffff : ACPI Non-volatile Storage
60000000-62ffffff : PCI Bus #01
60000000-61ffffff : PCI CardBus #02
62000000-6201ffff : 0000:01:00.0
64000000-65ffffff : PCI CardBus #02
cff00000-dfefffff : PCI Bus #03
cff00000-cff1ffff : 0000:03:00.0
d0000000-d7ffffff : 0000:03:00.0
d0000000-d3ffffff : vesafb
fe900000-fe9fffff : PCI Bus #01
fe900000-fe900fff : 0000:01:01.0
fe900000-fe900fff : yenta_socket
fe9f8000-fe9fbfff : 0000:01:00.0
fe9f8000-fe9fbfff : SysKonnect SK-98xx
fe9fd800-fe9fdfff : 0000:01:01.1
fe9fd800-fe9fdfff : ohci1394
fe9fe400-fe9fe4ff : 0000:01:01.2
fe9fe800-fe9fe8ff : 0000:01:01.3
fe9fec00-fe9fecff : 0000:01:01.4
fe9ff000-fe9fffff : 0000:01:02.0
fe9ff000-fe9fffff : ipw2200
fea00000-feafffff : PCI Bus #03
feaf0000-feafffff : 0000:03:00.0
febf8000-febfbfff : 0000:00:1b.0
febf8000-febfbfff : ICH HD audio
febffc00-febfffff : 0000:00:1d.7
febffc00-febfffff : ehci_hcd
fed14000-fed19fff : reserved
fed1c000-fed1ffff : reserved
ffb80000-ffffffff : reserved


Regards,
Michal
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050922/=
23bedd82/attachment-0001.html
