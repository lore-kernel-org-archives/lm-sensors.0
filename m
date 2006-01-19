From: tparcina@lama.hr (=?iso-8859-2?Q?Tomislav_Par=E8ina?=)
Date: Thu, 19 Jan 2006 08:48:08 +0000
Subject: [lm-sensors] Via Epia-PD6000 - no sensor readings
Message-Id: <79337FA3BA80774F9FE87BF809C9F356201DEC@stipe.lama.hr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi everybody,

I have problem listed below - I don't get any sensors reading.
[root at ast26 ~]# sensors
eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at 0500
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256


According to Sensors FAQ those are information's that I need to send if I w=
ant receive some help :)) So here they are.

My motherboard is Via Epia-PD6000 (http://www.via.com.tw/en/products/mainbo=
ards/mini_itx/epia_pd/), lm_sensors-2.9.2-42.rhfc4.at.i386.rpm, and Kernel =
version 2.6.11-1.1369_FC4.

The readings are in attachment (in txt files, to be more clear) and below t=
his text. If you need more information please ask.

*********************************************
Dmesg
Linux version 2.6.11-1.1369_FC4 (bhcompile at tweety.build.redhat.com) (gcc=
 version 4.0.0 20050525 (Red Hat 4.0.0-9)) #1 Thu Jun 2 22:53:35 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eff0000 (usable)
 BIOS-e820: 000000000eff0000 - 000000000eff3000 (ACPI NVS)
 BIOS-e820: 000000000eff3000 - 000000000f000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
239MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 61424
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 57328 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 VT9174                                ) @ 0x000f6480
ACPI: RSDT (v001 VT9174 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0eff3000
ACPI: FADT (v001 VT9174 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0eff3040
ACPI: DSDT (v001 VT9174 AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 0f000000 (gap: 0f000000:f0ff0000)
Built 1 zonelists
Kernel command line: ro root=3D/dev/VolGroup00/LogVol00
Initializing CPU#0
CPU 0 irqstacks, hard=C044a000 soft=C0449000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 601.562 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 237312k/245696k available (2467k kernel code, 7768k reserved, 685k =
data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1187.84 BogoMIPS (lpjY3920)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 00803035 80803035 00000000 00000000 0000=
0000 00000000 00000000
CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 64K (32 bytes/line)
CPU: After all inits, caps: 00803135 80803035 00000000 00000000 00000000 00=
000000 00000000
CPU: Centaur VIA Samuel 2 stepping 03
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 1e20)
checking if image is initramfs... it is
softlockup thread 0 started up.
Freeing initrd memory: 1670k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfad30, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
PCI: Via IRQ fixup
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
pnp: 00:01: ioport range 0x400-0x47f could not be reserved
pnp: 00:01: ioport range 0x500-0x50f has been reserved
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1137661511.244:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key F8472E5DA68A03D6
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 2 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA CLE266 chipset
agpgart: AGP aperture is 4M @ 0xe6000000
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 10
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 10 (level, low) -=
> IRQ 10
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HTS541040G9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB) w/7539KiB Cache, CHS=16383/255/63, UDMA(10=
0)
hda: cache flushes supported
 hda: hda1 hda2
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS%6, MD_SB_DISKS'
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 16Kbytes
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 5, 229376 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:=20
PCI0 USB0 USB1 USB2 USB3 USB4 USB5 USB6 LAN0 AC97 UAR1=20
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 184k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel at redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
Floppy drive(s): fd0 is unknown type 15 (usb?), fd1 is unknown type 15 (usb=
?)
floppy0: no floppy controllers found
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
eth0: VIA Rhine III at 0xe6400000, 00:40:63:df:e1:65, IRQ 11.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 10 (level, low) -=
> IRQ 10
eth1: VIA Rhine II at 0xe6402000, 00:40:63:df:e1:15, IRQ 10.
eth1: MII PHY found at address 1, status 0x786d advertising 05e1 Link 41e1.
shpchp: shpc_init : shpc_cap_offset =3D 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
CSLIP: code copyright 1989 Regents of the University of California
ISDN subsystem Rev: 1.1.2.3/1.1.2.3/1.1.2.2/1.1.2.3/1.1.2.2/1.1.2.2 loaded
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (module)
HiSax: Layer1 Revision 2.46.2.5
HiSax: Layer2 Revision 2.30.2.4
HiSax: TeiMgr Revision 2.20.2.3
HiSax: Layer3 Revision 2.22.2.3
HiSax: LinkLayer Revision 2.59.2.4
ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: irq 11, io mem 0xe6401000
ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 10 (level, low) -=
> IRQ 10
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 10, io base 0x0000d400
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 12 (level, low) -=
> IRQ 12
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 12, io base 0x0000d800
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [LNKC] -> GSI 5 (level, low) ->=
 IRQ 5
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 5, io base 0x0000dc00
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 491512k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
vt1211: version magic '2.6.11-1.1369_FC4 686 REGPARM 4KSTACKS gcc-4.0' shou=
ld be '2.6.11-1.1369_FC4 586 REGPARM 4KSTACKS gcc-4.0'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (interrupt-driven).
lp0: console ready
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03d9780(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present

****************************************************

I2cdetect
[root at ast26 /]# i2cdetect
Error: No i2c-bus specified!
Syntax: i2cdetect [-y] [-a] [-q|-r] I2CBUS [FIRST LAST]
        i2cdetect -l
        i2cdetect -V
  I2CBUS is an integer
  With -a, probe all addresses (NOT RECOMMENDED)
  With -q, uses only quick write commands for probing (NOT RECOMMENDED)
  With -r, uses only read byte commands for probing (NOT RECOMMENDED)
  If provided, FIRST and LAST limit the probing range.
  With -l, lists installed busses only
  Installed I2C busses:
    i2c-1       dummy           ISA main adapter                        ISA=
 bus
algorithm
    i2c-0       unknown         SMBus Via Pro adapter at 0500           Alg=
orith
m unavailable
[root at ast26 /]#


[root at ast26 ~]# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX
[root at ast26 ~]#


[root at ast26 ~]# i2cdetect 1
Error: Can't use SMBus Quick Write command on this bus (ISA bus?)
[root at ast26 ~]#

*********************************************************

I2cdump
[root at ast26 ~]# i2cdump 0 0x69
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x69, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
10: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
20: 0f XX 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ?X??????????????
30: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
[root at ast26 ~]#


**********************************************************

Lsmod
Module                  Size  Used by
i2c_dev                10689  0=20
md5                     4033  1=20
ipv6                  266433  10=20
parport_pc             28805  1=20
lp                     13001  0=20
parport                39689  2 parport_pc,lp
autofs4                27333  2=20
eeprom                  7505  0=20
i2c_sensor              3521  1 eeprom
i2c_isa                 2241  0=20
rfcomm                 42589  0=20
l2cap                  30021  5 rfcomm
bluetooth              55109  4 rfcomm,l2cap
sunrpc                162821  1=20
video                  15941  0=20
button                  6609  0=20
battery                 9413  0=20
ac                      4805  0=20
uhci_hcd               34897  0=20
ehci_hcd               39757  0=20
hisax                 598429  0=20
crc_ccitt               2113  1 hisax
isdn                  149569  1 hisax
slhc                    7361  1 isdn
shpchp                 91205  0=20
i2c_viapro              8145  0=20
i2c_core               21825  5 i2c_dev,eeprom,i2c_sensor,i2c_isa,i2c_viapro
via_rhine              27465  0=20
mii                     5569  1 via_rhine
dm_snapshot            17669  0=20
dm_zero                 2113  0=20
dm_mirror              25261  0=20
ext3                  132297  2=20
jbd                    79449  1 ext3
dm_mod                 58997  6 dm_snapshot,dm_zero,dm_mirror

*****************************************************

Lspci
00:00.0 Class 0600: 1106:3123
00:01.0 Class 0604: 1106:b091
00:0f.0 Class 0200: 1106:3106 (rev 8b)
00:10.0 Class 0c03: 1106:3038 (rev 80)
00:10.1 Class 0c03: 1106:3038 (rev 80)
00:10.2 Class 0c03: 1106:3038 (rev 80)
00:10.3 Class 0c03: 1106:3104 (rev 82)
00:11.0 Class 0601: 1106:3177
00:11.1 Class 0101: 1106:0571 (rev 06)
00:12.0 Class 0200: 1106:3065 (rev 74)
00:14.0 Class 0780: e159:0001
01:00.0 Class 0300: 1106:3122 (rev 03)

*****************************************************

Sensors-detect

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
 Do you want to probe now? (YES/no): Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies VT8233A/8235 S=
outh Bridge
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):  Module loade=
d succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detect=
ed;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus Via Pro adapter at 0500
Do you want to scan it? (YES/no/selectively): Client at address 0x50 can no=
t be probed - unload all client drivers first!
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): Probing for `National Semiconduc=
tor LM78'
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

Do you want to scan for Super I/O sensors? (YES/no): Probing for `ITE 8702F=
 Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Success... found at address 0x6000
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x3c)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x3c)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x3c)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x3c)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x3c)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x3c)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (0x3c02)

Do you want to scan for secondary Super I/O sensors? (YES/no): Probing for =
`ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Success... but not activated
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x3c)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x3c)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x3c)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x3c)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x3c)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x3c)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (0x3c02)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:=20
Driver `vt1211' (should be inserted):
  Detects correctly:
  * ISA bus address 0x6000 (Busdriver `i2c-isa')
    Chip `VT1211 Super IO Sensors' (confidence: 9)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?=20
To make the sensors modules behave correctly, add these lines to
/etc/modprobe.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe vt1211
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): Copy prog/init=
/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.




I hope somebody will be able to help me.



--
Tomislav Par?ina
Lama Computers Split
Stinice 12, 21000 Split
Tel.: +385(21)393447
e-mail: tparcina#lama.hr
http://www.lama.hr
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: dmesg.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060119/=
523096b1/dmesg-0001.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: i2cdetect.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060119/=
523096b1/i2cdetect-0001.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: i2cdump.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060119/=
523096b1/i2cdump-0001.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: lsmod.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060119/=
523096b1/lsmod-0001.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: lspci.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060119/=
523096b1/lspci-0001.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensor-detect.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060119/=
523096b1/sensor-detect-0001.txt
