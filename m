From: martin@martin-fernau.de (Martin Fernau)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: no FAN3 available
Message-Id: <200309011224.08300.martin@martin-fernau.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there,

I just have a problem with one fan in my system. The processor fan works=20
correctly. But I recently added a system-fan which I connected to FAN3=20
connector on my board. But when I type 'sensors' I get only fan-output for =

FAN1 (CPU) and FAN2 (no fan connected so its every time 0) but no data for =

FAN3 where my system-fan is conneced to. I hope, you can help me to get it =

working :)
Winbond chip: W83697HF
Mainboard: Epox EP-8KHA+
Sensors ver: 2.7.0-r1
Kernel: 2.4.20

Regards,
Martin Fernau
- --=20

Name		: Martin Fernau
EMail		: martin@martin-fernau.de
url		: http://www.martin-fernau.de
icq		: 14509914

Random witze fortune:

Ein Medizinmann wird von den Stammesmitgliedern immer wieder nach
dem Winter gefragt. Er sagt jedem, da? ein sehr harter Winter zu
erwarten sei und es ratsam w?re viel Holz zu sammeln.

Nach ein paar Wochen hat sich ein beachtlicher Vorrat angesammelt
und der Medizinmann bekommt Bedenken, ob er seinen Leuten weiter
diesen Rat geben soll. Aus diesem Grund ruft er beim Wetteramt an
um sich von fachkundiger Seite einen guten Rat zu holen. Die Antort
vom Wetteramt lautet:

"Es wird bestimmt ein harter Winter! Die Indianer sammeln schon
seit Wochen wie verr?ckt Holz."
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Ux5HnYbNbD9S1MURAoTDAJ9T3Qty0TCNirRiIZsukysixDkf0ACfTLMK
xSVkQ1MLfnLS7maNvdSYT1Q=3DpxV4
-----END PGP SIGNATURE-----
-------------- next part --------------
Linux version 2.4.20-gentoo-r5 (root@murpy) (gcc version 3.2.3 20030422 (Ge=
ntoo Linux 1.4 3.2.3-r1, propolice)) #1 Sun Aug 24 23:24:29 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 VIA694                     ) @ 0x000f7360
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
Kernel command line: root=3D/dev/hda3 hdc=3Dide-scsi
ide_setup: hdc=3Dide-scsi
Initializing CPU#0
Detected 1403.307 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2791.83 BogoMIPS
Memory: 512660k/524224k available (1484k kernel code, 9000k reserved, -1912=
k data, 264k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:             Common caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: AMD Athlon(tm) XP 1600+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021122
PCI: PCI BIOS revision 2.10 entry at 0xfb470, last bus=3D1
PCI: Using configuration type 1
    ACPI-0511: *** Info: GPE Block0 defined as GPE0 to GPE15
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
schedule_task(): keventd has not started
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
PCI: Probing PCI hardware
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: detected chipset, but driver not compiled in!
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L040AVVA07-0, ATA DISK drive
hdb: Maxtor 4D080H4, ATA DISK drive
hdc: LITE-ON LTR-24102B, ATAPI CD/DVD-ROM drive
hdd: _NEC DV-5700A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80418240 sectors (41174 MB) w/1863KiB Cache, CHSP05/255/63
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63
hdd: ATAPI 40X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
 /dev/ide/host0/bus0/target1/lun0: p1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 9, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected=20
sym53c875-0: rev 0x26 on pci bus 0 device 9 function 0 irq 11
sym53c875-0: ID 7, Fast-20, Parity Checking
scsi0 : sym53c8xx-1.7.3c-20010512
  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-24102B        Rev: 5S54
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
sym53c875-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 16)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 < p5 >
sym53c875-0-<1,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 16)
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1 < p5 p6 p7 >
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray
sr0: mmc-3 profile capable, current profile: 9h
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
uhci.c: USB UHCI at I/O 0xd800, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: USB UHCI at I/O 0xdc00, IRQ 11
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: USB UHCI at I/O 0xe000, IRQ 11
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 264k freed
hub.c: new USB device 00:11.2-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x46d/0xc00b) is not claimed by any active d=
river.
Adding Swap: 1004052k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xc800. Vers LK1.1.16
usb.c: registered new driver hid
input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:2.0
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4363  Sat A=
pr 19 17:46:46 PDT 2003
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-viapro.o version 2.7.0 (20021208)
i2c-viapro.o: Found Via VT8233 device
i2c-viapro.o: Via Pro SMBus detected and initialized
i2c-isa.o version 2.7.0 (20021208)
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-proc.o version 2.7.0 (20021208)
eeprom.o version 2.7.0 (20021208)
w83781d.o version 2.7.0 (20021208)
Real Time Clock Driver v1.10e
blk: queue c0143164, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c01432a4, I/O limit 4095Mb (mask 0xffffffff)
hdd: CHECK for good STATUS
hdd: drive_cmd: status=3D0x51 { DriveReady SeekComplete Error }
hdd: drive_cmd: error=3D0x04
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT266 chipset
agpgart: AGP aperture is 128M @ 0xd0000000
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
i2c-dev.o: Registered 'SMBus Via Pro adapter at 5000' as minor 0
i2c-dev.o: Registered 'ISA main adapter' as minor 1
i2c-algo-pcf.o: i2c pcf8584 algorithm module version 2.7.0 (20021208)
i2c-elektor.o: i2c pcf8584-isa adapter module version 2.7.0 (20021208)
i2c-algo-bit.o: i2c bit algorithm module version 2.7.0 (20021208)
i2c-elv.o: i2c ELV parallel port adapter module version 2.7.0 (20021208)
i2c-dev.o: Registered 'ELV Parallel port adaptor' as minor 2
i2c-elv.o: found device at 0x378.
i2c-philips-par.o: i2c Philips parallel port adapter module version 2.7.0 (=
20021208)
i2c-velleman.o: i2c Velleman K8000 adapter module version 2.7.0 (20021208)
i2c-velleman.o: Port 0x378 already in use.
-------------- next part --------------
Module                  Size  Used by    Tainted: P =20
i2c-philips-par         2428   0  (unused)
parport                26368   0  [i2c-philips-par]
i2c-elv                 1540   0=20
i2c-algo-bit            8392   1  [i2c-philips-par i2c-elv]
i2c-dev                 4772   0=20
snd-pcm-oss            39940   1  (autoclean)
snd-mixer-oss          13848   1  (autoclean) [snd-pcm-oss]
agpgart                14288   3  (autoclean)
smbfs                  40048   6  (autoclean)
rtc                     7644   0  (autoclean)
nls_iso8859-1           2844   4  (autoclean)
nls_cp437               4348   4  (autoclean)
vfat                   10700   4  (autoclean)
fat                    33336   0  (autoclean) [vfat]
w83781d                20400   0  (unused)
eeprom                  3668   0  (unused)
i2c-proc                7440   0  [w83781d eeprom]
i2c-isa                 1160   0  (unused)
i2c-viapro              3984   0=20
i2c-core               15816   0  [i2c-algo-bit i2c-dev w83781d eeprom i2c-=
proc i2c-isa i2c-viapro]
nvidia               1542336  10=20
snd-emu10k1            73460   2=20
snd-pcm                65024   0  [snd-pcm-oss snd-emu10k1]
snd-timer              15880   0  [snd-pcm]
snd-page-alloc          5292   0  [snd-emu10k1 snd-pcm]
snd-util-mem            1408   0  [snd-emu10k1]
snd-rawmidi            15072   0  [snd-emu10k1]
snd-seq-device          4448   0  [snd-emu10k1 snd-rawmidi]
snd-hwdep               5280   0  [snd-emu10k1]
snd-ac97-codec         37888   0  [snd-emu10k1]
snd                    32644   0  [snd-pcm-oss snd-mixer-oss snd-emu10k1 sn=
d-pcm snd-timer snd-util-mem snd-rawmidi snd-seq-device snd-hwdep snd-ac97-=
codec]
soundcore               4164   6  [snd]
mousedev                4372   1=20
hid                    13992   0  (unused)
input                   3648   0  [mousedev hid]
3c59x                  27568   1=20
-------------- next part --------------
eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
Memory size (MB):       256

eeprom-i2c-0-51
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
Memory size (MB):       256

w83697hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore:     +1.76 V  (min =3D  +0.00 V, max =3D  +0.00 V)             =20
+3.3V:     +1.52 V  (min =3D  +2.97 V, max =3D  +3.63 V)             =20
+5V:       +4.86 V  (min =3D  +4.50 V, max =3D  +5.48 V)             =20
+12V:     +12.50 V  (min =3D +10.79 V, max =3D +13.11 V)             =20
-12V:      +2.00 V  (min =3D -13.21 V, max =3D -10.90 V)             =20
-5V:       +0.58 V  (min =3D  -5.51 V, max =3D  -4.51 V)             =20
V5SB:      +5.48 V  (min =3D  +4.50 V, max =3D  +5.48 V)             =20
VBat:      +3.15 V  (min =3D  +2.70 V, max =3D  +3.29 V)             =20
fan1:     3199 RPM  (min =3D 3000 RPM, div =3D 2)                    =20
fan2:        0 RPM  (min =3D 3000 RPM, div =3D 2)                    =20
temp1:       +32?C  (limit =3D  +60?C)                       sensor =3D the=
rmistor          =20
temp2:     +46.0?C  (limit =3D  +60?C, hysteresis =3D  +50?C) sensor =3D th=
ermistor          =20
alarms:  =20
beep_enable:
          Sound alarm disabled
