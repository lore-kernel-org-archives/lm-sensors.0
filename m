From: lundby@ameritech.net (water modem)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: kern2.6.3 - report busted PST laptop table in eMachines M5312 ( ic2
Message-Id: <40409BEF.7070108@ameritech.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

copied to rgooch due to mtrr messages...
copied to lm78 due to i2c radeon messages..
copied to ndiswrapper folks as 2.6.3 is last version where ndiswrapper=20
runs before coredumping...   2.6.4-rc1 gives a fatal dump on wlan0=20
init with hard paging crash

2.3.6 config is attached

btw 2.6.3 runs.  2.6.4-rc1 runs 2.6.4.rc1 with ndiswrapper doesn't.


eMachines M5312

 From dmidecode:
# dmidecode 1.8
ACPI 1.0 present.
         OEM ID: ARIMA
RSD table at 0x1BEFAE80.
SMBIOS 2.3 present.
DMI 2.3 present.
18 structures occupying 694 bytes.
DMI table at 0x000DF010.
Handle 0x0000
         DMI type 0, 20 bytes.
         BIOS Information Block
                 Vendor: Phoenix
                 Version: 0010
                 Release: 09/07/2003
                 BIOS base: 0xE5EB0
                 ROM size: 512K
                 Capabilities:
                         Flags: 0x000000000003DF90
Handle 0x0001
         DMI type 1, 25 bytes.
         System Information Block
                 Vendor: eMachines. Inc.
                 Product: M5300 Series.
                 Version: 0010
                 Serial Number: N703X 500 02506
Handle 0x0002
         DMI type 2, 8 bytes.
         Board Information Block
                 Vendor: Arima
                 Product: W720K7
                 Version: KBC Revision: 1913
                 Serial Number: None
Handle 0x0003
         DMI type 3, 17 bytes.
         Chassis Information Block
                 Vendor: Arima
                 Chassis Type: Notebook
                 Version: N/A
                 Serial Number: None
                 Asset Tag:
Handle 0x0004
         DMI type 4, 32 bytes.
         Processor
                 Socket Designation: U23
                 Processor Type: Central Processor
                 Processor Family: K5
                 Processor Manufacturer: AuthenticAMD
                 Processor Version: Mobile AMD Athlon(tm) XP processor=20
2400+
Handle 0x0005
         DMI type 7, 19 bytes.
         Cache
                 Socket: L1 Cache
                 L1 Internal Cache: write-back
                 L1 Cache Size: 128K
                 L1 Cache Maximum: 128K
                 L1 Cache Type: Synchronous
Handle 0x0006
         DMI type 7, 19 bytes.
         Cache
                 Socket: L2 Cache
                 L2 socketed Internal Cache: write-back
                 L2 Cache Size: 512K
                 L2 Cache Maximum: 512K
                 L2 Cache Type: Synchronous
Handle 0x0007
         DMI type 16, 15 bytes.
         Physical Memory Array
                 Location: System board or motherboard
                 Use: Flash memory
                 Error Correction Type: None
                 Maximum Capacity: 512 kB
                 Error Information Handle: Not Provided
                 Number of Devices: 1
Handle 0x0008
         DMI type 16, 15 bytes.
         Physical Memory Array
                 Location: System board or motherboard
                 Use: System memory
                 Error Correction Type: None
                 Maximum Capacity: 1048576 kB
                 Error Information Handle: Not Provided
                 Number of Devices: 2
Handle 0x0009
         DMI type 17, 23 bytes.
         Memory Device
                 Array Handle: 0x0008
                 Error Information Handle: Not Provided
                 Total Width: 64 bits
                 Data Width: 64 bits
                 Size: 256 Mbyte
                 Form Factor: DIMM
                 Set: 0x01
                 Locator: U5
                 Bank Locator: Bank 0
                 Type: DRAM
                 Type Detail: Synchronous
                 Speed: 266 MHz (3.8 ns)
Handle 0x000A
         DMI type 17, 23 bytes.
         Memory Device
                 Array Handle: 0x0008
                 Error Information Handle: Not Provided
                 Total Width: 64 bits
                 Data Width: 64 bits
                 Size: 256 Mbyte
                 Form Factor: DIMM
                 Set: 0x01
                 Locator: U6
                 Bank Locator: Bank 1
                 Type: DRAM
                 Type Detail: Synchronous
                 Speed: 266 MHz (3.8 ns)
Handle 0x000B
         DMI type 17, 23 bytes.
         Memory Device
                 Array Handle: 0x0007
                 Error Information Handle: Not Provided
                 Total Width: 16 bits
                 Data Width: 16 bits
                 Size: 512 Kbyte
                 Form Factor: Chip
                 Locator: System Board
                 Bank Locator: Null
                 Type: FLASH
                 Type Detail:
                 Speed: 8 MHz (125.0 ns)
Handle 0x000C
         DMI type 19, 15 bytes.
         Memory Array Mapped Address
Handle 0x000D
         DMI type 19, 15 bytes.
         Memory Array Mapped Address
Handle 0x000E
         DMI type 20, 19 bytes.
         Memory Device Mapped Address
Handle 0x000F
         DMI type 20, 19 bytes.
         Memory Device Mapped Address
Handle 0x0010
         DMI type 32, 20 bytes.
         System Boot Information
Handle 0x0011
         DMI type 127, 4 bytes.
         End-of-Table
BIOS32 Service Directory present.
         Calling Interface Address: 0x000FD770
PNP 1.0 present.
         Event Notification: Not Supported
         Real Mode Code Address: F000:A2C0
         Real Mode Data Address: 0040:0000
         Protected Mode Code Address: 0x000FA2DE
         Protected Mode Data Address: 0x00000400
PCI Interrupt Routing 1.0 present.
         Table Size: 192 bytes
         Router ID: 00:07.0
         Exclusive IRQs: None
         Compatible Router: 10b9:1533


CPUINFO:
cpuinfo.txt
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : Mobile AMD Athlon(tm) XP 2400+
stepping        : 0
cpu MHz         : 1788.968
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=20
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowex
t 3dnow
s        : 3538.94



DMESG:



bogomipLinux version 2.6.3 (root@enlaptop.ameritech.net) (gcc version=20
3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk)) #2 Tue Feb 24 19:57:46 UTC
  2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001bef0000 (usable)
  BIOS-e820: 000000001bef0000 - 000000001beff000 (ACPI data)
  BIOS-e820: 000000001beff000 - 000000001bf00000 (ACPI NVS)
  BIOS-e820: 000000001bf00000 - 000000001c000000 (usable)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
448MB LOWMEM available.
On node 0 totalpages: 114688
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 110592 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ARIMA                                     ) @ 0x000f7680
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1befae80
ACPI: FADT (v001 ARIMA  W720-K7  0x06040000 PTL_ 0x000f4240) @ 0x1befee53
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x1befeec7
ACPI: DSDT (v001 ARIMA  W720-K7  0x06040000 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
Kernel command line: BOOT_IMAGE&3 ro root05 devfs=3Dmount hdc=3Dide-cd=20
resume=3D/dev/hda6 splash=3Dsilent
ide_setup: hdc=3Dide-cd
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1788.968 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 449788k/458752k available (2247k kernel code, 8132k reserved,=20
902k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor=20
mode... Ok.
Calibrating delay loop... 3538.94 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like=20
an initrd
Freeing initrd memory: 18k freed
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: CLK_CTL MSR was 60071263. Reprogramming to 20071263
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Mobile AMD Athlon(tm) XP 2400+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
.... CPU clock speed is 1788.0673 MHz.
.... host bus clock speed is 264.0988 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd88e, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
spurious 8259A interrupt: IRQ7.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNK6] (IRQs 3 4 *5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNK7] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNK8] (IRQs 3 4 5 6 7 10 11 12)
ACPI: Embedded Controller [EC] (gpe 24)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even=20
'acpi=3Doff'
radeonfb_pci_register BEGIN
radeonfb: probed SDR SGRAM 245760k videoram
radeonfb: mapped 16384k videoram
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=191.86 MHz (RefDivB6) Memory=160.00 Mhz,=20
System=133.00 MHz
i2c_adapter i2c-0: registered as adapter #0
i2c_adapter i2c-1: registered as adapter #1
i2c_adapter i2c-2: registered as adapter #2
i2c_adapter i2c-3: registered as adapter #3
1 chips in connector info
  - chip 1 has 1 connectors
   * connector 0 of type 2 (CRT) : 2300
Starting monitor auto detection...
i2c_adapter i2c-0: master_xfer: with 2 msgs.
i2c_adapter i2c-0: master_xfer: with 2 msgs.
i2c_adapter i2c-0: master_xfer: with 2 msgs.
radeonfb: I2C (port 1) ... not found
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
radeonfb: I2C (port 2) ... not found
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
radeonfb: I2C (port 3) ... not found
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
radeonfb: I2C (port 4) ... not found
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
radeonfb: I2C (port 2) ... not found
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
radeonfb: I2C (port 4) ... not found
Non-DDC laptop panel detected
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
radeonfb: I2C (port 3) ... not found
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
radeonfb: I2C (port 4) ... not found
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: 1280x800 WXGA
radeonfb: detected LVDS panel size from BIOS: 1280x800
BIOS provided panel power delay: 400
radeondb: BIOS provided dividers will be used
ref_divider =3D 14
post_divider =3D 2
fbk_divider =3D 1d
Scanning BIOS table ...
  320 x 350
  320 x 400
  320 x 400
  320 x 480
  400 x 600
  512 x 384
  640 x 350
  640 x 400
  640 x 475
  640 x 480
  720 x 480
  720 x 576
  800 x 600
  848 x 480
  1024 x 768
  1280 x 800
Found panel in BIOS table:
   hblank: 144
   hOver_plus: 72
   hSync_width: 32
   vblank: 12
   vOver_plus: 2
   vSync_width: 1
   clock: 6950
Setting up default mode based on panel info
radeonfb: Power Management enabled for Mobility chipsets
mtrr: base(0xe0000000) is not aligned on a size(0xf000000) boundary
radeonfb: ATI Radeon C6  SDR SGRAM 240 MB
radeonfb_pci_register END
vesafb: abort, cannot reserve video memory at 0xe0000000
vesafb: framebuffer at 0xe0000000, mapped to 0xdd835000, size 16384k
vesafb: mode is 800x600x16, linelength=1600, pagesg
vesafb: protected mode interface info at c000:511f
vesafb: scrolling: redraw
vesafb: directcolor: size=3D0:5:6:5, shift=3D0:11:5:0
fb1: VESA VGA frame buffer device
Machine check exception polling timer started.
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00f0c70
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 43 PST tables. (Only dumping ones relevant to this CPU).
powernow: No PST tables match this cpuid (0x7a0)
powernow: This is indicative of a broken BIOS.
powernow: See=20
http://www.codemonkey.org.uk/projects/cpufreq/powernow-k7.shtml
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
udf: registering filesystem
Initializing Cryptographic API
ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.
Activating ISA DMA hang workarounds.
hStart =3D 1352, hEnd =3D 1384, hTotal =3D 1424
vStart =3D 802, vEnd =3D 803, vTotal =3D 812
h_total_disp =3D 0x9f00b1    hsync_strt_wid =3D 0x40542
v_total_disp =3D 0x31f032b           vsync_strt_wid =3D 0x10321
pixclock =3D 14388
freq =3D 6950
lvds_gen_cntl: 003dffa1
Console: switching to colour frame buffer device 160x100
pty: 1024 Unix98 ptys configured
[drm] Initialized radeon 1.9.0 20020828 on minor 0
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
b44.c:v0.92 (Nov 4, 2003)
eth0: Broadcom 4400 10/100BaseT Ethernet 00:03:25:0b:90:4f
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with=20
idebus=3Dxx
Warning: ATI Radeon IGP Northbridge is not yet fully tested.
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23FB-60, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Slimtype COMBO LSC-24082K, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHSe535/16/63,=20
UDMA(100)
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 >
hdc: ATAPI 24X DVD-ROM CD-R/RW CD-MRW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Console: switching to colour frame buffer device 160x100
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
  Firmware: 5.9
  Sensor: 35
  new absolute packet format
  Touchpad has extended capability bits
  -> multifinger detection
  -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 10
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
   (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
    (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2c /dev entries driver
i2c-core: driver dev_driver registered.
i2c_adapter i2c-0: Registered as minor 0
i2c_adapter i2c-1: Registered as minor 1
i2c_adapter i2c-2: Registered as minor 2
i2c_adapter i2c-3: Registered as minor 3
ali1535_smbus 0000:00:11.0: SMBREV =3D 0x0
ali1535_smbus 0000:00:11.0: ALI1535_smba =3D 0x8040
i2c_adapter i2c-4: Registered as minor 4
i2c_adapter i2c-4: registered as adapter #4
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
Resume Machine: resuming from /dev/hda6
Resuming from device hda6
Resume Machine: This is normal swap space
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Mounted devfs on /dev
Freeing unused kernel memory: 168k freed
Real Time Clock Driver v1.12
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:0d.2: EHCI Host Controller
ehci_hcd 0000:00:0d.2: irq 11, pci mem de84c800
ehci_hcd 0000:00:0d.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0d.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
EXT3 FS on hda5, internal journal
Adding 506008k swap on /dev/hda6.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS driver 2.1.6 [Flags: R/O MODULE].
NTFS-fs warning (device hda1): parse_options(): Option iocharset is=20
deprecated. Please use option nls=3D<charsetname> in the futur
e.
NTFS volume version 3.0.
ohci1394: $Rev: 1097 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D[10]=20
MMIO=3D[d000c000-d000c7ff]  Max Packet=3D[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000325211900df9c]


From:
/var/log/kernel/info:
Feb 28 12:20:16 enlaptop kernel: Machine check exception polling timer=20
started.
Feb 28 12:20:16 enlaptop kernel: powernow: PowerNOW! Technology=20
present. Can scale: frequency and voltage.
Feb 28 12:20:16 enlaptop kernel: powernow: Found PSB header at c00f0c70
Feb 28 12:20:16 enlaptop kernel: powernow: Table version: 0x12
Feb 28 12:20:16 enlaptop kernel: powernow: Flags: 0x0 (Mobile voltage=20
regulator)
Feb 28 12:20:16 enlaptop kernel: powernow: Settling Time: 100=20
microseconds.
Feb 28 12:20:16 enlaptop kernel: powernow: Has 43 PST tables. (Only=20
dumping ones relevant to this CPU).
Feb 28 12:20:16 enlaptop kernel: powernow: No PST tables match this=20
cpuid (0x7a0)
Feb 28 12:20:16 enlaptop kernel: powernow: This is indicative of a=20
broken BIOS.
Feb 28 12:20:16 enlaptop kernel: powernow: See=20
http://www.codemonkey.org.uk/projects/cpufreq/powernow-k7.shtml
-------------- next part --------------
#
# Automatically generated make config: don't edit
#
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
# CONFIG_CLEAN_COMPILE is not set
# CONFIG_STANDALONE is not set
CONFIG_BROKEN=3Dy
CONFIG_BROKEN_ON_SMP=3Dy

#
# General setup
#
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_LOG_BUF_SHIFT=14
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

#
# Processor type and features
#
CONFIG_X86_PC=3Dy
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=3Dy
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_USE_3DNOW=3Dy
CONFIG_HPET_TIMER=3Dy
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=3Dy
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dy
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=3Dy

#
# Power management options (ACPI, APM)
#
CONFIG_PM=3Dy
CONFIG_SOFTWARE_SUSPEND=3Dy
CONFIG_PM_DISK=3Dy
CONFIG_PM_DISK_PARTITION=3D"/dev/hda6"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=3Dy
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SLEEP_PROC_FS=3Dy
CONFIG_ACPI_AC=3Dm
CONFIG_ACPI_BATTERY=3Dm
CONFIG_ACPI_BUTTON=3Dm
CONFIG_ACPI_FAN=3Dm
CONFIG_ACPI_PROCESSOR=3Dm
CONFIG_ACPI_THERMAL=3Dm
CONFIG_ACPI_ASUS=3Dm
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_ACPI_RELAXED_AML=3Dy

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=3Dy
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=3Dy
CONFIG_APM_CPU_IDLE=3Dy
CONFIG_APM_DISPLAY_BLANK=3Dy
CONFIG_APM_RTC_IS_GMT=3Dy
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_PROC_INTF=3Dy
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_24_API=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=3Dm
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_POWERNOW_K6 is not set
CONFIG_X86_POWERNOW_K7=3Dy
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_USE_VECTOR=3Dy
CONFIG_PCI_LEGACY_PROC=3Dy
CONFIG_PCI_NAMES=3Dy
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=3Dy

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=3Dm
CONFIG_YENTA=3Dm
CONFIG_CARDBUS=3Dy
# CONFIG_I82092 is not set
# CONFIG_TCIC is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_MISC=3Dm

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_FW_LOADER=3Dy

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=3Dm
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_PARTITIONS=3Dm
CONFIG_MTD_CONCAT=3Dm
CONFIG_MTD_REDBOOT_PARTS=3Dm
CONFIG_MTD_CMDLINE_PARTS=3Dm

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=3Dm
CONFIG_MTD_BLOCK=3Dm
CONFIG_MTD_BLOCK_RO=3Dm
CONFIG_FTL=3Dm
CONFIG_NFTL=3Dm
CONFIG_NFTL_RW=3Dy
CONFIG_INFTL=3Dm

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=3Dm
CONFIG_MTD_JEDECPROBE=3Dm
CONFIG_MTD_GEN_PROBE=3Dm
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_CFI_INTELEXT=3Dm
CONFIG_MTD_CFI_AMDSTD=3Dm
CONFIG_MTD_CFI_STAA=3Dm
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=3Dm
# CONFIG_MTD_OBSOLETE_CHIPS is not set

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=3Dy
CONFIG_MTD_PHYSMAP=3Dm
CONFIG_MTD_PHYSMAP_START=3D0x8000000
CONFIG_MTD_PHYSMAP_LEN=3D0x4000000
CONFIG_MTD_PHYSMAP_BUSWIDTH=3D2
# CONFIG_MTD_PNC2000 is not set
# CONFIG_MTD_SC520CDP is not set
# CONFIG_MTD_NETSC520 is not set
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_ELAN_104NC is not set
# CONFIG_MTD_SCx200_DOCFLASH is not set
CONFIG_MTD_AMD76XROM=3Dm
# CONFIG_MTD_ICH2ROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_DILNETPC is not set
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_PCMCIA is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLKMTD=3Dm

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set

#
# NAND Flash Device Drivers
#
CONFIG_MTD_NAND=3Dm
CONFIG_MTD_NAND_VERIFY_WRITE=3Dy
CONFIG_MTD_NAND_IDS=3Dm

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_CML1=3Dm
CONFIG_PARPORT_SERIAL=3Dm
CONFIG_PARPORT_PC_FIFO=3Dy
CONFIG_PARPORT_PC_SUPERIO=3Dy
CONFIG_PARPORT_PC_PCMCIA=3Dm
CONFIG_PARPORT_OTHER=3Dy
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play support
#

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=3Dm
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_SIZE2000
CONFIG_BLK_DEV_INITRD=3Dy
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECS=3Dm
CONFIG_BLK_DEV_IDECD=3Dy
CONFIG_BLK_DEV_IDETAPE=3Dm
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=3Dy
CONFIG_IDE_TASKFILE_IO=3Dy

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=3Dm
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_OFFBOARD=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=3Dy
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=3Dy
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=3Dm
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=3Dm
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=3Dm

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=3Dy

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=3Dm

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=3Dm
CONFIG_IEEE1394_SBP2=3Dm
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=3Dm
CONFIG_IEEE1394_DV1394=3Dm
CONFIG_IEEE1394_RAWIO=3Dm
CONFIG_IEEE1394_CMP=3Dm
CONFIG_IEEE1394_AMDTP=3Dm

#
# I2O device support
#
CONFIG_I2O=3Dy
CONFIG_I2O_PCI=3Dy
CONFIG_I2O_BLOCK=3Dy
CONFIG_I2O_SCSI=3Dm
CONFIG_I2O_PROC=3Dy

#
# Macintosh device drivers
#

#
# Networking support
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dm
CONFIG_PACKET_MMAP=3Dy
CONFIG_NETLINK_DEV=3Dm
CONFIG_UNIX=3Dy
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_NAT=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_TOS=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE=3Dm
CONFIG_NET_IPGRE_BROADCAST=3Dy
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
# CONFIG_ARPD is not set
CONFIG_INET_ECN=3Dy
CONFIG_SYN_COOKIES=3Dy
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_IPV6=3Dm
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_DECNET is not set
CONFIG_BRIDGE=3Dm
# CONFIG_NETFILTER is not set
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dm

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=3Dm
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=3Dm
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=3Dy
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
# CONFIG_NET_SCH_HFSC is not set
CONFIG_NET_SCH_CSZ=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_QOS=3Dy
CONFIG_NET_ESTIMATOR=3Dy
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_ROUTE=3Dy
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_POLICE=3Dy

#
# Network testing
#
CONFIG_NET_PKTGEN=3Dm
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=3Dm
CONFIG_BONDING=3Dm
# CONFIG_EQUALIZER is not set
CONFIG_TUN=3Dm
CONFIG_ETHERTAP=3Dm

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dm
# CONFIG_HAPPYMEAL is not set
CONFIG_SUNGEM=3Dy
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_B44=3Dy
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=3Dm
CONFIG_PPP=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPPOE=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=3Dy

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_AIRO=3Dm
CONFIG_HERMES=3Dm
CONFIG_PLX_HERMES=3Dm
CONFIG_TMD_HERMES=3Dm
CONFIG_PCI_HERMES=3Dm
# CONFIG_ATMEL is not set

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=3Dm
CONFIG_AIRO_CS=3Dm
# CONFIG_PCMCIA_WL3501 is not set
CONFIG_NET_WIRELESS=3Dy

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
CONFIG_SHAPER=3Dm

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=3Dy
CONFIG_PCMCIA_3C589=3Dm
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_PCMCIA_AXNET is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=3Dm

#
# IrDA protocols
#
CONFIG_IRLAN=3Dm
CONFIG_IRNET=3Dm
CONFIG_IRCOMM=3Dm
CONFIG_IRDA_ULTRA=3Dy

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
CONFIG_IRDA_FAST_RR=3Dy
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=3Dm

#
# Dongle support
#
CONFIG_DONGLE=3Dy
CONFIG_ESI_DONGLE=3Dm
CONFIG_ACTISYS_DONGLE=3Dm
CONFIG_TEKRAM_DONGLE=3Dm
# CONFIG_LITELINK_DONGLE is not set
# CONFIG_MA600_DONGLE is not set
# CONFIG_GIRBIL_DONGLE is not set
# CONFIG_MCP2120_DONGLE is not set
# CONFIG_OLD_BELKIN_DONGLE is not set
# CONFIG_ACT200L_DONGLE is not set

#
# Old SIR device drivers
#
CONFIG_IRPORT_SIR=3Dm

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
CONFIG_USB_IRDA=3Dm
CONFIG_TOSHIBA_FIR=3Dm
CONFIG_VLSI_FIR=3Dm

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=800
CONFIG_INPUT_JOYDEV=3Dm
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=3Dm
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
CONFIG_GAMEPORT=3Dm
CONFIG_SOUND_GAMEPORT=3Dm
CONFIG_GAMEPORT_NS558=3Dm
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dy
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
# CONFIG_INPUT_PCSPKR is not set
CONFIG_INPUT_UINPUT=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dm
CONFIG_SERIAL_8250_CS=3Dm
CONFIG_SERIAL_8250_ACPI=3Dy
CONFIG_SERIAL_8250_NR_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dm
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=1024
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=3Dm
# CONFIG_TIPAR is not set

#
# Mice
#
CONFIG_BUSMOUSE=3Dm
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=3Dm
CONFIG_IPMI_PANIC_EVENT=3Dy
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=3Dm
CONFIG_IPMI_KCS=3Dm
CONFIG_IPMI_WATCHDOG=3Dm

#
# Watchdog Cards
#
CONFIG_WATCHDOG=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=3Dm
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=3Dm
CONFIG_ALIM7101_WDT=3Dm
# CONFIG_AMD7XX_TCO is not set
# CONFIG_SC520_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I8XX_TCO is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
CONFIG_HW_RANDOM=3Dm
CONFIG_NVRAM=3Dm
CONFIG_RTC=3Dm
CONFIG_GEN_RTC=3Dm
CONFIG_GEN_RTC_X=3Dy
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dm
CONFIG_AGP_ALI=3Dm
CONFIG_AGP_ATI=3Dm
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=3Dy
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=3Dy
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_MWAVE=3Dm
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
CONFIG_I2C=3Dy
CONFIG_I2C_CHARDEV=3Dy

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=3Dy
CONFIG_I2C_ALGOPCF=3Dy

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=3Dy
CONFIG_I2C_ALI15X3=3Dy
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=3Dm
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_PHILIPSPAR=3Dm
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# I2C Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=3Dm
CONFIG_SENSORS_ADM1021=3Dm
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_EEPROM=3Dm
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_IT87=3Dm
CONFIG_SENSORS_LM75=3Dm
CONFIG_SENSORS_LM78=3Dm
CONFIG_SENSORS_LM83=3Dm
CONFIG_SENSORS_LM85=3Dm
CONFIG_SENSORS_LM90=3Dm
CONFIG_SENSORS_VIA686A=3Dm
CONFIG_SENSORS_W83781D=3Dm
CONFIG_SENSORS_W83L785TS=3Dm
CONFIG_I2C_DEBUG_CORE=3Dy
CONFIG_I2C_DEBUG_BUS=3Dy
CONFIG_I2C_DEBUG_CHIP=3Dy

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=3Dm

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_BWQCAM is not set
CONFIG_VIDEO_CQCAM=3Dm
# CONFIG_VIDEO_W9966 is not set
CONFIG_VIDEO_CPIA=3Dm
# CONFIG_VIDEO_CPIA_PP is not set
CONFIG_VIDEO_CPIA_USB=3Dm
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=3Dy
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=3Dm
CONFIG_FB_VESA=3Dy
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=3Dy
CONFIG_FB_RADEON_I2C=3Dy
CONFIG_FB_RADEON_DEBUG=3Dy
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_PCI_CONSOLE=3Dy
CONFIG_FONTS=3Dy
CONFIG_FONT_8x8=3Dy
# CONFIG_FONT_8x16 is not set
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
CONFIG_LOGO=3Dy
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=3Dy

#
# Sound
#
CONFIG_SOUND=3Dm

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dm
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dm
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_DUMMY=3Dm
CONFIG_SND_VIRMIDI=3Dm
CONFIG_SND_MTPAV=3Dm
CONFIG_SND_SERIAL_U16550=3Dm
CONFIG_SND_MPU401=3Dm

#
# PCI devices
#
CONFIG_SND_ALI5451=3Dm
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=3Dm

#
# PCMCIA devices
#

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=3Dm
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set
CONFIG_USB_DYNAMIC_MINORS=3Dy

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_OHCI_HCD=3Dm
# CONFIG_USB_UHCI_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=3Dm
# CONFIG_USB_BLUETOOTH_TTY is not set
CONFIG_USB_MIDI=3Dm
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=3Dy
CONFIG_USB_STORAGE_FREECOM=3Dy
CONFIG_USB_STORAGE_ISD200=3Dy
CONFIG_USB_STORAGE_DPCM=3Dy
CONFIG_USB_STORAGE_HP8200e=3Dy
CONFIG_USB_STORAGE_SDDR09=3Dy
CONFIG_USB_STORAGE_SDDR55=3Dy
CONFIG_USB_STORAGE_JUMPSHOT=3Dy

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT=3Dy
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=3Dy

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=3Dm
CONFIG_USB_MOUSE=3Dm
CONFIG_USB_AIPTEK=3Dm
CONFIG_USB_WACOM=3Dm
CONFIG_USB_KBTAB=3Dm
CONFIG_USB_POWERMATE=3Dm
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=3Dm
CONFIG_USB_MICROTEK=3Dm
CONFIG_USB_HPUSBSCSI=3Dm

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=3Dm
CONFIG_USB_VICAM=3Dm
CONFIG_USB_DSBR=3Dm
CONFIG_USB_IBMCAM=3Dm
CONFIG_USB_KONICAWC=3Dm
CONFIG_USB_OV511=3Dm
CONFIG_USB_PWC=3Dm
CONFIG_USB_SE401=3Dm
CONFIG_USB_STV680=3Dm
CONFIG_USB_W9968CF=3Dm

#
# USB Network adaptors
#
CONFIG_USB_CATC=3Dm
CONFIG_USB_KAWETH=3Dm
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_USBNET=3Dm

#
# USB Host-to-Host Cables
#
CONFIG_USB_AN2720=3Dy
CONFIG_USB_BELKIN=3Dy
CONFIG_USB_GENESYS=3Dy
CONFIG_USB_NET1080=3Dy
CONFIG_USB_PL2301=3Dy

#
# Intelligent USB Devices/Gadgets
#
# CONFIG_USB_ARMLINUX is not set
CONFIG_USB_EPSON2888=3Dy
CONFIG_USB_ZAURUS=3Dy
CONFIG_USB_CDCETHER=3Dy

#
# USB Network Adapters
#
CONFIG_USB_AX8817X=3Dy

#
# USB port drivers
#
CONFIG_USB_USS720=3Dm

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_WHITEHEAT=3Dm
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
CONFIG_USB_SERIAL_KEYSPAN=3Dm
CONFIG_USB_SERIAL_KEYSPAN_MPR=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28X=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA18X=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19W=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA49W=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=3Dy
CONFIG_USB_SERIAL_KLSI=3Dm
CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
CONFIG_USB_SERIAL_MCT_U232=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
CONFIG_USB_SERIAL_SAFE=3Dm
CONFIG_USB_SERIAL_SAFE_PADDED=3Dy
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_EZUSB=3Dy

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=3Dm
CONFIG_USB_EMI26=3Dm
CONFIG_USB_TIGL=3Dm
CONFIG_USB_AUERSWALD=3Dm
CONFIG_USB_RIO500=3Dm
CONFIG_USB_LEGOTOWER=3Dm
CONFIG_USB_BRLVGER=3Dm
CONFIG_USB_LCD=3Dm
CONFIG_USB_LED=3Dm
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
CONFIG_USB_GADGET=3Dy
CONFIG_USB_GADGET_NET2280=3Dy
CONFIG_USB_NET2280=3Dy
# CONFIG_USB_GADGET_PXA2XX is not set
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_SA1100 is not set
CONFIG_USB_ZERO=3Dm
CONFIG_USB_ETH=3Dm
CONFIG_USB_GADGETFS=3Dm
CONFIG_USB_FILE_STORAGE=3Dm
# CONFIG_USB_FILE_STORAGE_TEST is not set
CONFIG_USB_G_SERIAL=3Dm

#
# File systems
#
CONFIG_EXT2_FS=3Dy
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=3Dm
CONFIG_QUOTA=3Dy
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=3Dy
CONFIG_QUOTACTL=3Dy
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=3Dm

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dy
CONFIG_UDF_FS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_DEVFS_FS=3Dy
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=3Dy
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
CONFIG_JFFS2_FS=3Dm
CONFIG_JFFS2_FS_DEBUG=3D0
# CONFIG_JFFS2_FS_NAND is not set
CONFIG_CRAMFS=3Dm
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dm
CONFIG_SUNRPC=3Dy
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=3Dm
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp437"
CONFIG_CIFS=3Dm
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=3Dy
CONFIG_UNIXWARE_DISKLABEL=3Dy
CONFIG_LDM_PARTITION=3Dy
# CONFIG_LDM_DEBUG is not set
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_936=3Dm
CONFIG_NLS_CODEPAGE_950=3Dm
CONFIG_NLS_CODEPAGE_932=3Dm
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_CODEPAGE_1250=3Dm
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_U=3Dm
CONFIG_NLS_UTF8=3Dm

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_FRAME_POINTER=3Dy
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_NULL=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dm
CONFIG_CRYPTO_SHA1=3Dm
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_AES=3Dm
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_DEFLATE=3Dm
CONFIG_CRYPTO_TEST=3Dm

#
# Library routines
#
CONFIG_CRC32=3Dy
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_X86_BIOS_REBOOT=3Dy
CONFIG_PC=3Dy
