From: harip@vt.edu (Hari K. Pyla)
Date: Thu, 04 Jan 2007 21:42:41 +0000
Subject: [lm-sensors] DELL XPS 600 temperature and fan speed issues
Message-Id: <459D74D1.7070705@vt.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,
       I am trying to configure lm-sensors on a DELL XPS 600 box. I am=20
not able to read the temperature and fan speeds. I was wondering if you=20
can help me solve this problem. I am attaching the outputs some=20
commands. Thanks in advance.

Thanks and Regards,
 --Hari Pyla
=20
output of sensors:
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.

output of uname -a:
Linux localhost.localdomain 2.6.17-1.2142_FC4 #1 Tue Jul 11 22:41:14 EDT=20
2006
i686 i686 i386 GNU/Linux

output of sensors -v:
sensors version 2.10.1 with libsensors version 2.10.1

operating system:
Fedora core 4 with 2.6.17 kernel

motherboard:
NVIDIA nForce4 SLI Intel Edition

output of dmesg:
Linux version 2.6.17-1.2142_FC4 (bhcompile at hs20-bc1-4.build.redhat.com) =

(gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1 Tue Jul 11 22:41:14=20
EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fdecc00 (usable)
 BIOS-e820: 000000007fdecc00 - 000000007fdeec00 (ACPI NVS)
 BIOS-e820: 000000007fdeec00 - 000000007fdf0c00 (ACPI data)
 BIOS-e820: 000000007fdf0c00 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
1149MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 523756
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294380 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v002 DELL                                  ) @ 0x000feb00
ACPI: XSDT (v001 DELL    DXG051  0x00000009 ASL  0x00000061) @ 0x000fd29d
ACPI: FADT (v003 DELL    DXG051  0x00000009 ASL  0x00000061) @ 0x000fd385
ACPI: SSDT (v001   DELL    st_ex 0x00001000 INTL 0x20050624) @ 0xfffc1720
ACPI: MADT (v001 DELL    DXG051  0x00000009 ASL  0x00000061) @ 0x000fd479
ACPI: BOOT (v001 DELL    DXG051  0x00000009 ASL  0x00000061) @ 0x000fd4eb
ACPI: MCFG (v001 DELL    DXG051  0x00000009 ASL  0x00000061) @ 0x000fd513
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 INTL 0x20050624) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x05] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Built 1 zonelists
Kernel command line: ro root=3D/dev/VolGroup00/LogVol00 rhgb quiet
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=C077d000 soft=C077e000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2993.596 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2070708k/2095024k available (1977k kernel code, 23068k reserved,=20
1358k data, 212k init, 1177520k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5994.00 BogoMIPS=20
(lpj=11988019)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000=20
0000649d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000=20
0000649d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: After all inits, caps: bfebf3ff 20100000 00000000 00000180 0000649d=20
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) D CPU 3.00GHz stepping 04
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=3D0x31 apic1=3D0 pin1=3D0 apic2=3D-1 pin2=3D-1
checking if image is initramfs... it is
Freeing initrd memory: 1776k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:12.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKJ] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKK] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKL] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKM] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKN] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKO] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [APCA] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCB] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APCC] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APCD] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCN] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCO] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a=20
report
pnp: 00:01: ioport range 0x800-0x87f has been reserved
pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
PCI: Bridge: 0000:00:02.0
  IO window: d000-dfff
  MEM window: dd000000-dfefffff
  PREFETCH window: c0000000-cfffffff
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:12.0
  IO window: c000-cfff
  MEM window: d8000000-dcffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:17.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:12.0 to 64
PCI: Setting latency timer of device 0000:00:17.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Simple Boot Flag at 0x7a set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1167926290.580:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 7EEDE88F5E4DFD06
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:02.0 to 64
pcie_portdrv_probe->Dev[007e:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
Allocate Port Service[0000:00:02.0:pcie03]
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcie_portdrv_probe->Dev[007e:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie03]
PCI: Setting latency timer of device 0000:00:17.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:17.0:pcie00]
Allocate Port Service[0000:00:17.0:pcie03]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:0f.0
NFORCE-CK804: chipset revision 243
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:0f.0 (rev f3) UDMA133 controller
    ide0: BM-DMA at 0xecd0-0xecd7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: _NEC DVD+/-RW ND-3530A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS%6, MD_SB_DISKS'
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices:
VBTN PCI0 PCI2 PCI3 MAC0 USB0 USB1
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 212k freed
Write protecting the kernel read-only data: 924k
SCSI subsystem initialized
libata version 1.20 loaded.
sata_nv 0000:00:10.0: version 0.8
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [APCK] -> GSI 23 (level,=20
low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:10.0 to 64
ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 209
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 209
ata1: SATA link up 3.0 Gbps (SStatus 123)
ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3e01 87:4023=20
88:207f
ata1: dev 0 ATA-7, max UDMA/133, 488281250 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: SATA link up 3.0 Gbps (SStatus 123)
ata2: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3e01 87:4023=20
88:207f
ata2: dev 0 ATA-7, max UDMA/133, 488281250 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata2: dev 0 configured for UDMA/133
scsi1 : sata_nv
  Vendor: ATA       Model: WDC WD2500JS-75N  Rev: 10.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488281250 512-byte hdwr sectors (250000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488281250 512-byte hdwr sectors (250000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
 sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
  Vendor: ATA       Model: WDC WD2500JS-75N  Rev: 10.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 488281250 512-byte hdwr sectors (250000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 488281250 512-byte hdwr sectors (250000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
 sdb1
sd 1:0:0:0: Attached scsi disk sdb
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [APCJ] -> GSI 22 (level,=20
low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:11.0 to 64
ata3: SATA max UDMA/133 cmd 0xFE40 ctl 0xFE52 bmdma 0xFEB0 irq 217
ata4: SATA max UDMA/133 cmd 0xFE60 ctl 0xFE72 bmdma 0xFEB8 irq 217
ata3: SATA link down (SStatus 0)
scsi2 : sata_nv
ata4: SATA link down (SStatus 0)
scsi3 : sata_nv
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel at redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1167926294.800:2): selinux=3D0 auidB94967295
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.54.
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:13.0[A] -> Link [APCM] -> GSI 21 (level,=20
low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:13.0 to 64
forcedeth: using HIGHDMA
eth0: forcedeth.c: subsystem: 01028:01c3 bound to 0000:00:13.0
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5100
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [APCH] -> GSI 20 (level,=20
low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:0b.1 to 64
ehci_hcd 0000:00:0b.1: EHCI Host Controller
ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0b.1: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:0b.1
ehci_hcd 0000:00:0b.1: irq 233, io mem 0xdfffbf00
ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [APCL] -> GSI 23 (level,=20
low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:0b.0 to 64
ohci_hcd 0000:00:0b.0: OHCI Host Controller
ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:0b.0: irq 209, io mem 0xdfffc000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usb 2-3: new low speed USB device using ohci_hcd and address 2
usb 2-3: configuration #1 chosen from 1 choice
input: Logitech USB-PS/2 Optical Mouse as /class/input/input0
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on=20
usb-0000:00:0b.0-3
usb 2-4: new full speed USB device using ohci_hcd and address 3
ieee1394: Initialized config rom entry `ip1394'
usb 2-4: configuration #1 chosen from 1 choice
hub 2-4:1.0: USB hub found
hub 2-4:1.0: 3 ports detected
usb 2-4.3: new full speed USB device using ohci_hcd and address 4
usb 2-4.3: configuration #1 chosen from 1 choice
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input1
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB=20
Keyboard] on usb-0000:00:0b.0-4.3
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input2
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB=20
Keyboard] on usb-0000:00:0b.0-4.3
ACPI: PCI Interrupt Link [APCC] enabled at IRQ 18
ACPI: PCI Interrupt 0000:03:0a.0[A] -> Link [APCC] -> GSI 18 (level,=20
low) -> IRQ 50
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[50] =20
MMIO=3D[dcdfb800-dcdfbfff]  Max Packet=3D[2048]  IR/IT contexts=3D[4/8]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[80140000b90d4122]
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [VBTN]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1=20
across:2031608k
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 224 bytes per conntrack
audit(1167944315.869:3): audit_pid=1840 old=3D0 by auidB94967295
eth0: no IPv6 routers present


output of sensors-detect:
# sensors-detect revision 4171 (2006-09-24 03:37:01 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 0000:00:0a.1: nVidia Corporation nForce4
SMBus (MCP)

We will now try to load each adapter module in turn.
Module `i2c-nforce2' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no): YES
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus nForce2 adapter at 5100
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x08

Next adapter: SMBus nForce2 adapter at 5000
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x08
Client found at address 0x30
Client found at address 0x31
Client found at address 0x50
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x51
Handled by driver `eeprom' (already loaded), chip type `eeprom'

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): YES
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `AMD K8 thermal sensors'...                     No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      Yes
Found unknown chip with ID 0x7901
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x7901
Trying family `VIA/Winbond/Fintek'...                       No
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 5000'
    Busdriver `i2c-nforce2', I2C address 0x50
    Chip `eeprom' (confidence: 6)
  * Bus `SMBus nForce2 adapter at 5000'
    Busdriver `i2c-nforce2', I2C address 0x51
    Chip `eeprom' (confidence: 6)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-nforce2
# Chip drivers
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): YES

output of lsmod:
Module                  Size  Used by
i2c_dev                 9441  0
autofs4                21957  2
eeprom                  7249  0
sunrpc                163557  1
ipt_REJECT              5825  1
xt_state                2497  1
ip_conntrack           53625  1 xt_state
nfnetlink               7257  1 ip_conntrack
xt_tcpudp               3393  2
iptable_filter          3393  1
ip_tables              13209  1 iptable_filter
x_tables               15173  4 ipt_REJECT,xt_state,xt_tcpudp,ip_tables
video                  17733  0
button                  7121  0
battery                10821  0
ac                      5189  0
ipv6                  248513  10
ohci1394               36229  0
ieee1394              301081  1 ohci1394
ohci_hcd               22109  0
ehci_hcd               33741  0
i2c_nforce2             7489  0
i2c_core               22721  3 i2c_dev,eeprom,i2c_nforce2
forcedeth              30669  0
dm_snapshot            18925  0
dm_zero                 2241  0
dm_mirror              23797  0
ext3                  136137  2
jbd                    60629  1 ext3
dm_mod                 60885  6 dm_snapshot,dm_zero,dm_mirror
sata_nv                 9797  3
libata                 69841  1 sata_nv
sd_mod                 21697  5
scsi_mod              139341  2 libata,sd_mod

output of lspci -n:

00:00.0 Class 0600: 10de:0071 (rev a3)
00:00.1 Class 0500: 10de:007f (rev a1)
00:00.2 Class 0500: 10de:0075 (rev a1)
00:00.3 Class 0500: 10de:006f (rev a1)
00:00.4 Class 0500: 10de:00b4 (rev a1)
00:01.0 Class 0500: 10de:0076 (rev a1)
00:01.1 Class 0500: 10de:0078 (rev a1)
00:01.2 Class 0500: 10de:0079 (rev a1)
00:01.3 Class 0500: 10de:007a (rev a1)
00:01.4 Class 0500: 10de:007b (rev a1)
00:01.5 Class 0500: 10de:007c (rev a1)
00:01.6 Class 0500: 10de:007d (rev a1)
00:02.0 Class 0604: 10de:007e (rev a2)
00:04.0 Class 0604: 10de:007e (rev a2)
00:09.0 Class 0580: 10de:005e (rev a4)
00:0a.0 Class 0601: 10de:0050 (rev a4)
00:0a.1 Class 0c05: 10de:0052 (rev a2)
00:0b.0 Class 0c03: 10de:005a (rev a2)
00:0b.1 Class 0c03: 10de:005b (rev a4)
00:0f.0 Class 0101: 10de:0053 (rev f3)
00:10.0 Class 0104: 10de:0054 (rev f3)
00:11.0 Class 0104: 10de:0055 (rev f4)
00:12.0 Class 0604: 10de:005c (rev a2)
00:13.0 Class 0680: 10de:0057 (rev a3)
00:17.0 Class 0604: 10de:005d (rev a3)
01:00.0 Class 0300: 10de:0091 (rev a1)
03:04.0 Class 0401: 1102:0005
03:0a.0 Class 0c00: 104c:8023

output of i2cdetect:
[root at localhost detect]# ./i2cdetect
Error: No i2c-bus specified!
Syntax: i2cdetect [-y] [-a] [-q|-r] I2CBUS [FIRST LAST]
        i2cdetect -F I2CBUS
        i2cdetect -l
        i2cdetect -V
  I2CBUS is an integer
  With -a, probe all addresses (NOT RECOMMENDED)
  With -q, uses only quick write commands for probing (NOT RECOMMENDED)
  With -r, uses only read byte commands for probing (NOT RECOMMENDED)
  If provided, FIRST and LAST limit the probing range.
  With -l, lists installed busses only
  Installed I2C busses:
    i2c-1       smbus           SMBus nForce2 adapter at 5100
    i2c-0       smbus           SMBus nForce2 adapter at 5000

output of i2cdetect 1 :
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1.
I will probe address range 0x03-0x77.
Continue? [Y/n] Y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

output of i2cdetect 0 :
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] Y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: 30 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: UU UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

/etc/rc.local file contains:
# I2C adapter drivers
modprobe i2c-nforce2
# Chip drivers
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended

output of modprobe:
[root at localhost ~]# modprobe i2c-nforce2
[root at localhost ~]# modprobe eeprom

/etc/modprobe.conf file contains
alias eth0 forcedeth
alias scsi_hostadapter sata_nv
alias usb-controller ehci-hcd
alias usb-controller1 ohci-hcd
alias ieee1394-controller ohci1394
# I2C module options
alias char-major-89 i2c-dev






