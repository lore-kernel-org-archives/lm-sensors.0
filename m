From: "KEITH ROMBERG" <k_romberg@msn.com>
Date: Tue, 16 Oct 2007 22:44:19 +0000
Subject: Re: [lm-sensors] Compaq EVO W8000 Sensor/Chip Support
Message-Id: <BAY117-F33BB7825679E4831804794939C0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1192538331.4059.17.camel@tiger.atd.ucar.edu>
In-Reply-To: <1192538331.4059.17.camel@tiger.atd.ucar.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hey juerg,

Here is the output you wanted.

Thanks,
Keith

#############################################################

sensors-detect output:

# sensors-detect revision 4171 (2006-09-24 03:37:01 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Sorry, no known PCI bus adapters found.

We will now try to load each adapter module in turn.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `AMD K8 thermal sensors'...                     No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      Yes
Found unknown chip with ID 0x5d00
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x5d00
Trying family `VIA/Winbond/Fintek'...                       No
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No

Sorry, no sensors were detected.
Either your sensors are not supported, or they are connected to an
I2C or SMBus adapter that is not supported. See doc/FAQ,
doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
(FAQ #4.24.3) for further information.
If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.

############################################################

[root@scatha ~]# lspci -nn -vv
00:00.0 0600: 8086:2531 (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-=20
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at c8000000 (32-bit, prefetchable) [sizedM]
        Capabilities: [a0] AGP version 2.0
                Status: RQ2 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-=20
HTrans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit- =
FW+=20
Rate=3Dx4

00:01.0 0604: 8086:2532 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency2
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: fea00000-febfffff
        Prefetchable memory behind bridge: d0000000-efffffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 0604: 8086:2533 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=02, subordinate=03, sec-latency=3D0
        Memory behind bridge: cf600000-cf6fffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1e.0 0604: 8086:244e (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency2
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: cf700000-cfffffff
        Prefetchable memory behind bridge: 50000000-501fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 0601: 8086:2440 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 0101: 8086:244b (rev 04) (prog-if 80)
        Subsystem: 0e11:0078
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable)=20
[disabled] [size=3D8]
        Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable)=20
[disabled] [size=3D1]
        Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable)=20
[disabled] [size=3D8]
        Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable)=20
[disabled] [size=3D1]
        Region 4: I/O ports at 3040 [size=16]

00:1f.2 0c03: 8086:2442 (rev 04)
        Subsystem: 0e11:0078
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at 3000 [size2]

00:1f.4 0c03: 8086:2444 (rev 04)
        Subsystem: 0e11:0078
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 23
        Region 4: I/O ports at 3020 [size2]

01:00.0 0300: 1002:4153
        Subsystem: 1002:0402
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (2000ns min), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size%6M]
        Region 1: I/O ports at 2000 [size%6]
        Region 2: Memory at fea00000 (32-bit, non-prefetchable) [sizedK]
        [virtual] Expansion ROM at fea20000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=80 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-=20
HTrans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ2 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit- FW+=
=20
Rate=3Dx4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.1 0380: 1002:4173
        Subsystem: 1002:0403
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), Cache Line Size: 32 bytes
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size%6M]
        Region 1: Memory at feb00000 (32-bit, non-prefetchable) [sizedK]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

02:1f.0 0604: 8086:1360 (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=02, secondary=03, subordinate=03, sec-latencyd
        Memory behind bridge: cf600000-cf6fffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

03:00.0 0800: 8086:1161 (rev 01) (prog-if 20)
        Subsystem: 8086:1161
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at cf600000 (32-bit, non-prefetchable) [size=3D4K]

04:06.0 0401: 1274:1371 (rev 09)
        Subsystem: 0e11:0025
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at 1800 [sized]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

04:07.0 0200: 8086:1229 (rev 08)
        Subsystem: 0e11:3006
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at cf700000 (32-bit, non-prefetchable) [size=3D4K]
        Region 1: I/O ports at 1840 [sized]
        Region 2: Memory at cf800000 (32-bit, non-prefetchable) [size=3D1M]
        [virtual] Expansion ROM at 50000000 [disabled] [size=3D1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

04:09.0 0200: 8086:100e (rev 02)
        Subsystem: 8086:002e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at cf900000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at cfa00000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at 1880 [sized]
        [virtual] Expansion ROM at 50100000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
        Capabilities: [e4] PCI-X non-bridge device
                Command: DPERE- ERO+ RBCQ2 OST=3D1
                Status: Dev=00:00.0 64bit- 133MHz- SCD- USC- DC=3Dsimple=20
DMMRBC 48 DMOST=3D1 DMCRS=16 RSCEM- 266MHz- 533MHz-
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=3D0/0=
=20
Enable-
                Address: 0000000000000000  Data: 0000

04:0b.0 0c03: 1033:0035 (rev 43) (prog-if 10)
        Subsystem: 14db:14db
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at cfb00000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

04:0b.1 0c03: 1033:0035 (rev 43) (prog-if 10)
        Subsystem: 14db:14db
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max), Cache Line Size: 32 bytes
        Interrupt: pin B routed to IRQ 16
        Region 0: Memory at cfc00000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

04:0b.2 0c03: 1033:00e0 (rev 04) (prog-if 20)
        Subsystem: 14db:00e0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8500ns max), Cache Line Size: 128 bytes
        Interrupt: pin C routed to IRQ 18
        Region 0: Memory at cfd00000 (32-bit, non-prefetchable) [size%6]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

04:0d.0 0100: 9005:00cf (rev 01)
        Subsystem: 0e11:003a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (10000ns min, 6250ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 22
        BIST result: 00
        Region 0: I/O ports at 1000 [disabled] [size%6]
        Region 1: Memory at cfe00000 (64-bit, non-prefetchable) [size=3D4K]
        [virtual] Expansion ROM at 50120000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

04:0d.1 0100: 9005:00cf (rev 01)
        Subsystem: 0e11:003a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (10000ns min, 6250ns max), Cache Line Size: 32 bytes
        Interrupt: pin B routed to IRQ 16
        BIST result: 00
        Region 0: I/O ports at 1400 [disabled] [size%6]
        Region 1: Memory at cff00000 (64-bit, non-prefetchable) [size=3D4K]
        [virtual] Expansion ROM at 50140000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

############################################################

[root@scatha ~]# isadump -k 0x55 0x2e 0x2f 0xa
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 10 using bank register 0x07.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 0a 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 5d 00 38 00 04 11 2e 00 00 00 00 00 00 00 00 00
30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff ff
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


>
>The LMs are dependent on the 82801BA. Maybe the SMBus is hidden on
>your machine (but then again it shows up under windows). The LPC47m967
>is independent.
>
>Can you post the full output of sensors-detect and also run the
>following commands (as root):
>lspci -nn -vv
>isadump -k 0x55 0x2e 0x2f 0xa
>
>...juerg
>
>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
