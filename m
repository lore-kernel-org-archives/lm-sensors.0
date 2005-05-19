From: wfallows@metroweb.co.za (Wayne Fallows)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Issue with lm-sensors 2.4.4.1
Message-Id: <3CB604BD.5B0E57DE@metroweb.co.za>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Joey

I am not sure if this is an issue or just my own stupidity. I have
installed lm-sensors 2.4.4.1 on my Debian server 2.2.19.

I get the following error msg when dselect sets up lm-sensors (see
lm_error). The motherboard that I am using is a EP-MVP3C their website
is http://www.epox.com. I tried getting the out put of the
"sensors-detect" with no success. It detects a Via-Pro but is unable to
load mod not found. The chip I think it uses is VIA 82C596.

I have attached the dmesg and lspci outputs as text files.

I have read the support file and found that you do support this
chip(ticket 316)

Regards

Wayne
-------------- next part --------------
00:00.0 Class 0600: 1106:0597 (rev 04)
00:01.0 Class 0604: 1106:8598
00:07.0 Class 0601: 1106:0596 (rev 23)
00:07.1 Class 0101: 1106:0571 (rev 10)
00:07.3 Class 0600: 1106:3050 (rev 30)
00:09.0 Class 0280: 1397:2bd0 (rev 02)
00:0a.0 Class 0300: 1002:4755 (rev 9a)
00:0b.0 Class 0200: 10b7:9055 (rev 24)
-------------- next part --------------
depmod: *** Unresolved symbols in /lib/modules/2.2.19/fs/binfmt_aout.o
depmod: *** Unresolved symbols in /lib/modules/2.2.19/fs/binfmt_aout.o
depmod: *** Unresolved symbols in /lib/modules/2.2.19/fs/binfmt_aout.o
-------------- next part --------------
Linux version 2.2.19 (herbert@gondolin) (gcc version 2.7.2.3) #1 Sat Jun 9 13:04:06 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0009fc00 @ 00000000 (usable)
 BIOS-e820: 00000400 @ 0009fc00 (usable)
 BIOS-e820: 03ef0000 @ 00100000 (usable)
Detected 501147 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 62168k/65472k available (1744k kernel code, 412k reserved, 992k data, 156k init)
Dentry hash table entries: 8192 (order 4, 64k)
Buffer cache hash table entries: 65536 (order 6, 256k)
Page cache hash table entries: 16384 (order 4, 64k)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: L1 I Cache: 32K  L1 D Cache: 32K
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfb420
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: 00:38 [1106/0596]: Work around ISA DMA hangs (00)
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 65536 bhash 65536)
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLlct20 20, ATA DISK drive
hdd: IDE/ATAPI CD-ROM, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: QUANTUM FIREBALLlct20 20, 19470MB w/418kB Cache, CHS$82/255/63
hdd: ATAPI 12X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
md driver 0.36.6 MAX_MD_DEV=4, MAX_REAL=8
scsi: <fdomain> Detection failed (no card)
NCR53c406a: no available ports found
sym53c416.c: Version 1.0.0
Failed initialization of WD-7000 SCSI card!
IBM MCA SCSI: Version 3.2
IBM MCA SCSI: No Microchannel-bus present --> Aborting.
              This machine does not have any IBM MCA-bus
              or the MCA-Kernel-support is not enabled!
megaraid: v1.11 (Aug 23, 2000)
aec671x_detect: 
3w-xxxx: tw_findcards(): No cards found.
scsi : 0 hosts.
scsi : detected total.
Partition check:
 hda: hda1 hda2 < hda5 hda6 > hda3 hda4
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.13)
apm: disabled on user request.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 156k freed
NET4: Unix domain sockets 1.0 for Linux NET4.0.
Adding Swap: 289160k swap-space (priority -1)
IPv4 over IPv4 tunneling driver
NTFS version 000607
Installing knfsd (copyright (C) 1996 okir@monad.swb.de)
3c59x.c 18Feb01 Donald Becker and others http://www.scyld.com/network/vortex.html
eth0: 3Com 3c905B Cyclone 100baseTx at 0xe000,  00:10:4b:c3:90:71, IRQ 10
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
eth0: Initial media type Autonegotiate.
eth0: MII #24 status 786d, link partner capability 0020, setting half-duplex.
gmc uses obsolete /proc/pci interface
VFS: Disk change detected on device ide1(22,64)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
VFS: Disk change detected on device ide1(22,64)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
VFS: Disk change detected on device ide1(22,64)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
