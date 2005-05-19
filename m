From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: fan out of control (lm-sensors 2.6.2-1)
Message-Id: <20011221103157.Z789@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E16HU06-0006Nj-00@ernie.physik.uni-marburg.de>
In-Reply-To: <E16HU06-0006Nj-00@ernie.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Are you doing a 'sensors -s' (as root) to set those values?  Otherwise
they will never be set.  Fans usually have different high and low
thresholds for turning on and turning off.  I.e., it might need to get
to 60 degrees to turn the fan on, but might need to go down to 50
before it shuts off.


Phil

On Fri, Dec 21, 2001 at 07:02:29PM +0100, Marcus Eger wrote:
> Dear developers,
> 
> installation of l2c and lm-sensors does not work properly on my laptop 
> Twinhead GX3 p98 using Linux version 2.4.16 (root@dimbel) (gcc version 2.95.4 
> 20011006 (Debian prerelease)) #5 Fri Dec 21 16:40:48 CET 2001.
> 
> The problem:
> The following configuration in /etc/sensors.conf....
> 
> chip "max1617-*"
> 
>         set temp_over 60
>         set temp_low  57
>         set remote_temp_over 50
>         set remote_temp_low  47
> 
> .... is now and then overwritten (by the bios?), i.e. the temperature limits 
> change. Moreover, the fan cannot really be controled. It starts properly 
> when the temperature is beyond the limit, but it hardly ever stops.
> Has anybody got an idea?
> Thanks
>   Marcus Eger
> 
> 
> ###################################
> sensor and i2c was loaded as modules.
> 
> ii  i2c-source     2.6.2-1        sources for drivers for the i2c bus
> ii  libsensors1    2.6.2-1        Library to read temperature/voltage/fan sens
> ii  lm-sensors     2.6.2-1        Utilities to read temperature/voltage/fan se
> ii  lm-sensors-sou 2.6.2-1        Kernel drivers to read temperature/voltage/f
> 
> ################################################
> ################################################
> dimbel:/usr/src/modules/lm-sensors# cat /proc/bus/i2c
> i2c-0   smbus           SMBus PIIX4 adapter at 0440             Non-I2C SMBus 
> adapter
> 
> dimbel:/usr/src/modules/lm-sensors# prog/dump/i2cdump 0 0x23 b
>   WARNING! This program can confuse your I2C bus, cause data loss and worse!
>   I will probe file /dev/i2c-0, address 0x23, mode byte
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 
> 
> 
> ################################################
> ################################################
> dimbel:/usr/src/modules/lm-sensors# prog/dump/isadump 0x295 0x296
>   WARNING! Running this program can cause system crashes, data loss and worse!
>   I will probe address register 0x0295 and data register 0x0296.
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> 
> 
> ################################################
> ################################################
> dimbel:~# dmesg
> Linux version 2.4.16 (root@dimbel) (gcc version 2.95.4 20011006 (Debian 
> prerelease)) #5 Fri Dec 21 16:40:48 CET 2001
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
>  BIOS-e820: 0000000007ff0000 - 0000000007ff8000 (ACPI data)
>  BIOS-e820: 0000000007ff8000 - 0000000008000000 (ACPI NVS)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
> On node 0 totalpages: 32768
> zone(0): 4096 pages.
> zone(1): 28672 pages.
> zone(2): 0 pages.
> Kernel command line: BOOT_IMAGE=lxinst ro root02 mem8M 3
> Initializing CPU#0
> Detected 601.368 MHz processor.
> Console: colour VGA+ 80x50
> Calibrating delay loop... 1199.30 BogoMIPS
> Memory: 126308k/131072k available (1459k kernel code, 4376k reserved, 421k 
> data, 200k init, 0k highmem)
> Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
> Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
> Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
> CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 256K
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
> CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
> CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
> CPU: Intel Pentium III (Coppermine) stepping 03
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: Intel
> PCI: PCI BIOS revision 2.10 entry at 0xfdba1, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
> PCI: Found IRQ 5 for device 00:0c.0
> PCI: Sharing IRQ 5 with 00:09.0
> Limiting direct PCI/PCI transfers.
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
> Starting kswapd
> udf: registering filesystem
> parport0: PC-style at 0x378 [PCSPP,TRISTATE]
> parport0: cpp_daisy: aa5500ff(38)
> parport0: assign_addrs: aa5500ff(38)
> parport0: cpp_daisy: aa5500ff(38)
> parport0: assign_addrs: aa5500ff(38)
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
> enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> lp0: using parport0 (polling).
> lp0: console ready
> ppdev: user-space parallel port driver
> block: 128 slots per queue, batch2
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev 39
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
> hda: HITACHI_DK22AA-18, ATA DISK drive
> hdc: TOSHIBA DVD-ROM SD-C2302, ATAPI CD/DVD-ROM drive
> hdd: LS-120 SLIM3 00 UHD Floppy, ATAPI FLOPPY drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 35433216 sectors (18142 MB) w/512KiB Cache, CHS"05/255/63, UDMA(33)
> hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> ide-floppy driver 0.97.sv
> hdd: No disk in drive
> hdd: 123264kB, 963/8/32 CHS, 533 kBps, 512 sector size, 720 rpm
> Partition check:
>  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
> floppy0: no floppy controllers found
> loop: loaded (max 8 devices)
> PPP generic driver version 2.4.1
> PPP Deflate Compression module registered
> ide-floppy driver 0.97.sv
> maestro: version 0.15 time 16:42:43 Dec 21 2001
> PCI: Found IRQ 5 for device 00:09.0
> PCI: Sharing IRQ 5 with 00:0c.0
> maestro: Configuring ESS Maestro 2E found at IO 0xEE00 IRQ 5
> maestro:  subvendor id: 0x0f0214ff
> maestro: not attempting power management.
> maestro: AC97 Codec detected: v: 0x83847600 caps: 0x6940 pwr: 0xf
> maestro: 1 channels configured.
> Linux Kernel Card Services 3.1.22
>   options:  [pci] [cardbus] [pm]
> PCI: Assigned IRQ 9 for device 00:0c.1
> PCI: Found IRQ 5 for device 00:0c.0
> PCI: Sharing IRQ 5 with 00:09.0
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> Yenta IRQ list 04d8, PCI irq9
> Socket status: 30000006
> Yenta IRQ list 04d8, PCI irq5
> Socket status: 30000010
> usb-uhci.c: $Revision: 1.268 $ time 16:42:52 Dec 21 2001
> usb-uhci.c: High bandwidth mode enabled
> PCI: Found IRQ 11 for device 00:07.2
> usb-uhci.c: USB UHCI at I/O 0xec00, IRQ 11
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> usb.c: kmalloc IF c12ca440, numif 1
> usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
> usb.c: USB device number 1 default language ID 0x0
> Product: USB UHCI Root Hub
> SerialNumber: ec00
> hub.c: USB hub found
> hub.c: 2 ports detected
> hub.c: standalone hub
> hub.c: ganged power switching
> hub.c: global over-current protection
> hub.c: Port indicators are not supported
> hub.c: power on to power good time: 2ms
> hub.c: hub controller current requirement: 0mA
> hub.c: port removable status: RR
> hub.c: local power source is good
> hub.c: no over-current condition exists
> hub.c: enabling power on all ports
> usb.c: hub driver claimed interface c12ca440
> usb.c: call_policy add, num 1 -- no FS yet
> usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
> usb.c: registered new driver usbscanner
> scanner.c: 0.4.6:USB Scanner Driver
> usb.c: registered new driver acm
> acm.c: v0.21:USB Abstract Control Model driver for USB modems and ISDN 
> adapters
> usb.c: registered new driver usblp
> printer.c: v0.8:USB Printer Device Class driver
> usb.c: registered new driver audio
> audio.c: v1.0.0:USB Audio Class driver
> usb.c: registered new driver dc2xx
> dc2xx.c: v1.0.0:USB Camera Driver for Kodak DC-2xx series cameras
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 1024 buckets, 8Kbytes
> TCP: Hash tables configured (established 8192 bind 8192)
> IPv4 over IPv4 tunneling driver
> GRE over IPv4 tunneling driver
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 200k freed
> Adding Swap: 120452k swap-space (priority -1)
> i2c-core.o: i2c core module version 2.6.2 (20011118)
> i2c-piix4.o version 2.6.2 (20011118)
> i2c-piix4.o: Found PIIX4 device
> i2c-core.o: adapter SMBus PIIX4 adapter at 0440 registered as adapter 0.
> i2c-piix4.o: SMBus detected and initialized
> i2c-proc.o version 2.6.2 (20011118)
> adm1021.o version 2.6.2 (20011118)
> i2c-core.o: driver ADM1021, MAX1617 sensor driver registered.
> i2c-core.o: client [MAX1617 chip] registered to adapter [SMBus PIIX4 adapter 
> at 0440](pos. 0).
> ttyS2: LSR safety check engaged!
> ttyS2: LSR safety check engaged!
> cs: IO port probe 0x0c00-0x0cff: clean.
> cs: IO port probe 0x0800-0x08ff: clean.
> cs: IO port probe 0x0100-0x04ff: excluding 0x398-0x39f 0x4d0-0x4d7
> cs: IO port probe 0x0a00-0x0aff: clean.
> cs: memory probe 0xa0000000-0xa0ffffff: clean.
> eth0: NE2000 Compatible: io 0x300, irq 3, hw_addr 00:E0:98:7D:DE:E2
> eth0: bogus packet: status=0x80 nxpg=0x62 sizeY4
> eth0: bogus packet: status=0x80 nxpg=0x5a sizeY4
> eth0: bogus packet: status=0x80 nxpg=0x61 sizeY4
> eth0: bogus packet: status=0x80 nxpg=0x66 sizeY4
> eth0: bogus packet: status=0x80 nxpg=0x74 sizeY4
> eth0: bogus packet: status=0x80 nxpg=0x6b sizeY4
> eth0: bogus packet: status=0x80 nxpg=0x77 sizeY4
> eth0: bogus packet: status=0x80 nxpg=0x4d sizeY4
> eth0: bogus packet: status=0x80 nxpg=0x51 sizeY4
> lm80.o version 2.6.2 (20011118)
> i2c-core.o: driver LM80 sensor driver registered.
> i2c-core.o: client [LM80 chip] registered to adapter [SMBus PIIX4 adapter at 
> 0440](pos. 1).
> i2c-core.o: client [LM80 chip] unregistered.
> i2c-core.o: driver unregistered: LM80 sensor driver
> i2c-core.o: client [MAX1617 chip] unregistered.
> i2c-core.o: driver unregistered: ADM1021, MAX1617 sensor driver
> i2c-core.o: adapter unregistered: SMBus PIIX4 adapter at 0440
> i2c-core.o: i2c core module version 2.6.2 (20011118)
> i2c-piix4.o version 2.6.2 (20011118)
> i2c-piix4.o: Found PIIX4 device
> i2c-core.o: adapter SMBus PIIX4 adapter at 0440 registered as adapter 0.
> i2c-piix4.o: SMBus detected and initialized
> i2c-core.o: adapter unregistered: SMBus PIIX4 adapter at 0440
> i2c-core.o: i2c core module version 2.6.2 (20011118)
> i2c-piix4.o version 2.6.2 (20011118)
> i2c-piix4.o: Found PIIX4 device
> i2c-core.o: adapter SMBus PIIX4 adapter at 0440 registered as adapter 0.
> i2c-piix4.o: SMBus detected and initialized
> i2c-dev.o: i2c /dev entries driver module version 2.6.2 (20011118)
> i2c-core.o: driver i2c-dev dummy driver registered.
> i2c-dev.o: Registered 'SMBus PIIX4 adapter at 0440' as minor 0
> 
> 
> 
> 
> ################################################
> ################################################
> dimbel:~# sensors-detect
>  This program will help you to determine which I2C/SMBus modules you need to
>  load to use lm_sensors most effectively.
>  You need to have installed lm-sensors modules before you can use
>  some functions of this utility.
>  Also, you need to be `root', or at least have access to
>  the /dev/i2c[-/]* files for some things.
>  If you have patched your kernel and have some drivers built-in you can
>  safely answer NO if asked to load some modules. In this case, things may
>  seem a bit confusing, but they will still work.
> 
>  IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
>  IBM Thinkpads have a severely broken i2c/SMBus implementation,  just scanning
>  the bus will break your thinkpad forever!
> 
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-piix4' for device 00:07.3: Intel 82371AB PIIX4 ACPI
> Probe succesfully concluded.
> 
>  We will now try to load each adapter module in turn.
> Load `i2c-piix4' (say NO if built into your kernel)? (YES/no):
> Module loaded succesfully.
>  Do you now want to be prompted for non-detectable adapters? (yes/NO):
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
>  i2c-dev is not loaded. Do you want to load it now? (YES/no):
>  Module loaded succesfully.
> 
>  We are now going to do the adapter probings. Some adapters may hang halfway
>  through; we can't really help that. Also, some chips will be double detected;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address, you can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
> 
> Next adapter: SMBus PIIX4 adapter at 0440 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x00
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x08
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x09
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x0b
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x0c
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x2c
> Probing for `Myson MTP008'... Failed!
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Success!
>     (confidence 3, driver `lm80')
> Probing for `National Semiconductor LM87'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
> Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
> Probing for `Genesys Logic GL520SM'... Failed!
> Probing for `Analog Devices ADM9240'... Failed!
> Probing for `Dallas Semiconductor DS1780'... Failed!
> Probing for `National Semiconductor LM81'... Failed!
> Probing for `Analog Devices ADM1025'... Failed!
> Probing for `Analog Devices ADM1024'... Failed!
> Probing for `Analog Devices ADM1022'... Failed!
> Probing for `Texas Instruments THMC50'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x2d
> Probing for `Myson MTP008'... Failed!
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Failed!
> Probing for `National Semiconductor LM87'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
> Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
> Probing for `Genesys Logic GL520SM'... Failed!
> Probing for `Genesys Logic GL525SM'... Failed!
> Probing for `Analog Devices ADM9240'... Failed!
> Probing for `Dallas Semiconductor DS1780'... Failed!
> Probing for `National Semiconductor LM81'... Failed!
> Probing for `Analog Devices ADM1025'... Failed!
> Probing for `Analog Devices ADM1024'... Failed!
> Probing for `Analog Devices ADM1022'... Failed!
> Probing for `Texas Instruments THMC50'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x4e
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM75'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Maxim MAX1617'... Success!
>     (confidence 3, driver `adm1021')
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Failed!
> Probing for `Genesys Logic GL523SM'... Failed!
> 
>  Some chips are also accessible through the ISA bus. ISA probes are
>  typically a bit more dangerous, as we have to write to I/O ports to do
>  this.  Do you want to scan the ISA bus? (YES/no):
> Probing for `National Semiconductor LM78'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM78-J'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM79'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83781D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83782D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83627HF'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83697HF'
>   Trying address 0x0290... Failed!
> Probing for `Silicon Integrated Systems SIS5595'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT 82C686 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'
>   Trying address 0x0290... Failed!
> 
>  Now follows a summary of the probes I have just done.
>  Just press ENTER to continue:
> 
> Driver `lm80' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus PIIX4 adapter at 0440' (Non-I2C SMBus adapter)
>     Busdriver `i2c-piix4', I2C address 0x2c
>     Chip `National Semiconductor LM80' (confidence: 3)
> 
> Driver `adm1021' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus PIIX4 adapter at 0440' (Non-I2C SMBus adapter)
>     Busdriver `i2c-piix4', I2C address 0x4e
>     Chip `Maxim MAX1617' (confidence: 3)
> 
> 
>  I will now generate the commands needed to load the I2C modules.
>  Sometimes, a chip is available both through the ISA bus and an I2C bus.
>  ISA bus access is faster, but you need to load an additional driver module
>  for it. If you have the choice, do you want to use the ISA bus or the
>  I2C/SMBus (ISA/smbus)? smbus
> 
> WARNING! If you have some things built into your kernel, the
> below list will contain too many modules. Skip the appropriate ones!
> To load everything that is needed, edit /etc/modules and add the modules
>  listed here to it:
> 
> #----cut here----
> # I2C adapter drivers
> i2c-piix4
> # I2C chip drivers
> lm80
> adm1021
> #----cut here----
> 
> Then, run /etc/init.d/modutils
> 
> 
> To make the sensors modules behave correctly, add these lines to
> /etc/modutils/local and run update-modules:
> 
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
> 
> 
> 
> -- 
> +-------------------------------------------------------
> | Dr.-Ing. Marcus Eger
> | Philipps Universitaet Marburg
> | Fachbereich Physik AG Neurophysik
> | Renthof 7
> | 35032 Marburg
> | Tel. ++49 +6421 282-4169
> | Fax  ++49 +6421 282-7034
> +-------- ><> -------------------------------------------
> | E-Mail: eger.m@gmx.de (NEW)
> |         marcus.eger@physik.uni-marburg.de (OLD)
> | WWW:    http://neuro.physik.uni-marburg.de/~eger (NEW)
> +--------------------------------------------------------

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
