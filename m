From: lundby@ameritech.net (water modem)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: kern2.6.3 - report busted PST laptop table in eMachines M5312
Message-Id: <404320F6.8000504@ameritech.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <40409BEF.7070108@ameritech.net>
In-Reply-To: <40409BEF.7070108@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Benjamin Herrenschmidt wrote:
> Your message was mangled. Can you forward me some clear
> report of the problem ?
> 
Attached original report as report.eml

There is no real functional problem in that that laptop and most 
applications run as expected.  The problem is the error reports made 
by ic2 and the radeonfb subsystems.

These reports have been there since at least 2.6.1 and maybe earlier. 
  (I would have to uncompress some of the compressed logs in /var/log 
to see how far back.)  I only noticed them when I got a oops with 
ndiswrapper in 2.6.4-rc1.  I solved that problem (the patch for rc1 
enabled an alternate driver api using register passing and I just 
reverted that config option - might cure me of "make oldconfig".) but 
still see these radeonfb and ic2 complaints.

from dmidecode:
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
                 Processor Version: Mobile AMD Athlon(tm) XP processor 
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
[root@enlaptop kernel]#

from /var/log/kernel/errors

Mar  1 01:32:20 enlaptop kernel: Unable to handle kernel paging 
request at virtual address de94b1e9
Mar  1 01:32:20 enlaptop kernel: *pde = 015d7067
Mar  1 01:32:20 enlaptop kernel: *pte = 00000000
Mar  1 01:32:20 enlaptop kernel: In idle task - not syncing
Mar  1 10:27:20 enlaptop kernel: radeonfb: Invalid ROM signature 0 
should be 0xaa55
Mar  1 10:27:20 enlaptop kernel: Warning: ATI Radeon IGP Northbridge 
is not yet fully tested.
Mar  1 10:27:20 enlaptop kernel: Resume Machine: This is normal swap space
Mar  1 10:27:20 enlaptop kernel: NTFS-fs warning (device hda1): 
parse_options(): Option iocharset is deprecated. Please use option 
nls=<charsetname> in the future.


from /var/log/kernel/warnings
ar  1 10:27:20 enlaptop kernel: ..... CPU clock speed is 1788.0680 MHz.
Mar  1 10:27:20 enlaptop kernel: ..... host bus clock speed is 
264.0989 MHz.
Mar  1 10:27:20 enlaptop kernel: spurious 8259A interrupt: IRQ7.
Mar  1 10:27:20 enlaptop kernel: ACPI: IRQ9 SCI: Edge set to Level 
Trigger.
Mar  1 10:27:20 enlaptop kernel: PCI: Probing PCI hardware (bus 00)
Mar  1 10:27:20 enlaptop kernel: ACPI: PCI Interrupt Link [LNK0] (IRQs 
3 4 5 6 7 10 11 12)
Mar  1 10:27:20 enlaptop kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 
3 4 5 6 7 10 *11 12)
Mar  1 10:27:20 enlaptop kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 
3 4 5 6 7 *10 11 12)
Mar  1 10:27:20 enlaptop kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 
3 4 5 6 7 10 *11 12)
Mar  1 10:27:20 enlaptop kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 
3 4 5 6 7 10 11 12)
Mar  1 10:27:20 enlaptop kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 
3 4 5 6 7 10 11 12)
Mar  1 10:27:20 enlaptop kernel: ACPI: PCI Interrupt Link [LNK6] (IRQs 
3 4 *5 6 7 10 11 12)
Mar  1 10:27:20 enlaptop kernel: ACPI: PCI Interrupt Link [LNK7] (IRQs 
3 4 5 6 7 10 *11 12)
Mar  1 10:27:20 enlaptop kernel: ACPI: PCI Interrupt Link [LNK8] (IRQs 
3 4 5 6 7 10 11 12)
Mar  1 10:27:20 enlaptop kernel: ACPI: PCI Interrupt Link [LNK7] 
enabled at IRQ 11
Mar  1 10:27:20 enlaptop kernel: ACPI: PCI Interrupt Link [LNK6] 
enabled at IRQ 5
Mar  1 10:27:20 enlaptop kernel: ACPI: PCI Interrupt Link [LNK2] 
enabled at IRQ 10
Mar  1 10:27:20 enlaptop kernel: ACPI: PCI Interrupt Link [LNK1] 
enabled at IRQ 11
Mar  1 10:27:20 enlaptop kernel: ACPI: PCI Interrupt Link [LNK3] 
enabled at IRQ 11
Mar  1 10:27:20 enlaptop kernel: ACPI: No IRQ known for interrupt pin 
A of device 0000:00:10.0
Mar  1 10:27:20 enlaptop kernel: radeonfb_pci_register BEGIN
Mar  1 10:27:20 enlaptop kernel: radeonfb: probed SDR SGRAM 245760k 
videoram
Mar  1 10:27:20 enlaptop kernel: radeonfb: mapped 16384k videoram
Mar  1 10:27:20 enlaptop kernel: radeonfb: Reference1.86 MHz 
(RefDivB6) Memory0.00 Mhz, System3.00 MHz
Mar  1 10:27:20 enlaptop kernel: 1 chips in connector info
Mar  1 10:27:20 enlaptop kernel:  - chip 1 has 1 connectors
Mar  1 10:27:20 enlaptop kernel:   * connector 0 of type 2 (CRT) : 2300
Mar  1 10:27:20 enlaptop kernel: Starting monitor auto detection...
Mar  1 10:27:20 enlaptop kernel: radeonfb: I2C (port 1) ... not found
Mar  1 10:27:20 enlaptop kernel: radeonfb: I2C (port 2) ... not found
Mar  1 10:27:20 enlaptop kernel: radeonfb: I2C (port 3) ... not found
Mar  1 10:27:20 enlaptop kernel: radeonfb: I2C (port 4) ... not found
Mar  1 10:27:20 enlaptop kernel: radeonfb: I2C (port 2) ... not found
Mar  1 10:27:20 enlaptop kernel: radeonfb: I2C (port 4) ... not found
Mar  1 10:27:20 enlaptop kernel: Non-DDC laptop panel detected
Mar  1 10:27:20 enlaptop kernel: radeonfb: I2C (port 3) ... not found
Mar  1 10:27:20 enlaptop kernel: radeonfb: I2C (port 4) ... not found
Mar  1 10:27:20 enlaptop kernel: radeonfb: panel ID string: 1280x800 WXGA
Mar  1 10:27:20 enlaptop kernel: radeonfb: detected LVDS panel size 
from BIOS: 1280x800
Mar  1 10:27:20 enlaptop kernel: BIOS provided panel power delay: 400
Mar  1 10:27:20 enlaptop kernel: ref_divider = 14
Mar  1 10:27:20 enlaptop kernel: post_divider = 2
Mar  1 10:27:20 enlaptop kernel: fbk_divider = 1d
Mar  1 10:27:20 enlaptop kernel: Scanning BIOS table ...
Mar  1 10:27:20 enlaptop kernel:  320 x 350
Mar  1 10:27:20 enlaptop kernel:  320 x 400
Mar  1 10:27:20 enlaptop kernel:  320 x 400
Mar  1 10:27:20 enlaptop kernel:  320 x 480
Mar  1 10:27:20 enlaptop kernel:  400 x 600
Mar  1 10:27:20 enlaptop kernel:  512 x 384
Mar  1 10:27:20 enlaptop kernel:  640 x 350
Mar  1 10:27:20 enlaptop kernel:  640 x 400
Mar  1 10:27:20 enlaptop kernel:  640 x 475
Mar  1 10:27:20 enlaptop kernel:  640 x 480
Mar  1 10:27:20 enlaptop kernel:  720 x 480
Mar  1 10:27:20 enlaptop kernel:  720 x 576
Mar  1 10:27:20 enlaptop kernel:  800 x 600
Mar  1 10:27:20 enlaptop kernel:  848 x 480
Mar  1 10:27:20 enlaptop kernel:  1024 x 768
Mar  1 10:27:20 enlaptop kernel:  1280 x 800
Mar  1 10:27:20 enlaptop kernel: Found panel in BIOS table:
Mar  1 10:27:20 enlaptop kernel:   hblank: 144
Mar  1 10:27:20 enlaptop kernel:   hOver_plus: 72
Mar  1 10:27:20 enlaptop kernel:   hSync_width: 32
Mar  1 10:27:20 enlaptop kernel:   vblank: 12
Mar  1 10:27:20 enlaptop kernel:   vOver_plus: 2
Mar  1 10:27:20 enlaptop kernel:   vSync_width: 1
Mar  1 10:27:20 enlaptop kernel:   clock: 6950
Mar  1 10:27:20 enlaptop kernel: Setting up default mode based on 
panel info
Mar  1 10:27:20 enlaptop kernel: radeonfb: Power Management enabled 
for Mobility chipsets
Mar  1 10:27:20 enlaptop kernel: mtrr: base(0xe0000000) is not aligned 
on a size(0xf000000) boundary
Mar  1 10:27:20 enlaptop kernel: radeonfb: ATI Radeon C6  SDR SGRAM 240 MB
Mar  1 10:27:20 enlaptop kernel: radeonfb_pci_register END
Mar  1 10:27:20 enlaptop kernel: vesafb: abort, cannot reserve video 
memory at 0xe0000000
Mar  1 10:27:20 enlaptop kernel: hStart = 1352, hEnd = 1384, hTotal = 1424
Mar  1 10:27:20 enlaptop kernel: vStart = 802, vEnd = 803, vTotal = 812
Mar  1 10:27:20 enlaptop kernel: h_total_disp = 0x9f00b1^I 
hsync_strt_wid = 0x40542
Mar  1 10:27:20 enlaptop kernel: v_total_disp = 0x31f032b^I 
vsync_strt_wid = 0x10321
Mar  1 10:27:20 enlaptop kernel: pixclock = 14388
Mar  1 10:27:20 enlaptop kernel: freq = 6950
Mar  1 10:27:20 enlaptop kernel: lvds_gen_cntl: 003dffa1
Mar  1 10:27:20 enlaptop kernel: Console: switching to colour frame 
buffer device 160x100
Mar  1 10:27:20 enlaptop kernel: RAMDISK driver initialized: 16 RAM 
disks of 32000K size 1024 blocksize
Mar  1 10:27:20 enlaptop kernel: ACPI: No IRQ known for interrupt pin 
A of device 0000:00:10.0
Mar  1 10:27:20 enlaptop kernel: hda: HITACHI_DK23FB-60, ATA DISK drive
Mar  1 10:27:20 enlaptop kernel: Using anticipatory io scheduler
Mar  1 10:27:20 enlaptop kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar  1 10:27:20 enlaptop kernel: hdc: Slimtype COMBO LSC-24082K, ATAPI 
CD/DVD-ROM drive
Mar  1 10:27:20 enlaptop kernel: ide1 at 0x170-0x177,0x376 on irq 15
Mar  1 10:27:20 enlaptop kernel: hda: max request size: 128KiB
Mar  1 10:27:20 enlaptop kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW CD-MRW 
drive, 2048kB Cache, UDMA(33)
Mar  1 10:27:20 enlaptop kernel: Console: switching to colour frame 
buffer device 160x100
Mar  1 10:27:20 enlaptop kernel: Resume Machine: resuming from /dev/hda6
Mar  1 10:27:20 enlaptop kernel: Resuming from device hda6
Mar  1 10:27:20 enlaptop kernel: VFS: Mounted root (ext2 filesystem).
Mar  1 10:27:36 enlaptop kernel: mtrr: 0xe0000000,0x4000000 overlaps 
existing 0xe0000000,0x1000000
Mar  1 10:27:37 enlaptop kernel: atkbd.c: Unknown key released 
(translated set 2, code 0x7a on isa0060/serio0).
Mar  1 10:27:37 enlaptop kernel: atkbd.c: This is an XFree86 bug. It 
shouldn't access hardware directly.
Mar  1 10:27:37 enlaptop kernel: atkbd.c: Unknown key released 
(translated set 2, code 0x7a on isa0060/serio0).
Mar  1 10:27:37 enlaptop kernel: atkbd.c: This is an XFree86 bug. It 
shouldn't access hardware directly.

 From info:
ar  1 10:27:20 enlaptop kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Mar  1 10:27:20 enlaptop kernel: input: AT Translated Set 2 keyboard 
on isa0060/serio0
Mar  1 10:27:20 enlaptop kernel: I2O Core - (C) Copyright 1999 Red Hat 
Software
Mar  1 10:27:20 enlaptop kernel: I2O: Event thread created as pid 10
Mar  1 10:27:20 enlaptop kernel: i2o: Checking for PCI I2O controllers...
Mar  1 10:27:20 enlaptop kernel: I2O configuration manager v 0.04.
Mar  1 10:27:20 enlaptop kernel:   (C) Copyright 1999 Red Hat Software
Mar  1 10:27:20 enlaptop kernel: I2O Block Storage OSM v0.9
Mar  1 10:27:20 enlaptop kernel:    (c) Copyright 1999-2001 Red Hat 
Software.
Mar  1 10:27:20 enlaptop kernel: i2o_block: Checking for Boot device...
Mar  1 10:27:20 enlaptop kernel: i2o_block: Checking for I2O Block 
devices...
Mar  1 10:27:20 enlaptop kernel: i2c /dev entries driver
Mar  1 10:27:20 enlaptop kernel: i2c-core: driver dev_driver registered.
Mar  1 10:27:20 enlaptop kernel: i2c_adapter i2c-0: Registered as minor 0
Mar  1 10:27:20 enlaptop kernel: i2c_adapter i2c-1: Registered as minor 1
Mar  1 10:27:20 enlaptop kernel: i2c_adapter i2c-2: Registered as minor 2
Mar  1 10:27:20 enlaptop kernel: i2c_adapter i2c-3: Registered as minor 3
Mar  1 10:27:20 enlaptop kernel: ali1535_smbus 0000:00:11.0: SMBREV = 0x0
Mar  1 10:27:20 enlaptop kernel: ali1535_smbus 0000:00:11.0: 
ALI1535_smba = 0x8040
Mar  1 10:27:20 enlaptop kernel: i2c_adapter i2c-4: Registered as minor 4
Mar  1 10:27:20 enlaptop kernel: i2c_adapter i2c-4: registered as 
adapter #4
Mar  1 10:27:20 enlaptop kernel: NET: Registered protocol family 2
Mar  1 10:27:20 enlaptop kernel: IP: routing cache hash table of 4096 
buckets, 32Kbytes
Mar  1 10:27:20 enlaptop kernel: TCP: Hash tables configured 
(established 8192 bind 16384)
Mar  1 10:27:20 enlaptop kernel: NET: Registered protocol family 1
Mar  1 10:27:20 enlaptop kernel: PM: Reading pmdisk image.
Mar  1 10:27:20 enlaptop kernel: PM: Resume from disk failed.
Mar  1 10:27:20 enlaptop kernel: ACPI: (supports S0 S3 S4 S5)
Mar  1 10:27:20 enlaptop kernel: RAMDISK: Compressed image found at 
block 0
Mar  1 10:27:20 enlaptop kernel: Mounted devfs on /dev
Mar  1 10:27:20 enlaptop kernel: kjournald starting.  Commit interval 
5 seconds
Mar  1 10:27:20 enlaptop kernel: EXT3-fs: mounted filesystem with 
ordered data mode.
Mar  1 10:27:20 enlaptop kernel: Mounted devfs on /dev
Mar  1 10:27:20 enlaptop kernel: Freeing unused kernel memory: 180k freed
Mar  1 10:27:20 enlaptop kernel: Real Time Clock Driver v1.12
Mar  1 10:27:20 enlaptop kernel: drivers/usb/core/usb.c: registered 
new driver usbfs
Mar  1 10:27:20 enlaptop kernel: drivers/usb/core/usb.c: registered 
new driver hub
Mar  1 10:27:20 enlaptop kernel: ehci_hcd 0000:00:0d.2: EHCI Host 
Controller

-------------- next part --------------
A non-text attachment was scrubbed...
Name: report.26290DEFANGED-eml
Type: application/octet-stream
Size: 73151 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040301/4693eb62/report.obj
