From: rhp.lpt@gmail.com (rhp)
Date: Thu, 01 Sep 2005 10:37:34 +0000
Subject: [lm-sensors] no sensors found beyond eeproms - OEM laptop -
Message-Id: <a2967b6d05090101374c7f1294@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

01-sep-05

Hello:

The general symptom is no sensors, beyond eeproms, are detected by
sensors-detect.

The machine is a local laptop with the hardware coming from an
OEM manufacturer in Taiwan:

Machine OEM Identification: Clevo M220S

O.S. is Fedora Core 3.

'uname -a' output:
Linux torus 2.6.12.5 #2 Mon Aug 29 16:00:16 ICT 2005 i686 i686 i386 GNU/Lin=
ux

lm_sensors package: 2.9.1

Information as per FAQ sec 5.1:

Note: I did not include lspci, i2cdetect, i2cdump, & isadump outputs
as the problem is not with
a specific sensor; however, I have the information if you need it.

1. dmesg:

Linux version 2.6.12.5 (root@torus) (gcc version 3.4.4 20050721 (Red
Hat 3.4.4-2)) #2 Mon Aug 29 16:00:16 ICT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002def0000 (usable)
 BIOS-e820: 000000002def0000 - 000000002defb000 (ACPI data)
 BIOS-e820: 000000002defb000 - 000000002df00000 (ACPI NVS)
 BIOS-e820: 000000002df00000 - 000000002e000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
736MB LOWMEM available.
On node 0 totalpages: 188416
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 184320 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6ee0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x2def78ba
ACPI: FADT (v001 SiS    650      0x06040000 PTL  0x000f4240) @ 0x2defaf8c
ACPI: DSDT (v001 Clevo       650 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 2e000000 (gap: 2e000000:d1f80000)
Built 1 zonelists
Kernel command line: ro root=3DLABEL=3D/ i8042.nomux rhgb quiet
Initializing CPU#0
CPU 0 irqstacks, hard=C0472000 soft=C0471000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1793.346 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 741952k/753664k available (2620k kernel code, 11040k reserved,
688k data, 188k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3555.32 BogoMIPS (lpj=1777664)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000 0000=
0400
00000000 00000000
CPU: After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
00000400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebf9ff 00000000 00000000 00000080
00000400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
    ACPI-0294: *** Info: Table [DSDT] replaced by host OS
ACPI: setting ELCR to 0400 (from 0c20)
checking if image is initramfs... it is
Freeing initrd memory: 403k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9ae, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS961 that hid as a SIS503 (compatible=3D1)
Enabling SiS 96x SMBus.
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *5)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Embedded Controller [EC] (gpe 23)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
pnp: 00:03: ioport range 0x8000-0x807f could not be reserved
pnp: 00:03: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:03: ioport range 0xfe00-0xfe00 has been reserved
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1125549906.882:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THM0] (51 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected SiS 650 chipset
agpgart: AGP aperture is 64M @ 0xe8000000
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 8250
PCI: Enabling device 0000:00:02.6 (0000 -> 0001)
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:02.6[C] -> Link [LNKF] -> GSI 10 (level,
low) -> IRQ 10
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 961 MuTIOL IDE UDMA100 controller
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC25N020ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-ROM SCR-242, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1768KiB Cache, CHS8760/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS%6, MD_SB_DISKS'
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:
MODM LANC PWRB SLPB  LID
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 188k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
alps.c: Enabling hardware tapping
input: PS/2 Mouse on isa0060/serio1
input: AlpsPS/2 ALPS GlidePoint on isa0060/serio1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 4 roles, 343 types, 30 bools
security:  55 classes, 14891 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda2, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), not configured for labeling
SELinux: initialized (dev hugetlbfs, type hugetlbfs), not configured
for labeling
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contex=
ts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
8139too Fast Ethernet driver 0.9.27
PCI: Enabling device 0000:00:0a.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKD] -> GSI 11 (level,
low) -> IRQ 11
eth0: RealTek RTL8139 at 0x2000, 00:90:f5:1a:9c:9c, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
PCI: Enabling device 0000:00:02.7 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:02.7[C] -> Link [LNKF] -> GSI 10 (level,
low) -> IRQ 10
intel8x0_measure_ac97_clock: measured 49411 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:02.6[C] -> Link [LNKF] -> GSI 10 (level,
low) -> IRQ 10
i2c-sis96x version 1.0.0
sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x8080
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:02.2[D] -> Link [LNKE] -> GSI 11 (level,
low) -> IRQ 11
ohci_hcd 0000:00:02.2: OHCI Host Controller
ohci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.2: irq 11, io mem 0xec000000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:02.3[A] -> Link [LNKH] -> GSI 10 (level,
low) -> IRQ 10
ohci_hcd 0000:00:02.3: OHCI Host Controller
ohci_hcd 0000:00:02.3: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.3: irq 10, io mem 0xec001000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:00:0c.0 (0000 -> 0002)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKC] -> GSI 5 (level, low) ->=
 IRQ
5
Yenta: CardBus bridge found at 0000:00:0c.0 [1558:2263]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0c.0, mfunc 0x00001002, devctl 0x44
Yenta: ISA IRQ mask 0x0010, PCI irq 5
Socket status: 30000006
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0000:00:0b.0 (0010 -> 0012)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level,
low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[10]=20
MMIO=3D[ec002800-ec002fff]  Max Packet=3D[2048]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0090f500001a9c9c]
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0400bc0(lo)
IPv6 over IPv4 tunneling driver
ACPI: AC Adapter [ADP0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ibm_acpi: hkey object not found
EXT3 FS on hda2, internal journal
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Adding 714884k swap on /dev/hda3.  Priority:-1 extents:1
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contex=
ts
spurious 8259A interrupt: IRQ7.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
Trying to free free DMA1
pnp: Device 00:08 disabled.
ip_tables: (C) 2000-2002 Netfilter core team
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x100-0x4ff: excluding 0x480-0x48f
cs: IO port probe 0xa00-0xaff: clean.
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
pnp: Device 00:08 activated.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (interrupt-driven).
lp0: console ready
eth0: no IPv6 routers present
i2c /dev entries driver

2. sensors-detect

 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-sis96x' for device 00:02.1: Silicon Integrated Systems
SMBus Controller
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-sis96x' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detect=
ed;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).


Next adapter: SiS96x SMBus adapter at 0x8080
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x10
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69
Client found at address 0x6a

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
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
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
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0xea)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0xea)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0xea)
Probing for `Nat. Semi. PC8739x Super IO'
  Success... (no hardware monitoring capabilities)
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
Probing for `SMSC LPC47B397-NC Super IO'
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
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (0xea11)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SiS96x SMBus adapter at 0x8080'
    Busdriver `i2c-sis96x', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SiS96x SMBus adapter at 0x8080'
    Busdriver `i2c-sis96x', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)

3. lsmod:

Module                  Size  Used by
i2c_dev                11776  0
parport_pc             29508  1
lp                     13832  0
parport                41928  2 parport_pc,lp
sunrpc                172612  1
pcmcia                 30240  2
ipt_LOG                 7936  1
iptable_filter          3328  1
ip_tables              20736  2 ipt_LOG,iptable_filter
dm_mod                 62516  0
video                  16004  0
button                  6928  0
battery                 9604  0
ac                      5124  0
md5                     4480  1
ipv6                  277504  20
ohci1394               40628  0
ieee1394              308984  1 ohci1394
yenta_socket           22536  1
rsrc_nonstatic         14080  1 yenta_socket
pcmcia_core            53144  3 pcmcia,yenta_socket,rsrc_nonstatic
ohci_hcd               26628  0
i2c_sis96x              5892  0
i2c_core               22528  2 i2c_dev,i2c_sis96x
snd_intel8x0m          20164  3
snd_intel8x0           35264  0
snd_ac97_codec         78968  2 snd_intel8x0m,snd_intel8x0
snd_pcm_oss            54304  0
snd_mixer_oss          19200  1 snd_pcm_oss
snd_pcm               107144  6
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              34564  1 snd_pcm
snd                    61188  11
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm=
,snd_timer
soundcore              11360  1 snd
snd_page_alloc         10500  3 snd_intel8x0m,snd_intel8x0,snd_pcm
8139too                30720  0
mii                     6016  1 8139too
floppy                 66740  0
ext3                  137736  2
jbd                    87448  1 ext3

4. Part numbers: - not inspected, this is a laptop.

5. Sensors version: lm_sensors 2.9.1

6. Kernel version: 2.6.12.5

Thank you,
Brgds
Bob
