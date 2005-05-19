From: norbert@zawodsky.at (Norbert Zawodsky)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: New Chipset ?
Message-Id: <3C137EFB.6C366DF@zawodsky.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello there,

i just played around with the 'sensors' package coming with my SuSE 7.3
distro but I can't get it to
do something.

sensors-detect tries to load i2c-i801.o module, but in the system log I
read:

Dec  9 15:47:27 rincewind kernel: i2c-i801.o version 2.6.0 (20010612)
Dec  9 15:47:27 rincewind kernel: i2c-i801.o: Error: Can't detect I801,
function 3!
Dec  9 15:47:27 rincewind kernel: i2c-i801.o: I801 not detected, module
not inserted.

This is part of lspci output (the important one I think):

00:1f.3 SMBus: Intel Corporation 82820 820 (Camino 2) Chipset SMBus (rev
04)
        Subsystem: Asustek Computer, Inc.: Unknown device 8043
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at e800 [size]


The motherboard is a brand new ASUS P4T with a Pentium iV CPU

Can I force the i801 driver or do I have to wait for a '820' driver?

Greetings from a sunny but cold (-7.8) Vienna
Norbert

