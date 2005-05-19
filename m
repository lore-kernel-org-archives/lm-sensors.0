From: miles.lane@gmail.com (Miles Lane)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <a44ae5cd05032309522218e97e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I tried compiling the nvidiafb driver as a module.  I was able to boot
the machine successfully and then both add and remove the driver.
However, when I modprobe the driver, I get the following error:

ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 19 (level, high) -> IRQ 19
PCI: Unable to reserve mem region #2:10000000@d0000000 for device 0000:03:0=
0.0
nvidiafb: cannot request PCI regions

Here is the output of lspci -vv (I hope this is helpful information):

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different
version?) (rev c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [40] AGP version 3.0
                Status: RQ2 Iso- ArqSz=3D2 Cal=3D0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=3Dx4,x8
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- =
FW- Rate=3Dx4
        Capabilities: [60] #08 [2001]

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [48] #08 [01e1]

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e000 [size2]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at ee087000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 20
        Region 0: Memory at ee082000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4) (prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin C routed to IRQ 22
        Region 0: Memory at ee083000 (32-bit, non-prefetchable) [size%6]
        Capabilities: [44] #0a [2080]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard onboard
nForce2 Ethernet
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at ee086000 (32-bit, non-prefetchable) [size=3D4K]
        Region 1: I/O ports at e400 [size=3D8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:05.0 Multimedia audio controller: nVidia Corporation nForce
MultiMedia audio [Via VT82C686B] (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 3000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ee000000 (32-bit, non-prefetchable) [sizeQ2K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2
AC97 Audio Controler (MCP) (rev a1)
        Subsystem: Asustek Computer, Inc.: Unknown device 8095
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at d000 [size%6]
        Region 1: I/O ports at d400 [size=128]
        Region 2: Memory at ee080000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI
Bridge (rev a3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency2
        I/O behind bridge: 0000a000-0000bfff
        Memory behind bridge: ec000000-edffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
(prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev
a3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency2
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e8000000-e9ffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire
(IEEE 1394) Controller (rev a3) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 809a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at ee084000 (32-bit, non-prefetchable) [size=3D2K]
        Region 1: Memory at ee085000 (32-bit, non-prefetchable) [sized]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME+

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16
        Bus: primary=00, secondary=03, subordinate=03, sec-latency2
        Memory behind bridge: ea000000-ebffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:01:06.0 Network controller: Broadcom Corporation BCM4306
802.11b/g Wireless LAN Controller (rev 03)
        Subsystem: Motorola: Unknown device 7110
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at ed000000 (32-bit, non-prefetchable) [size=3D8K]

0000:01:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD
Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller
(rev 02)
        Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) Asus A=
7N8X
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at a000 [size=3D8]
        Region 1: I/O ports at a400 [size=3D4]
        Region 2: I/O ports at a800 [size=3D8]
        Region 3: I/O ports at ac00 [size=3D4]
        Region 4: I/O ports at b000 [size=16]
        Region 5: Memory at ed002000 (32-bit, non-prefetchable) [sizeQ2]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB
Integrated Fast Ethernet Controller [Tornado] (rev 40)
        Subsystem: Asustek Computer, Inc. A7N8X Deluxe onboard
3C920B-EMB Integrated Fast Ethernet Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at c000 [disabled] [size=128]
        Region 1: [virtual] Memory at e9000000 (32-bit,
non-prefetchable) [disabled] [size=128]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D3 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:03:00.0 VGA compatible controller: nVidia Corporation NV31
[GeForce FX 5600] (rev a1) (prog-if 00 [VGA])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 9123
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at ea000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size%6M]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
 0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different
version?) (rev c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [40] AGP version 3.0
                Status: RQ2 Iso- ArqSz=3D2 Cal=3D0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=3Dx4,x8
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- =
FW- Rate=3Dx4
        Capabilities: [60] #08 [2001]

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [48] #08 [01e1]

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e000 [size2]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at ee087000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 20
        Region 0: Memory at ee082000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4) (prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin C routed to IRQ 22
        Region 0: Memory at ee083000 (32-bit, non-prefetchable) [size%6]
        Capabilities: [44] #0a [2080]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard onboard
nForce2 Ethernet
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at ee086000 (32-bit, non-prefetchable) [size=3D4K]
        Region 1: I/O ports at e400 [size=3D8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:05.0 Multimedia audio controller: nVidia Corporation nForce
MultiMedia audio [Via VT82C686B] (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 3000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ee000000 (32-bit, non-prefetchable) [sizeQ2K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2
AC97 Audio Controler (MCP) (rev a1)
        Subsystem: Asustek Computer, Inc.: Unknown device 8095
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at d000 [size%6]
        Region 1: I/O ports at d400 [size=128]
        Region 2: Memory at ee080000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI
Bridge (rev a3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency2
        I/O behind bridge: 0000a000-0000bfff
        Memory behind bridge: ec000000-edffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
(prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev
a3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency2
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e8000000-e9ffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire
(IEEE 1394) Controller (rev a3) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 809a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at ee084000 (32-bit, non-prefetchable) [size=3D2K]
        Region 1: Memory at ee085000 (32-bit, non-prefetchable) [sized]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME+

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16
        Bus: primary=00, secondary=03, subordinate=03, sec-latency2
        Memory behind bridge: ea000000-ebffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:01:06.0 Network controller: Broadcom Corporation BCM4306
802.11b/g Wireless LAN Controller (rev 03)
        Subsystem: Motorola: Unknown device 7110
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at ed000000 (32-bit, non-prefetchable) [size=3D8K]

0000:01:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD
Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller
(rev 02)
        Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) Asus A=
7N8X
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at a000 [size=3D8]
        Region 1: I/O ports at a400 [size=3D4]
        Region 2: I/O ports at a800 [size=3D8]
        Region 3: I/O ports at ac00 [size=3D4]
        Region 4: I/O ports at b000 [size=16]
        Region 5: Memory at ed002000 (32-bit, non-prefetchable) [sizeQ2]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB
Integrated Fast Ethernet Controller [Tornado] (rev 40)
        Subsystem: Asustek Computer, Inc. A7N8X Deluxe onboard
3C920B-EMB Integrated Fast Ethernet Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at c000 [disabled] [size=128]
        Region 1: [virtual] Memory at e9000000 (32-bit,
non-prefetchable) [disabled] [size=128]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D3 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:03:00.0 VGA compatible controller: nVidia Corporation NV31
[GeForce FX 5600] (rev a1) (prog-if 00 [VGA])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 9123
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at ea000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size%6M]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different
version?) (rev c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [40] AGP version 3.0
                Status: RQ2 Iso- ArqSz=3D2 Cal=3D0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=3Dx4,x8
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- =
FW- Rate=3Dx4
        Capabilities: [60] #08 [2001]

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (re=
v c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [48] #08 [01e1]

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e000 [size2]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at ee087000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 20
        Region 0: Memory at ee082000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4) (prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin C routed to IRQ 22
        Region 0: Memory at ee083000 (32-bit, non-prefetchable) [size%6]
        Capabilities: [44] #0a [2080]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard onboard
nForce2 Ethernet
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at ee086000 (32-bit, non-prefetchable) [size=3D4K]
        Region 1: I/O ports at e400 [size=3D8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:05.0 Multimedia audio controller: nVidia Corporation nForce
MultiMedia audio [Via VT82C686B] (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 3000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ee000000 (32-bit, non-prefetchable) [sizeQ2K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2
AC97 Audio Controler (MCP) (rev a1)
        Subsystem: Asustek Computer, Inc.: Unknown device 8095
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at d000 [size%6]
        Region 1: I/O ports at d400 [size=128]
        Region 2: Memory at ee080000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI
Bridge (rev a3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency2
        I/O behind bridge: 0000a000-0000bfff
        Memory behind bridge: ec000000-edffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
(prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev
a3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency2
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e8000000-e9ffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire
(IEEE 1394) Controller (rev a3) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 809a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at ee084000 (32-bit, non-prefetchable) [size=3D2K]
        Region 1: Memory at ee085000 (32-bit, non-prefetchable) [sized]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME+

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16
        Bus: primary=00, secondary=03, subordinate=03, sec-latency2
        Memory behind bridge: ea000000-ebffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:01:06.0 Network controller: Broadcom Corporation BCM4306
802.11b/g Wireless LAN Controller (rev 03)
        Subsystem: Motorola: Unknown device 7110
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at ed000000 (32-bit, non-prefetchable) [size=3D8K]

0000:01:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD
Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller
(rev 02)
        Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) Asus A=
7N8X
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at a000 [size=3D8]
        Region 1: I/O ports at a400 [size=3D4]
        Region 2: I/O ports at a800 [size=3D8]
        Region 3: I/O ports at ac00 [size=3D4]
        Region 4: I/O ports at b000 [size=16]
        Region 5: Memory at ed002000 (32-bit, non-prefetchable) [sizeQ2]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB
Integrated Fast Ethernet Controller [Tornado] (rev 40)
        Subsystem: Asustek Computer, Inc. A7N8X Deluxe onboard
3C920B-EMB Integrated Fast Ethernet Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at c000 [disabled] [size=128]
        Region 1: [virtual] Memory at e9000000 (32-bit,
non-prefetchable) [disabled] [size=128]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D3 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:03:00.0 VGA compatible controller: nVidia Corporation NV31
[GeForce FX 5600] (rev a1) (prog-if 00 [VGA])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 9123
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at ea000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size%6M]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ2 Iso- ArqSz=3D0 Cal=3D3 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=3Dx4,x8
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit-
FW- Rate=3D<none>
