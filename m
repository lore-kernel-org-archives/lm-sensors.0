From: chw@scs.co.uk (Charles Whittington)
Date: Fri, 14 Oct 2005 13:33:26 +0000
Subject: [lm-sensors] lm_sensors 2.9.2 & kernel 2.6.8-24
Message-Id: <434F973D.5080607@scs.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am having freeze-ups and reboots on an MTC8640 laptop running SuSE 9.2 
which I suspect may be caused by hardware problems, possibly 
clock/powersave related. I have installed lm_sensors 2.9.2, kernel is 
2.6.8-24. I am OK with software but sometimes a bit dim where h/w is 
concerned. I have read the docs on the website, I am still not sure 
whether precisely this combination is supposed to be supported. The 
website sort of indicates that SiS996x is supported but the outputs are 
as below. Could you advise?

lshw  output:

 cat lshw-output
nport1
    description: Portable Computer
    product: 8640
    vendor: MTC
    version: A1
    serial: 12345678
    width: 32 bits
    capabilities: smbios-2.3 dmi-2.3
    configuration: administrator_password=disabled boot=normal 
chassis=portable power-on_password=disabled
  *-core
       description: Motherboard
       product: 8640
       vendor: MTC
       physical id: 0
       version: A1
       serial: 12345678
       slot: J6
     *-firmware
          description: BIOS
          vendor: Insyde Software
          physical id: 0
          version: Version 4.00 (04/02/2001)
          size: 88KB
          capacity: 192KB
          capabilities: isa pci pcmcia pnp apm upgrade shadowing cdboot 
socketedrom edd int13floppynec int13floppy720 int13floppy2880 
int5printscreen int9keyboard int14serial int17printer int10video acpi 
usb ls120boot zipboot smartbattery netboot
     *-cpu
          description: CPU
          product: Intel(R) Celeron(R) CPU 2.80GHz
          vendor: Intel Corp.
          physical id: 4
          bus info: cpu@0
          version: 15.2.9
          slot: PGA478
          size: 2799MHz
          capacity: 2799MHz
          width: 32 bits
          clock: 100MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce 
cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 
ss ht tm pbe cid xtpr
          configuration: id=0
        *-cache:0
             description: L1 cache
             physical id: 5
             slot: L1 Cache
             size: 8KB
             capacity: 32KB
             capabilities: burst pipeline-burst internal write-back
        *-cache:1
             description: L2 cache
             physical id: 6
             slot: L2 Cache
             size: 128KB
             capacity: 128KB
             capabilities: burst pipeline-burst external write-back
     *-memory:0
          description: System Memory
          physical id: 15
          slot: System board or motherboard
          capacity: 256MB
        *-bank:0
             description: DIMM DRAM EDO 1 MHz (1000.0 ns)
             physical id: 0
             slot: DRAM Slot 0
             size: 256MB
             width: 64 bits
             clock: 1MHz (1000ns)
        *-bank:1
             description: DIMM DRAM EDO 1 MHz (1000.0 ns) [empty]
             physical id: 1
             slot: DRAM Slot 1
             width: 64 bits
             clock: 1MHz (1000ns)
        *-bank:2
             description: DIMM DRAM EDO 1 MHz (1000.0 ns) [empty]
             physical id: 2
             slot: DRAM Slot 2
             width: 64 bits
             clock: 1MHz (1000ns)
     *-memory:1 UNCLAIMED
          description: Video Memory
          physical id: 16
          slot: System board or motherboard
          capacity: 2MB
     *-memory:2 UNCLAIMED
          description: Flash Memory
          physical id: 17
          slot: System board or motherboard
          capacity: 2MB
     *-memory:3 UNCLAIMED
          description: Cache Memory
          physical id: 18
          slot: System board or motherboard
          capacity: 256KB
     *-memory:4 UNCLAIMED
          physical id: 1
     *-memory:5 UNCLAIMED
          physical id: 2
     *-pci
          description: Host bridge
          product: 650/M650 Host
          vendor: Silicon Integrated Systems [SiS]
          physical id: f0000000
          bus info: pci@00:00.0
          version: 80
          width: 32 bits
          clock: 33MHz
          resources: iomemory:f0000000-f3ffffff
        *-pci
             description: PCI bridge
             product: Virtual PCI-to-PCI bridge (AGP)
             vendor: Silicon Integrated Systems [SiS]
             physical id: 1
             bus info: pci@00:01.0
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: pci normal_decode bus_master
           *-display
                description: VGA compatible controller
                product: 65x/M650/740 PCI/AGP VGA Display Adapter
                vendor: Silicon Integrated Systems [SiS]
                physical id: 0
                bus info: pci@01:00.0
                logical name: /dev/fb0
                version: 00
                size: 128MB
                width: 32 bits
                clock: 66MHz
                capabilities: vga cap_list fb
                configuration: depth frequencyu.69Hz mode24x768 
visual=truecolor xres24 yresv8
                resources: iomemory:90000000-97ffffff 
iomemory:e0000000-e001ffff ioport:c000-c07f irq:11
        *-isa UNCLAIMED
             description: ISA bridge
             product: SiS962 [MuTIOL Media IO]
             vendor: Silicon Integrated Systems [SiS]
             physical id: 2
             bus info: pci@00:02.0
             version: 25
             width: 32 bits
             clock: 33MHz
             capabilities: isa bus_master
        *-serial
             description: SMBus
             product: SiS961/2 SMBus Controller
             vendor: Silicon Integrated Systems [SiS]
             physical id: 2.1
             bus info: pci@00:02.1
             version: 00
             width: 32 bits
             clock: 33MHz
             configuration: driver=sis96x_smbus
             resources: irq:10
        *-ide
             description: IDE interface
             product: 5513 [IDE]
             vendor: Silicon Integrated Systems [SiS]
             physical id: 2.5
             bus info: pci@00:02.5
             version: 00
             width: 32 bits
            
etc etc


dmesg output:

nport1:~ # cat dmesg.output
Linux version 2.6.8-24-default (geeko@buildhost) (gcc version 3.3.4 (pre 
3.3.520040809)) #1 Wed Oct 6 09:16:23 UTC 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000dff0000 (usable)
 BIOS-e820: 000000000dff0000 - 000000000dffffc0 (ACPI data)
 BIOS-e820: 000000000dffffc0 - 000000000e000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
789MB vmalloc/ioremap area available.
0MB HIGHMEM available.
223MB LOWMEM available.
On node 0 totalpages: 57328
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 53232 pages, LIFO batch:12
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Built 1 zonelists
Kernel command line: root=/dev/hda2 vga=0x317 selinux=0 acpi=off 
resume=/dev/hda1 desktop elevator=as splash=silent
bootsplash: silent mode.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 2800.140 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 222028k/229312k available (2074k kernel code, 6672k reserved, 
782k data, 212k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5537.79 BogoMIPS (lpj'68896)
Security Scaffold v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
CPU: After all inits, caps:        bfebf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Celeron(R) CPU 2.80GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
Looking for DSDT in initrd ...No customized DSDT found in initrd!
Freeing initrd memory: 1165k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xe8994, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Uncovering SIS962 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
PCI: Using IRQ router SIS [1039/0962] at 0000:00:02.0
PCI: IRQ 0 for device 0000:00:02.1 doesn't match PIRQ mask - try 
pci=usepirqmask
PCI: Found IRQ 10 for device 0000:00:02.1
PCI: Sharing IRQ 10 with 0000:00:09.0
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
audit: initializing netlink socket (disabled)
audit(1129107889.501:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
vesafb: framebuffer at 0x90000000, mapped to 0xce880000, using 6144k, 
total 32768k
vesafb: mode is 1024x768x16, linelength 48, pages=4
vesafb: protected mode interface info at cbdd:0000
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
bootsplash 3.1.6-2004/03/31: looking for picture...<6> silentjpeg size 
35007 bytes,<6>...found (1024x768, 21643 bytes, v3).
Console: switching to colour frame buffer device 127x43
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
PCI: Found IRQ 5 for device 0000:00:02.6
PCI: Sharing IRQ 5 with 0000:00:02.7
Using anticipatory io scheduler
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG MP0302H, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SONY CD-RW/DVD-ROM CRX830E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 58711968 sectors (30060 MB) w/8192KiB Cache, CHS383/255/63, UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 37
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
input: PC Speaker
md: md driver 0.90.0 MAX_MD_DEVS%6, MD_SB_DISKS'
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 8
NET: Registered protocol family 20
PM: Reading pmdisk image.
swsusp: Resume From Partition: /dev/hda1
<3>swsusp: Invalid partition type.
pmdisk: Error -22 resuming
PM: Resume from disk failed.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
reiserfs: using flush barriers
ReiserFS: hda2: journal params: device hda2, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: replayed 22 transactions in 0 seconds
ReiserFS: hda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 212k freed
Adding 449780k swap on /dev/hda1.  Priority:42 extents:1
reiserfs: enabling write barrier flush mode
ReiserFS: hda2: Removing [55174 15779 0x0 SD]..done
ReiserFS: hda2: There were 1 uncompleted unlinks/truncates. Completed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
sis900.c: v1.08.07 11/02/2003
PCI: Found IRQ 11 for device 0000:00:04.0
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xe400, IRQ 11, 00:40:d0:57:f4:92.
subfs 0.9
evdev_connect: evdev c11fe480 handle c11fe49c name event0
evdev_connect: evdev c11fe280 handle c11fe29c name event1
evdev_connect: evdev c11fe180 handle c11fe19c name event2
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 10 for device 0000:00:09.0
PCI: Sharing IRQ 10 with 0000:00:02.1
Yenta: CardBus bridge found at 0000:00:09.0 [1071:8640]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:09.0, mfunc 0x01021c72, devctl 0x64
Yenta: ISA IRQ mask 0x0098, PCI irq 10
Socket status: 30000006
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 650 chipset
agpgart: Maximum main memory to use for agp memory: 176M
agpgart: AGP aperture is 64M @ 0xf0000000
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: IRQ 6 for device 0000:00:03.0 doesn't match PIRQ mask - try 
pci=usepirqmask
PCI: Found IRQ 6 for device 0000:00:03.0
ohci_hcd 0000:00:03.0: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:03.0 to 64
ohci_hcd 0000:00:03.0: irq 6, pci mem c00d8000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.8-24-default ohci_hcd
usb usb1: SerialNumber: 0000:00:03.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
PCI: Found IRQ 5 for device 0000:00:03.1
ohci_hcd 0000:00:03.1: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:03.1 to 64
ohci_hcd 0000:00:03.1: irq 5, pci mem c00da000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.8-24-default ohci_hcd
usb usb2: SerialNumber: 0000:00:03.1
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
PCI: Found IRQ 5 for device 0000:00:03.3
ehci_hcd 0000:00:03.3: EHCI Host Controller
ehci_hcd 0000:00:03.3: irq 5, pci mem cf138000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 3
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
usb usb3: Product: EHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.8-24-default ehci_hcd
usb usb3: SerialNumber: 0000:00:03.3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
SCSI subsystem initialized
st: Version 20040403, fixed bufsize 32768, s/g segs 256
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0820-0x08ff: clean.
cs: IO port probe 0x0800-0x080f: clean.
cs: IO port probe 0x03e0-0x04ff: excluding 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0100-0x03af: excluding 0x378-0x37f
cs: IO port probe 0x0a00-0x0aff: clean.
eth0: Media Link On 100mbps full-duplex
PCI: Found IRQ 5 for device 0000:00:02.7
PCI: Sharing IRQ 5 with 0000:00:02.6
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
NET: Registered protocol family 10
Disabled Privacy Extensions on device c037f6a0(lo)
IPv6 over IPv4 tunneling driver
intel8x0_measure_ac97_clock: measured 49434 usecs
intel8x0: clocking to 48000
Non-volatile memory driver v1.2
Disabled Privacy Extensions on device cd3c9800(sit0)
eth0: no IPv6 routers present
cdrom: open failed.
cdrom: open failed.
subfs: unsuccessful attempt to mount media (256)
cdrom: open failed.
cdrom: open failed.
UDF-fs: No VRS found
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
cdrom: open failed.
cdrom: open failed.
UDF-fs: No VRS found
UDF-fs: No VRS found
subfs: unsuccessful attempt to mount media (256)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
i2c-sis96x version 1.0.0
sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x1000
i2c /dev entries driver
osst :I: Tape driver with OnStream support version 0.99.1
osst :I: $Id: osst.c,v 1.70 2003/12/23 14:22:12 wriede Exp $
nport1:~ #         

sensors-detect output:
nport1:~ # sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-sis96x' for device 00:02.1: Silicon Integrated Systems 
SMBus Controller
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-sis96x' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double 
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SiS96x SMBus adapter at 0x1000 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively):

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0xea11)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0xea11)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0xea11)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0xea)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0xea)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0xea)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0xea)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0xea)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0xea)
Probing for `SMSC 47M172 Super IO'
  Failed! (0xea)
Probing for `VT1211 Super IO Sensors'
  Failed! (0xea)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0xea)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0xea)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0xea)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0xea)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0xea)
Probing for `Winbond W83L517D Super IO'
  Failed! (0xea)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.
 See doc/FAQ, doc/lm_sensors-FAQ.html, or
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
 (FAQ #4.24.3) for further information.
 If you find out what chips are on your board, see
 http://secure.netroedge.com/~lm78/newdrivers.html for driver status.
nport1:~ #

sensors outut (not surprisingly!)

sensors
No sensors found!
nport1:~ #   






