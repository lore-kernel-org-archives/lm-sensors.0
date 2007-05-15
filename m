From: "Hans Edgington" <hans@edgington.nl>
Date: Tue, 15 May 2007 19:23:21 +0000
Subject: Re: [lm-sensors] Fintek F71882FG Driver -> Problems with
Message-Id: <002d01c79726$805257e0$20140a0a@EA002>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_NextPart_000_002E_01C79737.43DB27E0"
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c796e2$2af45760$20140a0a@EA002>
In-Reply-To: <000f01c796e2$2af45760$20140a0a@EA002>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_002E_01C79737.43DB27E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

The description from Jacob Heerikhuisen:

The _input files in /sys/devices/platform/f71882fg.2576 show 4 temp sensors,
but each reads 255. All four fan sensors show 22. I tried running some code
on my machine, but even when I hear my fans increase in speed, those sensor
files don't change.


Full dmesg output from him is attached, but this is from loading/unloading a
few times:

Module F71882FG init
f71882fg: Not a Fintek device
f71882fg: Found F71882FG chip at 0xa10
i2c_adapter i2c-1: SMBus Quick command not supported, can't probe for chips
i2c_adapter i2c-2: SMBus Quick command not supported, can't probe for chips
i2c_adapter i2c-3: SMBus Quick command not supported, can't probe for chips
i2c_adapter i2c-4: SMBus Quick command not supported, can't probe for chips
Module F71882FG exit
Module F71882FG init
f71882fg: Not a Fintek device
f71882fg: Found F71882FG chip at 0xa10
Module F71882FG exit
Module F71882FG init
f71882fg: Not a Fintek device
f71882fg: Found F71882FG chip at 0xa10

Full /proc/ioports before loading driver:
[root@pierce-dhcp-212 jacobh]# cat /proc/ioports 0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f8-03ff : serial
0400-041f : 0000:00:1f.3
  0400-041f : i801_smbus
0480-04bf : 0000:00:1f.0
0800-087f : 0000:00:1f.0
  0800-0803 : ACPI PM1a_EVT_BLK
  0804-0805 : ACPI PM1a_CNT_BLK
  0808-080b : ACPI PM_TMR
  0810-0815 : ACPI CPU throttle
  0828-082f : ACPI GPE0_BLK
  0860-087f : iTCO_wdt
0a10-0aef : pnp 00:0b
  0ae0-0aef : pnp 00:0b
0cf8-0cff : PCI conf1
a800-a81f : 0000:00:1f.2
  a800-a81f : ahci
a880-a883 : 0000:00:1f.2
  a880-a883 : ahci
ac00-ac07 : 0000:00:1f.2
  ac00-ac07 : ahci
b000-b003 : 0000:00:1f.2
  b000-b003 : ahci
b080-b087 : 0000:00:1f.2
  b080-b087 : ahci
b400-b41f : 0000:00:1d.2
  b400-b41f : uhci_hcd
b480-b49f : 0000:00:1d.1
  b480-b49f : uhci_hcd
b800-b81f : 0000:00:1d.0
  b800-b81f : uhci_hcd
b880-b89f : 0000:00:1a.1
  b880-b89f : uhci_hcd
bc00-bc1f : 0000:00:1a.0
  bc00-bc1f : uhci_hcd
c000-cfff : PCI Bus #01
  cc00-cc7f : 0000:01:00.0
d000-dfff : PCI Bus #04
  d800-d8ff : 0000:04:00.0
    d800-d8ff : eth0
e000-efff : PCI Bus #05
  ec00-ec7f : 0000:05:04.0

isadump -k 0x87,0x87 0x4e 0x4f 
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x4e and data register 0x4f.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 04 ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 05 41 20 19 34 00 00 5e 40 00 00 00 0b 0e 00 00
30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: 0a 10 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

isadump 0xA10 0xA11 
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0xa10 and data register 0xa11.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

This is all the info I have from Jacob hope it helps. He does have sensor
reading in the bios.
I'll start cc'ing the mailing list when replying to testers.

Regards,
Hans

------=_NextPart_000_002E_01C79737.43DB27E0
Content-Type: application/octet-stream;
	name="dmesg.out"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.out"

Linux version 2.6.20-1.2948.fc6 =
(brewbuilder@ls20-bc2-14.build.redhat.com) (gcc version 4.1.1 20070105 =
(Red Hat 4.1.1-51)) #1 SMP Fri Apr 27 19:18:54 EDT 2007
Command line: ro root=3DLABEL=3D/ rhgb quiet
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e3000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cffb0000 (usable)
 BIOS-e820: 00000000cffb0000 - 00000000cffbe000 (ACPI data)
 BIOS-e820: 00000000cffbe000 - 00000000cfff0000 (ACPI NVS)
 BIOS-e820: 00000000cfff0000 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
Entering add_active_range(0, 0, 158) 0 entries of 3200 used
Entering add_active_range(0, 256, 851888) 1 entries of 3200 used
Entering add_active_range(0, 1048576, 1245184) 2 entries of 3200 used
end_pfn_map =3D 1245184
DMI present.
ACPI: RSDP (v000 ACPIAM                                ) @ =
0x00000000000f8e50
ACPI: RSDT (v001 M S I  OEMRSDT  0x03000706 MSFT 0x00000097) @ =
0x00000000cffb0000
ACPI: FADT (v002 M S I  OEMFACP  0x03000706 MSFT 0x00000097) @ =
0x00000000cffb0200
ACPI: MADT (v001 M S I  OEMAPIC  0x03000706 MSFT 0x00000097) @ =
0x00000000cffb0390
ACPI: MCFG (v001 M S I  OEMMCFG  0x03000706 MSFT 0x00000097) @ =
0x00000000cffb0400
ACPI: OEMB (v001 M S I  AMI_OEM  0x03000706 MSFT 0x00000097) @ =
0x00000000cffbe040
ACPI: DSDT (v001  0AAAA 0AAAA000 0x00000000 INTL 0x20051117) @ =
0x0000000000000000
No NUMA configuration found
Faking a node at 0000000000000000-0000000130000000
Entering add_active_range(0, 0, 158) 0 entries of 3200 used
Entering add_active_range(0, 256, 851888) 1 entries of 3200 used
Entering add_active_range(0, 1048576, 1245184) 2 entries of 3200 used
Bootmem setup node 0 0000000000000000-0000000130000000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1245184
early_node_map[3] active PFN ranges
    0:        0 ->      158
    0:      256 ->   851888
    0:  1048576 ->  1245184
On node 0 totalpages: 1048398
  DMA zone: 64 pages used for memmap
  DMA zone: 1326 pages reserved
  DMA zone: 2608 pages, LIFO batch:0
  DMA32 zone: 16320 pages used for memmap
  DMA32 zone: 831472 pages, LIFO batch:31
  Normal zone: 3072 pages used for memmap
  Normal zone: 193536 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009e000 - 000000000009f000
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e3000
Nosave address range: 00000000000e3000 - 0000000000100000
Nosave address range: 00000000cffb0000 - 00000000cffbe000
Nosave address range: 00000000cffbe000 - 00000000cfff0000
Nosave address range: 00000000cfff0000 - 00000000d0000000
Nosave address range: 00000000d0000000 - 00000000fee00000
Nosave address range: 00000000fee00000 - 00000000fee01000
Nosave address range: 00000000fee01000 - 00000000ffb00000
Nosave address range: 00000000ffb00000 - 0000000100000000
Allocating PCI resources starting at d4000000 (gap: d0000000:2ee00000)
SMP: Allowing 4 CPUs, 0 hotplug CPUs
PERCPU: Allocating 43264 bytes of per cpu data
Built 1 zonelists.  Total pages: 1027616
Kernel command line: ro root=3DLABEL=3D/ rhgb quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0x627b000 - 0xa27b000
Memory: 4036332k/4980736k available (2454k kernel code, 157260k =
reserved, 1458k data, 316k init)
Calibrating delay using timer specific routine.. 5335.24 BogoMIPS =
(lpj=3D2667620)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 16666713
Detected 16.666 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5332.35 BogoMIPS =
(lpj=3D2666176)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM1)
Intel(R) Core(TM)2 Quad CPU           @ 2.66GHz stepping 07
SMP alternatives: switching to SMP code
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 5332.43 BogoMIPS =
(lpj=3D2666218)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 2/2 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 2
CPU2: Thermal monitoring enabled (TM1)
Intel(R) Core(TM)2 Quad CPU           @ 2.66GHz stepping 07
SMP alternatives: switching to SMP code
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 5332.43 BogoMIPS =
(lpj=3D2666217)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 3/3 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 3
CPU3: Thermal monitoring enabled (TM1)
Intel(R) Core(TM)2 Quad CPU           @ 2.66GHz stepping 07
Brought up 4 CPUs
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 2666.675 MHz processor.
sizeof(vma)=3D176 bytes
sizeof(page)=3D64 bytes
sizeof(inode)=3D720 bytes
sizeof(dentry)=3D224 bytes
sizeof(ext3inode)=3D968 bytes
sizeof(buffer_head)=3D104 bytes
sizeof(skbuff)=3D248 bytes
sizeof(task_struct)=3D1920 bytes
migration_cost=3D24,3302
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH6 GPIO
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 *14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 *4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post =
a report
NetLabel: Initializing
NetLabel:  domain hash size =3D 128
NetLabel:  protocols =3D UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
PCI-GART: No AMD northbridge found.
pnp: 00:08: ioport range 0xa10-0xaef has been reserved
pnp: 00:08: ioport range 0xae0-0xaef has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: fa000000-fe9fffff
  PREFETCH window: d0000000-dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
  IO window: d000-dfff
  MEM window: fea00000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: e000-efff
  MEM window: feb00000-febfffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.4 to 64
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.5 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 1531k freed
audit: initializing netlink socket (disabled)
audit(1179163342.074:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
ksign: Installing public key data
Loading keyring
- Added public key 214E108B717C14AC
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie02]
PCI: Setting latency timer of device 0000:00:1c.5 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.5:pcie00]
Allocate Port Service[0000:00:1c.5:pcie02]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 965G Chipset.
agpgart: AGP aperture is 256M @ 0x0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
input: Macintosh mouse button emulation as /class/input/input0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
Probing IDE interface ide0...
Probing IDE interface ide1...
ide-floppy driver 0.99.newide
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input1
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 316k freed
Write protecting the kernel read-only data: 1042k
firmware_class: attempt to set timeout to 10
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000bc00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000b880
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000b800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000b480
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
input: ImPS/2 Generic Wheel Mouse as /class/input/input2
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000b400
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 3-2: new full speed USB device using uhci_hcd and address 2
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver =
(PCI)
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 6
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xf9fffc00
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 7
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf9fff800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 6 ports detected
usb 3-2: device descriptor read/all, error -71
SCSI subsystem initialized
libata version 2.00 loaded.
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
usb 3-2: new full speed USB device using uhci_hcd and address 4
usb 3-2: configuration #1 chosen from 1 choice
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports 3 Gbps 0x3f impl SATA =
mode
ahci 0000:00:1f.2: flags: 64bit ncq stag pm led clo pio slum part=20
ata1: SATA max UDMA/133 cmd 0xFFFFC20000022100 ctl 0x0 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xFFFFC20000022180 ctl 0x0 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xFFFFC20000022200 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xFFFFC20000022280 ctl 0x0 bmdma 0x0 irq 19
ata5: SATA max UDMA/133 cmd 0xFFFFC20000022300 ctl 0x0 bmdma 0x0 irq 19
ata6: SATA max UDMA/133 cmd 0xFFFFC20000022380 ctl 0x0 bmdma 0x0 irq 19
scsi0 : ahci
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 293046768 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATAPI, max UDMA/33
ata2.00: configured for UDMA/33
scsi2 : ahci
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/133
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
scsi4 : ahci
ata5: SATA link down (SStatus 0 SControl 300)
scsi5 : ahci
ata6: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      WDC WD1500ADFD-0 20.0 PQ: 0 =
ANSI: 5
SCSI device sda: 293046768 512-byte hdwr sectors (150040 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA
SCSI device sda: 293046768 512-byte hdwr sectors (150040 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
scsi 1:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183L SB01 PQ: 0 =
ANSI: 5
scsi 2:0:0:0: Direct-Access     ATA      WDC WD5000YS-01M 09.0 PQ: 0 =
ANSI: 5
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA
 sdb: sdb1 sdb2
sd 2:0:0:0: Attached scsi disk sdb
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1179163348.206:2): selinux=3D0 auid=3D4294967295
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 4 if 0 =
alt 1 proto 2 vid 0x03F0 pid 0x0217
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
input: PC Speaker as /class/input/input3
iTCO_vendor_support: vendor-support=3D0
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Attached scsi generic sg1 type 5
sd 2:0:0:0: Attached scsi generic sg2 type 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (11-Nov-2006)
iTCO_wdt: Found a ICH8 or ICH8R TCO device (Version=3D2, =
TCOBASE=3D0x0860)
iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:04:00.0 to 64
eth0: RTL8168b/8111b at 0xffffc20000026000, 00:19:db:5f:94:68, IRQ 17
ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 18 (level, low) -> IRQ 18
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:05:04.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[20]  =
MMIO=3D[febff800-febfffff]  Max Packet=3D[2048]  IR/IT contexts=3D[4/8]
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA UNIX x86_64 Kernel Module  1.0-9755  Mon Feb 26 =
23:16:31 PST 2007
sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc0001084d5c]
floppy0: no floppy controllers found
lp: driver loaded but no devices found
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
input: Power Button (FF) as /class/input/input4
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input5
ACPI: Power Button (CM) [PWRB]
No dock devices found.
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: =
dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
EXT3 FS on sda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 4096564k swap on /dev/sda2.  Priority:-1 extents:1 =
across:4096564k
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (8192 buckets, 65536 max)
r8169: eth0: link up
r8169: eth0: link up
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery =
directory
NFSD: starting 90-second grace period
eth0: no IPv6 routers present
i2c_adapter i2c-1: SMBus Quick command not supported, can't probe for =
chips
i2c_adapter i2c-2: SMBus Quick command not supported, can't probe for =
chips
i2c_adapter i2c-3: SMBus Quick command not supported, can't probe for =
chips
i2c_adapter i2c-4: SMBus Quick command not supported, can't probe for =
chips
Module F71882FG init
f71882fg: Not a Fintek device
f71882fg: Found F71882FG chip at 0xa10
i2c_adapter i2c-1: SMBus Quick command not supported, can't probe for =
chips
i2c_adapter i2c-2: SMBus Quick command not supported, can't probe for =
chips
i2c_adapter i2c-3: SMBus Quick command not supported, can't probe for =
chips
i2c_adapter i2c-4: SMBus Quick command not supported, can't probe for =
chips
Module F71882FG exit
Module F71882FG init
f71882fg: Not a Fintek device
f71882fg: Found F71882FG chip at 0xa10
Module F71882FG exit
Module F71882FG init
f71882fg: Not a Fintek device
f71882fg: Found F71882FG chip at 0xa10

------=_NextPart_000_002E_01C79737.43DB27E0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_NextPart_000_002E_01C79737.43DB27E0--

