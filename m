From: jay@grue.userfriendly.org (Jay Thorne)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: i845 / asus p4b266
Message-Id: <20020328221419.B7446562D2@grue.userfriendly.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Not supported yet. I have one, about to go into production. I can delay a d=
ay=20
or two if there's something I can do to get it supported.

lspci:

00:00.0 Host bridge: Intel Corporation 82845 845 (Brookdale) Chipset Host=20
Bridge (rev 04)
00:01.0 PCI bridge: Intel Corporation 82845 845 (Brookdale) Chipset AGP=20
Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 05)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 05)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 05)
02:02.0 VGA compatible controller: Cirrus Logic GD 5434-8 [Alpine] (rev f9)
02:04.0 USB Controller: NEC Corporation USB (rev 41)
02:04.1 USB Controller: NEC Corporation USB (rev 41)
02:04.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 02)
02:09.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (re=
v=20
08)

Following is the lspci -nvvvv for more detail.

00:00.0 Class 0600: 8086:1a30 (rev 04)
????????Subsystem: 1043:8070
????????Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
????????Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-=20
<TAbort- <MAbort+ >SERR- <PERR-
????????Latency: 0
????????Region 0: Memory at f8000000 (32-bit, prefetchable) [sizedM]
????????Capabilities: [e4] #09 [9104]
????????Capabilities: [a0] AGP version 2.0
????????????????Status: RQ1 SBA+ 64bit- FW+ Rate=3Dx1,x2
????????????????Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>

00:01.0 Class 0604: 8086:1a31 (rev 04)
????????Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
????????Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
????????Latency: 64
????????Bus: primary=00, secondary=01, subordinate=01, sec-latency=3D0
????????I/O behind bridge: 0000e000-0000dfff
????????Memory behind bridge: f6f00000-f6efffff
????????Prefetchable memory behind bridge: f8000000-f7ffffff
????????BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:1e.0 Class 0604: 8086:244e (rev 05)
????????Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
????????Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
????????Latency: 0
????????Bus: primary=00, secondary=02, subordinate=02, sec-latency2
????????I/O behind bridge: 0000d000-0000dfff
????????Memory behind bridge: f2800000-f6efffff
????????Prefetchable memory behind bridge: f6f00000-f7ffffff
????????BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 Class 0601: 8086:2440 (rev 05)
????????Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
????????Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
????????Latency: 0

00:1f.1 Class 0101: 8086:244b (rev 05) (prog-if 80 [Master])
????????Subsystem: 1043:8028
????????Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
????????Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
????????Latency: 0
????????Region 4: I/O ports at b800 [size=16]

02:02.0 Class 0300: 1013:00a8 (rev f9)
????????Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
????????Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
????????Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
????????Expansion ROM at f7000000 [disabled] [size=16M]

02:04.0 Class 0c03: 1033:0035 (rev 41) (prog-if 10)
????????Subsystem: 807d:0035
????????Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
????????Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
????????Latency: 40 (250ns min, 10500ns max), cache line size 08
????????Interrupt: pin A routed to IRQ 11
????????Region 0: Memory at f4800000 (32-bit, non-prefetchable) [size=3D4K]
????????Capabilities: [40] Power Management version 2
????????????????Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold-)
????????????????Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

02:04.1 Class 0c03: 1033:0035 (rev 41) (prog-if 10)
????????Subsystem: 807d:0035
????????Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
????????Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
????????Latency: 40 (250ns min, 10500ns max), cache line size 08
????????Interrupt: pin B routed to IRQ 10
????????Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=3D4K]
????????Capabilities: [40] Power Management version 2
????????????????Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold-)
????????????????Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

02:04.2 Class 0c03: 1033:00e0 (rev 02) (prog-if 20)
????????Subsystem: 807d:1043
????????Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
????????Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
????????Latency: 64 (4000ns min, 8500ns max), cache line size 08
????????Interrupt: pin C routed to IRQ 7
????????Region 0: Memory at f3800000 (32-bit, non-prefetchable) [size%6]
????????Capabilities: [40] Power Management version 2
????????????????Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold-)
????????????????Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

02:09.0 Class 0200: 8086:1229 (rev 08)
????????Subsystem: 8086:000c
????????Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
????????Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
????????Latency: 64 (2000ns min, 14000ns max), cache line size 08
????????Interrupt: pin A routed to IRQ 11
????????Region 0: Memory at f3000000 (32-bit, non-prefetchable) [size=3D4K]
????????Region 1: I/O ports at d800 [sized]
????????Region 2: Memory at f2800000 (32-bit, non-prefetchable) [size=3D1M]
????????Expansion ROM at <unassigned> [disabled] [size=3D1M]
????????Capabilities: [dc] Power Management version 2
????????????????Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
????????????????Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

--=20
Jay "yohimbe" Thorne  yohimbe@userfriendly.org
Mgr Sys & Tech, Userfriendly.org
