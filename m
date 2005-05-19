From: thiemel@centrum.cz (=?iso-8859-2?Q?Tom=E1=B9_Thiemel?=)
Date: Thu, 19 May 2005 06:25:49 +0000
Subject: No subject
Message-Id: <000001c53bd1$ae167c40$e500a8c0@KRTEK>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0111200151170.1364-100000@home.apu.edu>
In-Reply-To: <Pine.LNX.4.33.0111200151170.1364-100000@home.apu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi. 
I have this problem:
==
i2c-piix4.o: IBM Laptop detected; this module may corrupt your serial
eeprom! Refusing to load module!
==

And I have read this message:
####
http://archives.andrew.net.au/lm-sensors/msg01833.html
####

Is my PC on your "whitelist", please?


Thanks a lot

Tomas Thiemel
ICQ #170438916
http://www.wifizabreh.net

PS: What means "serial eeprom" - is it "BIOS chip"?

------------------------------
See information listed below:


***lspci -v ***
..
00:02.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Flags: medium devsel, IRQ 9
..

***lspci -n***
00:00.0 Class 0600: 8086:7190 (rev 03)
00:01.0 Class 0604: 8086:7191 (rev 03)
00:02.0 Class 0601: 8086:7110 (rev 02)
00:02.1 Class 0101: 8086:7111 (rev 01)
00:02.2 Class 0c03: 8086:7112 (rev 01)
00:02.3 Class 0680: 8086:7113 (rev 02)
00:03.0 Class 0200: 8086:1229 (rev 05)
00:12.0 Class 0280: 1260:3873 (rev 01)
00:14.0 Class 0280: 1260:3873 (rev 01)
01:01.0 Class 0300: 5333:8904 (rev 01)

***cat /var/log/dmesg***
Linux version 2.4.29 (root@wifizabreh2) (gcc version 3.2.2 20030222 (Red
Hat Linux 3.2.2-5)) #12 22:57:14 CEST 07-04-2005
127MB LOWMEM available.
..
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: ro root=/dev/hda1
No local APIC present or hardware disabled
Initializing CPU#0
Detected 398.272 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 794.62 BogoMIPS
Memory: 126864k/131060k available (1508k kernel code, 3808k reserved,
541k data, 100k init, 0k highmem)
..
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd85c, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 00:02.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: Card 'Crystal Audio'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
..
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 00:02.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:DMA, hdb:pio
hda: Maxtor 90644D3, ATA DISK drive
blk: queue c0346500, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
..

