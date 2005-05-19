From: EmreTas@gmail.com (Emre Tas)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: Sensors doesn't find any sensors, just eeproms.
Message-Id: <b25af0dc04100121563c6b6567@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I read everything and also try everything.I use kernel 2.6.8.1 on
slackware 10.0.I have an Sis M650 chipset.And mainboard of Asus
A2H/L.Yes this is a notebook.And I can figure only temperature by
using GKrellM.And also eeproms by sensors.What is wrong I don't
know.Also I am using the latest lm_sensors.Thanks anyway for your
help...
-- 
Nothing is impossible,just takes some times.
-------------- next part --------------
fy, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.50GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1730, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 9 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 9 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 6 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 6 7) *11
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 5 11) *4
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 5 11) *4
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 5 11) *4
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 5 11) *4
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS962 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:02.6[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 7
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
sisfb: Using vga mode 1024x768x16 pre-set by kernel as default
sisfb: Video ROM found and mapped to 0xc00c0000
sisfb: Identified [Asus A2H (V2)], special timing applies
sisfb: [specialtiming parameter name: ASUS_A2H_2]
sisfb: Framebuffer at 0xf0000000, mapped to 0xdc80a000, size 65536k
sisfb: MMIO at 0xe7800000, mapped to 0xe080b000, size 128k
sisfb: Memory heap starting at 64928K, size 32K
sisfb: Detected SiS302LV video bridge
sisfb: Detected secondary VGA connection
sisfb: Detected 1024x768 flat panel
sisfb: Detected LCD PDC 0x08 (for LCD=CRT2)
sisfb: Detected LCD PDC1 0x08 (for LCD=CRT1)
sisfb: Default mode is 1024x768x16 (60Hz)
sisfb: Initial vbflags 0x800001a
sisfb: 2D acceleration is enabled, y-panning enabled (auto-max)
fb0: SiS 650 frame buffer device, Version 1.7.12
sisfb: (C) 2001-2004 Thomas Winischhofer.
vesafb: abort, cannot reserve video memory at 0xf0000000
vesafb: framebuffer at 0xf0000000, mapped to 0xe082c000, size 3072k
vesafb: mode is 1024x768x16, linelength 48, pages=4
vesafb: protected mode interface info at cbbe:0000
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb1: VESA VGA frame buffer device
Simple Boot Flag at 0x3a set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (54 C)
Asus Laptop ACPI Extras version 0.28
  A2H model detected, supported
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 128x48
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI interrupt 0000:00:02.6[C] -> GSI 11 (level, low) -> IRQ 11
Using anticipatory io scheduler
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
sis900.c: v1.08.07 11/02/2003
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 7 (level, low) -> IRQ 7
divert: allocating divert_blk for eth0
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xa000, IRQ 7, 00:0c:6e:e5:2c:ba.
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
hda: IC25N040ATMR04-0, ATA DISK drive
hdb: ASUS SCB-2408, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS383/255/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 >
hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 164k freed
Adding 506008k swap on /dev/hda6.  Priority:-1 extents:1
input: PS/2 Synaptics TouchPad on isa0060/serio4
Linux agpgart interface v0.100 (c) Dave Jones
NTFS driver 2.1.15 [Flags: R/W MODULE].
NTFS-fs warning (device hda1): ntfs_fill_super(): Atime updates are not implemented yet.  Disabling them.
NTFS volume version 3.1.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Intel ISA PCIC probe: not found.
Device 'i823650' does not have a release() function, it is broken and must be fixed.
Badness in device_release at drivers/base/core.c:85
 [<c019ff78>] kobject_cleanup+0x98/0xa0
 [<e0b7a3d3>] init_i82365+0x1c3/0x1d9 [i82365]
 [<c01324e9>] sys_init_module+0x119/0x230
 [<c010613b>] syscall_call+0x7/0xb
Databook TCIC-2 PCMCIA probe: not found.
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:0a.0 [1043:1764]
Yenta: adjusting diagnostic: 20 -> 60
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0a.0, mfunc 0x00101d02, devctl 0x44
Yenta: ISA IRQ mask 0x0468, PCI irq 11
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0820-0x08ff: excluding 0x880-0x887
cs: IO port probe 0x0800-0x080f: excluding 0x800-0x807
cs: IO port probe 0x03e0-0x04ff: excluding 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0100-0x03af: excluding 0x378-0x37f
cs: IO port probe 0x0a00-0x0aff: clean.
eth0: Media Link On 100mbps full-duplex 
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:03.3: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 0000:00:03.3: irq 11, pci mem e0b7b000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:03.0: Silicon Integrated Systems [SiS] USB 1.0 Controller
ohci_hcd 0000:00:03.0: irq 11, pci mem e0b9c000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:03.1: Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
ohci_hcd 0000:00:03.1: irq 11, pci mem e0b9e000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 1.0 Controller (#3)
usb 1-1: new high speed USB device using address 2
ohci_hcd 0000:00:03.2: irq 11, pci mem e0ba0000
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
ohci_hcd 0000:00:03.1: wakeup
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: SAMSUNG   Model: SP0802N           Rev: TK20
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
sda: assuming drive cache: write through
 sda: sda1 sda2 <<6>ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 11 (level, low) -> IRQ 11
 sda5 sda6 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
USB Mass Storage device found at 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb 3-1: new low speed USB device using address 2
intel8x0_measure_ac97_clock: measured 51199 usecs
intel8x0: clocking to 48000
input: USB HID v1.10 Mouse [Acrox USB & PS/2 Mouse] on usb-0000:00:03.1-1
ACPI: PCI interrupt 0000:00:02.6[C] -> GSI 11 (level, low) -> IRQ 11
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[e7000000-e70007ff]  Max Packet=[2048]
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
agpgart: Detected SiS 650 chipset
agpgart: Maximum main memory to use for agp memory: 380M
agpgart: AGP aperture is 64M @ 0xe8000000
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000000000000000]
ip1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
divert: not allocating divert_blk for non-ethernet device eth1
ip1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
USB Universal Host Controller Interface driver v2.2
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03bfb80(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
i2c-sis96x version 1.0.0
sis96x smbus 0000:00:02.1: SiS96x SMBus base address: 0xe600
eth0: no IPv6 routers present
NET: Registered protocol family 4
NET: Registered protocol family 3
NET: Registered protocol family 5
i2c /dev entries driver
