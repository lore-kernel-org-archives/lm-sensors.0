From: shurdeek@panorama.sth.ac.at (Peter Surda)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: ticket #814
Message-Id: <20020209193900.B22573@shurdeek.cb.ac.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi!

Yes, you are right, it's a 2.6.2, not 2.5.2, I noticed the typo about 1 sec=
ond
after clicking on "send".

It could be indeed that it's unsupported, but I saw some postings about
lmsensors working on this motherboard so I was hoping :-) It's a nice mobo =
and
I got everything else working...

In case it's unsupported, what can I do to help?

So here's a a lspci -vv:

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0735 =
(rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [sizedM]
	Capabilities: [c0] AGP version 2.0
		Status: RQ1 SBA+ 64bit- FW- Rate=3Dx1,x2
		Command: RQ=3D0 SBA+ AGP+ 64bit- FW- Rate=3Dx1

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if=
 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latencyd
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: cfe00000-cfefffff
	Prefetchable memory behind bridge: c7c00000-cfcfffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (pro=
g-if 10 [OHCI])
	Subsystem: Elitegroup Computer Systems: Unknown device 0a14
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at cfffd000 (32-bit, non-prefetchable) [size=3D4K]

00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (pro=
g-if 10 [OHCI])
	Subsystem: Elitegroup Computer Systems: Unknown device 0a14
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at cfffe000 (32-bit, non-prefetchable) [size=3D4K]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)=
 (prog-if 80 [Master])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B s=
tep)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR-
	Latency: 16
	Region 4: I/O ports at ff00 [size=16]

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]: Unkn=
own device 7012 (rev a0)
	Subsystem: Elitegroup Computer Systems: Unknown device 0a14
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at d400 [size%6]
	Region 1: I/O ports at d000 [sized]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrentUmA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100=
 Ethernet (rev 90)
	Subsystem: Elitegroup Computer Systems: Unknown device 0a14
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (13000ns min, 2750ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at cc00 [size%6]
	Region 1: Memory at cfffc000 (32-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at cffc0000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 0=
6)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at c800 [size2]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:09.1 Input device controller: Creative Labs SB Live! (rev 06)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at dc00 [size=3D8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c810 (=
rev 23)
	Subsystem: Symbios Logic Inc. (formerly NCR) 8100S
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d800 [size%6]
	Region 1: Memory at cfffff00 (32-bit, non-prefetchable) [size%6]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF (prog-i=
f 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0068
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c8000000 (32-bit, prefetchable) [sizedM]
	Region 1: I/O ports at 9800 [size%6]
	Region 2: Memory at cfefc000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at cfec0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ1 SBA+ 64bit- FW- Rate=3Dx1,x2
		Command: RQ1 SBA+ AGP+ 64bit- FW- Rate=3Dx1
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

Bye,

Peter Surda (Shurdeek) <shurdeek@panorama.sth.ac.at>, ICQ 10236103, +436505=
122023

--
                   three saints: looser & lamer & hacker
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 232 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020209=
/8d8d71e9/attachment.bin
