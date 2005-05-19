From: l3ech@l3ech.dyns.net (L3ECH)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: sensors fail randomally (hardware weirdness?)
Message-Id: <1024260801.775.12.camel@l3ech.dyns.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1023701513.1407.10.camel@l3ech.dyns.net>
In-Reply-To: <1023701513.1407.10.camel@l3ech.dyns.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

after installing the CVS version the hangs didn't appear anymore. but
then again, they never appeared during the winter too (when it was cold
outside). i live in a desert-like climate and it can get VERY hot in the
summer, and because it's an amd cpu, the weather has major effect on the
system's temperature (and on the sensor chips?).
i'll let you know if the weirdness happen again.

thanks for the help.
L3ECH.


On Wed, 2002-06-12 at 04:58, Mark D. Studebaker wrote:
> As sensors-detect didn't find any chips after things hang,
> the problem is most likely in adm-756.
> You can verify this by trying prog/detect/i2cdetect before and after
> the hang.
> We recently checked in some changes advertised as 'reliability
> improvements'
> to amd-756 in CVS. Please try it and see if it helps.
> Let us know.
> mds
> 
> 
> L3ECH wrote:
> > 
> > lm_sensors, i2c drivers and everything else installs and works just
> > fine.
> > however, on random occasions (usually on a hot day), the sensor chip
> > just fails (i think). data from sensors is no longer recieved.
> > unloading the modules and loading them again doesn't help and
> > sensors-detect do not detect the lm chip after that happens.
> > this happened with previous versions of lm_sensors too.
> > after a reboot everything goes back to normal.
> > is this a hardware problem, or am i doing something wrong?
> > is there a way to do the same thing a reboot does without a reboot?
> > 
> > included info: chip and motherboard type, dmesg output, sensors-detect
> > output after the weirdness, normal sensors-detect output, lsmod output,
> > output of 'lspci -n', output of i2cdetect.
> > 
> > sensor chip: Winbond W83977E AW
> > motherboard: Gigabyte GA-7IXE
> > (http://www.gigabyte.com.tw/products/ga7ixe.htm)
> > 
> > dmesg output:
> > --------------------------------------------------------------------------
> > Linux version 2.4.18 (root@l3ech.dyns.net) (gcc version 2.95.4 20011002
> > (Debian prerelease)) #3 Sun Jun 9 12:26:51 IDT 2002
> > BIOS-provided physical RAM map:
> >  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> >  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> >  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> >  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
> >  BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
> >  BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
> >  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> > On node 0 totalpages: 65520
> > zone(0): 4096 pages.
> > zone(1): 61424 pages.
> > zone(2): 0 pages.
> > Kernel command line: auto BOOT_IMAGE=Linux ro root01
> > Initializing CPU#0
> > Detected 757.481 MHz processor.
> > Console: colour VGA+ 132x50
> > Calibrating delay loop... 1510.60 BogoMIPS
> > Memory: 255424k/262080k available (1327k kernel code, 6268k reserved,
> > 387k data, 204k init, 0k highmem)
> > Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
> > Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
> > Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
> > Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
> > Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
> > CPU: Before vendor init, caps: 0183f9ff c1c3f9ff 00000000, vendor = 2
> > CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> > CPU: L2 Cache: 512K (64 bytes/line)
> > CPU: After vendor init, caps: 0183f9ff c1c3f9ff 00000000 00000000
> > Intel machine check architecture supported.
> > Intel machine check reporting enabled on CPU#0.
> > CPU:     After generic, caps: 0183f9ff c1c3f9ff 00000000 00000000
> > CPU:             Common caps: 0183f9ff c1c3f9ff 00000000 00000000
> > CPU: AMD Athlon(tm) Processor stepping 02
> > Enabling fast FPU save and restore... done.
> > Checking 'hlt' instruction... OK.
> > POSIX conformance testing by UNIFIX
> > PCI: PCI BIOS revision 2.10 entry at 0xfdb71, last bus=1
> > PCI: Using configuration type 1
> > PCI: Probing PCI hardware
> > PCI: Using IRQ router AMD756 VIPER [1022/740b] at 00:07.3
> > isapnp: Scanning for PnP cards...
> > isapnp: Card 'Rockwell 56K ACF II Fax+Data+Voice Modem'
> > isapnp: 1 Plug & Play card detected total
> > Linux NET4.0 for Linux 2.4
> > Based upon Swansea University Computer Society NET3.039
> > Initializing RT netlink socket
> > Starting kswapd
> > Journalled Block Device driver loaded
> > pty: 256 Unix98 ptys configured
> > Real Time Clock Driver v1.10e
> > block: 128 slots per queue, batch2
> > Uniform Multi-Platform E-IDE driver Revision: 6.31
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx
> > AMD7409: IDE controller on PCI bus 00 dev 39
> > AMD7409: chipset revision 3
> > AMD7409: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> > hda: ST36531A, ATA DISK drive
> > hdc: WDC WD400EB-00CPF0, ATA DISK drive
> > hdd: LG CD-ROM CRD-8521B, ATAPI CD/DVD-ROM drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > hda: 12706470 sectors (6506 MB) w/128KiB Cache, CHSy0/255/63, UDMA(33)
> > hdc: 78165360 sectors (40021 MB) w/2048KiB Cache, CHSw545/16/63,
> > UDMA(33)
> > hdd: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
> > Uniform CD-ROM driver Revision: 3.12
> > Partition check:
> >  hda: hda1 hda2
> >  hdc: hdc1
> > Floppy drive(s): fd0 is 1.44M
> > FDC 0 is a post-1991 82077
> > loop: loaded (max 8 devices)
> > ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
> >   http://www.scyld.com/network/ne2k-pci.html
> > AMD756: dev 10ec:8029, router pirq : 3 get irq :  5
> > PCI: Found IRQ 5 for device 00:0a.0
> > eth0: RealTek RTL-8029 found at 0xda00, IRQ 5, 00:40:95:46:6F:2D.
> > AMD756: dev 10ec:8029, router pirq : 2 get irq : 11
> > PCI: Found IRQ 11 for device 00:09.0
> > eth1: RealTek RTL-8029 found at 0xd800, IRQ 11, 00:40:95:42:6A:0A.
> > PPP generic driver version 2.4.1
> > PPP Deflate Compression module registered
> > PPP BSD Compression module registered
> > SCSI subsystem driver Revision: 1.00
> > aec671x_detect:
> > AMD756: dev 1191:8030, router pirq : 4 get irq : 10
> > PCI: Found IRQ 10 for device 00:0b.0
> > PCI: Sharing IRQ 10 with 00:07.4
> >    ACARD AEC-671X PCI Ultra/W SCSI-3 Host Adapter: 0    IO:de00, IRQ:10.
> >          ID:  3  YAMAHA  CRW2100S        1.0H
> >          ID:  7  Host Adapter
> > scsi0 : ACARD AEC-6710/6712/67160 PCI Ultra/W/LVD SCSI-3 Adapter Driver
> > V2.5+ac
> >   Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0H
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> > Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
> > sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
> > NET4: Linux TCP/IP 1.0 for NET4.0
> > IP Protocols: ICMP, UDP, TCP, IGMP
> > IP: routing cache hash table of 2048 buckets, 16Kbytes
> > TCP: Hash tables configured (established 16384 bind 16384)
> > ip_conntrack (2047 buckets, 16376 max)
> > ip_tables: (C) 2000-2002 Netfilter core team
> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > kjournald starting.  Commit interval 5 seconds
> > EXT3-fs: mounted filesystem with ordered data mode.
> > VFS: Mounted root (ext3 filesystem) readonly.
> > Freeing unused kernel memory: 204k freed
> > Adding Swap: 257032k swap-space (priority -1)
> > EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide1(22,1), internal journal
> > es1371: version v0.30 time 01:06:23 Jun  9 2002
> > AMD756: dev 1274:1371, router pirq : 1 get irq :  9
> > PCI: Found IRQ 9 for device 00:0c.0
> > es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x06
> > es1371: found es1371 rev 6 at io 0xdc00 irq 9
> > es1371: features: joystick 0x0
> > ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A
> > rev A)
> > i2c-core.o: i2c core module
> > i2c-dev.o: i2c /dev entries driver module version 2.6.3 (20020322)
> > i2c-core.o: driver i2c-dev dummy driver registered.
> > nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14
> > 07:41:42 PDT 2002
> > Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
> > SERIAL_PCI ISAPNP enabled
> > ttyS00 at 0x03f8 (irq = 4) is a 16550A
> > ttyS01 at port 0x02f8 (irq = 12) is a 16550A
> > i2c-amd756.o version 2.6.3 (20020322)
> > i2c-dev.o: Registered 'SMBus AMD7X6 adapter at 50e0' as minor 0
> > i2c-core.o: adapter SMBus AMD7X6 adapter at 50e0 registered as adapter
> > 0.
> > i2c-amd756.o: AMD756/766 bus detected and initialized
> > i2c-proc.o version 2.6.3 (20020322)
> > w83781d.o version 2.6.3 (20020322)
> > i2c-core.o: driver W83781D sensor driver registered.
> > i2c-core.o: client [W83782D chip] registered to adapter [SMBus AMD7X6
> > adapter at 50e0](pos. 0).
> > i2c-core.o: client [W83782D subclient] registered to adapter [SMBus
> > AMD7X6 adapter at 50e0](pos. 1).
> > i2c-core.o: client [W83782D subclient] registered to adapter [SMBus
> > AMD7X6 adapter at 50e0](pos. 2).
> > eeprom.o version 2.6.3 (20020322)
> > i2c-core.o: driver EEPROM READER registered.
> > i2c-core.o: client [EEPROM chip] registered to adapter [SMBus AMD7X6
> > adapter at 50e0](pos. 3).
> > i2c-core.o: client [EEPROM chip] registered to adapter [SMBus AMD7X6
> > adapter at 50e0](pos. 4).
> > lirc_serial: auto-detected active low receiver
> > i2c-core.o: client [W83782D chip] unregistered.
> > i2c-core.o: client [W83782D subclient] unregistered.
> > i2c-core.o: client [W83782D subclient] unregistered.
> > i2c-core.o: client [EEPROM chip] unregistered.
> > i2c-core.o: client [EEPROM chip] unregistered.
> > i2c-core.o: adapter unregistered: SMBus AMD7X6 adapter at 50e0
> > i2c-core.o: driver unregistered: W83781D sensor driver
> > i2c-core.o: driver unregistered: EEPROM READER
> > i2c-core.o: driver unregistered: i2c-dev dummy driver
> > i2c-core.o: i2c core module
> > i2c-amd756.o version 2.6.3 (20020322)
> > i2c-core.o: adapter SMBus AMD7X6 adapter at 50e0 registered as adapter
> > 0.
> > i2c-amd756.o: AMD756/766 bus detected and initialized
> > i2c-dev.o: i2c /dev entries driver module version 2.6.3 (20020322)
> > i2c-core.o: driver i2c-dev dummy driver registered.
> > i2c-dev.o: Registered 'SMBus AMD7X6 adapter at 50e0' as minor 0
> > --------------------------------------------------------------------------
> > 
> > sensors-detect output AFTER the weirdness:
> > --------------------------------------------------------------------------
> >  We can start with probing for (PCI) I2C or SMBus adapters.
> >  You do not need any special privileges for this.
> >  Do you want to probe now? (YES/no):
> > Probing for PCI bus adapters...
> > Use driver `i2c-amd756' for device 00:07.3: AMD-756 Athlon ACPI
> > Use driver `i2c-riva' for device 01:05.0: RIVA UVTNT2
> > Probe succesfully concluded.
> > 
> >  We will now try to load each adapter module in turn.
> > Load `i2c-amd756' (say NO if built into your kernel)? (YES/no):
> > Module loaded succesfully.
> > Load `i2c-riva' (say NO if built into your kernel)? (YES/no):
> > modprobe: Can't locate module i2c-riva
> > Loading failed ()... skipping.
> > ** Note: i2c-riva module is available at
> > ** http://drama.obuda.kando.hu/~fero/cgi-bin/rivatv.shtml
> >  Do you now want to be prompted for non-detectable adapters? (yes/NO):
> >  To continue, we need module `i2c-dev' to be loaded.
> >  If it is built-in into your kernel, you can safely skip this.
> >  i2c-dev is not loaded. Do you want to load it now? (YES/no):
> >  Module loaded succesfully.
> >  We are now going to do the adapter probings. Some adapters may hang
> > halfway
> >  through; we can't really help that. Also, some chips will be double
> > detected;
> >  we choose the one with the highest confidence value in that case.
> >  If you found that the adapter hung after probing a certain address, you
> > can
> >  specify that address to remain unprobed. That often
> >  includes address 0x69 (clock chip).
> > 
> > Next adapter: SMBus AMD7X6 adapter at 50e0 (Non-I2C SMBus adapter)
> > Do you want to scan it? (YES/no/selectively):
> > 
> >  Some chips are also accessible through the ISA bus. ISA probes are
> >  typically a bit more dangerous, as we have to write to I/O ports to do
> >  this.  Do you want to scan the ISA bus? (YES/no):
> > Probing for `National Semiconductor LM78'
> >   Trying address 0x0290... Failed!
> > Probing for `National Semiconductor LM78-J'
> >   Trying address 0x0290... Failed!
> > Probing for `National Semiconductor LM79'
> >   Trying address 0x0290... Failed!
> > Probing for `Winbond W83781D'
> >   Trying address 0x0290... Failed!
> > Probing for `Winbond W83782D'
> >   Trying address 0x0290... Failed!
> > Probing for `Winbond W83627HF'
> >   Trying address 0x0290... Failed!
> > Probing for `Winbond W83697HF'
> >   Trying address 0x0290... Failed!
> > Probing for `Silicon Integrated Systems SIS5595'
> >   Trying general detect... Failed!
> > Probing for `VIA Technologies VT82C686 Integrated Sensors'
> >   Trying general detect... Failed!
> > Probing for `ITE IT8705F / IT8712F / SiS 950'
> >   Trying address 0x0290... Failed!
> > Probing for `IPMI BMC KCS'
> >   Trying address 0x0ca0... Failed!
> > Probing for `IPMI BMC SMIC'
> >   Trying address 0x0ca8... Failed!
> > 
> >  Now follows a summary of the probes I have just done.
> >  Just press ENTER to continue:
> > 
> >  I will now generate the commands needed to load the I2C modules.
> >  Sometimes, a chip is available both through the ISA bus and an I2C bus.
> >  ISA bus access is faster, but you need to load an additional driver
> > module
> >  for it. If you have the choice, do you want to use the ISA bus or the
> >  I2C/SMBus (ISA/smbus)?
> > 
> > WARNING! If you have some things built into your kernel, the
> > below list will contain too many modules. Skip the appropriate ones!
> > To load everything that is needed, add this to some /etc/rc* file:
> > 
> > #----cut here----
> > # I2C adapter drivers
> > # I2C chip drivers
> > #----cut here----
> > 
> > To make the sensors modules behave correctly, add these lines to either
> > /etc/modules.conf or /etc/conf.modules:
> > 
> > #----cut here----
> > # I2C module options
> > alias char-major-89 i2c-dev
> > #----cut here----
> > --------------------------------------------------------------------------
> > 
> > sensors-detect output after a reboot (normal state):
> > --------------------------------------------------------------------------
> >  We can start with probing for (PCI) I2C or SMBus adapters.
> >  You do not need any special privileges for this.
> >  Do you want to probe now? (YES/no):
> > Probing for PCI bus adapters...
> > Use driver `i2c-amd756' for device 00:07.3: AMD-756 Athlon ACPI
> > Use driver `i2c-riva' for device 01:05.0: RIVA UVTNT2
> > Probe succesfully concluded.
> > 
> >  We will now try to load each adapter module in turn.
> > Load `i2c-amd756' (say NO if built into your kernel)? (YES/no):
> > Module loaded succesfully.
> > Load `i2c-riva' (say NO if built into your kernel)? (YES/no):
> > modprobe: Can't locate module i2c-riva
> > Loading failed ()... skipping.
> > ** Note: i2c-riva module is available at
> > ** http://drama.obuda.kando.hu/~fero/cgi-bin/rivatv.shtml
> >  Do you now want to be prompted for non-detectable adapters? (yes/NO):
> >  To continue, we need module `i2c-dev' to be loaded.
> >  If it is built-in into your kernel, you can safely skip this.
> >  i2c-dev is not loaded. Do you want to load it now? (YES/no):
> >  Module loaded succesfully.
> > 
> >  We are now going to do the adapter probings. Some adapters may hang
> > halfway
> >  through; we can't really help that. Also, some chips will be double
> > detected;
> >  we choose the one with the highest confidence value in that case.
> >  If you found that the adapter hung after probing a certain address, you
> > can
> >  specify that address to remain unprobed. That often
> >  includes address 0x69 (clock chip).
> > 
> > Next adapter: SMBus AMD7X6 adapter at 50e0 (Non-I2C SMBus adapter)
> > Do you want to scan it? (YES/no/selectively):
> > Client found at address 0x08
> > Probing for `National Semiconductor LM78'... Failed!
> > Probing for `National Semiconductor LM78-J'... Failed!
> > Probing for `National Semiconductor LM79'... Failed!
> > Probing for `Winbond W83781D'... Failed!
> > Probing for `Winbond W83782D'... Failed!
> > Probing for `Winbond W83783S'... Failed!
> > Probing for `Winbond W83627HF'... Failed!
> > Probing for `Asus AS99127F'... Failed!
> > Probing for `Winbond W83L784R/AR'... Failed!
> > Client found at address 0x0c
> > Probing for `National Semiconductor LM78'... Failed!
> > Probing for `National Semiconductor LM78-J'... Failed!
> > Probing for `National Semiconductor LM79'... Failed!
> > Probing for `Winbond W83781D'... Failed!
> > Probing for `Winbond W83782D'... Failed!
> > Probing for `Winbond W83783S'... Failed!
> > Probing for `Winbond W83627HF'... Failed!
> > Probing for `Asus AS99127F'... Failed!
> > Probing for `Winbond W83L784R/AR'... Failed!
> > Client found at address 0x2d
> > Probing for `Myson MTP008'... Failed!
> > Probing for `National Semiconductor LM78'... Failed!
> > Probing for `National Semiconductor LM78-J'... Failed!
> > Probing for `National Semiconductor LM79'... Failed!
> > Probing for `National Semiconductor LM80'... Failed!
> > Probing for `National Semiconductor LM87'... Failed!
> > Probing for `Winbond W83781D'... Failed!
> > Probing for `Winbond W83782D'... Success!
> >     (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
> > Probing for `Winbond W83783S'... Failed!
> > Probing for `Winbond W83627HF'... Failed!
> > Probing for `Asus AS99127F'... Failed!
> > Probing for `Winbond W83L784R/AR'... Failed!
> > Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
> > Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
> > Probing for `Genesys Logic GL520SM'... Failed!
> > Probing for `Genesys Logic GL525SM'... Failed!
> > Probing for `Analog Devices ADM9240'... Failed!
> > Probing for `Dallas Semiconductor DS1780'... Failed!
> > Probing for `National Semiconductor LM81'... Failed!
> > Probing for `Analog Devices ADM1025'... Failed!
> > Probing for `Analog Devices ADM1024'... Failed!
> > Probing for `Analog Devices ADM1022'... Failed!
> > Probing for `Texas Instruments THMC50'... Failed!
> > Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> > Client found at address 0x48
> > Probing for `National Semiconductor LM78'... Failed!
> > Probing for `National Semiconductor LM78-J'... Failed!
> > Probing for `National Semiconductor LM79'... Failed!
> > Probing for `National Semiconductor LM75'... Success!
> >     (confidence 3, driver `lm75')
> > Probing for `Winbond W83781D'... Failed!
> > Probing for `Winbond W83782D'... Failed!
> > Probing for `Winbond W83783S'... Failed!
> > Probing for `Winbond W83627HF'... Failed!
> > Probing for `Asus AS99127F'... Failed!
> > Probing for `Winbond W83L784R/AR'... Failed!
> > Probing for `Dallas Semiconductor DS1621'... Failed!
> > Probing for `Philips Semiconductors PCF8591'... Success!
> >     (confidence 1, driver `pcf8591')
> > Client found at address 0x49
> > Probing for `National Semiconductor LM78'... Failed!
> > Probing for `National Semiconductor LM78-J'... Failed!
> > Probing for `National Semiconductor LM79'... Failed!
> > Probing for `National Semiconductor LM75'... Success!
> >     (confidence 3, driver `lm75')
> > Probing for `Winbond W83781D'... Failed!
> > Probing for `Winbond W83782D'... Failed!
> > Probing for `Winbond W83783S'... Failed!
> > Probing for `Winbond W83627HF'... Failed!
> > Probing for `Asus AS99127F'... Failed!
> > Probing for `Winbond W83L784R/AR'... Failed!
> > Probing for `Dallas Semiconductor DS1621'... Failed!
> > Probing for `Philips Semiconductors PCF8591'... Success!
> >     (confidence 1, driver `pcf8591')
> > Client found at address 0x51
> > Probing for `National Semiconductor LM78'... Failed!
> > Probing for `National Semiconductor LM78-J'... Failed!
> > Probing for `National Semiconductor LM79'... Failed!
> > Probing for `Winbond W83781D'... Failed!
> > Probing for `Winbond W83782D'... Failed!
> > Probing for `Winbond W83783S'... Failed!
> > Probing for `Winbond W83627HF'... Failed!
> > Probing for `Asus AS99127F'... Failed!
> > Probing for `Winbond W83L784R/AR'... Failed!
> > Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
> >     (confidence 8, driver `eeprom')
> > Client found at address 0x52
> > Probing for `National Semiconductor LM78'... Failed!
> > Probing for `National Semiconductor LM78-J'... Failed!
> > Probing for `National Semiconductor LM79'... Failed!
> > Probing for `Winbond W83781D'... Failed!
> > Probing for `Winbond W83782D'... Failed!
> > Probing for `Winbond W83783S'... Failed!
> > Probing for `Winbond W83627HF'... Failed!
> > Probing for `Asus AS99127F'... Failed!
> > Probing for `Winbond W83L784R/AR'... Failed!
> > Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
> >     (confidence 8, driver `eeprom')
> > Client found at address 0x69
> > 
> >  Some chips are also accessible through the ISA bus. ISA probes are
> >  typically a bit more dangerous, as we have to write to I/O ports to do
> >  this.  Do you want to scan the ISA bus? (YES/no):
> > Probing for `National Semiconductor LM78'
> >   Trying address 0x0290... Failed!
> > Probing for `National Semiconductor LM78-J'
> >   Trying address 0x0290... Failed!
> > Probing for `National Semiconductor LM79'
> >   Trying address 0x0290... Failed!
> > Probing for `Winbond W83781D'
> >   Trying address 0x0290... Failed!
> > Probing for `Winbond W83782D'
> >   Trying address 0x0290... Failed!
> > Probing for `Winbond W83627HF'
> >   Trying address 0x0290... Failed!
> > Probing for `Winbond W83697HF'
> >   Trying address 0x0290... Failed!
> > Probing for `Silicon Integrated Systems SIS5595'
> >   Trying general detect... Failed!
> > Probing for `VIA Technologies VT82C686 Integrated Sensors'
> >   Trying general detect... Failed!
> > Probing for `ITE IT8705F / IT8712F / SiS 950'
> >   Trying address 0x0290... Failed!
> > Probing for `IPMI BMC KCS'
> >   Trying address 0x0ca0... Failed!
> > Probing for `IPMI BMC SMIC'
> >   Trying address 0x0ca8... Failed!
> >  Now follows a summary of the probes I have just done.
> >  Just press ENTER to continue:
> > 
> > Driver `w83781d' (should be inserted):
> >   Detects correctly:
> >   * Bus `SMBus AMD7X6 adapter at 50e0' (Non-I2C SMBus adapter)
> >     Busdriver `i2c-amd756', I2C address 0x2d (and 0x48 0x49)
> >     Chip `Winbond W83782D' (confidence: 8)
> > 
> > Driver `lm75' (may not be inserted):
> >   Misdetects:
> >   * Bus `SMBus AMD7X6 adapter at 50e0' (Non-I2C SMBus adapter)
> >     Busdriver `i2c-amd756', I2C address 0x48
> >     Chip `National Semiconductor LM75' (confidence: 3)
> >   * Bus `SMBus AMD7X6 adapter at 50e0' (Non-I2C SMBus adapter)
> >     Busdriver `i2c-amd756', I2C address 0x49
> >     Chip `National Semiconductor LM75' (confidence: 3)
> > 
> > Driver `pcf8591' (may not be inserted):
> >   Misdetects:
> >   * Bus `SMBus AMD7X6 adapter at 50e0' (Non-I2C SMBus adapter)
> >     Busdriver `i2c-amd756', I2C address 0x48
> >     Chip `Philips Semiconductors PCF8591' (confidence: 1)
> >   * Bus `SMBus AMD7X6 adapter at 50e0' (Non-I2C SMBus adapter)
> >     Busdriver `i2c-amd756', I2C address 0x49
> >     Chip `Philips Semiconductors PCF8591' (confidence: 1)
> > 
> > Driver `eeprom' (should be inserted):
> >   Detects correctly:
> >   * Bus `SMBus AMD7X6 adapter at 50e0' (Non-I2C SMBus adapter)
> >     Busdriver `i2c-amd756', I2C address 0x51
> >     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
> >   * Bus `SMBus AMD7X6 adapter at 50e0' (Non-I2C SMBus adapter)
> >     Busdriver `i2c-amd756', I2C address 0x52
> >     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
> > 
> >  I will now generate the commands needed to load the I2C modules.
> >  Sometimes, a chip is available both through the ISA bus and an I2C bus.
> >  ISA bus access is faster, but you need to load an additional driver
> > module
> >  for it. If you have the choice, do you want to use the ISA bus or the
> >  I2C/SMBus (ISA/smbus)?
> > 
> > WARNING! If you have some things built into your kernel, the
> > below list will contain too many modules. Skip the appropriate ones!
> > To load everything that is needed, add this to some /etc/rc* file:
> > 
> > #----cut here----
> > # I2C adapter drivers
> > modprobe i2c-amd756
> > # I2C chip drivers
> > modprobe w83781d
> > modprobe eeprom
> > #----cut here----
> > 
> > To make the sensors modules behave correctly, add these lines to either
> > /etc/modules.conf or /etc/conf.modules:
> > 
> > #----cut here----
> > # I2C module options
> > alias char-major-89 i2c-dev
> > #----cut here----
> > --------------------------------------------------------------------------
> > 
> > # lspci -n
> > 00:00.0 Class 0600: 1022:7006 (rev 23)
> > 00:01.0 Class 0604: 1022:7007 (rev 01)
> > 00:07.0 Class 0601: 1022:7408 (rev 01)
> > 00:07.1 Class 0101: 1022:7409 (rev 03)
> > 00:07.3 Class 0680: 1022:740b (rev 03)
> > 00:07.4 Class 0c03: 1022:740c (rev 06)
> > 00:09.0 Class 0200: 10ec:8029
> > 00:0a.0 Class 0200: 10ec:8029
> > 00:0b.0 Class 0100: 1191:8030 (rev 08)
> > 00:0c.0 Class 0401: 1274:1371 (rev 06)
> > 01:05.0 Class 0300: 10de:002d (rev 15)
> > --------------------------------------------------------------------------
> > 
> > # ./i2cdetect 0
> >   WARNING! This program can confuse your I2C bus, cause data loss and
> > worse!
> >   I will probe file /dev/i2c-0
> >   You have five seconds to reconsider and press CTRL-C!
> > 
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: XX XX XX XX XX XX XX XX 08 XX XX XX 0c XX XX XX
> > 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX XX
> > 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
> > 50: XX 51 52 XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
> > 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > --------------------------------------------------------------------------
> 
