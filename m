From: philippe.roubach@free.fr (ROUBACH Philippe)
Date: Sat, 28 Jan 2006 16:11:46 +0000
Subject: [lm-sensors] tuning an Asus A7N8X-X, somme data for developers,
Message-Id: <200601281711.46405.philippe.roubach@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

Some data. May be developers will be interesting by them.

1. My PC

chassis : ANTEC Sonata with a smart Power which tunes itself its temperarure, 
its fan speed and the chassis fan speed(low speed fan with 12 cm diameter).
Power temperature is not reported to MB(no connexion)
Power fan speed is not reported to MB(no connexion)
Chassis fan speed is reported to MB(connexion)

MB Asus A7N8X-X rev 2.xx bios V 1006 with Q-fan enabled tunes processor fan 
speed
bios can reports CPU temp, MB temp, CPU fan speed, chassis fan speed, power 
fan speed

Chip asb100, w83l785ts
CPU AMD Athlon XP 2600+

MDV 2006
kernel 2.6.12.15mdk-1-1mdk
lm_sensors-2.9.1-4mdk
liblm_sensors3-2.9.1-4mdk 
Ksensors-0.7.3-3mdk
Gkrellm-2.2.7-1mdk

2. tuning environment
- room temperature about 16 ?C
- reference : bios measures

3. asb100
3.1. temp1

- add compute temp1 @/2.267,  2.267*@
- reported by Ksensors as M/B TEMP                  : 19 ?C (right)
- reported by gkrellm as asb100-1-002d/temp1: 43 ?C 

3.2. temp2

- reported by Ksensors as CPU Temp (Intel)       : 15 ?C (it never changes)
- reported by gkrellm as asb100-1-002d/temp2 : 18,5 ?C(it changes)

what is this temperature ?

3.3. temp3

- reported by Ksensors as Power Temp              : 15 ?C (it never changes)
- reported by gkrellm as asb100-1-002d/temp3 : -0,5 ?C(it never changes)

 measures are without meaning because power temp is not connected to MB

3.4. temp4

- reported by Ksensors as CPU Temp (AMD)       : 25 ?C (it never changes)
- reported by gkrellm as asb100-1-002d/temp4 : 25 ?C (it never changes)

3.5. fan1

- add compute fan2 @/2,  2*@
- reported by Ksensors as CPU fan                  : 2400 rev/s
- reported by gkrellm as asb100-1-002d/fan1 : 5000 rev/s


3.6. fan2

- change set fan2_div 2 to 8 because sometime there is no measure
- add compute fan2 @/2,  2*@ or compute fan2 @/1.923,  1.923*@
- reported by Ksensors as CPU fan                  : 1400 rev/s
- reported by gkrellm as asb100-1-002d/fan2 : 2800 rev/s

4. w83l785ts

4.1 temp1

- reported by Ksensors as temp                             : 60 ?C
- reported by gkrellm as w83l785ts-1-002e/temp1: 60 ?C

this is THE strange case

- its name is temp1, its label is "CPU temp"
 but ksensors reported  label "temp" and reported the same temperature 60 ?C
- when i add compute temp1 @/1.305,  1.305*@ to have the same temperature as 
bios
  , measure is not recompute!

i hope this report can help developers

If you have an idea about THE strange case, thanks in advance

-- 
Philippe ROUBACH
-------------- next part --------------
Linux version 2.6.12-15mdk (qateam at mercury.mandriva.com) (gcc version 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0)) #1 Mon Jan 9 17:08:48 MST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x000f75c0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff74c0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Built 1 zonelists
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=linux root01 resume=/dev/hda5 splash=silent
bootsplash: silent mode.
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1912.970 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514692k/524224k available (2348k kernel code, 8972k reserved, 717k data, 268k init, 0k highmem, 0k BadRAM)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3792.89 BogoMIPS (lpj96448)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2600+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: Looking for DSDT in initrd... not found.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=0 pin2=-1
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Freeing initrd memory: 311k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4a0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
Boot video device is 0000:02:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
PnPBIOS: Disabled
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
pnp: 00:00: ioport range 0x4400-0x447f has been reserved
pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:00: ioport range 0x4200-0x427f has been reserved
pnp: 00:00: ioport range 0x4280-0x42ff has been reserved
pnp: 00:01: ioport range 0x5000-0x503f has been reserved
pnp: 00:01: ioport range 0x5500-0x553f has been reserved
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1138347285.332:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch at atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
vesafb: framebuffer at 0xe0000000, mapped to 0xe0880000, using 3750k, total 131072k
vesafb: mode is 800x600x16, linelength00, pages=2
vesafb: protected mode interface info at c000:e2d0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
bootsplash 3.1.6-2004/03/31: looking for picture...<6> silentjpeg size 34430 bytes,<6>...found (800x600, 34382 bytes, v3).
Console: switching to colour frame buffer device 93x30
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe at suse.de) and petero2 at telia.com
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6E040L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdd: Hewlett-Packard DVD Writer 200, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78156288 sectors (40016 MB) w/2048KiB Cache, CHSe535/16/63, UDMA(133)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS%6, MD_SB_DISKS'
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
swsusp: Suspend partition has wrong signature?
ACPI wakeup devices: 
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1 
ACPI: (supports S0 S1 S4 S4bios S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
devfs_mk_dev: could not append to parent for md/0
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 244KiB [1 disk] into ram disk... |/-\|/-\|/-\|/-\done.
VFS: Mounted root (cramfs filesystem) readonly.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 22, io mem 0xee004000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 21 (level, high) -> IRQ 21
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: OHCI Host Controller
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.1: irq 21, io mem 0xee005000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 20 (level, high) -> IRQ 20
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: debug port 1
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:02.2: irq 20, io mem 0xee000000
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: park 0
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 268k freed
ohci_hcd 0000:00:02.1: wakeup
usb 1-1: new full speed USB device using ohci_hcd and address 2
usb 2-1: new full speed USB device using ohci_hcd and address 2
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 2 ports detected
usb 2-1.1: new full speed USB device using ohci_hcd and address 3
input: USB HID v1.00 Keyboard [Silitek  Silitek USB Keyboard] on usb-0000:00:02.1-1.1
usb 2-1.2: new low speed USB device using ohci_hcd and address 4
input: USB HID v1.00 Mouse [0461:4d03] on usb-0000:00:02.1-1.2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0417
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usbcore: registered new driver usbkbd
drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
usbcore: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
ts: Compaq touchscreen protocol output
EXT3 FS on hda1, internal journal
Adding 1124508k swap on /dev/hda5.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
loop: loaded (max 8 devices)
hdd: ATAPI 32X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
-------------- next part --------------
Module                  Size  Used by
raw                     6592  1 
nvidia               4069712  12 
agpgart                29032  1 nvidia
md5                     3584  1 
ipv6                  233984  10 
snd_seq_dummy           2532  0 
snd_seq_oss            31136  0 
snd_seq_midi_event      5696  1 snd_seq_oss
snd_seq                46960  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          6828  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            48960  0 
snd_mixer_oss          16896  1 snd_pcm_oss
snd_intel8x0           28404  1 
snd_ac97_codec         83900  1 snd_intel8x0
snd_pcm                79784  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              20548  2 snd_seq,snd_pcm
snd_page_alloc          8392  2 snd_intel8x0,snd_pcm
snd                    46116  11 snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore               7008  1 snd
ppdev                   7364  0 
parport_pc             32612  1 
lp                     10024  0 
parport                31976  3 ppdev,parport_pc,lp
ipt_IFWLOG              2788  1 
ipt_psd                43428  1 
ip_set_iptree           5544  2 
ipt_REJECT              4256  4 
ipt_LOG                 6272  7 
ipt_state               1312  7 
ipt_pkttype             1184  4 
ipt_set                 1920  2 
ipt_CONNMARK            1696  0 
ipt_MARK                1984  0 
ipt_ROUTE               4260  0 
ipt_connmark            1216  0 
ipt_owner               2432  0 
ipt_recent              9292  0 
ipt_iprange             1312  0 
ipt_physdev             1744  0 
ipt_multiport           2112  0 
ipt_conntrack           1792  0 
iptable_mangle          2016  0 
ip_set_portmap          3872  0 
ip_set_macipmap         3780  0 
ip_set_ipmap            3872  0 
ip_set_iphash           5956  0 
ip_set                 18908  11 ip_set_iptree,ipt_set,ip_set_portmap,ip_set_macipmap,ip_set_ipmap,ip_set_iphash
ip_nat_irc              1824  0 
ip_nat_tftp             1216  0 
ip_nat_ftp              2560  0 
iptable_nat            20276  3 ip_nat_irc,ip_nat_tftp,ip_nat_ftp
ip_conntrack_irc       70352  1 ip_nat_irc
ip_conntrack_tftp       3088  1 ip_nat_tftp
ip_conntrack_ftp       71408  1 ip_nat_ftp
ip_conntrack           40856  9 ipt_state,ipt_conntrack,ip_nat_irc,ip_nat_tftp,ip_nat_ftp,iptable_nat,ip_conntrack_irc,ip_conntrack_tftp,ip_conntrack_ftp
iptable_filter          2080  1 
ip_tables              20384  20 ipt_IFWLOG,ipt_psd,ipt_REJECT,ipt_LOG,ipt_state,ipt_pkttype,ipt_set,ipt_CONNMARK,ipt_MARK,ipt_ROUTE,ipt_connmark,ipt_owner,ipt_recent,ipt_iprange,ipt_physdev,ipt_multiport,ipt_conntrack,iptable_mangle,iptable_nat,iptable_filter
forcedeth              16544  0 
af_packet              16392  2 
eeprom                  5616  0 
w83l785ts               5552  0 
asb100                 22388  0 
i2c_sensor              2592  3 eeprom,w83l785ts,asb100
i2c_nforce2             5568  0 
i2c_core               17360  5 eeprom,w83l785ts,asb100,i2c_sensor,i2c_nforce2
floppy                 55444  0 
video                  14052  0 
thermal                10792  0 
tc1100_wmi              5092  0 
processor              17876  1 thermal
fan                     3172  0 
container               3008  0 
button                  4848  0 
battery                 7460  0 
ac                      3268  0 
ide_cd                 37988  0 
loop                   14504  0 
tsdev                   5984  0 
usbmouse                4160  0 
usbkbd                  5760  0 
usblp                  10976  0 
evdev                   7648  0 
ext3                  124840  3 
jbd                    48568  1 ext3
usbhid                 44352  0 
ehci_hcd               28968  0 
ohci_hcd               18980  0 
usbcore               108348  7 usbmouse,usbkbd,usblp,usbhid,ehci_hcd,ohci_hcd
-------------- next part --------------
00:00.0 Class 0600: 10de:01e0 (rev c1)
00:00.1 Class 0500: 10de:01ea (rev c1)
00:00.2 Class 0500: 10de:01ee (rev c1)
00:00.3 Class 0500: 10de:01ed (rev c1)
00:00.4 Class 0500: 10de:01ec (rev c1)
00:00.5 Class 0500: 10de:01ef (rev c1)
00:01.0 Class 0601: 10de:0060 (rev a4)
00:01.1 Class 0c05: 10de:0064 (rev a2)
00:02.0 Class 0c03: 10de:0067 (rev a4)
00:02.1 Class 0c03: 10de:0067 (rev a4)
00:02.2 Class 0c03: 10de:0068 (rev a4)
00:04.0 Class 0200: 10de:0066 (rev a1)
00:06.0 Class 0401: 10de:006a (rev a1)
00:08.0 Class 0604: 10de:006c (rev a3)
00:09.0 Class 0101: 10de:0065 (rev a2)
00:1e.0 Class 0604: 10de:01e8 (rev c1)
02:00.0 Class 0300: 10de:0322 (rev a1)
-------------- next part --------------
 
[root at cau lm-sensors]# sensors-detect

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
 Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce2 SMBus (MCP)
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-nforce2' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus nForce2 adapter at 5500
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x08
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85 or LM96000'... Failed!
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `National Semiconductor LM93'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Success!
    (confidence 8, driver `asb100'), other addresses: 0x48 0x49
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Winbond W83L785R'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Philips NE1619'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `Analog Devices ADM1030'... Failed!
Probing for `Analog Devices ADM1031'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `VIA VT1211 (I2C)'... Failed!
Probing for `ITE IT8712F'... Failed!
Probing for `ITE IT8705F / SiS 950'... Failed!
Probing for `ALi M5879'... Failed!
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85 or LM96000'... Failed!
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'... Failed!
Probing for `Analog Devices ADT7467'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `National Semiconductor LM93'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Winbond W83L785TS-S'... Success!
    (confidence 8, driver `w83l785ts')
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `Analog Devices ADM1030'... Failed!
Probing for `Analog Devices ADM1031'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `Analog Devices ADM1028'... Failed!
Probing for `ITE IT8712F'... Failed!
Probing for `ITE IT8705F / SiS 950'... Failed!
Client found at address 0x37
Client found at address 0x48
Probing for `National Semiconductor LM75'... Failed!
Probing for `National Semiconductor LM77'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Maxim MAX6650/MAX6651'... Failed!
Probing for `National Semiconductor LM92'... Failed!
Probing for `National Semiconductor LM76'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x49
Probing for `National Semiconductor LM75'... Failed!
Probing for `National Semiconductor LM77'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `National Semiconductor LM92'... Failed!
Probing for `National Semiconductor LM76'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!

Next adapter: SMBus nForce2 adapter at 5000
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x08
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): yes
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

Do you want to scan for Super I/O sensors? (YES/no): yes
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x87)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x87)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x87)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x87)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x87)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x87)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x87)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (0x8708)

Do you want to scan for secondary Super I/O sensors? (YES/no): yes
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

Driver `asb100' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 5500'
    Busdriver `i2c-nforce2', I2C address 0x2d (and 0x48 0x49)
    Chip `Asus ASB100 Bach' (confidence: 8)

Driver `w83l785ts' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 5500'
    Busdriver `i2c-nforce2', I2C address 0x2e
    Chip `Winbond W83L785TS-S' (confidence: 8)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 5000'
    Busdriver `i2c-nforce2', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 5000'
    Busdriver `i2c-nforce2', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? isa

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
# I2C chip drivers
modprobe asb100
modprobe w83l785ts
modprobe eeprom
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): no
[root at cau lm-sensors]#              
