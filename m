From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: No Temperature Readings on SuSE Linux 9.2 on MSI MS-6341
Message-Id: <42640EC0.1030206@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <64fc4d69050417224510f3e7f0@mail.gmail.com>
In-Reply-To: <64fc4d69050417224510f3e7f0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

don't load i2c-viapro
see

http://mds.gotdns.com/localsensors/kernel26.html

Konrad Chan wrote:
> I apologize if this is a newbie mistake, but if you could give me some
> pointers to get it working it would be greatly appreciated.
> 
> Using SuSE Linux 9.2 Pro 32-bit
> Linux blackhole 2.6.8-24.14-default #1 Tue Mar 29 09:27:43 UTC 2005
> i686 athlon i386 GNU/Linux
> 
> Motherboard is MSI K7 Master MS-6341
> CPU is an AMD 1.2GHz with 1G mem
> 
> Using lm_sensors version:
> sensors version 2.9.1 with libsensors version 2.9.1
> 
> 
> Used sensors-detect, answered default to all questions and I followed
> the following instructions:
> 
> Added into /etc/modprobe.conf:
> # I2C module options
> alias char-major-89 i2c-dev
> 
> Added into /etc/init.d/boot.local:
> # I2C adapter drivers
> modprobe i2c-viapro
> modprobe i2c-isa
> # I2C chip drivers
> modprobe eeprom
> modprobe via686a
> # sleep 2 # optional
> /usr/bin/sensors -s # recommended
> 
> Copied etc/sensors.conf.eg to /etc/sensors.conf
> 
> Rebooted.
> 
> 
> However the only output I get from running "sensors" as root:
> eeprom-i2c-0-51
> Adapter: SMBus Via Pro adapter at 5000
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       512
> 
> eeprom-i2c-0-50
> Adapter: SMBus Via Pro adapter at 5000
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       512
> 
> No temperature readings, voltage, etc.
> 
> 
> dmesg output follows ...
> Linux version 2.6.8-24.14-default (geeko@buildhost) (gcc version 3.3.4
> (pre 3.3.5 20040809)) #1 Tue Mar 29 09:27:43 UTC 2005
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
>  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
>  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 128MB vmalloc/ioremap area available.
> 127MB HIGHMEM available.
> 896MB LOWMEM available.
> On node 0 totalpages: 262128
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 225280 pages, LIFO batch:16
>   HighMem zone: 32752 pages, LIFO batch:7
> DMI 2.2 present.
> ACPI: RSDP (v000 761686                                    ) @ 0x000f7320
> ACPI: RSDT (v001 761686 MSI ACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
> ACPI: FADT (v001 761686 MSI ACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
> ACPI: DSDT (v001 761686 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
> ACPI: PM-Timer IO Port: 0x4008
> ACPI: local apic disabled
> Built 1 zonelists
> Kernel command line: root=/dev/hda2 vga=0x31a selinux=0
> resume=/dev/hda1 desktop elevator=as splash=silent
> bootsplash: silent mode.
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 65536 bytes)
> Detected 1208.479 MHz processor.
> Using pmtmr for high-res timesource
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 1034088k/1048512k available (2076k kernel code, 13740k
> reserved, 780k data, 212k init, 131008k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay loop... 2392.06 BogoMIPS (lpj96032)
> Security Scaffold v1.0.0 initialized
> SELinux:  Disabled at boot.
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
> CPU: After vendor identify, caps:  0183f9ff c1c7f9ff 00000000 00000000
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> CPU: After all inits, caps:        0183f9ff c1c7f9ff 00000000 00000020
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: AMD Athlon(tm) processor stepping 02
> Enabling fast FPU save and restore... done.
> Checking 'hlt' instruction... OK.
> ACPI: Looking for DSDT in initrd... not found!
> ACPI: IRQ9 SCI: Level Trigger.
> checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
> Freeing initrd memory: 1178k freed
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfb2d0, last bus=1
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20040715
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
> Linux Plug and Play Support v0.97 (c) Adam Belay
> PCI: Using ACPI for IRQ routing
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
> ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
> ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 (level, low) -> IRQ 10
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 11 (level, low) -> IRQ 11
> ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 10 (level, low) -> IRQ 10
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
> ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
> ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 5 (level, low) -> IRQ 5
> TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
> apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
> apm: overridden by ACPI.
> audit: initializing netlink socket (disabled)
> audit(1113785111.246:0): initialized
> highmem bounce pool size: 64 pages
> Total HugeTLB memory allocated, 0
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> Initializing Cryptographic API
> PCI: Disabling Via external APIC routing
> vesafb: framebuffer at 0xd0000000, mapped to 0xf8880000, using 10240k,
> total 16384k
> vesafb: mode is 1280x1024x16, linelength%60, pages=5
> vesafb: protected mode interface info at c000:5798
> vesafb: scrolling: redraw
> vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
> bootsplash 3.1.6-2004/03/31: looking for picture...<6> silentjpeg size
> 47601 bytes,<6>...found (1280x1024, 24984 bytes, v3).
> Console: switching to colour frame buffer device 158x57
> fb0: VESA VGA frame buffer device
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Real Time Clock Driver v1.12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> Using anticipatory io scheduler
> FDC 0 is a post-1991 82077
> RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
> loop: loaded (max 8 devices)
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 0000:00:07.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
>     ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:DMA
> Probing IDE interface ide0...
> hda: Maxtor 6E040L0, ATA DISK drive
> hdb: IC35L120AVVA07-0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: LG CD-ROM CRD-8484B, ATAPI CD/DVD-ROM drive
> hdd: IC35L040AVVN07-0, ATA DISK drive
> ide1 at 0x170-0x177,0x376 on irq 15
> Probing IDE interface ide2...
> ide2: Wait for ready failed before probe !
> Probing IDE interface ide3...
> ide3: Wait for ready failed before probe !
> Probing IDE interface ide4...
> ide4: Wait for ready failed before probe !
> Probing IDE interface ide5...
> ide5: Wait for ready failed before probe !
> hda: max request size: 128KiB
> hda: 78156288 sectors (40016 MB) w/2048KiB Cache, CHSe535/16/63, UDMA(100)
> hda: cache flushes supported
>  hda: hda1 hda2 hda3
> hdb: max request size: 128KiB
> hdb: 234441648 sectors (120034 MB) w/1863KiB Cache, CHSe535/16/63, UDMA(100)
> hdb: cache flushes supported
>  hdb: hdb1
> hdd: max request size: 128KiB
> hdd: 78156288 sectors (40016 MB) w/1863KiB Cache, CHSe535/16/63, UDMA(100)
> hdd: cache flushes supported
>  hdd: hdd1
> ide-floppy driver 0.99.newide
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on isa0060/serio0
> alps.c: E6 report: 0a 03 c8
> input: PS2++ Logitech Wheel Mouse on isa0060/serio1
> input: PC Speaker
> md: md driver 0.90.0 MAX_MD_DEVS%6, MD_SB_DISKS'
> NET: Registered protocol family 2
> IP: routing cache hash table of 8192 buckets, 64Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> NET: Registered protocol family 1
> NET: Registered protocol family 8
> NET: Registered protocol family 20
> PM: Reading pmdisk image.
> swsusp: Resume From Partition: /dev/hda1
> <3>swsusp: Invalid partition type.
> pmdisk: Error -22 resuming
> PM: Resume from disk failed.
> ACPI: (supports S0 S1 S4 S5)
> ACPI wakeup devices:
> SLPB PCI0 USB0 USB1 UAR1
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem).
> ReiserFS: hda2: found reiserfs format "3.6" with standard journal
> ReiserFS: hda2: using ordered data mode
> reiserfs: using flush barriers
> ReiserFS: hda2: journal params: device hda2, size 8192, journal first
> block 18, max trans len 1024, max batch 900, max commit age 30, max
> trans age 30
> ReiserFS: hda2: checking transaction log (hda2)
> ReiserFS: hda2: Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem) readonly.
> Trying to move old root to /initrd ... failed
> Unmounting old root
> Trying to free ramdisk memory ... okay
> Freeing unused kernel memory: 212k freed
> Adding 1052216k swap on /dev/hda1.  Priority:42 extents:1
> reiserfs: enabling write barrier flush mode
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
> ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 11 (level, low) -> IRQ 11
> tulip0:  EEPROM default media type Autosense.
> 
> *snip network non-MII errors*
> 
> eth%d:  Invalid media table selection 255.
> tulip0: ***WARNING***: No MII transceiver found!
> eth0: Macronix 98715 PMAC rev 37 at 0xc000, 00:80:C6:FE:37:CD, IRQ 11.
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
> 8139too Fast Ethernet driver 0.9.27
> ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 10 (level, low) -> IRQ 10
> eth1: RealTek RTL8139 at 0xf886a000, 00:50:ba:b0:8e:88, IRQ 10
> eth1:  Identified 8139 chip type 'RTL-8139A'
> evdev_connect: evdev c18f2740 handle c18f275c name event0
> evdev_connect: evdev c18f2640 handle c18f265c name event1
> evdev_connect: evdev c18f2540 handle c18f255c name event2
> parport0: PC-style at 0x378 [PCSPP,EPP]
> parport_pc: Via 686A parallel port: io=0x378
> USB Universal Host Controller Interface driver v2.2
> ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
> uhci_hcd 0000:00:07.2: UHCI Host Controller
> uhci_hcd 0000:00:07.2: irq 10, io base 0000a800
> uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
> usb usb1: Product: UHCI Host Controller
> usb usb1: Manufacturer: Linux 2.6.8-24.14-default uhci_hcd
> usb usb1: SerialNumber: 0000:00:07.2
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> Linux agpgart interface v0.100 (c) Dave Jones
> ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 (level, low) -> IRQ 10
> uhci_hcd 0000:00:07.3: UHCI Host Controller
> uhci_hcd 0000:00:07.3: irq 10, io base 0000ac00
> uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
> usb usb2: Product: UHCI Host Controller
> usb usb2: Manufacturer: Linux 2.6.8-24.14-default uhci_hcd
> usb usb2: SerialNumber: 0000:00:07.3
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> agpgart: Detected AMD 761 chipset
> agpgart: Maximum main memory to use for agp memory: 941M
> agpgart: AGP aperture is 128M @ 0xe0000000
> gameport: pci0000:00:0d.1 speed 1242 kHz
> hdc: ATAPI 48X CD-ROM drive, 128kB Cache
> Uniform CD-ROM driver Revision: 3.20
> SCSI subsystem initialized
> st: Version 20040403, fixed bufsize 32768, s/g segs 256
> ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
> BIOS EDD facility v0.16 2004-Jun-25, 3 devices found
> ReiserFS: hdb1: using ordered data mode
> reiserfs: using flush barriers
> ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first
> block 18, max trans len 1024, max batch 900, max commit age 30, max
> trans age 30
> ReiserFS: hdb1: checking transaction log (hdb1)
> ReiserFS: hdb1: Using r5 hash to sort names
> ReiserFS: hdd1: found reiserfs format "3.6" with standard journal
> ReiserFS: hdd1: using ordered data mode
> reiserfs: using flush barriers
> ReiserFS: hdd1: journal params: device hdd1, size 8192, journal first
> block 18, max trans len 1024, max batch 900, max commit age 30, max
> trans age 30
> ReiserFS: hdd1: checking transaction log (hdd1)
> ReiserFS: hdd1: Using r5 hash to sort names
> ReiserFS: hda3: found reiserfs format "3.6" with standard journal
> ReiserFS: hda3: using ordered data mode
> reiserfs: using flush barriers
> ReiserFS: hda3: journal params: device hda3, size 8192, journal first
> block 18, max trans len 1024, max batch 900, max commit age 30, max
> trans age 30
> ReiserFS: hda3: checking transaction log (hda3)
> ReiserFS: hda3: Using r5 hash to sort names
> subfs 0.9
> NET: Registered protocol family 10
> Disabled Privacy Extensions on device c037f760(lo)
> IPv6 over IPv4 tunneling driver
> ip6_tables: (C) 2000-2002 Netfilter core team
> ip_tables: (C) 2000-2002 Netfilter core team
> ip_conntrack version 2.1 (8191 buckets, 65528 max) - 336 bytes per conntrack
> ip6_conntrack version 0.1 (8191 buckets, 65528 max) - 208 bytes per conntrack
> NET: Registered protocol family 17
> eth1: link up, 100Mbps, full-duplex, lpa 0x41E1
> Disabled Privacy Extensions on device f7d84400(sit0)
> eth0: no IPv6 routers present
> eth1: no IPv6 routers present
> martian source 192.168.0.111 from 192.168.0.102, on dev eth0
> ll header: 00:80:c6:fe:37:cd:00:0c:f1:06:c4:dc:08:00
> martian source 192.168.0.111 from 192.168.0.102, on dev eth0
> ll header: 00:80:c6:fe:37:cd:00:0c:f1:06:c4:dc:08:00
> ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
> ACPI: Power Button (FF) [PWRF]
> ACPI: Sleep Button (CM) [SLPB]
> ACPI: Processor [CPU0] (supports C1, 2 throttling states)
> 
> *snip network martian source errors*
> 
> 
> Thanks, let me know if this is sufficient.

