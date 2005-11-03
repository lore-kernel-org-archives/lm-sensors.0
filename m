From: davidhaertig@earthlink.net (David Haertig)
Date: Thu, 03 Nov 2005 05:37:58 +0000
Subject: [lm-sensors] lm-sensors install changed/corrupted
Message-Id: <43699477.5000809@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all -

I'm a bit confused here.  After installing lm-sensors where
everything went smoothly, I rebooted.  My computer then
hung in POST!!!  At the normal "Display PC hardware health"
screen.  It got so far as to display "CPU temp = 246 degrees
celcius"  (Yikes! - I doubt that's accurate) and then hung.
100% repeatable.  I then disabled "Show H/W Monitor in POST"
in the BIOS and was able to boot successfully.  The "sensors"
program displays bogus numbers, but I couldn't care less
about that right now.  I more concerned that I'm now having
a problem >>> in POST <<< ???!!!

Below are the specifics I can come up with, in excruciating
detail.  Please let me know if other info would be useful
(and where/how to obtain it).  First find hardware/OS info,
followed by lspci, lsmod, sensors-detect, and dmesg output.

I am concerned enough that I appear to have a problem on
the mobo, BIOS, or some-chips-firmware that I am wary of
even turning the computer on, for fear of overheating
something and not being aware of it.  So if possible, a
quick reply would be most appreciated!

Thanks!

Specifics:
=====

BioStar iDeq 210P SFF barebones
    K8NBP motherboard (socket 754)
    nForce3 250Gb chipset
    ITE IT8712 Super I/O
    VIA VT6307 (IEEE 1394A)
    nVidia CK8
    Onboard sound and ethernet
    Phoenix-Award BIOS
Components added:
    Athlon64 3000+
    1Gb Corsair ValueSelect PC3200 (one stick)
    eVGA nVidia MX4000 64Mb AGP
    200 Gb PATA Seagate Barracuda (boot drive)
    120 Gb SATA Seagate Barracuda (secondary drive)
    Hauppauge PVR-150 (model #1045) ISA video tuner/capture card
    NEC 3540A DVD burner
    PS/2 mouse, standard keyboard, LogiTech speakers

OS and software:
    Debian Sarge 3.1r0a, LVM2, all filesystems EXT3
    Kernel 2.6.12-1-686 (downloaded from Debian unstable)
    nVidia graphic drivers (version 7676)
    Can dual-boot to Windows 2000 Pro SP4 or MSDOS
    lm-sensors 1:2.9.1-1sarge2 (apt-get from Debian stable)

Technically I guess this is a mixed stable/unstable Debian
system ... but mostly it's standard Sarge 3.1r0a  The only
things downloaded from unstable are the kernel, the kernel
source, and gcc version 4.0  These were needed to support
my nForce3 SATA and onboard ethernet.  The nVidia display
drivers were downloaded from nVidia's website and compiled
locally.

---

0000:00:00.0 0600: 10de:00e1 (rev a1)
0000:00:01.0 0601: 10de:00e0 (rev a2)
0000:00:01.1 0c05: 10de:00e4 (rev a1)
0000:00:02.0 0c03: 10de:00e7 (rev a1)
0000:00:02.1 0c03: 10de:00e7 (rev a1)
0000:00:02.2 0c03: 10de:00e8 (rev a2)
0000:00:05.0 0680: 10de:00df (rev a2)
0000:00:06.0 0401: 10de:00ea (rev a1)
0000:00:08.0 0101: 10de:00e5 (rev a2)
0000:00:0a.0 0101: 10de:00e3 (rev a2)
0000:00:0b.0 0604: 10de:00e2 (rev a2)
0000:00:0e.0 0604: 10de:00ed (rev a2)
0000:00:18.0 0600: 1022:1100
0000:00:18.1 0600: 1022:1101
0000:00:18.2 0600: 1022:1102
0000:00:18.3 0600: 1022:1103
0000:01:00.0 0300: 10de:0185 (rev c1)
0000:02:06.0 0c00: 1106:3044 (rev 46)
0000:02:0a.0 0400: 4444:0016 (rev 01)

---

Module                  Size  Used by
nvidia               3699176  12
ipv6                  261984  8
ipt_REJECT              5504  1
ipt_state               1696  1
iptable_filter          2784  1
iptable_mangle          2656  0
iptable_nat            23092  0
ip_conntrack           44536  2 ipt_state,iptable_nat
ip_tables              20128  5 
ipt_REJECT,ipt_state,iptable_filter,iptable_mangle,iptable_nat
parport_pc             36708  0
parport                36936  1 parport_pc
floppy                 60180  0
pcspkr                  3332  0
rtc                    12376  0
shpchp                 99428  0
pci_hotplug            28468  1 shpchp
snd_intel8x0           34016  2
snd_ac97_codec         83960  1 snd_intel8x0
snd_pcm_oss            54848  1
snd_mixer_oss          19968  2 snd_pcm_oss
snd_pcm                93416  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              24644  1 snd_pcm
snd                    56260  6 
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               9696  3 snd
snd_page_alloc          9860  2 snd_intel8x0,snd_pcm
forcedeth              18976  0
ehci_hcd               35336  0
usb_storage            76384  0
ohci_hcd               21348  0
usbcore               122300  4 ehci_hcd,usb_storage,ohci_hcd
amd64_agp              12648  1
agpgart                35560  2 nvidia,amd64_agp
ide_scsi               17700  0
sata_nv                 8964  0
libata                 49604  1 sata_nv
ohci1394               35604  0
nls_cp437               5568  1
ntfs                  113872  1
dm_mod                 60540  6
tsdev                   7808  0
mousedev               11776  1
it87                   27712  0
evdev                   9728  0
eeprom                  7280  0
lm90                   13924  0
i2c_sensor              3264  3 it87,eeprom,lm90
i2c_isa                 1888  0
i2c_nforce2             6752  0
i2c_core               21776  6 
it87,eeprom,lm90,i2c_sensor,i2c_isa,i2c_nforce2
sr_mod                 17380  0
sd_mod                 19664  0
sbp2                   23432  0
scsi_mod              138472  6 
usb_storage,ide_scsi,libata,sr_mod,sd_mod,sbp2
ieee1394              104632  2 ohci1394,sbp2
psmouse                31236  0
ide_cd                 43140  0
cdrom                  40640  2 sr_mod,ide_cd
ext3                  141736  7
jbd                    56760  1 ext3
mbcache                 9252  1 ext3
ide_disk               18688  6
ide_generic             1152  0 [permanent]
via82cxxx              13820  0 [permanent]
trm290                  4196  0 [permanent]
triflex                 3680  0 [permanent]
slc90e66                5664  0 [permanent]
sis5513                16488  0 [permanent]
siimage                12448  0 [permanent]
serverworks             9032  0 [permanent]
sc1200                  7296  0 [permanent]
rz1000                  2400  0 [permanent]
piix                   10340  0 [permanent]
pdc202xx_old           11168  0 [permanent]
opti621                 4324  0 [permanent]
ns87415                 4264  0 [permanent]
hpt366                 20384  0 [permanent]
hpt34x                  5152  0 [permanent]
generic                 3808  0 [permanent]
cy82c693                4676  0 [permanent]
cs5530                  5312  0 [permanent]
cs5520                  4544  0 [permanent]
cmd64x                 12028  0 [permanent]
atiixp                  5904  0 [permanent]
amd74xx                14396  0 [permanent]
alim15x3               12268  0 [permanent]
aec62xx                 7360  0 [permanent]
pdc202xx_new            9248  0 [permanent]
ide_core              130388  30 
usb_storage,ide_scsi,ide_cd,ide_disk,ide_generic,via82cxxx,trm290,triflex,slc90e66,sis5513,siimage,serverworks,sc1200,rz1000,piix,pdc202xx_old,opti621,ns87415,hpt366,hpt34x,generic,cy82c693,cs5530,cs5520,cmd64x,atiixp,amd74xx,alim15x3,aec62xx,pdc202xx_new
unix                   27888  434
fbcon                  39936  0
tileblit                2240  1 fbcon
font                    8096  1 fbcon
bitblit                 5920  1 fbcon
vesafb                  7992  0
cfbcopyarea             3872  1 vesafb
cfbimgblt               2816  1 vesafb
cfbfillrect             4128  1 vesafb
softcursor              2176  1 vesafb
capability              4584  0
commoncap               6912  1 capability

---

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
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce3 
250Gb SMBus (MCP)
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-nforce2' already loaded.
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

Next adapter: SMBus nForce2 adapter at 4c40
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus nForce2 adapter at 4c00
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client at address 0x50 can not be probed - unload all client drivers first!

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
Trying address 0x0290... Success!
(confidence 8, driver `it87')
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
Failed! (0x8712)
Probing for `ITE 8705F Super IO Sensors'
Failed! (0x8712)
Probing for `ITE 8712F Super IO Sensors'
Success... found at address 0x0290
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
Failed! (skipping family)

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

Driver `it87' (should be inserted):
Detects correctly:
* ISA bus address 0x0290 (Busdriver `i2c-isa')
Chip `ITE 8712F Super IO Sensors' (confidence: 9)


I will now generate the commands needed to load the I2C modules.
Sometimes, a chip is available both through the ISA bus and an I2C bus.
ISA bus access is faster, but you need to load an additional driver module
for it. If you have the choice, do you want to use the ISA bus or the
I2C/SMBus (ISA/smbus)? ISA

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-isa
# I2C chip drivers
it87
#----cut here----

Do you want to add these lines to /etc/modules automatically? (yes/NO)NO

---

CPU: After all inits, caps: 078bfbff e1d3fbff 00000000 00000010 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=0 pin2=-1
checking if image is initramfs...it isn't (bad gzip magic numbers); 
looks like an initrd
Freeing initrd memory: 4848k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfbae0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 10 *11 12 14 15)
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
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
pnp: 00:00: ioport range 0x4400-0x447f has been reserved
pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:00: ioport range 0x4800-0x487f has been reserved
pnp: 00:00: ioport range 0x4880-0x48ff has been reserved
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
ACPI wakeup devices:
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1
ACPI: (supports S0 S1 S4 S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4848KiB [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 180k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
Capability LSM initialized
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST3200822A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3540A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS$321/255/63, 
UDMA(100)
hda: cache flushes supported
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 >
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 514040k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda7, internal journal
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ieee1394: Initialized config rom entry `ip1394'
SCSI subsystem initialized
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
it87: Found IT8712F chip at 0x290, revision 7
mice: PS/2 mouse device common for all mice
ts: Compaq touchscreen protocol output
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS driver 2.1.22 [Flags: R/O MODULE].
NTFS volume version 3.0.
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [APC1] -> GSI 16 (level, 
low) -> IRQ 177
PCI: Via IRQ fixup for 0000:02:06.0, from 10 to 1
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[177] 
MMIO=[e6000000-e60007ff]  Max Packet=[2048]
libata version 1.11 loaded.
sata_nv version 0.6
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 22 (level, 
high) -> IRQ 185
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xDC00 irq 185
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xDC08 irq 185
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
88:407f
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device removed
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: no device found (phy stat 00000000)
scsi1 : sata_nv
   Vendor: ATA       Model: ST3120827AS       Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sda: drive cache: write back
  /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0030670000047d2c]
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: AGP aperture is 128M @ 0xd0000000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 21 (level, 
high) -> IRQ 193
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: nVidia Corporation CK8S USB Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 193, io mem 0xe7002000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 20 (level, 
high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: nVidia Corporation CK8S USB Controller (#2)
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.1: irq 201, io mem 0xe7003000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
usb 2-4: new full speed USB device using ohci_hcd and address 2
Initializing USB Mass Storage driver...
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 22 (level, 
high) -> IRQ 185
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 EHCI USB 2.0 Controller
ehci_hcd 0000:00:02.2: debug port 1
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:02.2: irq 185, io mem 0xe7004000
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
usb 2-4: USB disconnect, address 2
usb 2-4: new full speed USB device using ohci_hcd and address 3
scsi3 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.32.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APCH] -> GSI 21 (level, 
high) -> IRQ 193
PCI: Setting latency timer of device 0000:00:05.0 to 64
eth0: forcedeth.c: subsystem: 01565:2501 bound to 0000:00:05.0
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 20 (level, 
high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49678 usecs
intel8x0: clocking to 46756
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset = 0
shpchp: shpc_init : shpc_cap_offset = 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
   Vendor: IC        Model: USB Storage-CFC   Rev: 322E
   Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdb at scsi3, channel 0, id 0, lun 0
   Vendor: IC        Model: USB Storage-SMC   Rev: 322E
   Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdc at scsi3, channel 0, id 0, lun 1
   Vendor: IC        Model: USB Storage-MMC   Rev: 322E
   Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdd at scsi3, channel 0, id 0, lun 2
   Vendor: IC        Model: USB Storage-MSC   Rev: 322E
   Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sde at scsi3, channel 0, id 0, lun 3
usb-storage: device scan complete
Real Time Clock Driver v1.12
input: PC Speaker
FDC 0 is a post-1991 82077
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 248 bytes per conntrack
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0331860(lo)
IPv6 over IPv4 tunneling driver
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC5] -> GSI 16 (level, 
low) -> IRQ 177
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7676  Fri Jul 
29 12:58:54 PDT 2005
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
eth0: no IPv6 routers present

---



