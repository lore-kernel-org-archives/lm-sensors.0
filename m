From: miles.lane@gmail.com (Miles Lane)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <a44ae5cd050315155048b6f2f4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I narrowed the problem down.
In the following scenario, the OOPS occurs:
CONFIG_I2C=y
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y

If CONFIG_I2C is changed to build as a module, no crash occurs.
If CONFIG_FB_NVIDIA_I2C is not set, no crash occurs.
If CONFIG_FB_NVIDIA is changed to build as a module, no crash occurs.

Here is start of my dmesg output for a successful boot with CONFIG_FB_NVIDIA=m:

[4294667.296000] Linux version 2.6.11-mm3 (root@Monkey100) (gcc
version 3.3.5 (Debian 1:3.3.5-12)) #25 Tue Mar 15 17:58:18 EST 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[4294667.296000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000005fff0000 (usable)
[4294667.296000]  BIOS-e820: 000000005fff0000 - 000000005fff3000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 000000005fff3000 - 0000000060000000 (ACPI data)
[4294667.296000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[4294667.296000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[4294667.296000] Warning only 896MB will be used.
[4294667.296000] Use a HIGHMEM enabled kernel.
[4294667.296000] 896MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 229376
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:1
[4294667.296000]   Normal zone: 225280 pages, LIFO batch:16
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
[4294667.296000] DMI 2.2 present.
[4294667.296000] ACPI: RSDP (v000 Nvidia                              
 ) @ 0x000f75f0
[4294667.296000] ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD
0x00000000) @ 0x5fff3000
[4294667.296000] ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD
0x00000000) @ 0x5fff3040
[4294667.296000] ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD
0x00000000) @ 0x5fff74c0
[4294667.296000] ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT
0x0100000e) @ 0x00000000
[4294667.296000] ACPI: Local APIC address 0xfee00000
[4294667.296000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[4294667.296000] Processor #0 6:10 APIC version 16
[4294667.296000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[4294667.296000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[4294667.296000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[4294667.296000] ACPI: BIOS IRQ0 pin2 override ignored.
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[4294667.296000] ACPI: IRQ9 used by override.
[4294667.296000] ACPI: IRQ14 used by override.
[4294667.296000] ACPI: IRQ15 used by override.
[4294667.296000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[4294667.296000] Using ACPI (MADT) for SMP configuration information
[4294667.296000] Allocating PCI resources starting at 60000000 (gap:
60000000:9ec00000)
[4294667.296000] Built 1 zonelists
[4294667.296000] mapped APIC to ffffd000 (fee00000)
[4294667.296000] mapped IOAPIC to ffffc000 (fec00000)
[4294667.296000] Initializing CPU#0
[4294667.296000] Kernel command line: BOOT_IMAGE=Linux ro root06
video=vesafb init=/etc/initlang=us apm=power-off nomce
[4294667.296000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[    0.000000] Detected 1829.782 MHz processor.
[   22.394917] Using tsc for high-res timesource
[   22.394943] Console: colour dummy device 80x25
[   22.395595] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   22.396201] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   22.416825] Memory: 905116k/917504k available (2283k kernel code,
11932k reserved, 1145k data, 176k init, 0k highmem)
[   22.416836] Checking if this processor honours the WP bit even in
supervisor mode... Ok.
[   22.416920] Calibrating delay loop... 3612.67 BogoMIPS (lpj06336)
[   22.438853] Mount-cache hash table entries: 512
[   22.438960] CPU: After generic identify, caps: 0383fbff c1c3fbff
00000000 00000000 0000000000000000 00000000
[   22.438968] CPU: After vendor identify, caps: 0383fbff c1c3fbff
00000000 00000000 00000000 00000000 00000000
[   22.438976] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   22.438981] CPU: L2 Cache: 512K (64 bytes/line)
[   22.438985] CPU: After all inits, caps: 0383fbff c1c3fbff 00000000
00000020 00000000 00000000 00000000
[   22.438991] CPU: AMD Athlon(tm) XP 2500+ stepping 00
[   22.438996] Enabling fast FPU save and restore... done.
[   22.439000] Enabling unmasked SIMD FPU exception support... done.
[   22.439006] Checking 'hlt' instruction... OK.
[   22.464614] ENABLING IO-APIC IRQs
[   22.464807] ..TIMER: vector=0x31 pin1=0 pin2=-1
[   22.575777] softlockup thread 0 started up.
[   22.576062] NET: Registered protocol family 16
[   22.592317] PCI: PCI BIOS revision 2.10 entry at 0xfb470, last bus=3
[   22.592328] PCI: Using configuration type 1
[   22.592332] mtrr: v2.0 (20020519)
[   22.592654] ACPI: Subsystem revision 20050309
[   22.606938] ACPI: Interpreter enabled
[   22.606944] ACPI: Using IOAPIC for interrupt routing
[   22.607498] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   22.607505] PCI: Probing PCI hardware (bus 00)
[   22.607570] PCI: nForce2 C1 Halt Disconnect fixup
[   22.609141] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   22.609452] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[   22.610018] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
[   22.610249] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB1._PRT]
[   22.611241] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   22.611580] ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11
12 14 15) *0, disabled.
[   22.611930] ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   22.612265] ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   22.612604] ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11
12 14 15) *0, disabled.
[   22.612954] ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   22.613289] ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   22.613633] ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   22.613977] ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   22.614312] ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   22.614657] ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11
12 14 15) *0, disabled.
[   22.614994] ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   22.615329] ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   22.615676] ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   22.616015] ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   22.616352] ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11
12 14 15) *0, disabled.
[   22.616681] ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
[   22.616974] ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
[   22.617264] ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
[   22.617553] ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
[   22.617855] ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
[   22.618237] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
[   22.618623] ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
[   22.618999] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
[   22.619375] ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
[   22.619760] ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
[   22.620133] ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
[   22.620425] ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
[   22.620811] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
[   22.621187] ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
[   22.621562] ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
[   22.621950] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
[   22.625775] Linux Plug and Play Support v0.97 (c) Adam Belay
[   22.625827] pnp: PnP ACPI init
[   22.632352] pnp: PnP ACPI: found 16 devices
[   22.632512] PCI: Using ACPI for IRQ routing
[   22.632519] PCI: If a device doesn't work, try "pci=routeirq".  If
it helps, post a report
[   22.697115] pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
[   22.697122] pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
[   22.697127] pnp: 00:00: ioport range 0x4400-0x447f has been reserved
[   22.697132] pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
[   22.697137] pnp: 00:00: ioport range 0x4200-0x427f has been reserved
[   22.697141] pnp: 00:00: ioport range 0x4280-0x42ff has been reserved
[   22.697148] pnp: 00:01: ioport range 0x5000-0x503f has been reserved
[   22.697153] pnp: 00:01: ioport range 0x5500-0x553f has been reserved
[   22.698053] inotify device minorc
[   22.698066] VFS: Disk quotas dquot_6.5.1
[   22.698093] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   22.698131] NTFS driver 2.1.23-WIP [Flags: R/W].
[   22.698164] Initializing Cryptographic API
[   22.698358] vesafb: framebuffer at 0xd0000000, mapped to
0xf8880000, using 3072k, total 131072k
[   22.698366] vesafb: mode is 1024x768x16, linelength 48, pages=1
[   22.698371] vesafb: protected mode interface info at c000:f530
[   22.698375] vesafb: scrolling: redraw
[   22.698380] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[   22.712150] Console: switching to colour frame buffer device 128x48
[   22.712241] fb0: VESA VGA frame buffer device
[   22.713496] Linux agpgart interface v0.101 (c) Dave Jones
[   22.713617] agpgart: Detected NVIDIA nForce2 chipset
[   22.721844] agpgart: AGP aperture is 128M @ 0xe0000000
[   22.722046] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at
0x60,0x64 irq 1,12
[   22.734958] serio: i8042 AUX port at 0x60,0x64 irq 12
[   22.735379] serio: i8042 KBD port at 0x60,0x64 irq 1
[   22.735449] Serial: 8250/16550 driver $Revision: 1.90 $ 46 ports,
IRQ sharing enabled
[   22.735689] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   22.735874] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   22.737526] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   22.738030] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   22.738291] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   22.738503] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   22.738661] io scheduler noop registered
[   22.738729] io scheduler anticipatory registered
[   22.738797] io scheduler deadline registered
[   22.738865] io scheduler cfq registered
[   22.741223] ACPI: PCI Interrupt Link [AP3C] enabled at IRQ 22
[   22.743245] ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [AP3C] ->
GSI 22 (level, high) -> IRQ 22
[   22.745348] 3c59x: Donald Becker and others.
www.scyld.com/network/vortex.html
[   22.747469] 0000:02:01.0: 3Com PCI 3c920 Tornado at 0xc000. Vers LK1.1.19
[   22.782505] forcedeth.c: Reverse Engineered nForce ethernet driver.
Version 0.31.
[   22.785001] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
[   22.787146] ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCH] ->
GSI 21 (level, high) -> IRQ 21
[   22.789401] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   23.299982] eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
[   23.302282] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   23.304614] ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
[   23.307113] NFORCE2: IDE controller at PCI slot 0000:00:09.0
[   23.309597] NFORCE2: chipset revision 162
[   23.312086] NFORCE2: not 100% native mode: will probe irqs later
[   23.314595] NFORCE2: BIOS didn't set cable bits correctly. Enabling
workaround.
[   23.317153] NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
[   23.319695]     ide0: BM-DMA at 0xf000-0xf007, BIOS settings:
hda:DMA, hdb:DMA
[   23.322281]     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings:
hdc:DMA, hdd:DMA
[   23.324831] Probing IDE interface ide0...
[   23.584601] hda: WDC WD2000BB-00DAA0, ATA DISK drive
[   24.192764] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   24.195279] Probing IDE interface ide1...
[   24.859095] hdc: JLMS XJ-HD165H, ATAPI CD/DVD-ROM drive
[   25.573250] hdd: SONY DVD RW DRU-500A, ATAPI CD/DVD-ROM drive
[   25.624700] ide1 at 0x170-0x177,0x376 on irq 15
[   25.627274] hda: max request size: 1024KiB
[   25.636996] hda: 390721968 sectors (200049 MB) w/2048KiB Cache,
CHS$321/255/63, UDMA(100)
[   25.640847] hda: cache flushes supported
[   25.643381]  hda: hda1 hda2 < hda5 hda6 hda7 >
[   25.705759] mice: PS/2 mouse device common for all mice
[   25.708256] i2c /dev entries driver
[   25.711559] i2c-core: driver dev_driver registered.
[   25.711618] i2c_adapter i2c-0: Registered as minor 0
[   25.711641] i2c_adapter i2c-0: registered as adapter #0
[   25.711645] i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
[   25.714349] i2c_adapter i2c-1: Registered as minor 1
[   25.714373] i2c_adapter i2c-1: registered as adapter #1
[   25.714376] i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5500
