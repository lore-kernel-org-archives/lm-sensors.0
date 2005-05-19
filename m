From: gustave@mechanized-mind.net (Gustave Nylander)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: i2c-2.7.0 won't comile
Message-Id: <3EB966D2.5090506@mechanized-mind.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm stuck at pretty much the first step, tyring to do a 'make' on the 
i2c package. It looks like i2c is not integrated into my kernel, and not 
loading as a module already, so I don't know what the problem is. I've 
included some details:

OS: Red Hat 9.0
Kernel: 2.4.20-9
Motherboard: MSI KT3 Ultra2 (MS-6380E)
Chipset: VIA VT8235 Chipset
Sensors: Winbond W83697HF

OUTPUT STUFF:
sensors-detect output is not really applicable for my situation.

=============='make' output for i2c-2.7.0
-----------------------------
gcc -I/usr/src/linux-2.4.20-9/include -O2 -DLM_SENSORS -D__KERNEL__ 
-DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -D__SMP__ -DMODVERSIONS 
-include /usr/src/linux-2.4.20-9/include/linux/modversions.h -c 
kernel/i2c-core.c -o kernel/i2c-core.o
In file included from /usr/src/linux-2.4.20-9/include/linux/spinlock.h:56,
                  from /usr/src/linux-2.4.20-9/include/linux/module.h:11,
                  from kernel/i2c-core.c:26:
/usr/src/linux-2.4.20-9/include/asm/spinlock.h:9: invalid suffix on 
integer constant
/usr/src/linux-2.4.20-9/include/asm/spinlock.h:9: parse error before 
numeric constant
/usr/src/linux-2.4.20-9/include/asm/spinlock.h:10: `printk_R_ver_str' 
declared as function returning a function
In file included from /usr/src/linux-2.4.20-9/include/linux/prefetch.h:13,
                  from /usr/src/linux-2.4.20-9/include/linux/list.h:6,
                  from /usr/src/linux-2.4.20-9/include/linux/module.h:12,
                  from kernel/i2c-core.c:26:
/usr/src/linux-2.4.20-9/include/asm/processor.h:60: warning: parameter 
names (without types) in function declaration
/usr/src/linux-2.4.20-9/include/asm/processor.h:60: field 
`loops_per_jiffy_R_ver_str' declared as a function
/usr/src/linux-2.4.20-9/include/asm/processor.h:82: invalid suffix on 
integer constant
/usr/src/linux-2.4.20-9/include/asm/processor.h:82: parse error before 
numeric constant
In file included from /usr/src/linux-2.4.20-9/include/linux/prefetch.h:13,
                  from /usr/src/linux-2.4.20-9/include/linux/list.h:6,
                  from /usr/src/linux-2.4.20-9/include/linux/module.h:12,
                  from kernel/i2c-core.c:26:
/usr/src/linux-2.4.20-9/include/asm/processor.h:267:1: warning: 
"EISA_bus" redefined
In file included from 
/usr/src/linux-2.4.20-9/include/linux/modversions.h:132,
                  from <command line>:1:
/usr/src/linux-2.4.20-9/include/linux/modules/i386_ksyms.ver:92:1: 
warning: this is the location of the previous definition
/usr/src/linux-2.4.20-9/include/asm/processor.h:269: warning: parameter 
names (without types) in function declaration
In file included from kernel/i2c-core.c:26:
/usr/src/linux-2.4.20-9/include/linux/module.h:183: invalid suffix on 
integer constant
/usr/src/linux-2.4.20-9/include/linux/module.h:183: parse error before 
numeric constant
/usr/src/linux-2.4.20-9/include/linux/module.h:183: 
`inter_module_register_R_ver_str' declared as function returning a function
/usr/src/linux-2.4.20-9/include/linux/module.h:184: invalid suffix on 
integer constant
/usr/src/linux-2.4.20-9/include/linux/module.h:184: parse error before 
numeric constant
/usr/src/linux-2.4.20-9/include/linux/module.h:184: 
`inter_module_unregister_R_ver_str' declared as function returning a 
function
/usr/src/linux-2.4.20-9/include/linux/module.h:185: 
`inter_module_get_R_ver_str' declared as function returning a function
/usr/src/linux-2.4.20-9/include/linux/module.h:185: warning: parameter 
names (without types) in function declaration
/usr/src/linux-2.4.20-9/include/linux/module.h:186: 
`inter_module_get_request_R_ver_str' declared as function returning a 
function
/usr/src/linux-2.4.20-9/include/linux/module.h:186: warning: parameter 
names (without types) in function declaration
/usr/src/linux-2.4.20-9/include/linux/module.h:187: invalid suffix on 
integer constant
/usr/src/linux-2.4.20-9/include/linux/module.h:187: parse error before 
numeric constant
/usr/src/linux-2.4.20-9/include/linux/module.h:187: 
`inter_module_put_R_ver_str' declared as function returning a function
/usr/src/linux-2.4.20-9/include/linux/module.h:196: 
`try_inc_mod_count_R_ver_str' declared as function returning a function
/usr/src/linux-2.4.20-9/include/linux/module.h:196: warning: parameter 
names (without types) in function declaration
make: *** [kernel/i2c-core.o] Error 1

==================
dmesg output:
------------------------------------
Linux version 2.4.20-9 (bhcompile@porky.devel.redhat.com) (gcc version 
3.2.2 20030313 (Red Hat Linux 3.2.2-10)) #1 Wed Apr 2 13:24:44 EST 2003
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
  BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
  BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: ro root=LABEL=/ hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 1533.444 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3060.53 BogoMIPS
Memory: 252988k/262080k available (1313k kernel code, 6660k reserved, 
996k data, 128k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(tm) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/3177] at 00:11.0
PCI: Hardcoded IRQ 14 for device 00:11.1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Detected PS/2 Mouse Port.
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
ttyS1 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: Hardcoded IRQ 14 for device 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD1200JB-00DUA3, ATA DISK drive
blk: queue c03be900, I/O limit 4095Mb (mask 0xffffffff)
hdc: ATAPI 52X CDROM, ATAPI CD/DVD-ROM drive
hdd: _NEC NR-7700A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS589/255/63, 
UDMA(100)
ide-floppy driver 0.99.newide
Partition check:
  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS%6, MD_SB_DISKS'
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 144k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 128k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
ehci-hcd 00:10.3: VIA Technologies, Inc. USB 2.0
ehci-hcd 00:10.3: irq 12, pci mem d0848e00
usb.c: new USB bus registered, assigned bus number 1
PCI: 00:10.3 PCI cache line size set incorrectly (32 bytes) by BIOS/FW.
PCI: 00:10.3 PCI cache line size corrected to 64.
ehci-hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 13:29:01 Apr  2 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xe800, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,11), internal journal
Adding Swap: 522072k swap-space (priority -1)
hub.c: new USB device 00:10.0-1, assigned address 2
input0: USB HID v1.00 Mouse [A4Tech USB Mouse] on usb4:2.0
hub.c: new USB device 00:10.0-2, assigned address 3
usb-uhci.c: interrupt, status 3, frame# 449
input1: USB HID v1.00 Mouse [Microsoft Microsoft Trackball Optical] on 
usb4:3.0
hub.c: new USB device 00:10.1-2, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: new USB device 00:10.1-2.1, assigned address 3
usb.c: USB device 3 (vend/prod 0x4b8/0x5) is not claimed by any active 
driver.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hub.c: new USB device 00:10.1-2.2, assigned address 4
usb.c: USB device 4 (vend/prod 0x3f0/0x805) is not claimed by any active 
driver.
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: _NEC      Model: NR-7700A          Rev: 1.01
   Type:   CD-ROM                             ANSI SCSI revision: 02
usb.c: registered new driver usblp
printer.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 
vid 0x04B8 pid 0x0005
printer.c: v0.11: USB Printer Device Class driver
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
ip_tables: (C) 2000-2002 Netfilter core team
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
divert: allocating divert_blk for eth0
eth0: Lite-On 82c168 PNIC rev 33 at 0xd0905f00, 00:A0:CC:50:C5:84, IRQ 10.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
Via 686a/8233/8235 audio driver 1.9.1-ac2
via82cxxx: Six channel audio available
PCI: Setting latency timer of device 00:11.5 to 64
ac97_codec: AC97 Audio codec, id: ALG32 (ALC650)
via82cxxx: board #1 at 0xDC00, IRQ 5
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11
udf: registering filesystem
UDF-fs DEBUG lowlevel.c:57:udf_get_last_session: XA disk: no, 
vol_desc_start=0
UDF-fs DEBUG super.c:1421:udf_read_super: Multi-session=0
UDF-fs DEBUG super.c:410:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs DEBUG super.c:437:udf_vrs: ISO9660 Primary Volume Descriptor found
UDF-fs DEBUG super.c:437:udf_vrs: ISO9660 Primary Volume Descriptor found
UDF-fs DEBUG super.c:440:udf_vrs: ISO9660 Supplementary Volume 
Descriptor found
UDF-fs DEBUG super.c:446:udf_vrs: ISO9660 Volume Descriptor Set 
Terminator found
UDF-fs: No VRS found
ISO 9660 Extensions: Microsoft Joliet Level 1
ISOFS: changing to secondary root
via_audio: ignoring drain playback error -11

=========================
lsmod output:
--------------------------------------------------
Module                  Size  Used by    Not tainted
udf                    97504   0  (autoclean)
via82cxxx_audio        24088   0  (autoclean)
uart401                 8260   0  (autoclean) [via82cxxx_audio]
ac97_codec             13544   0  (autoclean) [via82cxxx_audio]
sound                  73108   0  (autoclean) [via82cxxx_audio uart401]
soundcore               6276   4  (autoclean) [via82cxxx_audio sound]
parport_pc             18756   1  (autoclean)
lp                      8868   0  (autoclean)
parport                36480   1  (autoclean) [parport_pc lp]
autofs                 12948   0  (autoclean) (unused)
tulip                  43648   1
ipt_REJECT              3896   6  (autoclean)
iptable_filter          2380   1  (autoclean)
ip_tables              14648   2  [ipt_REJECT iptable_filter]
sg                     35980   0  (autoclean)
sr_mod                 17912   0  (autoclean)
printer                 8800   0
ide-scsi               11984   0
scsi_mod              106200   3  [sg sr_mod ide-scsi]
ide-cd                 35196   1
cdrom                  33472   0  [sr_mod ide-cd]
nls_iso8859-1           3484   3  (autoclean)
nls_cp437               5116   2  (autoclean)
vfat                   12844   2  (autoclean)
fat                    38328   0  (autoclean) [vfat]
keybdev                 2880   0  (unused)
mousedev                5428   1
hid                    21700   0  (unused)
input                   5792   0  [keybdev mousedev hid]
usb-uhci               25868   0  (unused)
ehci-hcd               19592   0  (unused)
usbcore                77696   1  [printer hid usb-uhci ehci-hcd]
ext3                   69984   6
jbd                    51220   6  [ext3]

