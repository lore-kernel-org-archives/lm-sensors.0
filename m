From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: new termal sensor ?
Message-Id: <3D66AEB1.2A9ED5B4@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020823003332.056f4a9b.valvoline@tiscalinet.it>
In-Reply-To: <20020823003332.056f4a9b.valvoline@tiscalinet.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

sorry, we don't know what is inside your laptop.
You probably won't get any luck with asking Asus either.

valvoline wrote:
>=20
> hi folks!,
>=20
> recently i bought a new asus laptop (L3C series), with P4 and i845 embedd=
ed,
> i've tried to install lm_sensor (2.6.4), but without success...my device =
seems
> to be not installed or not found...i've tried a manual hacking for the p4=
b series
> motherboard, but without success...(probable, the device lists in noteboo=
k is different).
>=20
> waiting for a response....
>=20
> following are some screen dump of lspci and pcitweak:
>=20
> >lspci -vvvv
>=20
> 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridg=
e (rev 04)
>         Subsystem: Asustek Computer, Inc.: Unknown device 1626
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Region 0: Memory at f8000000 (32-bit, prefetchable) [sizedM]
>         Capabilities: [e4] #09 [d104]
>         Capabilities: [a0] AGP version 2.0
>                 Status: RQ1 SBA+ 64bit- FW+ Rate=3Dx1,x2,x4
>                 Command: RQ=3D0 SBA+ AGP+ 64bit- FW- Rate=3Dx1
>=20
> 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge =
(rev 04) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=3D0
>         I/O behind bridge: 0000d000-0000dfff
>         Memory behind bridge: ef000000-efefffff
>         Prefetchable memory behind bridge: eff00000-f7ffffff
>         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
>=20
> 00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (pr=
og-if 00 [UHCI])
>         Subsystem: Asustek Computer, Inc.: Unknown device 1628
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 11
>         Region 4: I/O ports at b800 [size2]
>=20
> 00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (pr=
og-if 00 [UHCI])
>         Subsystem: Asustek Computer, Inc.: Unknown device 1628
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 9
>         Region 4: I/O ports at b400 [size2]
>=20
> 00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02) (pr=
og-if 00 [UHCI])
>         Subsystem: Asustek Computer, Inc.: Unknown device 1628
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin C routed to IRQ 9
>         Region 4: I/O ports at b000 [size2]
>=20
> 00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if=
 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency2
>         I/O behind bridge: 0000a000-0000afff
>         Memory behind bridge: ee000000-eeffffff
>         Prefetchable memory behind bridge: eff00000-efefffff
>         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
>=20
> 00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParEr=
r- Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>=20
> 00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a=
 [Master SecP PriP])
>         Subsystem: Asustek Computer, Inc.: Unknown device 1628
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 9
>         Region 0: I/O ports at 9800 [size=3D8]
>         Region 1: I/O ports at 9400 [size=3D4]
>         Region 2: I/O ports at 9000 [size=3D8]
>         Region 3: I/O ports at 8800 [size=3D4]
>         Region 4: I/O ports at 8400 [size=16]
>         Region 5: Memory at ed800000 (32-bit, non-prefetchable) [size=3D1=
K]
>=20
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio =
(rev 02)
>         Subsystem: Asustek Computer, Inc.: Unknown device 1583
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 9
>         Region 0: I/O ports at e000 [size%6]
>         Region 1: I/O ports at e100 [sized]
>=20
> 00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02) (prog-if 00 [=
Generic])
>         Subsystem: Asustek Computer, Inc.: Unknown device 1496
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 9
>         Region 0: I/O ports at e200 [size%6]
>         Region 1: I/O ports at e300 [size=128]
>=20
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M=
7 LW (prog-if 00 [VGA])
>         Subsystem: Asustek Computer, Inc.: Unknown device 1622
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (2000ns min), cache line size 08
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
>         Region 1: I/O ports at d800 [size%6]
>         Region 2: Memory at ef000000 (32-bit, non-prefetchable) [sizedK]
>         Expansion ROM at effe0000 [disabled] [size=128K]
>         Capabilities: [58] AGP version 2.0
>                 Status: RQG SBA+ 64bit- FW- Rate=3Dx1,x2,x4
>                 Command: RQ1 SBA+ AGP+ 64bit- FW- Rate=3Dx1
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,=
D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 02:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/813=
9C (rev 10)
>         Subsystem: Asustek Computer, Inc.: Unknown device 1045
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (8000ns min, 16000ns max)
>         Interrupt: pin A routed to IRQ 9
>         Region 0: I/O ports at a800 [size%6]
>         Region 1: Memory at ee800000 (32-bit, non-prefetchable) [size%6]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent75mA PME(D0-,D1+,D2=
+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable+ DSel=3D0 DScale=3D0 PME-
>=20
> 02:07.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
>         Subsystem: Asustek Computer, Inc.: Unknown device 1624
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 168
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at ee001000 (32-bit, non-prefetchable) [size=3D4=
K]
>         Bus: primary=02, secondary=02, subordinate=03, sec-latency=176
>         Memory window 0: ee400000-ee7ff000 (prefetchable)
>         Memory window 1: eec00000-eefff000
>         I/O window 0: 0000a000-0000a0ff
>         I/O window 1: 0000a400-0000a4ff
>         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWr=
ite+
>         16-bit legacy interface ports at 0001
>=20
> 02:07.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
>         Subsystem: Asustek Computer, Inc.: Unknown device 1624
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 168
>         Interrupt: pin B routed to IRQ 9
>         Region 0: Memory at ee002000 (32-bit, non-prefetchable) [size=3D4=
K]
>         Bus: primary=02, secondary=04, subordinate=07, sec-latency=176
>         Memory window 0: 00000000-00000000 (prefetchable)
>         Memory window 1: 00000000-00000000
>         I/O window 0: 0000ac00-0000acff
>         I/O window 1: 00000000-00000003
>         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWr=
ite+
>         16-bit legacy interface ports at 0001
>=20
> 02:07.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (p=
rog-if 10 [OHCI])
>         Subsystem: Asustek Computer, Inc.: Unknown device 1627
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (500ns min, 1000ns max)
>         Interrupt: pin C routed to IRQ 9
>         Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=3D2=
K]
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,=
D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-
>=20
> > pcitweak -l
>=20
> PCI: Probing config type using method 1
> PCI: Config type is 1
> PCI: PCI scan (all values are in hex)
> PCI: 00:00:0: chip 8086,1a30 card 1043,1626 rev 04 class 06,00,00 hdr 00
> PCI: 00:01:0: chip 8086,1a31 card 0000,0000 rev 04 class 06,04,00 hdr 01
> PCI: 00:1d:0: chip 8086,2482 card 1043,1628 rev 02 class 0c,03,00 hdr 80
> PCI: 00:1d:1: chip 8086,2484 card 1043,1628 rev 02 class 0c,03,00 hdr 00
> PCI: 00:1d:2: chip 8086,2487 card 1043,1628 rev 02 class 0c,03,00 hdr 00
> PCI: 00:1e:0: chip 8086,2448 card 0000,0000 rev 42 class 06,04,00 hdr 01
> PCI: 00:1f:0: chip 8086,248c card 0000,0000 rev 02 class 06,01,00 hdr 80
> PCI: 00:1f:1: chip 8086,248a card 1043,1628 rev 02 class 01,01,8a hdr 00
> PCI: 00:1f:5: chip 8086,2485 card 1043,1583 rev 02 class 04,01,00 hdr 00
> PCI: 00:1f:6: chip 8086,2486 card 1043,1496 rev 02 class 07,03,00 hdr 00
> PCI: 01:00:0: chip 1002,4c57 card 1043,1622 rev 00 class 03,00,00 hdr 00
> PCI: 02:05:0: chip 10ec,8139 card 1043,1045 rev 10 class 02,00,00 hdr 00
> PCI: 02:07:0: chip 1180,0476 card a000,0000 rev a8 class 06,07,00 hdr 82
> PCI: 02:07:1: chip 1180,0476 card ac00,0000 rev a8 class 06,07,00 hdr 82
> PCI: 02:07:2: chip 1180,0552 card 1043,1627 rev 00 class 0c,00,10 hdr 80
> PCI: End of PCI scan
>=20
> --
> [ valvoline :: VRL Team :: s0ftpj :: freaknet Medialab :: GPG key availab=
le  ]
> [ key fingerprint :: - :: B7E2 48BC 705F AE8F 9ABE  E422 076A 2561 1D67 B=
4DD ]
> [ GPG key available on keyserver :: pgp.mit.edu :: with keyID :: 1D67B4DD=
 :: ]
