From: jsnorman@ameritech.net (Jeffery S. Norman)
Date: Thu, 19 May 2005 06:25:49 +0000
Subject: Sensors detected, modules load, but nothing reported in sensors
Message-Id: <4255A7BA.1040007@ameritech.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have an iWill Zmaxdp (dual opteron) on the Nforce3 250 Pro chipset.

Running sensors-detect, I found the following chips/buses:
eeprom
i2c-isa
i2c-nforce2
w83627hf
it87

I had sensors-detect create my configuration files, and ran rc-update
add lm_sensors default.  Here is my output from sensors-detect:
Driver `it87' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)


Just for safety, I also added these modules to autoload

When I rebooted, I confirmed these modules are all loaded.=20

Output from lsmod:
Module                  Size  Used by
it87                   26140  0
i2c_isa                 2688  0
amd64_agp              10924  0
evdev                   8960  0
w83627hf               31400  0
eeprom                  7248  0
i2c_sensor              3392  2 it87,w83627hf,eeprom
i2c_nforce2             6784  0
ohci1394               30340  0
ieee1394               96656  1 ohci1394
usb_storage           101712  0
snd_rtctimer            3168  0
snd_ioctl32            26560  0
snd_intel8x0           31616  0
snd_ac97_codec         79248  1 snd_intel8x0
snd_pcm                85896  3 snd_ioctl32,snd_intel8x0,snd_ac97_codec
snd_timer              21896  2 snd_rtctimer,snd_pcm
snd_page_alloc          9224  2 snd_intel8x0,snd_pcm
agpgart                29804  1 amd64_agp
forcedeth              17600  0
sg                     27056  0
sr_mod                 14884  0
st                  =20

Note that sensors-detect did not generate a module load for it87, so I
added that on my own.  But I have tried with and without it87 loaded and
it still does not detect anything.

There are no errors or informational messages in dmesg or
/var/log/kernel/current which I have attached to this message.

My kernel is gentoo-patched source 2.6.11-r5.  I have i2c-dev compiled
in, everything else as modules.  Running 64 bit SMP.  I have attached my
kernel config to this email too.

When I run sensors, I only get the eeprom, however:

eeprom-i2c-4-51
Adapter: SMBus nForce2 adapter at c400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-4-50
Adapter: SMBus nForce2 adapter at c400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-1-50
Adapter: dvi
Either use the ddcmon driver instead of the eeprom driver,
or run the decode-edid.pl script.


The winbond and it87 adapters just do not appear, so I cannot see any
real sensor data (no temps for example), yet sensors-detect sees these
sensors, and the modules load okay.

sensors version is 2.9.0 same as libsensors.

Any ideas?
-------------- next part --------------
Apr  7 12:18:41 [kernel]  BIOS-e820: 0000000000000000 - 000000000009fc00 (u=
sable)
Apr  7 12:18:41 [kernel]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (r=
eserved)
Apr  7 12:18:41 [kernel]  BIOS-e820: 00000000000e6000 - 0000000000100000 (r=
eserved)
Apr  7 12:18:41 [kernel]  BIOS-e820: 0000000000100000 - 000000003ff40000 (u=
sable)
Apr  7 12:18:41 [kernel]  BIOS-e820: 000000003ff40000 - 000000003ff50000 (A=
CPI data)
Apr  7 12:18:41 [kernel]  BIOS-e820: 000000003ff50000 - 0000000040000000 (A=
CPI NVS)
Apr  7 12:18:41 [kernel]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (r=
eserved)
Apr  7 12:18:41 [kernel]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (r=
eserved)
Apr  7 12:18:41 [kernel]  BIOS-e820: 00000000ff7c0000 - 0000000100000000 (r=
eserved)
Apr  7 12:18:41 [kernel] ACPI: RSDP (v000 ACPIAM                           =
     ) @ 0x00000000000f6d00
Apr  7 12:18:41 [kernel] ACPI: RSDT (v001 A M I  OEMRSDT  0x03000516 MSFT 0=
x00000097) @ 0x000000003ff40000
Apr  7 12:18:41 [kernel] ACPI: FADT (v002 A M I  OEMFACP  0x03000516 MSFT 0=
x00000097) @ 0x000000003ff40200
Apr  7 12:18:41 [kernel] ACPI: MADT (v001 A M I  OEMAPIC  0x03000516 MSFT 0=
x00000097) @ 0x000000003ff40390
Apr  7 12:18:41 [kernel] ACPI: OEMB (v001 A M I  OEMBIOS  0x03000516 MSFT 0=
x00000097) @ 0x000000003ff50040
Apr  7 12:18:41 [kernel] ACPI: DSDT (v001  ZMDPV ZMDPV111 0x00000111 INTL 0=
x02002026) @ 0x0000000000000000
Apr  7 12:18:41 [kernel] Scanning NUMA topology in Northbridge 24
Apr  7 12:18:41 [kernel] Number of nodes 2
Apr  7 12:18:41 [kernel] Node 0 MemBase 0000000000000000 Limit 000000003ff4=
0000
Apr  7 12:18:41 [kernel] Skipping disabled node 1
Apr  7 12:18:41 [kernel] Using node hash shift of 24
Apr  7 12:18:41 [kernel] Bootmem setup node 0 0000000000000000-000000003ff4=
0000
Apr  7 12:18:41 [kernel] On node 0 totalpages: 261952
Apr  7 12:18:41 [kernel]   DMA zone: 4096 pages, LIFO batch:1
Apr  7 12:18:41 [kernel]   Normal zone: 257856 pages, LIFO batch:16
Apr  7 12:18:41 [kernel]   HighMem zone: 0 pages, LIFO batch:1
Apr  7 12:18:41 [kernel] Nvidia board detected. Ignoring ACPI timer overrid=
e.
Apr  7 12:18:41 [kernel] ACPI: Local APIC address 0xfee00000
Apr  7 12:18:41 [kernel] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Apr  7 12:18:41 [kernel] Processor #0 15:5 APIC version 16
Apr  7 12:18:41 [kernel] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Apr  7 12:18:41 [kernel] Processor #1 15:5 APIC version 16
Apr  7 12:18:41 [kernel] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
Apr  7 12:18:41 [kernel] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
Apr  7 12:18:41 [kernel] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_bas=
e[0])
Apr  7 12:18:41 [kernel] IOAPIC[0]: apic_id 2, version 17, address 0xfec000=
00, GSI 0-23
Apr  7 12:18:41 [kernel] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 df=
l dfl)
Apr  7 12:18:41 [kernel] ACPI: BIOS IRQ0 pin2 override ignored.
Apr  7 12:18:41 [kernel] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 hi=
gh level)
Apr  7 12:18:41 [kernel] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 =
high edge)
Apr  7 12:18:41 [kernel] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 =
high edge)
Apr  7 12:18:41 [kernel] ACPI: IRQ9 used by override.
Apr  7 12:18:41 [kernel] ACPI: IRQ14 used by override.
Apr  7 12:18:41 [kernel] ACPI: IRQ15 used by override.
Apr  7 12:18:41 [kernel] Setting APIC routing to flat
Apr  7 12:18:41 [kernel] Using ACPI (MADT) for SMP configuration information
Apr  7 12:18:41 [kernel] Built 1 zonelists
Apr  7 12:18:41 [kernel] Kernel command line: root=3D/dev/sda10 idle=3Dpoll=
 console=3Dtty0
Apr  7 12:18:41 [kernel] using polling idle threads.
Apr  7 12:18:41 [kernel] Initializing CPU#0
Apr  7 12:18:41 [kernel] PID hash table entries: 4096 (order: 12, 131072 by=
tes)
Apr  7 12:18:41 [kernel] time.c: Using 1.193182 MHz PIT timer.
Apr  7 12:18:41 [kernel] time.c: Detected 1400.036 MHz processor.
Apr  7 12:18:41 [kernel] Console: colour VGA+ 80x25
Apr  7 12:18:41 [kernel] Dentry cache hash table entries: 262144 (order: 9,=
 2097152 bytes)
Apr  7 12:18:41 [kernel] Inode-cache hash table entries: 131072 (order: 8, =
1048576 bytes)
Apr  7 12:18:41 [kernel] Memory: 1024112k/1047808k available (3436k kernel =
code, 0k reserved, 1330k data, 220k init)
Apr  7 12:18:41 [kernel] Calibrating delay loop... 2760.70 BogoMIPS (lpj=13=
80352)
Apr  7 12:18:41 [kernel] Security Framework v1.0.0 initialized
Apr  7 12:18:41 [kernel] Capability LSM initialized
Apr  7 12:18:41 [kernel] Mount-cache hash table entries: 256 (order: 0, 409=
6 bytes)
Apr  7 12:18:41 [kernel] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K =
(64 bytes/line)
Apr  7 12:18:41 [kernel] CPU: L2 Cache: 1024K (64 bytes/line)
Apr  7 12:18:41 [kernel] CPU 0(1) -> Node 0
Apr  7 12:18:41 [kernel] Using local APIC NMI watchdog using perfctr0
Apr  7 12:18:41 [kernel] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K =
(64 bytes/line)
Apr  7 12:18:41 [kernel] CPU: L2 Cache: 1024K (64 bytes/line)
Apr  7 12:18:41 [kernel] CPU 0(1) -> Node 0
Apr  7 12:18:41 [kernel] CPU0: AMD Opteron(tm) Processor 240 stepping 08
Apr  7 12:18:41 [kernel] per-CPU timeslice cutoff: 1023.85 usecs.
Apr  7 12:18:41 [kernel] task migration cache decay timeout: 2 msecs.
Apr  7 12:18:41 [kernel] Booting processor 1/1 rip 6000 rsp ffff810002197f58
Apr  7 12:18:41 [kernel] Initializing CPU#1
Apr  7 12:18:41 [kernel] Calibrating delay loop... <7>spurious 8259A interr=
upt: IRQ7.
Apr  7 12:18:41 [kernel] 2744.32 BogoMIPS (lpj=1372160)
Apr  7 12:18:41 [kernel] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K =
(64 bytes/line)
Apr  7 12:18:41 [kernel] CPU: L2 Cache: 1024K (64 bytes/line)
Apr  7 12:18:41 [kernel] CPU 1(1) -> Node 0
Apr  7 12:18:41 [kernel] AMD Opteron(tm) Processor 240 stepping 08
Apr  7 12:18:41 [kernel] Total of 2 processors activated (5505.02 BogoMIPS).
Apr  7 12:18:41 [kernel] time.c: Using PIT/TSC based timekeeping.
Apr  7 12:18:41 [kernel] Brought up 2 CPUs
Apr  7 12:18:41 [kernel] CPU0 attaching sched-domain:
Apr  7 12:18:41 [kernel]  domain 0: span 1
Apr  7 12:18:41 [kernel]   groups: 1
Apr  7 12:18:41 [kernel]   domain 1: span 3
Apr  7 12:18:41 [kernel]    groups: 1 2
Apr  7 12:18:41 [kernel]    domain 2: span 3
Apr  7 12:18:41 [kernel]     groups: 3
Apr  7 12:18:41 [kernel] CPU1 attaching sched-domain:
Apr  7 12:18:41 [kernel]  domain 0: span 2
Apr  7 12:18:41 [kernel]   groups: 2
Apr  7 12:18:41 [kernel]   domain 1: span 3
Apr  7 12:18:41 [kernel]    groups: 2 1
Apr  7 12:18:41 [kernel]    domain 2: span 3
Apr  7 12:18:41 [kernel]     groups: 3
Apr  7 12:18:41 [kernel] NET: Registered protocol family 16
Apr  7 12:18:41 [kernel] PCI: Using configuration type 1
Apr  7 12:18:41 [kernel] mtrr: v2.0 (20020519)
Apr  7 12:18:41 [kernel] ACPI: Subsystem revision 20050211
Apr  7 12:18:41 [kernel] ACPI: Interpreter enabled
Apr  7 12:18:41 [kernel] ACPI: Using IOAPIC for interrupt routing
Apr  7 12:18:41 [kernel] ACPI: PCI Root Bridge [PCI0] (00:00)
Apr  7 12:18:41 [kernel] PCI: Probing PCI hardware (bus 00)
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1=
._PRT]
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19)=
 *0, disabled.
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19)=
 *9
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19)=
 *11
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19)=
 *0, disabled.
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LNKE] (IRQs 16 17 18 19)=
 *11
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22) *4
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22) *7
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22) *3
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LKLN] (IRQs 20 21 22) *5
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LAUI] (IRQs 20 21 22) *9
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LKMO] (IRQs 20 21 22) *0=
, disabled.
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LKSM] (IRQs 20 21 22) *11
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *0
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LTIE] (IRQs 20 21 22) *0=
, disabled.
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22) *14
Apr  7 12:18:41 [kernel] Linux Plug and Play Support v0.97 (c) Adam Belay
Apr  7 12:18:41 [kernel] pnp: PnP ACPI init
Apr  7 12:18:41 [kernel] pnp: PnP ACPI: found 11 devices
Apr  7 12:18:41 [kernel] SCSI subsystem initialized
Apr  7 12:18:41 [kernel] usbcore: registered new driver usbfs
Apr  7 12:18:41 [kernel] usbcore: registered new driver hub
Apr  7 12:18:41 [kernel] PCI: Using ACPI for IRQ routing
Apr  7 12:18:41 [kernel] ** PCI interrupts are no longer routed automatical=
ly.  If this
Apr  7 12:18:41 [kernel] ** causes a device to stop working, it is probably=
 because the
Apr  7 12:18:41 [kernel] ** driver failed to call pci_enable_device().  As =
a temporary
Apr  7 12:18:41 [kernel] ** workaround, the "pci=3Drouteirq" argument resto=
res the old
Apr  7 12:18:41 [kernel] ** behavior.  If this argument makes the device wo=
rk again,
Apr  7 12:18:41 [kernel] ** please email the output of "lspci" to bjorn.hel=
gaas@hp.com
Apr  7 12:18:41 [kernel] ** so I can fix the driver.
Apr  7 12:18:41 [kernel] pnp: 00:09: ioport range 0x680-0x6ff has been rese=
rved
Apr  7 12:18:41 [kernel] pnp: 00:09: ioport range 0x295-0x296 has been rese=
rved
Apr  7 12:18:41 [kernel] IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 1=
3:02:28 ak Exp $
Apr  7 12:18:41 [kernel] Total HugeTLB memory allocated, 0
Apr  7 12:18:41 [kernel] inotify device minorc
Apr  7 12:18:41 [kernel] devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro=
.au)
Apr  7 12:18:41 [kernel] devfs: boot_options: 0x0
Apr  7 12:18:41 [kernel] NTFS driver 2.1.22 [Flags: R/W].
Apr  7 12:18:41 [kernel] SGI XFS with large block/inode numbers, no debug e=
nabled
Apr  7 12:18:41 [kernel] Initializing Cryptographic API
Apr  7 12:18:41 [kernel] Real Time Clock Driver v1.12
Apr  7 12:18:41 [kernel] Hangcheck: starting hangcheck timer 0.5.0 (tick is=
 180 seconds, margin is 60 seconds).
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 19
Apr  7 12:18:41 [kernel] ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (lev=
el, low) -> IRQ 177
Apr  7 12:18:41 [kernel] radeonfb: Found Intel x86 BIOS ROM Image
Apr  7 12:18:41 [kernel] radeonfb: Retreived PLL infos from BIOS
Apr  7 12:18:41 [kernel] radeonfb: Reference'.00 MHz (RefDiv=12) Memory%0.0=
0 Mhz, System 0.00 MHz
Apr  7 12:18:41 [kernel] radeonfb: PLL min 20000 max 40000
Apr  7 12:18:41 [kernel] radeonfb: Monitor 1 type DFP found
Apr  7 12:18:41 [kernel] radeonfb: EDID probed
Apr  7 12:18:41 [kernel] radeonfb: Monitor 2 type no found
Apr  7 12:18:41 [kernel] Console: switching to colour frame buffer device 1=
60x64
Apr  7 12:18:41 [kernel] radeonfb (0000:02:00.0): ATI Radeon AS=20
Apr  7 12:18:41 [kernel] ACPI: Power Button (FF) [PWRF]
Apr  7 12:18:41 [kernel] ACPI: Processor [CPU1] (supports 8 throttling stat=
es)
Apr  7 12:18:41 [kernel] serio: i8042 AUX port at 0x60,0x64 irq 12
Apr  7 12:18:41 [kernel] serio: i8042 KBD port at 0x60,0x64 irq 1
Apr  7 12:18:41 [kernel] Serial: 8250/16550 driver $Revision: 1.90 $ 8 port=
s, IRQ sharing disabled
Apr  7 12:18:41 [kernel] mice: PS/2 mouse device common for all mice
Apr  7 12:18:41 [kernel] input: AT Translated Set 2 keyboard on isa0060/ser=
io0
Apr  7 12:18:41 [kernel] input: PS/2 Generic Mouse on isa0060/serio1
Apr  7 12:18:41 [kernel] input: PC Speaker
Apr  7 12:18:41 [kernel] io scheduler noop registered
Apr  7 12:18:41 [kernel] io scheduler anticipatory registered
Apr  7 12:18:41 [kernel] io scheduler deadline registered
Apr  7 12:18:41 [kernel] io scheduler cfq registered
Apr  7 12:18:41 [kernel] Floppy drive(s): fd0 is 1.44M
Apr  7 12:18:41 [kernel] FDC 0 is a post-1991 82077
Apr  7 12:18:41 [kernel] loop: loaded (max 8 devices)
Apr  7 12:18:41 [kernel] netconsole: not configured, aborting
Apr  7 12:18:41 [kernel] Uniform Multi-Platform E-IDE driver Revision: 7.00=
alpha2
Apr  7 12:18:41 [kernel] ide: Assuming 33MHz system bus speed for PIO modes=
; override with idebus=3Dxx
Apr  7 12:18:41 [kernel] NFORCE3-250: IDE controller at PCI slot 0000:00:08=
.0
Apr  7 12:18:41 [kernel] NFORCE3-250: chipset revision 162
Apr  7 12:18:41 [kernel] NFORCE3-250: not 100% native mode: will probe irqs=
 later
Apr  7 12:18:41 [kernel] NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 control=
ler
Apr  7 12:18:41 [kernel]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: =
hda:pio, hdb:pio
Apr  7 12:18:41 [kernel]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: =
hdc:pio, hdd:pio
Apr  7 12:18:41 [kernel] Probing IDE interface ide0...
Apr  7 12:18:41 [kernel] Probing IDE interface ide1...
Apr  7 12:18:41 [kernel] hdc: HL-DT-ST DVDRAM GSA-4163B, ATAPI CD/DVD-ROM d=
rive
Apr  7 12:18:41 [kernel] ide1 at 0x170-0x177,0x376 on irq 15
Apr  7 12:18:41 [kernel] Probing IDE interface ide0...
Apr  7 12:18:41 [kernel] Probing IDE interface ide2...
Apr  7 12:18:41 [kernel] Probing IDE interface ide3...
Apr  7 12:18:41 [kernel] Probing IDE interface ide4...
Apr  7 12:18:41 [kernel] Probing IDE interface ide5...
Apr  7 12:18:41 [kernel] hdc: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 20=
48kB Cache, UDMA(33)
Apr  7 12:18:41 [kernel] Uniform CD-ROM driver Revision: 3.20
Apr  7 12:18:41 [kernel] libata version 1.10 loaded.
Apr  7 12:18:41 [kernel] sata_nv version 0.6
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LTID] BIOS reported IRQ =
0, using IRQ 22
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
Apr  7 12:18:41 [kernel] ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 22 (lev=
el, low) -> IRQ 185
Apr  7 12:18:41 [kernel] PCI: Setting latency timer of device 0000:00:0a.0 =
to 64
Apr  7 12:18:41 [kernel] ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdm=
a 0xDC00 irq 185
Apr  7 12:18:41 [kernel] ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdm=
a 0xDC08 irq 185
Apr  7 12:18:41 [kernel] ata1: no device found (phy stat 00000000)
Apr  7 12:18:41 [kernel] scsi0 : sata_nv
Apr  7 12:18:41 [kernel] ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85=
:7c69 86:3a01 87:4003 88:047f
Apr  7 12:18:41 [kernel] ata2: dev 0 ATA, max UDMA/133, 240121728 sectors:
Apr  7 12:18:41 [kernel] nv_sata: Primary device removed
Apr  7 12:18:41 [kernel] nv_sata: Secondary device added
Apr  7 12:18:41 [kernel] nv_sata: Secondary device removed
Apr  7 12:18:41 [kernel] ata2: dev 0 configured for UDMA/133
Apr  7 12:18:41 [kernel] scsi1 : sata_nv
Apr  7 12:18:41 [kernel]   Vendor: ATA       Model: Maxtor 6Y120M0    Rev: =
YAR5
Apr  7 12:18:41 [kernel]   Type:   Direct-Access                      ANSI =
SCSI revision: 05
Apr  7 12:18:41 [kernel] SCSI device sda: 240121728 512-byte hdwr sectors (=
122942 MB)
Apr  7 12:18:41 [kernel] SCSI device sda: drive cache: write back
Apr  7 12:18:41 [kernel] SCSI device sda: 240121728 512-byte hdwr sectors (=
122942 MB)
Apr  7 12:18:41 [kernel] SCSI device sda: drive cache: write back
Apr  7 12:18:41 [kernel]  /dev/scsi/host1/bus0/target0/lun0: p1 p2 < p5 p6 =
p7 p8 p9 p10 p11 p12 >
Apr  7 12:18:41 [kernel] Attached scsi disk sda at scsi1, channel 0, id 0, =
lun 0
Apr  7 12:18:41 [kernel] Fusion MPT base driver 3.01.18
Apr  7 12:18:41 [kernel] Copyright (c) 1999-2004 LSI Logic Corporation
Apr  7 12:18:41 [kernel] Fusion MPT SCSI Host driver 3.01.18
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 21
Apr  7 12:18:41 [kernel] ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 21 (lev=
el, low) -> IRQ 193
Apr  7 12:18:41 [kernel] ehci_hcd 0000:00:02.2: PCI device 10de:00e8 (nVidi=
a Corporation)
Apr  7 12:18:41 [kernel] PCI: Setting latency timer of device 0000:00:02.2 =
to 64
Apr  7 12:18:41 [kernel] ehci_hcd 0000:00:02.2: irq 193, pci mem 0xff6fdc00
Apr  7 12:18:41 [kernel] ehci_hcd 0000:00:02.2: new USB bus registered, ass=
igned bus number 1
Apr  7 12:18:41 [kernel] PCI: cache line size of 64 is not supported by dev=
ice 0000:00:02.2
Apr  7 12:18:41 [kernel] ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1=
.00, driver 10 Dec 2004
Apr  7 12:18:41 [kernel] hub 1-0:1.0: USB hub found
Apr  7 12:18:41 [kernel] hub 1-0:1.0: 8 ports detected
Apr  7 12:18:41 [kernel] ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controll=
er (OHCI) Driver (PCI)
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 20
Apr  7 12:18:41 [kernel] ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 20 (lev=
el, low) -> IRQ 201
Apr  7 12:18:41 [kernel] ohci_hcd 0000:00:02.0: PCI device 10de:00e7 (nVidi=
a Corporation)
Apr  7 12:18:41 [kernel] PCI: Setting latency timer of device 0000:00:02.0 =
to 64
Apr  7 12:18:41 [kernel] ohci_hcd 0000:00:02.0: irq 201, pci mem 0xff6fb000
Apr  7 12:18:41 [kernel] ohci_hcd 0000:00:02.0: new USB bus registered, ass=
igned bus number 2
Apr  7 12:18:41 [kernel] hub 2-0:1.0: USB hub found
Apr  7 12:18:41 [kernel] hub 2-0:1.0: 4 ports detected
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 22
Apr  7 12:18:41 [kernel] ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 22 (lev=
el, low) -> IRQ 185
Apr  7 12:18:41 [kernel] ohci_hcd 0000:00:02.1: PCI device 10de:00e7 (nVidi=
a Corporation)
Apr  7 12:18:41 [kernel] Losing some ticks... checking if CPU frequency cha=
nged.
Apr  7 12:18:41 [kernel] PCI: Setting latency timer of device 0000:00:02.1 =
to 64
Apr  7 12:18:41 [kernel] ohci_hcd 0000:00:02.1: irq 185, pci mem 0xff6fc000
Apr  7 12:18:41 [kernel] ohci_hcd 0000:00:02.1: new USB bus registered, ass=
igned bus number 3
Apr  7 12:18:41 [kernel] hub 3-0:1.0: USB hub found
Apr  7 12:18:41 [kernel] hub 3-0:1.0: 4 ports detected
Apr  7 12:18:41 [kernel] hub 1-5:1.0: USB hub found
Apr  7 12:18:41 [kernel] hub 1-5:1.0: 4 ports detected
Apr  7 12:18:41 [kernel] usbcore: registered new driver usbhid
Apr  7 12:18:41 [kernel] drivers/usb/input/hid-core.c: v2.0:USB HID core dr=
iver
Apr  7 12:18:41 [kernel] i2c /dev entries driver
Apr  7 12:18:41 [kernel] i2c_adapter i2c-4: nForce2 SMBus adapter at 0xc400
Apr  7 12:18:41 [kernel] i2c_adapter i2c-5: nForce2 SMBus adapter at 0xc000
Apr  7 12:18:41 [kernel] Advanced Linux Sound Architecture Driver Version 1=
.0.8 (Thu Jan 13 09:39:32 2005 UTC).
Apr  7 12:18:41 [kernel] ALSA device list:
Apr  7 12:18:41 [kernel]   No soundcards found.
Apr  7 12:18:41 [kernel] NET: Registered protocol family 2
Apr  7 12:18:41 [kernel] IP: routing cache hash table of 4096 buckets, 64Kb=
ytes
Apr  7 12:18:41 [kernel] TCP established hash table entries: 262144 (order:=
 10, 4194304 bytes)
Apr  7 12:18:41 [kernel] TCP bind hash table entries: 65536 (order: 8, 1048=
576 bytes)
Apr  7 12:18:41 [kernel] TCP: Hash tables configured (established 262144 bi=
nd 65536)
Apr  7 12:18:41 [kernel] ip_conntrack version 2.1 (4093 buckets, 32744 max)=
 - 312 bytes per conntrack
Apr  7 12:18:41 [kernel] ip_tables: (C) 2000-2002 Netfilter core team
Apr  7 12:18:41 [kernel] Initializing IPsec netlink socket
Apr  7 12:18:41 [kernel] NET: Registered protocol family 1
Apr  7 12:18:41 [kernel] NET: Registered protocol family 17
Apr  7 12:18:41 [kernel] NET: Registered protocol family 15
Apr  7 12:18:41 [kernel] powernow-k8: Power state transitions not supported
                - Last output repeated twice -
Apr  7 12:18:41 [kernel] usb 3-1: new low speed USB device using ohci_hcd a=
nd address 2
Apr  7 12:18:41 [kernel] ReiserFS: sda10: found reiserfs format "3.6" with =
standard journal
Apr  7 12:18:41 [kernel] input: USB HID v1.00 Mouse [Kensington Kensington =
USB Mouse] on usb-0000:00:02.1-1
Apr  7 12:18:41 [kernel] usb 3-2: new full speed USB device using ohci_hcd =
and address 3
Apr  7 12:18:41 [kernel] hub 3-2:1.0: USB hub found
Apr  7 12:18:41 [kernel] hub 3-2:1.0: 4 ports detected
Apr  7 12:18:41 [kernel] usb 1-5.2: new full speed USB device using ehci_hc=
d and address 5
Apr  7 12:18:41 [kernel] usb 3-2.2: new full speed USB device using ohci_hc=
d and address 4
Apr  7 12:18:41 [kernel] ReiserFS: sda10: using ordered data mode
Apr  7 12:18:41 [kernel] ReiserFS: sda10: journal params: device sda10, siz=
e 8192, journal first block 18, max trans len 1024, max batch 900, max comm=
it age 30, max trans age 30
Apr  7 12:18:41 [kernel] ReiserFS: sda10: checking transaction log (sda10)
Apr  7 12:18:41 [kernel] ReiserFS: sda10: Using r5 hash to sort names
Apr  7 12:18:41 [kernel] VFS: Mounted root (reiserfs filesystem) readonly.
Apr  7 12:18:41 [kernel] Freeing unused kernel memory: 220k freed
Apr  7 12:18:41 [kernel] Adding 1004020k swap on /dev/sda5.  Priority:-1 ex=
tents:1
Apr  7 12:18:41 [kernel] st: Version 20041025, fixed bufsize 32768, s/g seg=
s 256
Apr  7 12:18:41 [kernel] Attached scsi generic sg0 at scsi1, channel 0, id =
0, lun 0,  type 0
Apr  7 12:18:41 [kernel] forcedeth.c: Reverse Engineered nForce ethernet dr=
iver. Version 0.31.
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LKLN] enabled at IRQ 21
Apr  7 12:18:41 [kernel] ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 21 (lev=
el, low) -> IRQ 193
Apr  7 12:18:41 [kernel] PCI: Setting latency timer of device 0000:00:05.0 =
to 64
Apr  7 12:18:41 [kernel] eth0: forcedeth.c: subsystem: 015d4:0044 bound to =
0000:00:05.0
Apr  7 12:18:41 [kernel] Linux agpgart interface v0.100 (c) Dave Jones
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LAUI] enabled at IRQ 20
Apr  7 12:18:41 [kernel] ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 20 (lev=
el, low) -> IRQ 201
Apr  7 12:18:41 [kernel] PCI: Setting latency timer of device 0000:00:06.0 =
to 64
Apr  7 12:18:41 [kernel] intel8x0_measure_ac97_clock: measured 50784 usecs
Apr  7 12:18:41 [kernel] intel8x0: clocking to 46877
Apr  7 12:18:41 [kernel] Initializing USB Mass Storage driver...
Apr  7 12:18:41 [kernel] usb-storage: USB Mass Storage device detected
Apr  7 12:18:41 [kernel] usb-storage: -- associate_dev
Apr  7 12:18:41 [kernel] usb-storage: Vendor: 0x04e6, Product: 0x0325, Revi=
sion: 0x0503
Apr  7 12:18:41 [kernel] usb-storage: Interface Subclass: 0x06, Protocol: 0=
x50
Apr  7 12:18:41 [kernel] usb-storage: Vendor: SCM Microsystems Inc.,  Produ=
ct: eUSB ORCA Quad Reader
Apr  7 12:18:41 [kernel] usb-storage: Transport: Bulk
Apr  7 12:18:41 [kernel] usb-storage: Protocol: Transparent SCSI
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_control_msg: rq=FE rqtype=A1=
 value=0000 index=00 len=3D1
Apr  7 12:18:41 [kernel] usb-storage: GetMaxLUN command result is 1, data i=
s 1
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] scsi2 : SCSI emulation for USB Mass Storage devices
Apr  7 12:18:41 [kernel] usbcore: registered new driver usb-storage
Apr  7 12:18:41 [kernel] USB Mass Storage support registered.
Apr  7 12:18:41 [kernel] usb-storage: device found at 5
Apr  7 12:18:41 [kernel] usb-storage: waiting for device to settle before s=
canning
Apr  7 12:18:41 [kernel] ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debia=
n.org>
Apr  7 12:18:41 [kernel] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 18
Apr  7 12:18:41 [kernel] ACPI: PCI interrupt 0000:01:06.0[A] -> GSI 18 (lev=
el, low) -> IRQ 209
Apr  7 12:18:41 [kernel] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[20=
9]  MMIO=3D[ff4ff800-ff4fffff]  Max Packet=3D[2048]
Apr  7 12:18:41 [kernel] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000=
000000016ebc]
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage:  12 00 00 00 24 00
Apr  7 12:18:41 [kernel] usb-storage: Bulk Command S 0x43425355 T 0xfc8 L 3=
6 F 128 Trg 0 LUN 0 CL 6
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 36 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 36/36
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk data transfer result 0x0
Apr  7 12:18:41 [kernel] usb-storage: Attempting to get CSW...
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 12:18:41 [kernel] usb-storage: Bulk Status S 0x53425355 T 0xfc8 R 0 =
Stat 0x0
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x0
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel]   Vendor: eUSB      Model: Compact Flash     Rev: =
5.03
Apr  7 12:18:41 [kernel]   Type:   Direct-Access                      ANSI =
SCSI revision: 02
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr  7 12:18:41 [kernel] usb-storage:  00 00 00 00 00 00
Apr  7 12:18:41 [kernel] usb-storage: Bulk Command S 0x43425355 T 0xfc9 L 0=
 F 0 Trg 0 LUN 0 CL 6
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 12:18:41 [kernel] usb-storage: Attempting to get CSW...
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 12:18:41 [kernel] usb-storage: Bulk Status S 0x53425355 T 0xfc9 R 0 =
Stat 0x1
Apr  7 12:18:41 [kernel] usb-storage: -- transport indicates command failure
Apr  7 12:18:41 [kernel] usb-storage: Issuing auto-REQUEST_SENSE
Apr  7 12:18:41 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x80000fc=
9 L 18 F 128 Trg 0 LUN 0 CL 6
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 18 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 18/18
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk data transfer result 0x0
Apr  7 12:18:41 [kernel] usb-storage: Attempting to get CSW...
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 12:18:41 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x80000fc9=
 R 0 Stat 0x0
Apr  7 12:18:41 [kernel] usb-storage: -- Result from auto-sense is 0
Apr  7 12:18:41 [kernel] usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, A=
SCQ: 0x0
Apr  7 12:18:41 [kernel] usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x2
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr  7 12:18:41 [kernel] usb-storage:  00 00 00 00 00 00
Apr  7 12:18:41 [kernel] usb-storage: Bulk Command S 0x43425355 T 0xfca L 0=
 F 0 Trg 0 LUN 0 CL 6
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 12:18:41 [kernel] usb-storage: Attempting to get CSW...
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 12:18:41 [kernel] usb-storage: Bulk Status S 0x53425355 T 0xfca R 0 =
Stat 0x1
Apr  7 12:18:41 [kernel] usb-storage: -- transport indicates command failure
Apr  7 12:18:41 [kernel] usb-storage: Issuing auto-REQUEST_SENSE
Apr  7 12:18:41 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x80000fc=
a L 18 F 128 Trg 0 LUN 0 CL 6
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 18 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 18/18
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
                - Last output repeated twice -
Apr  7 12:18:41 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 12:18:41 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x80000fca=
 R 0 Stat 0x0
Apr  7 12:18:41 [kernel] usb-storage: -- Result from auto-sense is 0
Apr  7 12:18:41 [kernel] usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, A=
SCQ: 0x0
Apr  7 12:18:41 [kernel] usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x2
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr  7 12:18:41 [kernel] usb-storage:  00 00 00 00 00 00
Apr  7 12:18:41 [kernel] usb-storage: Bulk Command S 0x43425355 T 0xfcb L 0=
 F 0 Trg 0 LUN 0 CL 6
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 12:18:41 [kernel] usb-storage: Attempting to get CSW...
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 12:18:41 [kernel] usb-storage: Bulk Status S 0x53425355 T 0xfcb R 0 =
Stat 0x1
Apr  7 12:18:41 [kernel] usb-storage: -- transport indicates command failure
Apr  7 12:18:41 [kernel] usb-storage: Issuing auto-REQUEST_SENSE
Apr  7 12:18:41 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x80000fc=
b L 18 F 128 Trg 0 LUN 0 CL 6
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 18 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 18/18
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk data transfer result 0x0
Apr  7 12:18:41 [kernel] usb-storage: Attempting to get CSW...
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 12:18:41 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x80000fcb=
 R 0 Stat 0x0
Apr  7 12:18:41 [kernel] usb-storage: -- Result from auto-sense is 0
Apr  7 12:18:41 [kernel] usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, A=
SCQ: 0x0
Apr  7 12:18:41 [kernel] usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x2
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] Attached scsi removable disk sdb at scsi2, channel=
 0, id 0, lun 0
Apr  7 12:18:41 [kernel] Attached scsi generic sg1 at scsi2, channel 0, id =
0, lun 0,  type 0
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Command INQUIRY (6 bytes)
Apr  7 12:18:41 [kernel] usb-storage:  12 20 00 00 24 00
Apr  7 12:18:41 [kernel] usb-storage: Bulk Command S 0x43425355 T 0xfcd L 3=
6 F 128 Trg 0 LUN 1 CL 6
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 36 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 36/36
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk data transfer result 0x0
Apr  7 12:18:41 [kernel] usb-storage: Attempting to get CSW...
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 12:18:41 [kernel] usb-storage: Bulk Status S 0x53425355 T 0xfcd R 0 =
Stat 0x0
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x0
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel]   Vendor: eUSB      Model: SD-MS-SM          Rev: =
5.03
Apr  7 12:18:41 [kernel]   Type:   Direct-Access                      ANSI =
SCSI revision: 02
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr  7 12:18:41 [kernel] usb-storage:  00 20 00 00 00 00
Apr  7 12:18:41 [kernel] usb-storage: Bulk Command S 0x43425355 T 0xfcf L 0=
 F 0 Trg 0 LUN 1 CL 6
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 12:18:41 [kernel] usb-storage: Attempting to get CSW...
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: -- transport indicates command failure
Apr  7 12:18:41 [kernel] usb-storage: Issuing auto-REQUEST_SENSE
Apr  7 12:18:41 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x80000fc=
f L 18 F 128 Trg 0 LUN 1 CL 6
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 18 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 18/18
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk data transfer result 0x0
Apr  7 12:18:41 [kernel] usb-storage: Attempting to get CSW...
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 12:18:41 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x80000fcf=
 R 0 Stat 0x0
Apr  7 12:18:41 [kernel] usb-storage: -- Result from auto-sense is 0
Apr  7 12:18:41 [kernel] usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, A=
SCQ: 0x0
Apr  7 12:18:41 [kernel] usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x2
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr  7 12:18:41 [kernel] usb-storage:  00 20 00 00 00 00
Apr  7 12:18:41 [kernel] usb-storage: Bulk Command S 0x43425355 T 0xfd0 L 0=
 F 0 Trg 0 LUN 1 CL 6
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 12:18:41 [kernel] usb-storage: Attempting to get CSW...
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 12:18:41 [kernel] usb-storage: Bulk Status S 0x53425355 T 0xfd0 R 0 =
Stat 0x1
Apr  7 12:18:41 [kernel] usb-storage: -- transport indicates command failure
Apr  7 12:18:41 [kernel] usb-storage: Issuing auto-REQUEST_SENSE
Apr  7 12:18:41 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x80000fd=
0 L 18 F 128 Trg 0 LUN 1 CL 6
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 18 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 18/18
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk data transfer result 0x0
Apr  7 12:18:41 [kernel] usb-storage: Attempting to get CSW...
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 12:18:41 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x80000fd0=
 R 0 Stat 0x0
Apr  7 12:18:41 [kernel] usb-storage: -- Result from auto-sense is 0
Apr  7 12:18:41 [kernel] usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, A=
SCQ: 0x0
Apr  7 12:18:41 [kernel] usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x2
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr  7 12:18:41 [kernel] usb-storage:  00 20 00 00 00 00
Apr  7 12:18:41 [kernel] usb-storage: Bulk Command S 0x43425355 T 0xfd2 L 0=
 F 0 Trg 0 LUN 1 CL 6
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 12:18:41 [kernel] usb-storage: Attempting to get CSW...
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 12:18:41 [kernel] usb-storage: Bulk Status S 0x53425355 T 0xfd2 R 0 =
Stat 0x1
Apr  7 12:18:41 [kernel] usb-storage: -- transport indicates command failure
Apr  7 12:18:41 [kernel] usb-storage: Issuing auto-REQUEST_SENSE
Apr  7 12:18:41 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x80000fd=
2 L 18 F 128 Trg 0 LUN 1 CL 6
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 18 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk data transfer result 0x0
Apr  7 12:18:41 [kernel] usb-storage: Attempting to get CSW...
Apr  7 12:18:41 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 12:18:41 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 12:18:41 [kernel] usb-storage: -- transfer complete
Apr  7 12:18:41 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 12:18:41 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x80000fd2=
 R 0 Stat 0x0
Apr  7 12:18:41 [kernel] usb-storage: -- Result from auto-sense is 0
Apr  7 12:18:41 [kernel] usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, A=
SCQ: 0x0
Apr  7 12:18:41 [kernel] usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x2
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] Attached scsi removable disk sdc at scsi2, channel=
 0, id 0, lun 1
Apr  7 12:18:41 [kernel] Attached scsi generic sg2 at scsi2, channel 0, id =
0, lun 1,  type 0
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Bad LUN (0:2)
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Bad target number (1:0)
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Bad target number (2:0)
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Bad target number (3:0)
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Bad target number (4:0)
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Bad target number (5:0)
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Bad target number (6:0)
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] usb-storage: queuecommand called
Apr  7 12:18:41 [kernel] usb-storage: *** thread awakened.
Apr  7 12:18:41 [kernel] usb-storage: Bad target number (7:0)
Apr  7 12:18:41 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 12:18:41 [kernel] usb-storage: *** thread sleeping.
Apr  7 12:18:41 [kernel] usb-storage: device scan complete
Apr  7 12:18:41 [kernel] ReiserFS: sda7: found reiserfs format "3.6" with s=
tandard journal
Apr  7 12:18:41 [kernel] ReiserFS: sda7: using ordered data mode
Apr  7 12:18:41 [kernel] ReiserFS: sda7: journal params: device sda7, size =
8192, journal first block 18, max trans len 1024, max batch 900, max commit=
 age 30, max trans age 30
Apr  7 12:18:41 [kernel] ReiserFS: sda7: checking transaction log (sda7)
Apr  7 12:18:41 [kernel] ReiserFS: sda7: Using r5 hash to sort names
Apr  7 12:18:41 [kernel] ReiserFS: sda8: found reiserfs format "3.6" with s=
tandard journal
Apr  7 12:18:41 [kernel] ReiserFS: sda8: using ordered data mode
Apr  7 12:18:41 [kernel] ReiserFS: sda8: journal params: device sda8, size =
8192, journal first block 18, max trans len 1024, max batch 900, max commit=
 age 30, max trans age 30
Apr  7 12:18:41 [kernel] ReiserFS: sda8: checking transaction log (sda8)
Apr  7 12:18:41 [kernel] ReiserFS: sda8: Using r5 hash to sort names
Apr  7 12:18:41 [kernel] ReiserFS: sda9: found reiserfs format "3.6" with s=
tandard journal
Apr  7 12:18:41 [kernel] ReiserFS: sda9: using ordered data mode
Apr  7 12:18:41 [kernel] ReiserFS: sda9: journal params: device sda9, size =
8192, journal first block 18, max trans len 1024, max batch 900, max commit=
 age 30, max trans age 30
Apr  7 12:18:41 [kernel] ReiserFS: sda9: checking transaction log (sda9)
Apr  7 12:18:41 [kernel] ReiserFS: sda9: Using r5 hash to sort names
Apr  7 12:18:41 [kernel] ReiserFS: sda11: found reiserfs format "3.6" with =
standard journal
Apr  7 12:18:41 [kernel] ReiserFS: sda11: using ordered data mode
Apr  7 12:18:41 [kernel] ReiserFS: sda11: journal params: device sda11, siz=
e 8192, journal first block 18, max trans len 1024, max batch 900, max comm=
it age 30, max trans age 30
Apr  7 12:18:41 [kernel] ReiserFS: sda11: checking transaction log (sda11)
Apr  7 12:18:41 [kernel] ReiserFS: sda11: Using r5 hash to sort names
Apr  7 12:21:47 [kernel] Unable to handle kernel NULL pointer dereference a=
t 0000000000000000 RIP:=20
Apr  7 12:21:47 [kernel] <ffffffff802dd8ab>{__memcpy+11}
Apr  7 12:21:47 [kernel] PGD e1e2067 PUD e199067 PMD 0=20
Apr  7 12:21:47 [kernel] CPU 1=20
Apr  7 12:21:47 [kernel] Modules linked in: ohci1394 ieee1394 usb_storage s=
nd_rtctimer snd_ioctl32 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_p=
age_alloc agpgart forcedeth sg sr_mod st
Apr  7 12:21:47 [kernel] Pid: 7239, comm: artsd Not tainted 2.6.11-gentoo-r5
Apr  7 12:21:47 [kernel] RIP: 0010:[<ffffffff802dd8ab>] <ffffffff802dd8ab>{=
__memcpy+11}
Apr  7 12:21:47 [kernel] RSP: 0018:ffff81000de95a70  EFLAGS: 00010246
Apr  7 12:21:47 [kernel] RAX: 0000000000000000 RBX: ffff81000e1f29c0 RCX: 0=
000000000000004
Apr  7 12:21:47 [kernel] RDX: 0000000000000000 RSI: ffff81000de95ae8 RDI: 0=
000000000000000
Apr  7 12:21:47 [kernel] RBP: ffff81000e1f29c0 R08: 0000000000000000 R09: 3=
03d5645442c303d
Apr  7 12:21:47 [kernel] R10: 0000000000000001 R11: 0000000000000246 R12: 0=
0000000ffffffea
Apr  7 12:21:47 [kernel] R13: 00007fffffffe490 R14: ffff81000de95b08 R15: 0=
00000000057fd50
Apr  7 12:21:47 [kernel] FS:  00002aaaacdefd10(0000) GS:ffffffff805f3f40(00=
00) knlGS:0000000000000000
Apr  7 12:21:47 [kernel] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Apr  7 12:21:47 [kernel] CR2: 0000000000000000 CR3: 000000000e1ae000 CR4: 0=
0000000000006e0
Apr  7 12:21:47 [kernel] Process artsd (pid: 7239, threadinfo ffff81000de94=
000, task ffff81003e7ae130)
Apr  7 12:21:47 [kernel] Stack: ffffffff8802cbcf ffff81003ea86d28 ffffffff8=
802da6d 0000000000000001=20
Apr  7 12:21:47 [kernel]        ffff81000de95c98 ffff81003e8b8018 000000000=
00001e0 0000000100000000=20
Apr  7 12:21:47 [kernel]        ffff81000de95c90 0000000100000001=20
Apr  7 12:21:47 [kernel] Call Trace:<ffffffff8802cbcf>{:snd_timer:snd_timer=
_user_append_to_tqueue+47}=20
Apr  7 12:21:47 [kernel]        <ffffffff8802da6d>{:snd_timer:snd_timer_use=
r_ioctl+2813}=20
Apr  7 12:21:47 [kernel]        <ffffffff801567b4>{buffered_rmqueue+516} <f=
fffffff80162864>{do_wp_page+996}=20
Apr  7 12:21:47 [kernel]        <ffffffff80163891>{handle_mm_fault+1169} <f=
fffffff8802ce88>{:snd_timer:snd_timer_user_open+104}=20
Apr  7 12:21:47 [kernel]        <ffffffff802db2cd>{__up_read+29} <ffffffff8=
011d2bc>{do_page_fault+1276}=20
Apr  7 12:21:47 [kernel]        <ffffffff8017e081>{chrdev_open+401} <ffffff=
ff80188144>{do_ioctl+116}=20
Apr  7 12:21:47 [kernel]        <ffffffff801884ab>{vfs_ioctl+827} <ffffffff=
8019c398>{inotify_dentry_parent_queue_event+216}=20
Apr  7 12:21:47 [kernel]        <ffffffff8018853a>{sys_ioctl+106} <ffffffff=
8010d4ca>{system_call+126}=20
Apr  7 12:21:47 [kernel]       =20
Apr  7 12:21:47 [kernel] Code: f3 48 a5 89 d1 f3 a4 c3 66 66 66 90 66 66 66=
 90 66 66 66 90=20
Apr  7 12:21:47 [kernel] RIP <ffffffff802dd8ab>{__memcpy+11} RSP <ffff81000=
de95a70>
Apr  7 15:29:33 [kernel] eth0: too many iterations (6) in nv_nic_irq.
Apr  7 15:32:44 [kernel]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (r=
eserved)
Apr  7 15:32:44 [kernel]  BIOS-e820: 00000000000e6000 - 0000000000100000 (r=
eserved)
Apr  7 15:32:44 [kernel]  BIOS-e820: 0000000000100000 - 000000003ff40000 (u=
sable)
Apr  7 15:32:44 [kernel]  BIOS-e820: 000000003ff40000 - 000000003ff50000 (A=
CPI data)
Apr  7 15:32:44 [kernel]  BIOS-e820: 000000003ff50000 - 0000000040000000 (A=
CPI NVS)
Apr  7 15:32:44 [kernel]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (r=
eserved)
Apr  7 15:32:44 [kernel]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (r=
eserved)
Apr  7 15:32:44 [kernel]  BIOS-e820: 00000000ff7c0000 - 0000000100000000 (r=
eserved)
Apr  7 15:32:44 [kernel] ACPI: RSDP (v000 ACPIAM                           =
     ) @ 0x00000000000f6d00
Apr  7 15:32:44 [kernel] ACPI: RSDT (v001 A M I  OEMRSDT  0x03000516 MSFT 0=
x00000097) @ 0x000000003ff40000
Apr  7 15:32:44 [kernel] ACPI: FADT (v002 A M I  OEMFACP  0x03000516 MSFT 0=
x00000097) @ 0x000000003ff40200
Apr  7 15:32:44 [kernel] ACPI: MADT (v001 A M I  OEMAPIC  0x03000516 MSFT 0=
x00000097) @ 0x000000003ff40390
Apr  7 15:32:44 [kernel] ACPI: OEMB (v001 A M I  OEMBIOS  0x03000516 MSFT 0=
x00000097) @ 0x000000003ff50040
Apr  7 15:32:44 [kernel] ACPI: DSDT (v001  ZMDPV ZMDPV111 0x00000111 INTL 0=
x02002026) @ 0x0000000000000000
Apr  7 15:32:44 [kernel] Scanning NUMA topology in Northbridge 24
Apr  7 15:32:44 [kernel] Number of nodes 2
Apr  7 15:32:44 [kernel] Node 0 MemBase 0000000000000000 Limit 000000003ff4=
0000
Apr  7 15:32:44 [kernel] Skipping disabled node 1
Apr  7 15:32:44 [kernel] Using node hash shift of 24
Apr  7 15:32:44 [kernel] Bootmem setup node 0 0000000000000000-000000003ff4=
0000
Apr  7 15:32:44 [kernel] On node 0 totalpages: 261952
Apr  7 15:32:44 [kernel]   DMA zone: 4096 pages, LIFO batch:1
Apr  7 15:32:44 [kernel]   Normal zone: 257856 pages, LIFO batch:16
Apr  7 15:32:44 [kernel]   HighMem zone: 0 pages, LIFO batch:1
Apr  7 15:32:44 [kernel] Nvidia board detected. Ignoring ACPI timer overrid=
e.
Apr  7 15:32:44 [kernel] ACPI: Local APIC address 0xfee00000
Apr  7 15:32:44 [kernel] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Apr  7 15:32:44 [kernel] Processor #0 15:5 APIC version 16
Apr  7 15:32:44 [kernel] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Apr  7 15:32:44 [kernel] Processor #1 15:5 APIC version 16
Apr  7 15:32:44 [kernel] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
Apr  7 15:32:44 [kernel] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
Apr  7 15:32:44 [kernel] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_bas=
e[0])
Apr  7 15:32:44 [kernel] IOAPIC[0]: apic_id 2, version 17, address 0xfec000=
00, GSI 0-23
Apr  7 15:32:44 [kernel] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 df=
l dfl)
Apr  7 15:32:44 [kernel] ACPI: BIOS IRQ0 pin2 override ignored.
Apr  7 15:32:44 [kernel] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 hi=
gh level)
Apr  7 15:32:44 [kernel] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 =
high edge)
Apr  7 15:32:44 [kernel] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 =
high edge)
Apr  7 15:32:44 [kernel] ACPI: IRQ9 used by override.
Apr  7 15:32:44 [kernel] ACPI: IRQ14 used by override.
Apr  7 15:32:44 [kernel] ACPI: IRQ15 used by override.
Apr  7 15:32:44 [kernel] Setting APIC routing to flat
Apr  7 15:32:44 [kernel] Using ACPI (MADT) for SMP configuration information
Apr  7 15:32:44 [kernel] Built 1 zonelists
Apr  7 15:32:44 [kernel] Kernel command line: root=3D/dev/sda10 idle=3Dpoll=
 console=3Dtty0
Apr  7 15:32:44 [kernel] using polling idle threads.
Apr  7 15:32:44 [kernel] Initializing CPU#0
Apr  7 15:32:44 [kernel] PID hash table entries: 4096 (order: 12, 131072 by=
tes)
Apr  7 15:32:44 [kernel] time.c: Using 1.193182 MHz PIT timer.
Apr  7 15:32:44 [kernel] time.c: Detected 1400.017 MHz processor.
Apr  7 15:32:44 [kernel] Console: colour VGA+ 80x25
Apr  7 15:32:44 [kernel] Dentry cache hash table entries: 262144 (order: 9,=
 2097152 bytes)
Apr  7 15:32:44 [kernel] Inode-cache hash table entries: 131072 (order: 8, =
1048576 bytes)
Apr  7 15:32:44 [kernel] Memory: 1024120k/1047808k available (3432k kernel =
code, 0k reserved, 1327k data, 220k init)
Apr  7 15:32:44 [kernel] Calibrating delay loop... 2768.89 BogoMIPS (lpj=13=
84448)
Apr  7 15:32:44 [kernel] Security Framework v1.0.0 initialized
Apr  7 15:32:44 [kernel] Capability LSM initialized
Apr  7 15:32:44 [kernel] Mount-cache hash table entries: 256 (order: 0, 409=
6 bytes)
Apr  7 15:32:44 [kernel] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K =
(64 bytes/line)
Apr  7 15:32:44 [kernel] CPU: L2 Cache: 1024K (64 bytes/line)
Apr  7 15:32:44 [kernel] CPU 0(1) -> Node 0
Apr  7 15:32:44 [kernel] Using local APIC NMI watchdog using perfctr0
Apr  7 15:32:44 [kernel] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K =
(64 bytes/line)
Apr  7 15:32:44 [kernel] CPU: L2 Cache: 1024K (64 bytes/line)
Apr  7 15:32:44 [kernel] CPU 0(1) -> Node 0
Apr  7 15:32:44 [kernel] CPU0: AMD Opteron(tm) Processor 240 stepping 08
Apr  7 15:32:44 [kernel] per-CPU timeslice cutoff: 1023.85 usecs.
Apr  7 15:32:44 [kernel] task migration cache decay timeout: 2 msecs.
Apr  7 15:32:44 [kernel] Booting processor 1/1 rip 6000 rsp ffff810002197f58
Apr  7 15:32:44 [kernel] Initializing CPU#1
Apr  7 15:32:44 [kernel] Calibrating delay loop... <7>spurious 8259A interr=
upt: IRQ7.
Apr  7 15:32:44 [kernel] 2760.70 BogoMIPS (lpj=1380352)
Apr  7 15:32:44 [kernel] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K =
(64 bytes/line)
Apr  7 15:32:44 [kernel] CPU: L2 Cache: 1024K (64 bytes/line)
Apr  7 15:32:44 [kernel] CPU 1(1) -> Node 0
Apr  7 15:32:44 [kernel] AMD Opteron(tm) Processor 240 stepping 08
Apr  7 15:32:44 [kernel] Total of 2 processors activated (5529.60 BogoMIPS).
Apr  7 15:32:44 [kernel] Using local APIC timer interrupts.
Apr  7 15:32:44 [kernel] Detected 12.500 MHz APIC timer.
Apr  7 15:32:44 [kernel] time.c: Using PIT/TSC based timekeeping.
Apr  7 15:32:44 [kernel] Brought up 2 CPUs
Apr  7 15:32:44 [kernel] CPU0 attaching sched-domain:
Apr  7 15:32:44 [kernel]  domain 0: span 1
Apr  7 15:32:44 [kernel]   groups: 1
Apr  7 15:32:44 [kernel]   domain 1: span 3
Apr  7 15:32:44 [kernel]    groups: 1 2
Apr  7 15:32:44 [kernel]    domain 2: span 3
Apr  7 15:32:44 [kernel]     groups: 3
Apr  7 15:32:44 [kernel] CPU1 attaching sched-domain:
Apr  7 15:32:44 [kernel]  domain 0: span 2
Apr  7 15:32:44 [kernel]   groups: 2
Apr  7 15:32:44 [kernel]   domain 1: span 3
Apr  7 15:32:44 [kernel]    groups: 2 1
Apr  7 15:32:44 [kernel]    domain 2: span 3
Apr  7 15:32:44 [kernel]     groups: 3
Apr  7 15:32:44 [kernel] NET: Registered protocol family 16
Apr  7 15:32:44 [kernel] PCI: Using configuration type 1
Apr  7 15:32:44 [kernel] mtrr: v2.0 (20020519)
Apr  7 15:32:44 [kernel] ACPI: Subsystem revision 20050211
Apr  7 15:32:44 [kernel] ACPI: Interpreter enabled
Apr  7 15:32:44 [kernel] ACPI: Using IOAPIC for interrupt routing
Apr  7 15:32:44 [kernel] ACPI: PCI Root Bridge [PCI0] (00:00)
Apr  7 15:32:44 [kernel] PCI: Probing PCI hardware (bus 00)
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1=
._PRT]
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19)=
 *0, disabled.
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19)=
 *9
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19)=
 *11
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19)=
 *0, disabled.
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LNKE] (IRQs 16 17 18 19)=
 *11
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22) *4
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22) *7
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22) *3
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LKLN] (IRQs 20 21 22) *5
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LAUI] (IRQs 20 21 22) *9
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LKMO] (IRQs 20 21 22) *0=
, disabled.
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LKSM] (IRQs 20 21 22) *11
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *0
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LTIE] (IRQs 20 21 22) *0=
, disabled.
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22) *14
Apr  7 15:32:44 [kernel] Linux Plug and Play Support v0.97 (c) Adam Belay
Apr  7 15:32:44 [kernel] pnp: PnP ACPI init
Apr  7 15:32:44 [kernel] pnp: PnP ACPI: found 11 devices
Apr  7 15:32:44 [kernel] SCSI subsystem initialized
Apr  7 15:32:44 [kernel] usbcore: registered new driver usbfs
Apr  7 15:32:44 [kernel] usbcore: registered new driver hub
Apr  7 15:32:44 [kernel] PCI: Using ACPI for IRQ routing
Apr  7 15:32:44 [kernel] ** PCI interrupts are no longer routed automatical=
ly.  If this
Apr  7 15:32:44 [kernel] ** causes a device to stop working, it is probably=
 because the
Apr  7 15:32:44 [kernel] ** driver failed to call pci_enable_device().  As =
a temporary
Apr  7 15:32:44 [kernel] ** workaround, the "pci=3Drouteirq" argument resto=
res the old
Apr  7 15:32:44 [kernel] ** behavior.  If this argument makes the device wo=
rk again,
Apr  7 15:32:44 [kernel] ** please email the output of "lspci" to bjorn.hel=
gaas@hp.com
Apr  7 15:32:44 [kernel] ** so I can fix the driver.
Apr  7 15:32:44 [kernel] pnp: 00:09: ioport range 0x680-0x6ff has been rese=
rved
Apr  7 15:32:44 [kernel] pnp: 00:09: ioport range 0x295-0x296 has been rese=
rved
Apr  7 15:32:44 [kernel] IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 1=
3:02:28 ak Exp $
Apr  7 15:32:44 [kernel] Total HugeTLB memory allocated, 0
Apr  7 15:32:44 [kernel] inotify device minorc
Apr  7 15:32:44 [kernel] devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro=
.au)
Apr  7 15:32:44 [kernel] devfs: boot_options: 0x0
Apr  7 15:32:44 [kernel] NTFS driver 2.1.22 [Flags: R/W].
Apr  7 15:32:44 [kernel] SGI XFS with large block/inode numbers, no debug e=
nabled
Apr  7 15:32:44 [kernel] Initializing Cryptographic API
Apr  7 15:32:44 [kernel] Real Time Clock Driver v1.12
Apr  7 15:32:44 [kernel] Hangcheck: starting hangcheck timer 0.5.0 (tick is=
 180 seconds, margin is 60 seconds).
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 19
Apr  7 15:32:44 [kernel] ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (lev=
el, low) -> IRQ 177
Apr  7 15:32:44 [kernel] radeonfb: Found Intel x86 BIOS ROM Image
Apr  7 15:32:44 [kernel] radeonfb: Retreived PLL infos from BIOS
Apr  7 15:32:44 [kernel] radeonfb: Reference'.00 MHz (RefDiv=12) Memory%0.0=
0 Mhz, System 0.00 MHz
Apr  7 15:32:44 [kernel] radeonfb: PLL min 20000 max 40000
Apr  7 15:32:44 [kernel] radeonfb: Monitor 1 type DFP found
Apr  7 15:32:44 [kernel] radeonfb: EDID probed
Apr  7 15:32:44 [kernel] radeonfb: Monitor 2 type no found
Apr  7 15:32:44 [kernel] Console: switching to colour frame buffer device 1=
60x64
Apr  7 15:32:44 [kernel] radeonfb (0000:02:00.0): ATI Radeon AS=20
Apr  7 15:32:44 [kernel] ACPI: Power Button (FF) [PWRF]
Apr  7 15:32:44 [kernel] ACPI: Processor [CPU1] (supports 8 throttling stat=
es)
Apr  7 15:32:44 [kernel] serio: i8042 AUX port at 0x60,0x64 irq 12
Apr  7 15:32:44 [kernel] serio: i8042 KBD port at 0x60,0x64 irq 1
Apr  7 15:32:44 [kernel] Serial: 8250/16550 driver $Revision: 1.90 $ 8 port=
s, IRQ sharing disabled
Apr  7 15:32:44 [kernel] mice: PS/2 mouse device common for all mice
Apr  7 15:32:44 [kernel] input: AT Translated Set 2 keyboard on isa0060/ser=
io0
Apr  7 15:32:44 [kernel] input: PS/2 Generic Mouse on isa0060/serio1
Apr  7 15:32:44 [kernel] input: PC Speaker
Apr  7 15:32:44 [kernel] io scheduler noop registered
Apr  7 15:32:44 [kernel] io scheduler anticipatory registered
Apr  7 15:32:44 [kernel] io scheduler deadline registered
Apr  7 15:32:44 [kernel] io scheduler cfq registered
Apr  7 15:32:44 [kernel] Floppy drive(s): fd0 is 1.44M
Apr  7 15:32:44 [kernel] loop: loaded (max 8 devices)
Apr  7 15:32:44 [kernel] netconsole: not configured, aborting
Apr  7 15:32:44 [kernel] Uniform Multi-Platform E-IDE driver Revision: 7.00=
alpha2
Apr  7 15:32:44 [kernel] ide: Assuming 33MHz system bus speed for PIO modes=
; override with idebus=3Dxx
Apr  7 15:32:44 [kernel] NFORCE3-250: IDE controller at PCI slot 0000:00:08=
.0
Apr  7 15:32:44 [kernel] NFORCE3-250: chipset revision 162
Apr  7 15:32:44 [kernel] NFORCE3-250: not 100% native mode: will probe irqs=
 later
Apr  7 15:32:44 [kernel] NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 control=
ler
Apr  7 15:32:44 [kernel]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: =
hda:pio, hdb:pio
Apr  7 15:32:44 [kernel]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: =
hdc:pio, hdd:pio
Apr  7 15:32:44 [kernel] Probing IDE interface ide0...
Apr  7 15:32:44 [kernel] Probing IDE interface ide1...
Apr  7 15:32:44 [kernel] hdc: HL-DT-ST DVDRAM GSA-4163B, ATAPI CD/DVD-ROM d=
rive
Apr  7 15:32:44 [kernel] ide1 at 0x170-0x177,0x376 on irq 15
Apr  7 15:32:44 [kernel] Probing IDE interface ide0...
Apr  7 15:32:44 [kernel] Probing IDE interface ide2...
Apr  7 15:32:44 [kernel] Probing IDE interface ide3...
Apr  7 15:32:44 [kernel] Probing IDE interface ide4...
Apr  7 15:32:44 [kernel] Probing IDE interface ide5...
Apr  7 15:32:44 [kernel] hdc: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 20=
48kB Cache, UDMA(33)
Apr  7 15:32:44 [kernel] Uniform CD-ROM driver Revision: 3.20
Apr  7 15:32:44 [kernel] libata version 1.10 loaded.
Apr  7 15:32:44 [kernel] sata_nv version 0.6
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LTID] BIOS reported IRQ =
0, using IRQ 22
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
Apr  7 15:32:44 [kernel] ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 22 (lev=
el, low) -> IRQ 185
Apr  7 15:32:44 [kernel] PCI: Setting latency timer of device 0000:00:0a.0 =
to 64
Apr  7 15:32:44 [kernel] ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdm=
a 0xDC00 irq 185
Apr  7 15:32:44 [kernel] ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdm=
a 0xDC08 irq 185
Apr  7 15:32:44 [kernel] ata1: no device found (phy stat 00000000)
Apr  7 15:32:44 [kernel] scsi0 : sata_nv
Apr  7 15:32:44 [kernel] ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85=
:7c69 86:3a01 87:4003 88:047f
Apr  7 15:32:44 [kernel] ata2: dev 0 ATA, max UDMA/133, 240121728 sectors:
Apr  7 15:32:44 [kernel] nv_sata: Primary device removed
Apr  7 15:32:44 [kernel] nv_sata: Secondary device added
Apr  7 15:32:44 [kernel] nv_sata: Secondary device removed
Apr  7 15:32:44 [kernel] ata2: dev 0 configured for UDMA/133
Apr  7 15:32:44 [kernel] scsi1 : sata_nv
Apr  7 15:32:44 [kernel]   Vendor: ATA       Model: Maxtor 6Y120M0    Rev: =
YAR5
Apr  7 15:32:44 [kernel]   Type:   Direct-Access                      ANSI =
SCSI revision: 05
Apr  7 15:32:44 [kernel] SCSI device sda: 240121728 512-byte hdwr sectors (=
122942 MB)
Apr  7 15:32:44 [kernel] SCSI device sda: drive cache: write back
Apr  7 15:32:44 [kernel] SCSI device sda: 240121728 512-byte hdwr sectors (=
122942 MB)
Apr  7 15:32:44 [kernel] SCSI device sda: drive cache: write back
Apr  7 15:32:44 [kernel]  /dev/scsi/host1/bus0/target0/lun0: p1 p2 < p5 p6 =
p7 p8 p9 p10 p11 p12 >
Apr  7 15:32:44 [kernel] Attached scsi disk sda at scsi1, channel 0, id 0, =
lun 0
Apr  7 15:32:44 [kernel] Fusion MPT base driver 3.01.18
Apr  7 15:32:44 [kernel] Copyright (c) 1999-2004 LSI Logic Corporation
Apr  7 15:32:44 [kernel] Fusion MPT SCSI Host driver 3.01.18
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 21
Apr  7 15:32:44 [kernel] ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 21 (lev=
el, low) -> IRQ 193
Apr  7 15:32:44 [kernel] ehci_hcd 0000:00:02.2: PCI device 10de:00e8 (nVidi=
a Corporation)
Apr  7 15:32:44 [kernel] PCI: Setting latency timer of device 0000:00:02.2 =
to 64
Apr  7 15:32:44 [kernel] ehci_hcd 0000:00:02.2: irq 193, pci mem 0xff6fdc00
Apr  7 15:32:44 [kernel] ehci_hcd 0000:00:02.2: new USB bus registered, ass=
igned bus number 1
Apr  7 15:32:44 [kernel] PCI: cache line size of 64 is not supported by dev=
ice 0000:00:02.2
Apr  7 15:32:44 [kernel] ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1=
.00, driver 10 Dec 2004
Apr  7 15:32:44 [kernel] hub 1-0:1.0: USB hub found
Apr  7 15:32:44 [kernel] hub 1-0:1.0: 8 ports detected
Apr  7 15:32:44 [kernel] ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controll=
er (OHCI) Driver (PCI)
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 20
Apr  7 15:32:44 [kernel] ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 20 (lev=
el, low) -> IRQ 201
Apr  7 15:32:44 [kernel] ohci_hcd 0000:00:02.0: PCI device 10de:00e7 (nVidi=
a Corporation)
Apr  7 15:32:44 [kernel] PCI: Setting latency timer of device 0000:00:02.0 =
to 64
Apr  7 15:32:44 [kernel] ohci_hcd 0000:00:02.0: irq 201, pci mem 0xff6fb000
Apr  7 15:32:44 [kernel] ohci_hcd 0000:00:02.0: new USB bus registered, ass=
igned bus number 2
Apr  7 15:32:44 [kernel] hub 2-0:1.0: USB hub found
Apr  7 15:32:44 [kernel] hub 2-0:1.0: 4 ports detected
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 22
Apr  7 15:32:44 [kernel] ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 22 (lev=
el, low) -> IRQ 185
Apr  7 15:32:44 [kernel] ohci_hcd 0000:00:02.1: PCI device 10de:00e7 (nVidi=
a Corporation)
Apr  7 15:32:44 [kernel] PCI: Setting latency timer of device 0000:00:02.1 =
to 64
Apr  7 15:32:44 [kernel] ohci_hcd 0000:00:02.1: irq 185, pci mem 0xff6fc000
Apr  7 15:32:44 [kernel] ohci_hcd 0000:00:02.1: new USB bus registered, ass=
igned bus number 3
Apr  7 15:32:44 [kernel] hub 3-0:1.0: USB hub found
Apr  7 15:32:44 [kernel] hub 3-0:1.0: 4 ports detected
Apr  7 15:32:44 [kernel] usb 1-5: new high speed USB device using ehci_hcd =
and address 4
Apr  7 15:32:44 [kernel] hub 1-5:1.0: USB hub found
Apr  7 15:32:44 [kernel] usbcore: registered new driver usbhid
Apr  7 15:32:44 [kernel] drivers/usb/input/hid-core.c: v2.0:USB HID core dr=
iver
Apr  7 15:32:44 [kernel] i2c /dev entries driver
Apr  7 15:32:44 [kernel] Advanced Linux Sound Architecture Driver Version 1=
.0.8 (Thu Jan 13 09:39:32 2005 UTC).
Apr  7 15:32:44 [kernel] ALSA device list:
Apr  7 15:32:44 [kernel]   No soundcards found.
Apr  7 15:32:44 [kernel] NET: Registered protocol family 2
Apr  7 15:32:44 [kernel] IP: routing cache hash table of 4096 buckets, 64Kb=
ytes
Apr  7 15:32:44 [kernel] TCP established hash table entries: 262144 (order:=
 10, 4194304 bytes)
Apr  7 15:32:44 [kernel] TCP bind hash table entries: 65536 (order: 8, 1048=
576 bytes)
Apr  7 15:32:44 [kernel] TCP: Hash tables configured (established 262144 bi=
nd 65536)
Apr  7 15:32:44 [kernel] ip_conntrack version 2.1 (4093 buckets, 32744 max)=
 - 312 bytes per conntrack
Apr  7 15:32:44 [kernel] ip_tables: (C) 2000-2002 Netfilter core team
Apr  7 15:32:44 [kernel] Initializing IPsec netlink socket
Apr  7 15:32:44 [kernel] NET: Registered protocol family 1
Apr  7 15:32:44 [kernel] NET: Registered protocol family 17
Apr  7 15:32:44 [kernel] NET: Registered protocol family 15
Apr  7 15:32:44 [kernel] powernow-k8: Power state transitions not supported
                - Last output repeated twice -
Apr  7 15:32:44 [kernel] ReiserFS: sda10: found reiserfs format "3.6" with =
standard journal
Apr  7 15:32:44 [kernel] usb 3-1: new low speed USB device using ohci_hcd a=
nd address 2
Apr  7 15:32:44 [kernel] input: USB HID v1.00 Mouse [Kensington Kensington =
USB Mouse] on usb-0000:00:02.1-1
Apr  7 15:32:44 [kernel] usb 3-2: new full speed USB device using ohci_hcd =
and address 3
Apr  7 15:32:44 [kernel] hub 3-2:1.0: USB hub found
Apr  7 15:32:44 [kernel] hub 3-2:1.0: 4 ports detected
Apr  7 15:32:44 [kernel] usb 1-5.2: new full speed USB device using ehci_hc=
d and address 5
Apr  7 15:32:44 [kernel] usb 1-5.2: khubd timed out on ep0in
Apr  7 15:32:44 [kernel] usb 3-2.2: new full speed USB device using ohci_hc=
d and address 4
Apr  7 15:32:44 [kernel] ReiserFS: sda10: using ordered data mode
Apr  7 15:32:44 [kernel] ReiserFS: sda10: journal params: device sda10, siz=
e 8192, journal first block 18, max trans len 1024, max batch 900, max comm=
it age 30, max trans age 30
Apr  7 15:32:44 [kernel] ReiserFS: sda10: checking transaction log (sda10)
Apr  7 15:32:44 [kernel] ReiserFS: sda10: Using r5 hash to sort names
Apr  7 15:32:44 [kernel] VFS: Mounted root (reiserfs filesystem) readonly.
Apr  7 15:32:44 [kernel] Freeing unused kernel memory: 220k freed
Apr  7 15:32:44 [kernel] Adding 1004020k swap on /dev/sda5.  Priority:-1 ex=
tents:1
Apr  7 15:32:44 [kernel] st: Version 20041025, fixed bufsize 32768, s/g seg=
s 256
Apr  7 15:32:44 [kernel] Attached scsi generic sg0 at scsi1, channel 0, id =
0, lun 0,  type 0
Apr  7 15:32:44 [kernel] forcedeth.c: Reverse Engineered nForce ethernet dr=
iver. Version 0.31.
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LKLN] enabled at IRQ 21
Apr  7 15:32:44 [kernel] ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 21 (lev=
el, low) -> IRQ 193
Apr  7 15:32:44 [kernel] PCI: Setting latency timer of device 0000:00:05.0 =
to 64
Apr  7 15:32:44 [kernel] eth0: forcedeth.c: subsystem: 015d4:0044 bound to =
0000:00:05.0
Apr  7 15:32:44 [kernel] Linux agpgart interface v0.100 (c) Dave Jones
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LAUI] enabled at IRQ 20
Apr  7 15:32:44 [kernel] ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 20 (lev=
el, low) -> IRQ 201
Apr  7 15:32:44 [kernel] PCI: Setting latency timer of device 0000:00:06.0 =
to 64
Apr  7 15:32:44 [kernel] intel8x0_measure_ac97_clock: measured 49966 usecs
Apr  7 15:32:44 [kernel] intel8x0: clocking to 46874
Apr  7 15:32:44 [kernel] Initializing USB Mass Storage driver...
Apr  7 15:32:44 [kernel] usb-storage: USB Mass Storage device detected
Apr  7 15:32:44 [kernel] usb-storage: -- associate_dev
Apr  7 15:32:44 [kernel] usb-storage: Vendor: 0x04e6, Product: 0x0325, Revi=
sion: 0x0503
Apr  7 15:32:44 [kernel] usb-storage: Interface Subclass: 0x06, Protocol: 0=
x50
Apr  7 15:32:44 [kernel] usb-storage: Vendor: SCM Microsystems Inc.,  Produ=
ct: eUSB ORCA Quad Reader
Apr  7 15:32:44 [kernel] usb-storage: Transport: Bulk
Apr  7 15:32:44 [kernel] usb-storage: Protocol: Transparent SCSI
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_control_msg: rq=FE rqtype=A1=
 value=0000 index=00 len=3D1
Apr  7 15:32:44 [kernel] usb-storage: GetMaxLUN command result is 1, data i=
s 1
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] scsi2 : SCSI emulation for USB Mass Storage devices
Apr  7 15:32:44 [kernel] usbcore: registered new driver usb-storage
Apr  7 15:32:44 [kernel] USB Mass Storage support registered.
Apr  7 15:32:44 [kernel] usb-storage: device found at 5
Apr  7 15:32:44 [kernel] usb-storage: waiting for device to settle before s=
canning
Apr  7 15:32:44 [kernel] ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debia=
n.org>
Apr  7 15:32:44 [kernel] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 18
Apr  7 15:32:44 [kernel] ACPI: PCI interrupt 0000:01:06.0[A] -> GSI 18 (lev=
el, low) -> IRQ 209
Apr  7 15:32:44 [kernel] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[20=
9]  MMIO=3D[ff4ff800-ff4fffff]  Max Packet=3D[2048]
Apr  7 15:32:44 [kernel] i2c_adapter i2c-4: nForce2 SMBus adapter at 0xc400
Apr  7 15:32:44 [kernel] i2c_adapter i2c-5: nForce2 SMBus adapter at 0xc000
Apr  7 15:32:44 [kernel] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000=
000000016ebc]
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 36 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 36/36
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk data transfer result 0x0
Apr  7 15:32:44 [kernel] usb-storage: Attempting to get CSW...
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 15:32:44 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x850 R 0 =
Stat 0x0
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x0
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel]   Vendor: eUSB      Model: Compact Flash     Rev: =
5.03
Apr  7 15:32:44 [kernel]   Type:   Direct-Access                      ANSI =
SCSI revision: 02
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr  7 15:32:44 [kernel] usb-storage:  00 00 00 00 00 00
Apr  7 15:32:44 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x851 L 0=
 F 0 Trg 0 LUN 0 CL 6
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 15:32:44 [kernel] usb-storage: Attempting to get CSW...
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 15:32:44 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x851 R 0 =
Stat 0x1
Apr  7 15:32:44 [kernel] usb-storage: -- transport indicates command failure
Apr  7 15:32:44 [kernel] usb-storage: Issuing auto-REQUEST_SENSE
Apr  7 15:32:44 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x8000085=
1 L 18 F 128 Trg 0 LUN 0 CL 6
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 18 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 18/18
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk data transfer result 0x0
Apr  7 15:32:44 [kernel] usb-storage: Attempting to get CSW...
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 15:32:44 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x80000851=
 R 0 Stat 0x0
Apr  7 15:32:44 [kernel] usb-storage: -- Result from auto-sense is 0
Apr  7 15:32:44 [kernel] usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, A=
SCQ: 0x0
Apr  7 15:32:44 [kernel] usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x2
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr  7 15:32:44 [kernel] usb-storage:  00 00 00 00 00 00
Apr  7 15:32:44 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x852 L 0=
 F 0 Trg 0 LUN 0 CL 6
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 15:32:44 [kernel] usb-storage: Attempting to get CSW...
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 15:32:44 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x852 R 0 =
Stat 0x1
Apr  7 15:32:44 [kernel] usb-storage: -- transport indicates command failure
Apr  7 15:32:44 [kernel] usb-storage: Issuing auto-REQUEST_SENSE
Apr  7 15:32:44 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x8000085=
2 L 18 F 128 Trg 0 LUN 0 CL 6
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 18 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 18/18
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk data transfer result 0x0
Apr  7 15:32:44 [kernel] usb-storage: Attempting to get CSW...
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 15:32:44 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x80000852=
 R 0 Stat 0x0
Apr  7 15:32:44 [kernel] usb-storage: -- Result from auto-sense is 0
Apr  7 15:32:44 [kernel] usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, A=
SCQ: 0x0
Apr  7 15:32:44 [kernel] usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x2
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr  7 15:32:44 [kernel] usb-storage:  00 00 00 00 00 00
Apr  7 15:32:44 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x853 L 0=
 F 0 Trg 0 LUN 0 CL 6
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 15:32:44 [kernel] usb-storage: Attempting to get CSW...
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 15:32:44 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x853 R 0 =
Stat 0x1
Apr  7 15:32:44 [kernel] usb-storage: -- transport indicates command failure
Apr  7 15:32:44 [kernel] usb-storage: Issuing auto-REQUEST_SENSE
Apr  7 15:32:44 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x8000085=
3 L 18 F 128 Trg 0 LUN 0 CL 6
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 18 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 18/18
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk data transfer result 0x0
Apr  7 15:32:44 [kernel] usb-storage: Attempting to get CSW...
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 15:32:44 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x80000853=
 R 0 Stat 0x0
Apr  7 15:32:44 [kernel] usb-storage: -- Result from auto-sense is 0
Apr  7 15:32:44 [kernel] usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, A=
SCQ: 0x0
Apr  7 15:32:44 [kernel] usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x2
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] Attached scsi removable disk sdb at scsi2, channel=
 0, id 0, lun 0
Apr  7 15:32:44 [kernel] Attached scsi generic sg1 at scsi2, channel 0, id =
0, lun 0,  type 0
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Command INQUIRY (6 bytes)
Apr  7 15:32:44 [kernel] usb-storage:  12 20 00 00 24 00
Apr  7 15:32:44 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x854 L 3=
6 F 128 Trg 0 LUN 1 CL 6
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 36 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 36/36
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk data transfer result 0x0
Apr  7 15:32:44 [kernel] usb-storage: Attempting to get CSW...
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 15:32:44 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x854 R 0 =
Stat 0x0
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x0
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel]   Vendor: eUSB      Model: SD-MS-SM          Rev: =
5.03
Apr  7 15:32:44 [kernel]   Type:   Direct-Access                      ANSI =
SCSI revision: 02
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr  7 15:32:44 [kernel] usb-storage:  00 20 00 00 00 00
Apr  7 15:32:44 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x855 L 0=
 F 0 Trg 0 LUN 1 CL 6
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 15:32:44 [kernel] usb-storage: Attempting to get CSW...
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 15:32:44 [kernel] usb-storage: -- transport indicates command failure
Apr  7 15:32:44 [kernel] usb-storage: Issuing auto-REQUEST_SENSE
Apr  7 15:32:44 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x8000085=
5 L 18 F 128 Trg 0 LUN 1 CL 6
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 18 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 18/18
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk data transfer result 0x0
Apr  7 15:32:44 [kernel] usb-storage: Attempting to get CSW...
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 15:32:44 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x80000855=
 R 0 Stat 0x0
Apr  7 15:32:44 [kernel] usb-storage: -- Result from auto-sense is 0
Apr  7 15:32:44 [kernel] usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, A=
SCQ: 0x0
Apr  7 15:32:44 [kernel] usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x2
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr  7 15:32:44 [kernel] usb-storage:  00 20 00 00 00 00
Apr  7 15:32:44 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x856 L 0=
 F 0 Trg 0 LUN 1 CL 6
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 15:32:44 [kernel] usb-storage: Attempting to get CSW...
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 15:32:44 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x856 R 0 =
Stat 0x1
Apr  7 15:32:44 [kernel] usb-storage: -- transport indicates command failure
Apr  7 15:32:44 [kernel] usb-storage: Issuing auto-REQUEST_SENSE
Apr  7 15:32:44 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x8000085=
6 L 18 F 128 Trg 0 LUN 1 CL 6
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 18 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 18/18
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk data transfer result 0x0
Apr  7 15:32:44 [kernel] usb-storage: Attempting to get CSW...
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 15:32:44 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x80000856=
 R 0 Stat 0x0
Apr  7 15:32:44 [kernel] usb-storage: -- Result from auto-sense is 0
Apr  7 15:32:44 [kernel] usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, A=
SCQ: 0x0
Apr  7 15:32:44 [kernel] usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x2
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr  7 15:32:44 [kernel] usb-storage:  00 20 00 00 00 00
Apr  7 15:32:44 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x857 L 0=
 F 0 Trg 0 LUN 1 CL 6
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 15:32:44 [kernel] usb-storage: Attempting to get CSW...
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 15:32:44 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x857 R 0 =
Stat 0x1
Apr  7 15:32:44 [kernel] usb-storage: -- transport indicates command failure
Apr  7 15:32:44 [kernel] usb-storage: Issuing auto-REQUEST_SENSE
Apr  7 15:32:44 [kernel] usb-storage: Bulk Command S 0x43425355 T 0x8000085=
7 L 18 F 128 Trg 0 LUN 1 CL 6
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 31 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 31/31
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk command transfer result=3D0
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 18 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Attempting to get CSW...
Apr  7 15:32:44 [kernel] usb-storage: usb_stor_bulk_transfer_buf: xfer 13 b=
ytes
Apr  7 15:32:44 [kernel] usb-storage: Status code 0; transferred 13/13
Apr  7 15:32:44 [kernel] usb-storage: -- transfer complete
Apr  7 15:32:44 [kernel] usb-storage: Bulk status result =3D 0
Apr  7 15:32:44 [kernel] usb-storage: Bulk Status S 0x53425355 T 0x80000857=
 R 0 Stat 0x0
Apr  7 15:32:44 [kernel] usb-storage: -- Result from auto-sense is 0
Apr  7 15:32:44 [kernel] usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, A=
SCQ: 0x0
Apr  7 15:32:44 [kernel] usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x2
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] Attached scsi removable disk sdc at scsi2, channel=
 0, id 0, lun 1
Apr  7 15:32:44 [kernel] Attached scsi generic sg2 at scsi2, channel 0, id =
0, lun 1,  type 0
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Bad LUN (0:2)
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Bad target number (1:0)
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Bad target number (2:0)
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Bad target number (3:0)
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Bad target number (4:0)
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Bad target number (5:0)
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Bad target number (6:0)
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] usb-storage: queuecommand called
Apr  7 15:32:44 [kernel] usb-storage: *** thread awakened.
Apr  7 15:32:44 [kernel] usb-storage: Bad target number (7:0)
Apr  7 15:32:44 [kernel] usb-storage: scsi cmd done, result=3D0x40000
Apr  7 15:32:44 [kernel] usb-storage: *** thread sleeping.
Apr  7 15:32:44 [kernel] usb-storage: device scan complete
Apr  7 15:32:44 [kernel] ReiserFS: sda7: found reiserfs format "3.6" with s=
tandard journal
Apr  7 15:32:44 [kernel] ReiserFS: sda7: using ordered data mode
Apr  7 15:32:44 [kernel] ReiserFS: sda7: journal params: device sda7, size =
8192, journal first block 18, max trans len 1024, max batch 900, max commit=
 age 30, max trans age 30
Apr  7 15:32:44 [kernel] ReiserFS: sda7: checking transaction log (sda7)
Apr  7 15:32:44 [kernel] ReiserFS: sda7: Using r5 hash to sort names
Apr  7 15:32:44 [kernel] ReiserFS: sda8: found reiserfs format "3.6" with s=
tandard journal
Apr  7 15:32:44 [kernel] ReiserFS: sda8: using ordered data mode
Apr  7 15:32:44 [kernel] ReiserFS: sda8: journal params: device sda8, size =
8192, journal first block 18, max trans len 1024, max batch 900, max commit=
 age 30, max trans age 30
Apr  7 15:32:44 [kernel] ReiserFS: sda8: checking transaction log (sda8)
Apr  7 15:32:44 [kernel] ReiserFS: sda8: Using r5 hash to sort names
Apr  7 15:32:44 [kernel] ReiserFS: sda9: found reiserfs format "3.6" with s=
tandard journal
Apr  7 15:32:44 [kernel] ReiserFS: sda9: using ordered data mode
Apr  7 15:32:44 [kernel] ReiserFS: sda9: journal params: device sda9, size =
8192, journal first block 18, max trans len 1024, max batch 900, max commit=
 age 30, max trans age 30
Apr  7 15:32:44 [kernel] ReiserFS: sda9: checking transaction log (sda9)
Apr  7 15:32:44 [kernel] ReiserFS: sda9: Using r5 hash to sort names
Apr  7 15:32:44 [kernel] ReiserFS: sda11: found reiserfs format "3.6" with =
standard journal
Apr  7 15:32:44 [kernel] ReiserFS: sda11: using ordered data mode
Apr  7 15:32:44 [kernel] ReiserFS: sda11: journal params: device sda11, siz=
e 8192, journal first block 18, max trans len 1024, max batch 900, max comm=
it age 30, max trans age 30
Apr  7 15:32:44 [kernel] ReiserFS: sda11: checking transaction log (sda11)
Apr  7 15:32:44 [kernel] ReiserFS: sda11: Using r5 hash to sort names
Apr  7 15:32:44 [kernel] agpgart: Detected AGP bridge 0
Apr  7 15:32:44 [kernel] agpgart: Setting up Nforce3 AGP.
-------------- next part --------------
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.11-gentoo-r5
# Thu Apr  7 15:15:45 2005
#
CONFIG_X86_64=3Dy
CONFIG_64BIT=3Dy
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_EARLY_PRINTK=3Dy
CONFIG_HPET_TIMER=3Dy
CONFIG_HPET_EMULATE_RTC=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_LOCK_KERNEL=3Dy

#
# General setup
#
CONFIG_LOCALVERSION=3D""
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_POSIX_MQUEUE=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=3Dy
CONFIG_KOBJECT_UEVENT=3Dy
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=3Dy
CONFIG_CC_ALIGN_FUNCTIONS=3D0
CONFIG_CC_ALIGN_LABELS=3D0
CONFIG_CC_ALIGN_LOOPS=3D0
CONFIG_CC_ALIGN_JUMPS=3D0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=3Dy
CONFIG_STOP_MACHINE=3Dy

#
# Processor type and features
#
CONFIG_MK8=3Dy
# CONFIG_MPSC is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTESd
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_X86_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_MTRR=3Dy
CONFIG_SMP=3Dy
# CONFIG_PREEMPT is not set
CONFIG_SCHED_SMT=3Dy
CONFIG_K8_NUMA=3Dy
# CONFIG_NUMA_EMU is not set
CONFIG_DISCONTIGMEM=3Dy
CONFIG_NUMA=3Dy
CONFIG_HAVE_DEC_LOCK=3Dy
CONFIG_NR_CPUS=3D4
# CONFIG_GART_IOMMU is not set
CONFIG_DUMMY_IOMMU=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_INTEL=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy

#
# Power management options
#
CONFIG_PM=3Dy
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=3Dy
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_VIDEO=3Dy
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
CONFIG_ACPI_NUMA=3Dy
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR 01
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_ACPI_CONTAINER=3Dm

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=3Dy
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy

#
# CPUFreq processor drivers
#
CONFIG_X86_POWERNOW_K8=3Dy
CONFIG_X86_POWERNOW_K8_ACPI=3Dy
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_ACPI_CPUFREQ is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
CONFIG_UNORDERED_IO=3Dy
CONFIG_PCI_MSI=3Dy
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=3Dy

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PC-card bridges
#

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_MISC is not set
CONFIG_IA32_EMULATION=3Dy
CONFIG_IA32_AOUT=3Dy
CONFIG_COMPAT=3Dy
CONFIG_SYSVIPC_COMPAT=3Dy
CONFIG_UID16=3Dy

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dm

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_CML1=3Dm
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=3Dy
CONFIG_PARPORT_PC_SUPERIO=3Dy
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play support
#
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=3Dy

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dy
CONFIG_PARIDE=3Dm
CONFIG_PARIDE_PARPORT=3Dm

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=3Dm
CONFIG_PARIDE_PCD=3Dm
CONFIG_PARIDE_PF=3Dm
CONFIG_PARIDE_PT=3Dm
CONFIG_PARIDE_PG=3Dm

#
# Parallel IDE protocol modules
#
# CONFIG_PARIDE_ATEN is not set
# CONFIG_PARIDE_BPCK is not set
# CONFIG_PARIDE_COMM is not set
# CONFIG_PARIDE_DSTR is not set
# CONFIG_PARIDE_FIT2 is not set
# CONFIG_PARIDE_FIT3 is not set
# CONFIG_PARIDE_EPAT is not set
# CONFIG_PARIDE_EPIA is not set
# CONFIG_PARIDE_FRIQ is not set
# CONFIG_PARIDE_FRPW is not set
# CONFIG_PARIDE_KBIC is not set
# CONFIG_PARIDE_KTTI is not set
# CONFIG_PARIDE_ON20 is not set
# CONFIG_PARIDE_ON26 is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE@96
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_LBD=3Dy
CONFIG_CDROM_PKTCDVD=3Dm
CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
CONFIG_CDROM_PKTCDVD_WCACHE=3Dy

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_BLK_DEV_IDECD=3Dy
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=3Dy
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=3Dy
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=3Dy
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=3Dy
# CONFIG_BLK_DEV_ATIIXP is not set
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
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=3Dy
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
CONFIG_CHR_DEV_ST=3Dm
CONFIG_CHR_DEV_OSST=3Dm
CONFIG_BLK_DEV_SR=3Dm
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=3Dm

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=3Dy
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_SCSI_SATA=3Dy
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
CONFIG_SCSI_SATA_NV=3Dy
# CONFIG_SCSI_PATA_PDC2027X is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
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
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=3Dy
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
CONFIG_FUSION=3Dy
CONFIG_FUSION_MAX_SGE@
# CONFIG_FUSION_CTL is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=3Dm

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
# CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set

#
# Device Drivers
#
CONFIG_IEEE1394_PCILYNX=3Dm
CONFIG_IEEE1394_OHCI1394=3Dm

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=3Dm
CONFIG_IEEE1394_SBP2=3Dm
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
# CONFIG_IEEE1394_ETH1394 is not set
CONFIG_IEEE1394_DV1394=3Dm
CONFIG_IEEE1394_RAWIO=3Dm
CONFIG_IEEE1394_CMP=3Dm
CONFIG_IEEE1394_AMDTP=3Dm

#
# I2O device support
#
CONFIG_I2O=3Dm
CONFIG_I2O_CONFIG=3Dm
CONFIG_I2O_BLOCK=3Dm
CONFIG_I2O_SCSI=3Dm
CONFIG_I2O_PROC=3Dm

#
# Networking support
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=3Dy
CONFIG_NET_KEY=3Dy
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=3Dy
CONFIG_INET_ESP=3Dy
CONFIG_INET_IPCOMP=3Dy
CONFIG_INET_TUNNEL=3Dy
CONFIG_IP_TCPDIAG=3Dy
# CONFIG_IP_TCPDIAG_IPV6 is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dy
# CONFIG_IP_NF_CT_ACCT is not set
CONFIG_IP_NF_CONNTRACK_MARK=3Dy
CONFIG_IP_NF_CT_PROTO_SCTP=3Dm
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_IRC=3Dm
CONFIG_IP_NF_TFTP=3Dm
CONFIG_IP_NF_AMANDA=3Dm
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dy
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_IPRANGE=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_RECENT=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_HELPER=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dm
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_MATCH_ADDRTYPE=3Dm
CONFIG_IP_NF_MATCH_REALM=3Dm
CONFIG_IP_NF_MATCH_SCTP=3Dm
CONFIG_IP_NF_MATCH_COMMENT=3Dm
CONFIG_IP_NF_MATCH_CONNMARK=3Dm
CONFIG_IP_NF_MATCH_HASHLIMIT=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_NAT=3Dy
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_TARGET_NETMAP=3Dm
CONFIG_IP_NF_TARGET_SAME=3Dm
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_NAT_TFTP=3Dm
CONFIG_IP_NF_NAT_AMANDA=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_CLASSIFY=3Dm
CONFIG_IP_NF_TARGET_CONNMARK=3Dm
CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
CONFIG_IP_NF_RAW=3Dm
CONFIG_IP_NF_TARGET_NOTRACK=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dy

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=3Dm
# CONFIG_LLC2 is not set
CONFIG_IPX=3Dm
# CONFIG_IPX_INTERN is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=3Dy

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETPOLL=3Dy
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=3Dy
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=3Dy
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dy
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
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
# CONFIG_B44 is not set
CONFIG_FORCEDETH=3Dm
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
CONFIG_SKGE=3Dm
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=3Dy

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_HERMES=3Dm
CONFIG_PLX_HERMES=3Dm
CONFIG_TMD_HERMES=3Dm
CONFIG_PCI_HERMES=3Dm
CONFIG_ATMEL=3Dm
CONFIG_PCI_ATMEL=3Dm

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
CONFIG_PRISM54=3Dm
CONFIG_NET_WIRELESS=3Dy

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=3Dy

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

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
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Yv8
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
# CONFIG_GAMEPORT_CS461X is not set
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=3Dm
CONFIG_SERIO_LIBPS2=3Dy
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
CONFIG_INPUT_PCSPKR=3Dy
CONFIG_INPUT_UINPUT=3Dy

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
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_UNIX98_PTYS=3Dy
# CONFIG_LEGACY_PTYS is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=3Dy
# CONFIG_NVRAM is not set
CONFIG_RTC=3Dy
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dm
CONFIG_AGP_AMD64=3Dm
# CONFIG_AGP_INTEL_MCH is not set
CONFIG_DRM=3Dm
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=3Dm
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=3Dy

#
# I2C support
#
CONFIG_I2C=3Dy
CONFIG_I2C_CHARDEV=3Dy

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=3Dy
CONFIG_I2C_ALGOPCF=3Dm
CONFIG_I2C_ALGOPCA=3Dm

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=3Dm
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=3Dm
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=3Dm
CONFIG_I2C_NFORCE2=3Dm
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=3Dm
CONFIG_SENSORS_ADM1021=3Dm
CONFIG_SENSORS_ADM1025=3Dm
CONFIG_SENSORS_ADM1026=3Dm
CONFIG_SENSORS_ADM1031=3Dm
CONFIG_SENSORS_ASB100=3Dm
CONFIG_SENSORS_DS1621=3Dm
CONFIG_SENSORS_FSCHER=3Dm
CONFIG_SENSORS_GL518SM=3Dm
CONFIG_SENSORS_IT87=3Dm
CONFIG_SENSORS_LM63=3Dm
CONFIG_SENSORS_LM75=3Dm
CONFIG_SENSORS_LM77=3Dm
CONFIG_SENSORS_LM78=3Dm
CONFIG_SENSORS_LM80=3Dm
CONFIG_SENSORS_LM83=3Dm
CONFIG_SENSORS_LM85=3Dm
CONFIG_SENSORS_LM87=3Dm
CONFIG_SENSORS_LM90=3Dm
CONFIG_SENSORS_MAX1619=3Dm
CONFIG_SENSORS_PC87360=3Dm
CONFIG_SENSORS_SMSC47B397=3Dm
CONFIG_SENSORS_SMSC47M1=3Dm
CONFIG_SENSORS_VIA686A=3Dm
CONFIG_SENSORS_W83781D=3Dm
CONFIG_SENSORS_W83L785TS=3Dm
CONFIG_SENSORS_W83627HF=3Dm

#
# Other I2C Chip support
#
CONFIG_SENSORS_EEPROM=3Dm
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

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
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
CONFIG_VIDEO_CPIA=3Dm
# CONFIG_VIDEO_CPIA_PP is not set
# CONFIG_VIDEO_CPIA_USB is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
CONFIG_VIDEO_STRADIS=3Dm
CONFIG_VIDEO_ZORAN=3Dm
CONFIG_VIDEO_ZORAN_BUZ=3Dm
CONFIG_VIDEO_ZORAN_DC10=3Dm
CONFIG_VIDEO_ZORAN_DC30=3Dm
CONFIG_VIDEO_ZORAN_LML33=3Dm
CONFIG_VIDEO_ZORAN_LML33R10=3Dm
# CONFIG_VIDEO_ZR36120 is not set
CONFIG_VIDEO_SAA7134=3Dm
CONFIG_VIDEO_MXB=3Dm
CONFIG_VIDEO_DPC=3Dm
CONFIG_VIDEO_HEXIUM_ORION=3Dm
CONFIG_VIDEO_HEXIUM_GEMINI=3Dm
CONFIG_VIDEO_CX88=3Dm
CONFIG_VIDEO_OVCAMCHIP=3Dm

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
CONFIG_VIDEO_SAA7146=3Dm
CONFIG_VIDEO_SAA7146_VV=3Dm
CONFIG_VIDEO_VIDEOBUF=3Dm
CONFIG_VIDEO_TUNER=3Dm
CONFIG_VIDEO_BUF=3Dm
CONFIG_VIDEO_BTCX=3Dm
CONFIG_VIDEO_IR=3Dm

#
# Graphics support
#
CONFIG_FB=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=3Dy
CONFIG_FB_VESA_STD=3Dy
# CONFIG_FB_VESA_TNG is not set
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=3Dy
CONFIG_FB_RADEON_I2C=3Dy
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
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
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_FONTS=3Dy
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=3Dy
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
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
CONFIG_FB_SPLASH=3Dy

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
CONFIG_SPEAKUP_DEFAULT=3D"none"

#
# Sound
#
CONFIG_SOUND=3Dy

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dy
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_SEQUENCER=3Dm
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_BIT32_EMUL=3Dm
CONFIG_SND_RTCTIMER=3Dm
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=3Dm
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
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
CONFIG_SND_INTEL8X0=3Dm
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=3Dy
# CONFIG_USB_EHCI_SPLIT_ISO is not set
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
CONFIG_USB_OHCI_HCD=3Dy
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=3Dm
CONFIG_USB_BLUETOOTH_TTY=3Dm
CONFIG_USB_MIDI=3Dm
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=3Dm

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be neede=
d; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=3Dm
CONFIG_USB_STORAGE_DEBUG=3Dy
CONFIG_USB_STORAGE_RW_DETECT=3Dy
CONFIG_USB_STORAGE_DATAFAB=3Dy
CONFIG_USB_STORAGE_FREECOM=3Dy
CONFIG_USB_STORAGE_ISD200=3Dy
CONFIG_USB_STORAGE_DPCM=3Dy
CONFIG_USB_STORAGE_HP8200e=3Dy
CONFIG_USB_STORAGE_SDDR09=3Dy
CONFIG_USB_STORAGE_SDDR55=3Dy
CONFIG_USB_STORAGE_JUMPSHOT=3Dy

#
# USB Input Devices
#
CONFIG_USB_HID=3Dy
CONFIG_USB_HIDINPUT=3Dy
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
CONFIG_USB_XPAD=3Dm
CONFIG_USB_ATI_REMOTE=3Dm

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
# CONFIG_USB_DSBR is not set
CONFIG_USB_IBMCAM=3Dm
CONFIG_USB_KONICAWC=3Dm
CONFIG_USB_OV511=3Dm
CONFIG_USB_SE401=3Dm
CONFIG_USB_SN9C102=3Dm
CONFIG_USB_STV680=3Dm
CONFIG_USB_W9968CF=3Dm

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
CONFIG_USB_RIO500=3Dm
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_TEST is not set

#
# USB ATM/DSL drivers
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
CONFIG_MMC=3Dm
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_BLOCK=3Dm

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
CONFIG_REISERFS_FS=3Dy
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=3Dy
CONFIG_REISERFS_FS_POSIX_ACL=3Dy
# CONFIG_REISERFS_FS_SECURITY is not set
CONFIG_JFS_FS=3Dy
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=3Dy

#
# XFS support
#
CONFIG_XFS_FS=3Dy
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=3Dy
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=3Dy
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=3Dy
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dy
CONFIG_VFAT_FS=3Dy
CONFIG_FAT_DEFAULT_CODEPAGEC7
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
CONFIG_NTFS_FS=3Dy
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=3Dy

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_SYSFS=3Dy
CONFIG_DEVFS_FS=3Dy
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=3Dy
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=3Dy
CONFIG_HUGETLB_PAGE=3Dy
CONFIG_RAMFS=3Dy

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=3Dm
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=3Dm
CONFIG_UFS_FS_WRITE=3Dy

#
# Network File Systems
#
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_SUNRPC=3Dy
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=3Dm
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp437"
CONFIG_CIFS=3Dm
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_XATTR=3Dy
CONFIG_CIFS_POSIX=3Dy
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dy
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=3Dy
CONFIG_NLS_ISO8859_1=3Dy
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=3Dy
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=3Dy

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY=3Dy
CONFIG_SECURITY_NETWORK=3Dy
CONFIG_SECURITY_CAPABILITIES=3Dy
# CONFIG_SECURITY_ROOTPLUG is not set
# CONFIG_SECURITY_SECLVL is not set
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
# CONFIG_CRYPTO_NULL is not set
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_SHA1=3Dy
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_WP512=3Dm
CONFIG_CRYPTO_DES=3Dy
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_AES=3Dm
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_TEA=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_KHAZAD=3Dm
CONFIG_CRYPTO_ANUBIS=3Dm
CONFIG_CRYPTO_DEFLATE=3Dy
CONFIG_CRYPTO_MICHAEL_MIC=3Dm
CONFIG_CRYPTO_CRC32C=3Dm
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=3Dm
CONFIG_CRC32=3Dy
CONFIG_LIBCRC32C=3Dm
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
