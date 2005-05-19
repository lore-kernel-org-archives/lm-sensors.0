From: antonio@sunstone.it (Antonio Gennarini)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: lm_sensors error. Complete output of problem.
Message-Id: <20020217024154.A1328@geolandia.home>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi.

It's days now that I'm trying to get lm_sensors to work on my RH7.1 and Asu=
s motherboard but tere's nothing to do. I read the FAQ very well but nothin=
g. The only chance I have is that you help me out somehow. The sensors dete=
ct reveal sensors on my PC but when I run 'sensors' i get 'No sensors found=
' even with all modules loadeed in memory. I have tried with 2.4.2 kernel (=
i2c loaded as modules) and 2.4,14 kernel (i2c compiled directly into kernel=
) In both cases the result is the same, same errror. In the attached file t=
here is all the material and outputs requested by the FAQ so I hope it will=
 help figure out hte problem.

Bye and thanks.
--=20
                 Antonio Gennarini
                Crecchio, CH - ITALY
	-----------------------------------
Earth Science student at University "G. D'Annunzio".
     Join th GNU generation, start from LINUX.
-------------- next part --------------
###################################################################
sensors-detect output
###################################################################
1st question:
------------
ng for PCI bus adapters...
Use driver `i2c-piix4' for device 00:04.3: Intel 82371AB PIIX4 ACPI
Use driver `i2c-matroxfb' for device 01:00.0: MGA G200 AGP
Probe succesfully concluded.

2nd question:
------------
Next adapter: SMBus PIIX4 adapter at e800 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Success!
    (confidence 7, driver `lm78')
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Success!
    (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F'... Failed!
Client found at address 0x48
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `ITE IT8705F / IT8712F'... Failed!
Client found at address 0x49
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Dallas Semiconductor DS1621'... Success!
    (confidence 3, driver `ds1621')
Probing for `ITE IT8705F / IT8712F'... Failed!
Client found at address 0x50
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `ITE IT8705F / IT8712F'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x51
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `ITE IT8705F / IT8712F'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69

3rd question:
------------
 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): yae^H
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Success!
    (confidence 7, driver `lm78')
    Alias of the chip on I2C bus `SMBus PIIX4 adapter at e800', address 0x0=
02d
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
    Alias of the chip on I2C bus `SMBus PIIX4 adapter at e800', address 0x0=
02d
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT 82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F'
  Trying address 0x0290... Failed!




 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:=20

Driver `lm78' (may not be inserted):
  Misdetects:
  * Bus `SMBus PIIX4 adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x2d
    ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `National Semiconductor LM78' (confidence: 7)

Driver `w83781d' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x2d (and 0x48 0x49)
    ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83781D' (confidence: 8)

Driver `lm75' (may not be inserted):
  Misdetects:
  * Bus `SMBus PIIX4 adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x48
    Chip `National Semiconductor LM75' (confidence: 3)
  * Bus `SMBus PIIX4 adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x49
    Chip `National Semiconductor LM75' (confidence: 3)

Driver `ds1621' (may not be inserted):
  Misdetects:
  * Bus `SMBus PIIX4 adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x49
    Chip `Dallas Semiconductor DS1621' (confidence: 3)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x50
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
  * Bus `SMBus PIIX4 adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x51
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? isa

WARNING! If you have some things built into your kernel, the=20
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-piix4
# I2C chip drivers
modprobe w83781d
modprobe eeprom
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

#########################################################################
LSMOD OUTPUT:
#########################################################################
[root@gaia antonio]# /sbin/lsmod=20
Module                  Size  Used by
i2c-isa                 1232   0  (unused)
i2c-dev                 3648   0=20
i2c-piix4               4416   0=20
sensors                 6480   0=20
i2c-core               13408   0  [i2c-isa i2c-dev i2c-piix4 sensors]
sb                      7856   1  (autoclean)
sb_lib                 36016   0  (autoclean) [sb]
uart401                 6768   0  (autoclean) [sb_lib]
sound                  62688   1  (autoclean) [sb_lib uart401]
soundcore               4464   5  (autoclean) [sb_lib sound]
ide-cd                 26848   0  (autoclean)
cdrom                  27232   0  (autoclean) [ide-cd]
mga                    95984   1=20
agpgart                23392   3=20
parport_pc             17968   1  (autoclean)
lp                      5168   0  (autoclean)
parport                25952   1  (autoclean) [parport_pc lp]
8139too                16480   1  (autoclean)
ipchains               38976   0  (unused)
usb-uhci               20720   0  (unused)
usbcore                49664   1  [usb-uhci]
sd_mod                 11680   0  (unused)
scsi_mod               95072   1  [sd_mod]
[root@gaia antonio]# sensors
No sensors found!

######################################################################
DMESG OUTPUT
######################################################################
isapnp: Scanning for PnP cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative ViBRA16X PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 126341kB/42113kB, 384 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 51024H2, ATA DISK drive
hdb: Seagate Technology 1275MB - ST31276A, ATA DISK drive
hdc: FX120T, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 20010816 sectors (10246 MB) w/2048KiB Cache, CHS=1245/255/63, UDMA(33)
hdb: 2502308 sectors (1281 MB), CHSb0/64/63, DMA
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
 hdb: hdb1 hdb2 < hdb5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 313k freed
Serial driver version 5.02 (2000-08-09) with MANY_PORTS MULTIPORT SHARE_IRQ=
 SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Real Time Clock Driver v1.10d
md driver 0.90.0 MAX_MD_DEVS%6, MD_SB_DISKS'
md.c: sizeof(mdp_super_t) =3D 4096
autodetecting RAID arrays
autorun ...
... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
change_root: old root has d_count=3D3
Freeing unused kernel memory: 236k freed
Adding Swap: 136512k swap-space (priority -1)
Adding Swap: 125944k swap-space (priority -2)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 20:53:29 Apr  8 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:04.2
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
ip_conntrack (1535 buckets, 12280 max)
8139too Fast Ethernet driver 0.9.15 loaded
PCI: Found IRQ 5 for device 00:0a.0
eth0: RealTek RTL8139 Fast Ethernet at 0xcc86a000, 00:a0:a2:00:b8:9e, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
Winbond chip at EFER=3D0x3f0 key=3D0x87 devid=97 devrevs oldid=FF
Winbond chip type 83977TF / SMSC 97w33x/97w34x
Winbond LPT Config: cr_30=01 60,61=0378 70=07 74=03, f0;
Winbond LPT Config: active=3Dyes, io=3D0x0378 irq=3D7, dma=3D3
Winbond LPT Config: irqtype=3Dpulsed low, high-Z, ECP fifo threshold=3D7
Winbond LPT Config: Port mode=ECP and EPP-1.9
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 9
0x378: readIntrThreshold is 9
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=3D0x10 cfgB=3D0x48
0x378: ECP settings irq=3D7 dma=3D<none or set by other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 149M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xe4000000
[drm] AGP 0.99 on Intel 440BX @ 0xe4000000 64MB
[drm] Initialized mga 2.0.1 20000928 on minor 63
Linux video capture interface: v1.00
i2c: initialized
Zoran driver 1.00 (c) 1999 Rainer Johanni, Dave Perks.
zoran: no cards found.
hdc: ATAPI 12X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
cdrom: This disc doesn't have any tracks I recognize!
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative ViBRA16X PnP detected
sb: ISAPnP reports 'Creative ViBRA16X PnP' at i/o 0x220, irq 10, dma 1, 3
SB 4.16 detected OK (220)
SB16: Bad or missing 16 bit DMA channel
sb: 1 Soundblaster PnP card(s) found.
i2c-core.o: i2c core module
sensors.o version 2.5.5 (20010115)
piix4.o version 2.5.5 (20010115)
i2c-core.o: adapter SMBus PIIX4 adapter at e800 registered as adapter 0.
i2c-piix4.o: PIIX4 bus detected and initialized
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-dev.o: Registered 'SMBus PIIX4 adapter at e800' as minor 0
i2c-isa.o version 2.5.5 (20010115)
i2c-dev.o: Registered 'ISA main adapter' as minor 1
i2c-core.o: adapter ISA main adapter registered as adapter 1.
i2c-isa.o: ISA bus access for i2c modules initialized.

####################################
TECH & VERSIONS
####################################
moteherboard: ASUS P2B-F
lm_sensors: 2.2.5 (Redhat 7.1 default src rpm - compiled by me)
kernel: 2.4.2

sensors@stimpy.netroedge.com

=20
