From: cheaterjs@gmx.de (Jan Schiefer)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: False detection of sensors on MSI K7N2 Delta-L (NForce2)!
Message-Id: <415BD873.8010303@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've been trying to get lm_sensors working on my lovely MSI K7N2 Delta-L 
NForce2 mainboard since I switched to kernel 2.6.x.
When I choose ISA or SMBUS it makes no difference.
I tried every version...
It never worked...

Now I discovered the problem: False chip detection by sensors-detect.
I finally got it working (manually) with kernel 2.6.9-rc2 and lm_sensors 
CVS.
Just because I was lucky I tried the right module.

sensors-detect (even in latest CVS) makes following module suggestions: 
i2c-nforce2, i2c-isa, eeprom, w83627hf
Only the eeprom reader will be detected then.

The correct modules are: i2c-isa, eeprom, w83781d
Only these modules make it work. So you don't need i2c-nforce2 (I don't 
know why on a NForce2-Board...) and w83781d instead of w83627hf.

I'm using Fedora Core 2.
Here some system information from dmesg:
---
20040412 (Red Hat Linux 3.3.3-7)) #1 Thu Sep 30 10:51:12 CEST 2004
Sep 30 11:28:53 mrsuicide kernel: BIOS-provided physical RAM map:
Sep 30 11:28:53 mrsuicide kernel:  BIOS-e820: 0000000000000000 - 
00000000000a0000 (usable)
Sep 30 11:28:53 mrsuicide kernel:  BIOS-e820: 00000000000f0000 - 
0000000000100000 (reserved)
Sep 30 11:28:53 mrsuicide kernel:  BIOS-e820: 0000000000100000 - 
000000001fff0000 (usable)
Sep 30 11:28:53 mrsuicide kernel:  BIOS-e820: 000000001fff0000 - 
000000001fff3000 (ACPI NVS)
Sep 30 11:28:53 mrsuicide kernel:  BIOS-e820: 000000001fff3000 - 
0000000020000000 (ACPI data)
Sep 30 11:28:53 mrsuicide kernel: 511MB LOWMEM available.
Sep 30 11:28:53 mrsuicide syslog: Starten von klogd succeeded
Sep 30 11:28:53 mrsuicide kernel: DMI 2.3 present.
Sep 30 11:28:53 mrsuicide kernel: ACPI: RSDP (v000 
Nvidia                                    ) @ 0x000f73a0
Sep 30 11:28:53 mrsuicide kernel: ACPI: RSDT (v001 Nvidia AWRDACPI 
0x42302e31 AWRD 0x00000000) @ 0x1fff3000
Sep 30 11:28:53 mrsuicide kernel: ACPI: FADT (v001 Nvidia AWRDACPI 
0x42302e31 AWRD 0x00000000) @ 0x1fff3040
Sep 30 11:28:53 mrsuicide kernel: ACPI: MADT (v001 Nvidia AWRDACPI 
0x42302e31 AWRD 0x00000000) @ 0x1fff7700
Sep 30 11:28:53 mrsuicide kernel: ACPI: DSDT (v001 NVIDIA AWRDACPI 
0x00001000 MSFT 0x0100000e) @ 0x00000000
Sep 30 11:28:53 mrsuicide kernel: ACPI: LAPIC (acpi_id[0x00] 
lapic_id[0x00] enabled)
Sep 30 11:28:53 mrsuicide kernel: Processor #0 6:8 APIC version 16
Sep 30 11:28:53 mrsuicide kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high 
edge lint[0x1])
Sep 30 11:28:53 mrsuicide kernel: ACPI: IOAPIC (id[0x02] 
address[0xfec00000] gsi_base[0])
Sep 30 11:28:53 mrsuicide kernel: IOAPIC[0]: apic_id 2, version 17, 
address 0xfec00000, GSI 0-23
Sep 30 11:28:53 mrsuicide kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 
global_irq 2 dfl dfl)
Sep 30 11:28:53 mrsuicide kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 
global_irq 9 high level)
Sep 30 11:28:53 mrsuicide kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 14 
global_irq 14 high edge)
Sep 30 11:28:53 mrsuicide kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 15 
global_irq 15 high edge)
Sep 30 11:28:53 mrsuicide kernel: Enabling APIC mode:  Flat.  Using 1 
I/O APICs
Sep 30 11:28:53 mrsuicide kernel: Using ACPI (MADT) for SMP 
configuration information
Sep 30 11:28:53 mrsuicide kernel: Built 1 zonelists
Sep 30 11:28:53 mrsuicide kernel: Kernel command line: ro root=/dev/hda4 
quiet
Sep 30 11:28:53 mrsuicide kernel: Initializing CPU#0
Sep 30 11:28:53 mrsuicide kernel: PID hash table entries: 2048 (order: 
11, 32768 bytes)
Sep 30 11:28:53 mrsuicide kernel: Detected 2088.202 MHz processor.
Sep 30 11:28:53 mrsuicide kernel: Using tsc for high-res timesource
Sep 30 11:28:53 mrsuicide kernel: Console: colour VGA+ 80x25
Sep 30 11:28:53 mrsuicide kernel: Dentry cache hash table entries: 
131072 (order: 7, 524288 bytes)
Sep 30 11:28:53 mrsuicide kernel: Inode-cache hash table entries: 65536 
(order: 6, 262144 bytes)
Sep 30 11:28:53 mrsuicide kernel: Memory: 515616k/524224k available 
(1862k kernel code, 8088k reserved, 742k data, 228k init, 0k highmem)
Sep 30 11:28:53 mrsuicide kernel: Checking if this processor honours the 
WP bit even in supervisor mode... Ok.
Sep 30 11:28:53 mrsuicide kernel: Mount-cache hash table entries: 512 
(order: 0, 4096 bytes)
Sep 30 11:28:53 mrsuicide kernel: CPU: L1 I Cache: 64K (64 bytes/line), 
D cache 64K (64 bytes/line)
Sep 30 11:28:53 mrsuicide kernel: CPU: L2 Cache: 256K (64 bytes/line)
Sep 30 11:28:53 mrsuicide kernel: Intel machine check architecture 
supported.
Sep 30 11:28:53 mrsuicide kernel: Intel machine check reporting enabled 
on CPU#0.
Sep 30 11:28:53 mrsuicide kernel: CPU: AMD Athlon(tm) XP 2600+ stepping 01
Sep 30 11:28:53 mrsuicide random: Zufallszahlenerzeuger initialisieren:  
succeeded
Sep 30 11:28:53 mrsuicide kernel: Enabling fast FPU save and restore... 
done.
Sep 30 11:28:53 mrsuicide kernel: Enabling unmasked SIMD FPU exception 
support... done.
Sep 30 11:28:53 mrsuicide kernel: Checking 'hlt' instruction... OK.
Sep 30 11:28:53 mrsuicide kernel: ENABLING IO-APIC IRQs
Sep 30 11:28:53 mrsuicide kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Sep 30 11:28:53 mrsuicide kernel: ..MP-BIOS bug: 8254 timer not 
connected to IO-APIC
Sep 30 11:28:53 mrsuicide kernel: ...trying to set up timer (IRQ0) 
through the 8259A ...  failed.
Sep 30 11:28:53 mrsuicide kernel: ...trying to set up timer as Virtual 
Wire IRQ... failed.
Sep 30 11:28:53 mrsuicide kernel: ...trying to set up timer as ExtINT 
IRQ... works.
Sep 30 11:28:53 mrsuicide kernel: checking if image is initramfs...it 
isn't (no cpio magic); looks like an initrd
Sep 30 11:28:53 mrsuicide kernel: Freeing initrd memory: 109k freed
Sep 30 11:28:53 mrsuicide kernel: NET: Registered protocol family 16
Sep 30 11:28:53 mrsuicide kernel: EISA bus registered
Sep 30 11:28:53 mrsuicide kernel: PCI: PCI BIOS revision 2.10 entry at 
0xfbbd0, last bus=2
Sep 30 11:28:53 mrsuicide kernel: PCI: Using configuration type 1
Sep 30 11:28:53 mrsuicide kernel: mtrr: v2.0 (20020519)
Sep 30 11:28:53 mrsuicide kernel: ACPI: Subsystem revision 20040715
Sep 30 11:28:53 mrsuicide kernel: ACPI: Interpreter enabled
Sep 30 11:28:53 mrsuicide kernel: ACPI: Using IOAPIC for interrupt routing
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Sep 30 11:28:53 mrsuicide kernel: PCI: Probing PCI hardware (bus 00)
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 
3 4 5 6 7 10 11 12 14 15) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 
3 4 5 6 7 *10 11 12 14 15)
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 
3 4 5 6 7 10 11 12 14 15) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 
3 4 5 6 7 10 11 *12 14 15)
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 
3 4 5 6 7 10 11 12 14 15) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LUBA] (IRQs 
3 4 5 6 7 10 11 *12 14 15)
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LUBB] (IRQs 
3 4 5 6 7 *10 11 12 14 15)
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LMAC] (IRQs 
3 4 5 6 7 10 *11 12 14 15)
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LAPU] (IRQs 
3 4 5 6 7 10 11 12 14 15) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LACI] (IRQs 
3 4 *5 6 7 10 11 12 14 15)
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LMCI] (IRQs 
3 4 5 6 7 10 11 12 14 15) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LSMB] (IRQs 
3 4 *5 6 7 10 11 12 14 15)
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LUB2] (IRQs 
3 4 5 6 7 10 *11 12 14 15)
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LFIR] (IRQs 
3 4 5 6 7 10 11 12 14 15) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [L3CM] (IRQs 
3 4 5 6 7 10 11 12 14 15) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [LIDE] (IRQs 
3 4 5 6 7 10 11 12 14 15) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APC1] (IRQs 
*16), disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APC2] (IRQs 
*17), disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APC3] (IRQs 
*18), disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APC4] (IRQs 
*19), disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APC5] (IRQs 
*16), disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCF] (IRQs 
20 21 22) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCG] (IRQs 
20 21 22) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCH] (IRQs 
20 21 22) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCI] (IRQs 
20 21 22) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCJ] (IRQs 
20 21 22) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCK] (IRQs 
20 21 22) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCS] (IRQs 
*23), disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCL] (IRQs 
20 21 22) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCM] (IRQs 
20 21 22) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [AP3C] (IRQs 
20 21 22) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCZ] (IRQs 
20 21 22) *0, disabled.
Sep 30 11:28:53 mrsuicide kernel: usbcore: registered new driver usbfs
Sep 30 11:28:53 mrsuicide kernel: usbcore: registered new driver hub
Sep 30 11:28:53 mrsuicide kernel: PCI: Using ACPI for IRQ routing
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCS] 
enabled at IRQ 23
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI interrupt 0000:00:01.1[A] -> 
GSI 23 (level, high) -> IRQ 23
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCF] 
enabled at IRQ 22
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI interrupt 0000:00:02.0[A] -> 
GSI 22 (level, high) -> IRQ 22
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCG] 
enabled at IRQ 21
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI interrupt 0000:00:02.1[B] -> 
GSI 21 (level, high) -> IRQ 21
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCL] 
enabled at IRQ 20
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI interrupt 0000:00:02.2[C] -> 
GSI 20 (level, high) -> IRQ 20
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCH] 
enabled at IRQ 22
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI interrupt 0000:00:04.0[A] -> 
GSI 22 (level, high) -> IRQ 22
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APCJ] 
enabled at IRQ 21
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI interrupt 0000:00:06.0[A] -> 
GSI 21 (level, high) -> IRQ 21
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APC2] 
enabled at IRQ 17
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI interrupt 0000:01:08.0[A] -> 
GSI 17 (level, high) -> IRQ 17
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI Interrupt Link [APC4] 
enabled at IRQ 19
Sep 30 11:28:53 mrsuicide kernel: ACPI: PCI interrupt 0000:02:00.0[A] -> 
GSI 19 (level, high) -> IRQ 19
Sep 30 11:28:53 mrsuicide kernel: VFS: Disk quotas dquot_6.5.1
Sep 30 11:28:53 mrsuicide kernel: Dquot-cache hash table entries: 1024 
(order 0, 4096 bytes)
Sep 30 11:28:53 mrsuicide kernel: Initializing Cryptographic API
Sep 30 11:28:53 mrsuicide kernel: ACPI: Power Button (FF) [PWRF]
Sep 30 11:28:53 mrsuicide kernel: ACPI: Fan [FAN] (on)
Sep 30 11:28:53 mrsuicide kernel: ACPI: Processor [CPU0] (supports C1)
Sep 30 11:28:53 mrsuicide kernel: ACPI: Thermal Zone [THRM] (53 C)
Sep 30 11:28:53 mrsuicide kernel: Using anticipatory io scheduler
Sep 30 11:28:53 mrsuicide kernel: Floppy drive(s): fd0 is 1.44M
Sep 30 11:28:53 mrsuicide kernel: FDC 0 is a post-1991 82077
Sep 30 11:28:53 mrsuicide kernel: RAMDISK driver initialized: 16 RAM 
disks of 4096K size 1024 blocksize
Sep 30 11:28:53 mrsuicide kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
Sep 30 11:28:53 mrsuicide kernel: ide: Assuming 33MHz system bus speed 
for PIO modes; override with idebus=xx
Sep 30 11:28:53 mrsuicide lm_sensors: Starting up sensors:
Sep 30 11:28:53 mrsuicide kernel: NFORCE2: IDE controller at PCI slot 
0000:00:09.0
Sep 30 11:28:53 mrsuicide kernel: NFORCE2: chipset revision 162
Sep 30 11:28:53 mrsuicide kernel: NFORCE2: not 100%% native mode: will 
probe irqs later
Sep 30 11:28:53 mrsuicide kernel: NFORCE2: BIOS didn't set cable bits 
correctly. Enabling workaround.
Sep 30 11:28:53 mrsuicide kernel: NFORCE2: BIOS didn't set cable bits 
correctly. Enabling workaround.
Sep 30 11:28:53 mrsuicide kernel: NFORCE2: 0000:00:09.0 (rev a2) UDMA133 
controller
Sep 30 11:28:53 mrsuicide kernel:     ide0: BM-DMA at 0xf000-0xf007, 
BIOS settings: hda:DMA, hdb:DMA
Sep 30 11:28:53 mrsuicide kernel:     ide1: BM-DMA at 0xf008-0xf00f, 
BIOS settings: hdc:DMA, hdd:DMA
Sep 30 11:28:53 mrsuicide kernel: hda: WDC WD600AB-32CZA0, ATA DISK drive
Sep 30 11:28:53 mrsuicide kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 30 11:28:53 mrsuicide kernel: hdc: ExcelStor Technology J340, ATA 
DISK drive
Sep 30 11:28:53 mrsuicide kernel: hdd: HL-DT-ST GCE-8320B, ATAPI 
CD/DVD-ROM drive
Sep 30 11:28:53 mrsuicide kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 30 11:28:53 mrsuicide kernel: hda: max request size: 128KiB
Sep 30 11:28:53 mrsuicide kernel: hda: 117231408 sectors (60022 MB) 
w/2048KiB Cache, CHSe535/16/63, UDMA(100)
Sep 30 11:28:53 mrsuicide kernel:  hda: hda1 hda2 hda3 hda4
Sep 30 11:28:53 mrsuicide kernel: hdc: max request size: 1024KiB
Sep 30 11:28:53 mrsuicide kernel: hdc: 80418240 sectors (41174 MB) 
w/1821KiB Cache, CHS383/255/63, UDMA(100)
Sep 30 11:28:53 mrsuicide kernel:  hdc: hdc1 < hdc5 >
Sep 30 11:28:53 mrsuicide kernel: usbcore: registered new driver hiddev
Sep 30 11:28:53 mrsuicide kernel: usbcore: registered new driver usbhid
Sep 30 11:28:53 mrsuicide kernel: drivers/usb/input/hid-core.c: v2.0:USB 
HID core driver
Sep 30 11:28:53 mrsuicide kernel: mice: PS/2 mouse device common for all 
mice
Sep 30 11:28:53 mrsuicide kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 30 11:28:53 mrsuicide kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep 30 11:28:53 mrsuicide kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0
Sep 30 11:28:53 mrsuicide kernel: EISA: Probing bus 0 at eisa0
Sep 30 11:28:53 mrsuicide kernel: NET: Registered protocol family 2
Sep 30 11:28:53 mrsuicide kernel: IP: routing cache hash table of 4096 
buckets, 32Kbytes
Sep 30 11:28:53 mrsuicide kernel: TCP: Hash tables configured 
(established 32768 bind 65536)
Sep 30 11:28:53 mrsuicide kernel: NET: Registered protocol family 1
Sep 30 11:28:53 mrsuicide kernel: NET: Registered protocol family 17
Sep 30 11:28:53 mrsuicide kernel: BIOS EDD facility v0.16 2004-Jun-25, 2 
devices found
---
