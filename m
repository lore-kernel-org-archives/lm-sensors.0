From: pawel@w.pl (=?ISO-8859-2?Q?Pawe=B3_Tobi=B6?=)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: DPMS problem with lm_sensors 2.7.0
Message-Id: <3EBEB003.6090200@w.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 

Dear lm_sensors Coders,

Your package is extremely helpful in monitoring the system health status.
However, the last version of lm_sensors (and/or i2c) perheaps needs some fixing to
provide a stability for monitored system.
Please help me to solve problems described below.

with best regards
Pawel Tobis <pawel@w.pl>

Description of problem:
I found a problem using lm_sensors and DPMS power saving. Reading sensor chip
measures from /proc/sys/dev/sensors/*/* (by a daemon for example) causes the screen
to wake up from a DPMS-powerdown state. It's a problem when I'm using any of these
gui-monitors under X, because DPMS screen powersaving simply doesn't want to work.
The problem also exists with any of mrtg-kind sensor monitors.

Another problem has been found during collecting informations for this bug report.
It seems that nor /dev/i2c0 niether /dev/i2c-0 works correctly. Trying `cat /dev/i2c0`
shows an error: Could not open file `/dev/i2c0' : No such device. Same thing
is with /dev/i2c-0. Well, these entries in /dev exist for sure - as character devices
with major no. 89 and minor no. 0. i2c-dev has been compiled statically into
kernel. I didn't try it as a module.

Below comes necessarry information about my machine and Linux system:

Software spec:
lm_sensors:	2.7.0
i2c:		2.7.0 patched against double "/proc/bus/i2c" entry
linux:		2.4.20 (kernel patched with i2c & lm_sensors)
drivers:	i2c-core i2c-algo-bit i2c-dev i2c-proc i2c-via lm75
			(all statically compiled into kernel)
compiler:	gcc version 2.95.3 20010315 (release)

Hardware spec:
mb chipset:		VIA Apollo VP3 (year 1998)
sensor chipset:	NS LM75
cpu:			AMD K6-2 (CTX)
gpu:			ATI Rage Fury OR nVidia Riva TNT2 M64 (problem seen on both)

Contents of specific files and command outputs:
/proc/bus/i2c :
i2c-0   i2c             VIA i2c                                 Bit-shift algorithm

/proc/bus/i2c-0 :
4c      LM75 chip                               LM75 sensor chip driver

/proc/sys/dev/sensors/chips :
256     lm75-i2c-0-4c

/proc/sys/dev/sensors/lm75-i2c-0-4c/temp :
60.0 50.0 39.0

lspci -n :
00:00.0 Class 0600: 1106:0597 (rev 01)
00:01.0 Class 0604: 1106:8597
00:07.0 Class 0601: 1106:0586 (rev 41)
00:07.1 Class 0101: 1106:0571 (rev 06)
00:07.2 Class 0c03: 1106:3038 (rev 02)
00:07.3 Class 0680: 1106:3040 (rev 10)
00:0b.0 Class 0200: 8086:1030 (rev 08)
01:05.0 Class 0300: 1002:5246

i2cdetect & i2cdump: there's a little problem here because any of these commands
stops with errors:
Error: Could not open file `/dev/i2c-0' : No such device
Error: Could not open file `/dev/i2c0' : No such device
..even if these files really exist! `ls -l /dev/i2c*` gives:
crw-------    1 root     root      89,   0 sie 30  2001 /dev/i2c0
crw-------    1 root     root      89,   0 sie 30  2001 /dev/i2c-0
crw-------    1 root     root      89,   1 sie 30  2001 /dev/i2c1
crw-------    1 root     root      89,   1 sie 30  2001 /dev/i2c-1
.. and /proc/devices contains:
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  6 lp
  7 vcs
 10 misc
 14 sound
 89 i2c
128 ptm
136 pts
162 raw
180 usb
226 drm

Block devices:
  2 fd
  3 ide0
 22 ide1
I don't understand this. Maybe another bug? (notice double i2c-dev & i2c-proc 
registration in dmesg - is it normal?)

dmesg :
Linux version 2.4.20 (root@delta) (gcc version 2.95.3 20010315 (release)) #2 pon maj 5 02:22:21 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000c000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
192MB LOWMEM available.
On node 0 totalpages: 49152
zone(0): 4096 pages.
zone(1): 45056 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux ro root05 BOOT_FILE=/boot/vmlinuz-2.4.20
Initializing CPU#0
Detected 334.096 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 666.82 BogoMIPS
Memory: 192044k/196608k available (1213k kernel code, 4176k reserved, 533k data, 84k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Enabling new style K6 write allocation for 192 Mb
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb110, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
NTFS driver v1.1.22 [Flags: R/O]
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
i2c-algo-bit.o: i2c bit algorithm module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
i2c-via.o version 2.7.0 (20021208)
i2c-dev.o: Registered 'VIA i2c' as minor 0
i2c-via.o: Module succesfully loaded
pty: 256 Unix98 ptys configured
lm75.o version 2.7.0 (20021208)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: SAMSUNG SV2002H, ATA DISK drive
hdb: Seagate Technology 1275MB - ST31276A, ATA DISK drive
hdc: CRD-8520B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c02f47a4, I/O limit 4095Mb (mask 0xffffffff)
hda: 39180960 sectors (20061 MB) w/468KiB Cache, CHS$38/255/63, UDMA(33)
blk: queue c02f48f0, I/O limit 4095Mb (mask 0xffffffff)
hdb: 2502308 sectors (1281 MB), CHSb0/64/63, DMA
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
 hdb: hdb1
Floppy drive(s): fd0 is 1.44M, fd1 is 1.2M
FDC 0 is a post-1991 82077
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Assigned IRQ 5 for device 00:0b.0
eth0: Intel Corp. 82559 InBusiness 10/100, 00:03:47:AC:C8:72, IRQ 5.
  Board assembly 742252-003, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 150M
agpgart: Detected Via VP3 chipset
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] AGP 0.99 on VIA VP3 @ 0xe0000000 128MB
[drm] Initialized r128 2.2.0 20010917 on minor 0
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
uhci.c: USB UHCI at I/O 0xe400, IRQ 10
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack version 2.1 (1536 buckets, 12288 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 84k freed
Adding Swap: 265032k swap-space (priority -1)
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative SB AWE64 PnP detected
sb: ISAPnP reports 'Creative SB AWE64 PnP' at i/o 0x220, irq 9, dma 1, 5
SB 4.16 detected OK (220)
sb: 1 Soundblaster PnP card(s) found.
MSDOS FS: Using codepage 852
MSDOS FS: IO charset iso8859-2


