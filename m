From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: module (modprobe w83781d) works static compile do not work!
Message-Id: <3C3BB1B8.D420E96E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C3291D1.BBCAFA8F@unicef.org.yu>
In-Reply-To: <3C3291D1.BBCAFA8F@unicef.org.yu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

So this part from your first mail:
-----------
w83781d.o version 2.6.2 (20011118)
i2c-core.o: driver W83781D sensor driver registered.
i2c-core.o: client [W83782D chip] registered to adapter [ISA main
adapter](pos. 0).
-------------

Was for the module version, not the static  version.

In any case, I can't reproduce the problem on my system. Sorry.
I am running right now with static compilation, here's
my dmesg:
---------------
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
i2c-proc.o version 2.6.1 (20010825)
i2c-ali15x3.o version 2.6.2 (20011118)
i2c-core.o: adapter SMBus ALI15X3 adapter at e800 registered as adapter
0.
i2c-ali15x3.o: ALI15X3 SMBus Controller detected and initialized
i2c-voodoo3.o version 2.6.2 (20011118)
i2c-voodoo3: Using Banshee/Voodoo3 at 0xce806000
i2c-voodoo3: 1 Banshee/Voodoo3 found.
i2c-core.o: adapter I2C Voodoo3/Banshee adapter registered as adapter 1.
i2c-voodoo3.o: I2C bus initialized
i2c-core.o: adapter DDC Voodoo3/Banshee adapter registered as adapter 2.
i2c-voodoo3.o: DDC bus initialized
i2c-isa.o version 2.6.2 (20011118)
i2c-core.o: adapter ISA main adapter registered as adapter 3.
i2c-isa.o: ISA bus access for i2c modules initialized.
fb: Banshee memory = 16384K
fb: MTRR's turned on
tdfxfb: reserving 1024 bytes for the hwcursor at cf807000
Console: switching to colour frame buffer device 80x30
fb0: 3Dfx Banshee frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
pty: 256 Unix98 ptys configured
w83781d.o version 2.6.2 (20011118)
i2c-core.o: driver W83781D sensor driver registered.
i2c-core.o: client [W83781D chip] registered to adapter [SMBus ALI15X3
adapter at e800](pos. 0).
i2c-core.o: client [W83781D subclient] registered to adapter [SMBus
ALI15X3 adapter at e800](pos. 1).
i2c-core.o: client [W83781D subclient] registered to adapter [SMBus
ALI15X3 adapter at e800](pos. 2).
i2c-core.o: client [W83781D chip] registered to adapter [ISA main
adapter](pos. 0).
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A


mds



Zoran Davidovac wrote:
> 
> "Mark D. Studebaker" wrote:
> >
> > I still can't reproduce this problem on my system.
> > Others haven't seen the registration messages in dmesg.
> > You have those messages so it should work!
> > What is the problem?
> > 'sensors' doesn't have w83782d information?
> > There is no entry in /proc/sys/dev/sensors?
> >
> 
> I reproduce this problem on another system
> asus 815ep step2 board (not shure but think that board is tucls2)
> asus has something like as99 it is w83782d compatibile.
> 
> Maybe I wasn't clear what the problem is.
> 
> Kernel 2.2.20 + i2c-2.6.2 patch + sensors-2.6.2 patch
> 
> When I compile w83781d *static* in kernel it does not work.
> 
> In attachments:
> 
> static: dmesg from static compiled i2c sensors
> config: kernel config
> 
> but when I compile kernel with module for w83781d
> and I do:
> 
> bash-2.05# modprobe w83781d
> bash-2.05# dmesg |tail -n 7
> registered device ppp0
> w83781d.o version 2.6.2 (20011118)
> i2c-core.o: driver W83781D sensor driver registered.
> i2c-core.o: client [W83782D chip] registered to adapter [SMBus PIIX4
> adapter at 5000](pos. 0).
> i2c-core.o: client [W83782D subclient] registered to adapter [SMBus
> PIIX4 adapter at 5000](pos. 1).
> i2c-core.o: client [W83782D subclient] registered to adapter [SMBus
> PIIX4 adapter at 5000](pos. 2).
> i2c-core.o: client [W83782D chip] registered to adapter [ISA main
> adapter](pos. 0).
> bash-2.05#
> 
> and now I have everything working :)
> 
> but it does worko ONLY as a module and NOT static compiled IN kernel.
> 
> Keep up the good work,
>                         Zoran
> 
> 
> Linux version 2.2.20 (root@koala) (gcc version 2.95.3 20010315 (release)) #2 Mon Jan 7 20:55:58 CET 2002
> BIOS-provided physical RAM map:
>  BIOS-e820: 0009f000 @ 00000000 (usable)
>  BIOS-e820: 0ff00000 @ 00100000 (usable)
> Detected 952184 kHz processor.
> ide_setup: hda=ide-scsi
> Console: colour VGA+ 80x25
> Calibrating delay loop... 1900.54 BogoMIPS
> Memory: 256948k/262144k available (1684k kernel code, 412k reserved, 3024k data, 76k init)
> Dentry hash table entries: 32768 (order 6, 256k)
> Buffer cache hash table entries: 262144 (order 8, 1024k)
> Page cache hash table entries: 65536 (order 6, 256k)
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> 128K L2 cache (4 way)
> CPU: L2 Cache: 128K
> CPU: Intel Pentium III (Coppermine) stepping 06
> Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
> PCI: PCI BIOS revision 2.10 entry at 0xfb520
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 204M
> agpgart: Detected Intel 440BX chipset
> agpgart: AGP aperture is 64M @ 0xd8000000
> Linux NET4.0 for Linux 2.2
> Based upon Swansea University Computer Society NET3.039
> NET4: Unix domain sockets 1.0 for Linux NET4.0.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> TCP: Hash tables configured (ehash 262144 bhash 65536)
> IPAcctUser: version 0.9b
> IPv4 over IPv4 tunneling driver
> early initialization of device tunl0 is deferred
> divert: not allocating divert_blk for non-ethernet device tunl0
> GRE over IPv4 tunneling driver
> early initialization of device gre0 is deferred
> divert: not allocating divert_blk for non-ethernet device gre0
> Initializing RT netlink socket
> Starting kswapd v 1.5
> parport0: PC-style at 0x378 [SPP,PS2]
> i2c-core.o: i2c core module version 2.6.2 (20011118)
> i2c-dev.o: i2c /dev entries driver module version 2.6.2 (20011118)
> i2c-core.o: driver i2c-dev dummy driver registered.
> i2c-proc.o version 2.6.2 (20011118)
> i2c-piix4.o version 2.6.2 (20011118)
> i2c-piix4.o: Found PIIX4 device
> i2c-dev.o: Registered 'SMBus PIIX4 adapter at 5000' as minor 0
> i2c-core.o: adapter SMBus PIIX4 adapter at 5000 registered as adapter 0.
> i2c-piix4.o: SMBus detected and initialized
> i2c-isa.o version 2.6.2 (20011118)
> i2c-dev.o: Registered 'ISA main adapter' as minor 1
> i2c-core.o: adapter ISA main adapter registered as adapter 1.
> i2c-isa.o: ISA bus access for i2c modules initialized.
> Detected PS/2 Mouse Port.
> Serial driver version 4.27 with no serial options enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> pty: 256 Unix98 ptys configured
> lp0: using parport0 (polling).
> Real Time Clock Driver v1.09
> Non-volatile memory driver v1.0a
> Sound initialization started
> ESS chip ES1869 detected
> <ESS ES1869 AudioDrive (rev 11) (3.01)> at 0x220 irq 5 dma 1,3
> <ESS ES1688> at 0x330 irq 5 dma 0
> Sound initialization complete
> i2c: initialized
> Linux video capture interface: v1.00
> bttv0: Brooktree Bt848 (rev 17) bus: 0, devfn: 88, irq: 9, memory: 0xdf001000.
> bttv: 1 Bt8xx card(s) found.
> bttv0: NO fader chip: TEA6300
> bttv0: model: BT848(Miro)
> GemTek Radio Card driver.
> loop: registered device at major 7
> Uniform Multi-Platform E-IDE driver Revision: 6.30
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev 39
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
> HPT370: IDE controller on PCI bus 00 dev 98
> HPT370: chipset revision 3
> HPT370: not 100% native mode: will probe irqs later
>     ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:pio
>     ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
> hda: CD-W54E, ATAPI CDROM drive
> hdb: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
> hde: Maxtor 5T040H4, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide2 at 0xd800-0xd807,0xdc02 on irq 10
> hde: Maxtor 5T040H4, 39083MB w/2048kB Cache, CHSy408/16/63, UDMA(100)
> hdb: No disk in drive
> hdb: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
> hdb: The drive reports both 100663296 and 0 bytes as its capacity
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> md driver 0.36.6 MAX_MD_DEV=4, MAX_REAL=8
> raid0 personality registered
> raid1 personality registered
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> scsi : 1 host.
>   Vendor: TEAC      Model: CD-W54E           Rev: 1.1Y
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> scsi : detected 1 SCSI generic 1 SCSI cdrom total.
> sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.11
> early initialization of device teql0 is deferred
> divert: not allocating divert_blk for non-ethernet device teql0
> NET4: Frame Diverter 0.461
> via-rhine.c:v1.08b-LK1.0.1 12/14/2000  Written by Donald Becker
>   http://www.scyld.com/network/via-rhine.html
> eth0: VIA VT6102 Rhine-II at 0xd400, 00:50:ba:fa:c2:bd, IRQ 11.
> eth0: MII PHY found at address 8, status 0x7809 advertising 01e1 Link 0000.
> divert: allocating divert_blk for eth0
> Partition check:
>  hde: [PTBL] [4982/255/63] hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 hde9 hde10 >
> apm: BIOS version 1.2 Flags 0x07 (Driver version 1.13)
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb.c: registered new driver usblp
> usb.c: registered new driver usbscanner
> scanner.c: USB Scanner support registered.
> usb-uhci.c: $Revision: 1.237 $ time 20:47:44 Jan  7 2002
> usb-uhci.c: High bandwidth mode enabled
> usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 9
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> usb.c: USB new device connect, assigned device number 1
> usb.c: kmalloc IF cfcd3b00, numif 1
> usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
> usb.c: USB device number 1 default language ID 0x0
> Product: USB UHCI Root Hub
> SerialNumber: d000
> hub.c: USB hub found
> hub.c: 2 ports detected
> hub.c: standalone hub
> hub.c: ganged power switching
> hub.c: global over-current protection
> hub.c: power on to power good time: 2ms
> hub.c: hub controller current requirement: 0mA
> hub.c: port removable status: RR
> hub.c: local power source is good
> hub.c: no over-current condition exists
> hub.c: enabling power on all ports
> usb.c: hub driver claimed interface cfcd3b00
> usb.c: call_policy add, num 1 -- no FS yet
> udf: registering filesystem
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 76k freed
> Adding Swap: 240932k swap-space (priority -1)
> CSLIP: code copyright 1989 Regents of the University of California
> PPP: version 2.3.7 (demand dialling)
> PPP line discipline registered.
> PPP Deflate Compression module registered
> /dev/vmmon: Module vmmon: registered with major minor5 tag=$Name: build-1142 $
> /dev/vmmon: Module vmmon: initialized
> /dev/vmnet: open called by PID 159 (vmnet-bridge)
> /dev/vmnet: hub 0 does not exist, allocating memory.
> /dev/vmnet: port on hub 0 successfully opened
> bridge-eth0: up
> bridge-eth0: attached
> /dev/vmnet: open called by PID 169 (vmnet-netifup)
> /dev/vmnet: hub 1 does not exist, allocating memory.
> /dev/vmnet: port on hub 1 successfully opened
> divert: not allocating divert_blk for non-ethernet device vmnet1
> /dev/vmnet: open called by PID 179 (vmnet-dhcpd)
> /dev/vmnet: port on hub 1 successfully opened
> divert: not allocating divert_blk for non-ethernet device ppp0
> registered device ppp0
> 
> 
> #
> # Automatically generated by make menuconfig: don't edit
> #
> CONFIG_X86=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> 
> #
> # Processor type and features
> #
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> CONFIG_M686=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_TSC=y
> CONFIG_X86_GOOD_APIC=y
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> CONFIG_1GB=y
> # CONFIG_2GB is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> # CONFIG_SMP is not set
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> # CONFIG_MODVERSIONS is not set
> CONFIG_KMOD=y
> 
> #
> # General setup
> #
> CONFIG_NET=y
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_QUIRKS=y
> CONFIG_PCI_OPTIMIZE=y
> CONFIG_PCI_OLD_PROC=y
> # CONFIG_MCA is not set
> # CONFIG_VISWS is not set
> CONFIG_SYSVIPC=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_SYSCTL=y
> CONFIG_BINFMT_AOUT=y
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_ELF_AOUT is not set
> CONFIG_BINFMT_MISC=y
> # CONFIG_BINFMT_JAVA is not set
> CONFIG_PARPORT=y
> CONFIG_PARPORT_PC=y
> # CONFIG_PARPORT_OTHER is not set
> CONFIG_APM=y
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> # CONFIG_APM_DO_ENABLE is not set
> CONFIG_APM_CPU_IDLE=y
> # CONFIG_APM_DISPLAY_BLANK is not set
> # CONFIG_APM_RTC_IS_GMT is not set
> # CONFIG_APM_ALLOW_INTS is not set
> CONFIG_APM_REAL_MODE_POWER_OFF=y
> # CONFIG_TOSHIBA is not set
> 
> #
> # Plug and Play support
> #
> # CONFIG_PNP is not set
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=y
> CONFIG_BLK_DEV_IDE=y
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> # CONFIG_IDEDISK_MULTI_MODE is not set
> # CONFIG_IDEDISK_STROKE is not set
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> CONFIG_BLK_DEV_IDEFLOPPY=y
> CONFIG_BLK_DEV_IDESCSI=y
> # CONFIG_IDE_TASK_IOCTL is not set
> # CONFIG_PKT_TASK_IOCTL is not set
> # CONFIG_IDE_TASK_IOCTL_DEBUG is not set
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
> CONFIG_IDEDMA_PCI_EXPERIMENTAL=y
> CONFIG_IDEDMA_PCI_WIP=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> CONFIG_BLK_DEV_HPT366=y
> # HPT366_MODE3 is not set
> CONFIG_BLK_DEV_PIIX=y
> CONFIG_PIIX_TUNING=y
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_PDC202XX is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_OSB4 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_CHIPSETS is not set
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_NBD=y
> CONFIG_BLK_DEV_MD=y
> # CONFIG_MD_LINEAR is not set
> CONFIG_MD_STRIPED=y
> CONFIG_MD_MIRRORING=y
> # CONFIG_MD_RAID5 is not set
> # CONFIG_MD_BOOT is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> CONFIG_PARIDE_PARPORT=y
> # CONFIG_PARIDE is not set
> CONFIG_BLK_DEV_IDE_MODES=y
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_HD is not set
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_NETLINK=y
> CONFIG_RTNETLINK=y
> CONFIG_NETLINK_DEV=y
> CONFIG_FIREWALL=y
> CONFIG_FILTER=y
> CONFIG_UNIX=y
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> CONFIG_IP_FIREWALL=y
> CONFIG_IP_FIREWALL_NETLINK=y
> CONFIG_NETLINK_DEV=y
> CONFIG_IP_TRANSPARENT_PROXY=y
> CONFIG_IP_MASQUERADE=y
> CONFIG_IP_MASQUERADE_ICMP=y
> CONFIG_IP_MASQUERADE_MOD=y
> CONFIG_IP_MASQUERADE_IPAUTOFW=y
> CONFIG_IP_MASQUERADE_IPPORTFW=y
> CONFIG_IP_MASQUERADE_MFW=y
> CONFIG_IP_ACCT_USER=y
> # CONFIG_IP_ROUTER is not set
> CONFIG_NET_IPIP=y
> CONFIG_NET_IPGRE=y
> CONFIG_IP_ALIAS=y
> # CONFIG_ARPD is not set
> CONFIG_SYN_COOKIES=y
> CONFIG_INET_RARP=y
> CONFIG_SKB_LARGE=y
> # CONFIG_IPV6 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_BRIDGE is not set
> CONFIG_NET_DIVERT=y
> # CONFIG_LLC is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
> # CONFIG_CPU_IS_SLOW is not set
> 
> #
> # QoS and/or fair queueing
> #
> CONFIG_NET_SCHED=y
> CONFIG_NETLINK=y
> CONFIG_RTNETLINK=y
> CONFIG_NET_SCH_CBQ=y
> CONFIG_NET_SCH_CSZ=y
> CONFIG_NET_SCH_PRIO=y
> CONFIG_NET_SCH_RED=y
> CONFIG_NET_SCH_SFQ=y
> CONFIG_NET_SCH_TEQL=y
> CONFIG_NET_SCH_TBF=y
> CONFIG_NET_QOS=y
> CONFIG_NET_ESTIMATOR=y
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_ROUTE4=y
> CONFIG_NET_CLS_ROUTE=y
> CONFIG_NET_CLS_FW=y
> CONFIG_NET_CLS_U32=y
> CONFIG_NET_CLS_RSVP=y
> CONFIG_NET_CLS_RSVP6=y
> CONFIG_NET_CLS_POLICE=y
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> # CONFIG_PHONE_IXJ is not set
> 
> #
> # SCSI support
> #
> CONFIG_SCSI=y
> # CONFIG_BLK_DEV_SD is not set
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=y
> # CONFIG_BLK_DEV_SR_VENDOR is not set
> CONFIG_CHR_DEV_SG=y
> CONFIG_SCSI_MULTI_LUN=y
> CONFIG_SCSI_CONSTANTS=y
> # CONFIG_SCSI_LOGGING is not set
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AHA1740 is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_DMA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_SIM710 is not set
> # CONFIG_SCSI_NCR53C7xx is not set
> # CONFIG_SCSI_NCR53C8XX is not set
> # CONFIG_SCSI_SYM53C8XX is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_SEAGATE is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> # CONFIG_I2O_PCI is not set
> # CONFIG_I2O_BLOCK is not set
> # CONFIG_I2O_SCSI is not set
> 
> #
> # Network device support
> #
> CONFIG_NETDEVICES=y
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> CONFIG_DUMMY=y
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_ETHERTAP is not set
> # CONFIG_NET_SB1000 is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
> # CONFIG_RTL8139 is not set
> # CONFIG_RTL8139TOO is not set
> # CONFIG_NET_ISA is not set
> CONFIG_NET_EISA=y
> # CONFIG_PCNET32 is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_AC3200 is not set
> # CONFIG_APRICOT is not set
> # CONFIG_LP486E is not set
> # CONFIG_CS89x0 is not set
> # CONFIG_DM9102 is not set
> # CONFIG_DE4X5 is not set
> # CONFIG_DEC_ELCP is not set
> # CONFIG_DEC_ELCP_OLD is not set
> # CONFIG_DGRS is not set
> # CONFIG_EEXPRESS_PRO100 is not set
> # CONFIG_LNE390 is not set
> # CONFIG_NE3210 is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_TLAN is not set
> CONFIG_VIA_RHINE=y
> # CONFIG_SIS900 is not set
> # CONFIG_ES3210 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_ZNET is not set
> # CONFIG_NET_POCKET is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PLIP is not set
> CONFIG_PPP=m
> # CONFIG_SLIP is not set
> # CONFIG_NET_RADIO is not set
> 
> #
> # Token ring devices
> #
> # CONFIG_TR is not set
> # CONFIG_NET_FC is not set
> # CONFIG_RCPCI is not set
> # CONFIG_SHAPER is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_HOSTESS_SV11 is not set
> # CONFIG_COSA is not set
> # CONFIG_SEALEVEL_4021 is not set
> # CONFIG_SYNCLINK_SYNCPPP is not set
> # CONFIG_LANMEDIA is not set
> # CONFIG_COMX is not set
> # CONFIG_HDLC is not set
> # CONFIG_DLCI is not set
> # CONFIG_XPEED is not set
> # CONFIG_SBNI is not set
> 
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
> 
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
> 
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=y
> CONFIG_SERIAL_CONSOLE=y
> # CONFIG_SERIAL_EXTENDED is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT%6
> CONFIG_PRINTER=y
> CONFIG_PRINTER_READBACK=y
> CONFIG_MOUSE=y
> 
> #
> # Mice
> #
> # CONFIG_ATIXL_BUSMOUSE is not set
> # CONFIG_BUSMOUSE is not set
> # CONFIG_MS_BUSMOUSE is not set
> CONFIG_PSMOUSE=y
> # CONFIG_82C710_MOUSE is not set
> # CONFIG_PC110_PAD is not set
> 
> #
> # Joysticks
> #
> # CONFIG_JOYSTICK is not set
> # CONFIG_QIC02_TAPE is not set
> # CONFIG_WATCHDOG is not set
> CONFIG_NVRAM=y
> CONFIG_RTC=y
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> # CONFIG_I2C_ALGOBIT is not set
> # CONFIG_I2C_ALGOPCF is not set
> CONFIG_I2C_MAINBOARD=y
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_HYDRA is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_TSUNAMI is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_I810 is not set
> CONFIG_I2C_PIIX4=y
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> # CONFIG_I2C_VOODOO3 is not set
> CONFIG_I2C_ISA=y
> CONFIG_I2C_CHARDEV=y
> CONFIG_I2C_PROC=y
> 
> #
> # Hardware sensors support
> #
> CONFIG_SENSORS=y
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1024 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_FSCPOS is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_MAXILIFE is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_MTP008 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM87 is not set
> # CONFIG_SENSORS_SIS5595 is not set
> # CONFIG_SENSORS_THMC50 is not set
> # CONFIG_SENSORS_VIA686A is not set
> CONFIG_SENSORS_W83781D=y
> CONFIG_SENSORS_OTHER=y
> # CONFIG_SENSORS_BT869 is not set
> CONFIG_SENSORS_DDCMON=y
> CONFIG_SENSORS_EEPROM=y
> # CONFIG_SENSORS_MATORB is not set
> # CONFIG_INTEL_RNG is not set
> CONFIG_AGP=y
> CONFIG_AGP_INTEL=y
> # CONFIG_AGP_I810 is not set
> # CONFIG_AGP_VIA is not set
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_SWORKS is not set
> CONFIG_DRM=y
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_GAMMA is not set
> # CONFIG_DRM_R128 is not set
> # CONFIG_DRM_I810 is not set
> # CONFIG_DRM_MGA is not set
> 
> #
> # Video For Linux
> #
> CONFIG_VIDEO_DEV=y
> # CONFIG_RADIO_RTRACK is not set
> # CONFIG_RADIO_RTRACK2 is not set
> # CONFIG_RADIO_AZTECH is not set
> # CONFIG_RADIO_CADET is not set
> CONFIG_RADIO_GEMTEK=y
> CONFIG_RADIO_GEMTEK_PORT(c
> # CONFIG_RADIO_MAESTRO is not set
> # CONFIG_RADIO_MIROPCM20 is not set
> # CONFIG_RADIO_TRUST is not set
> CONFIG_VIDEO_BT848=y
> # CONFIG_VIDEO_BWQCAM is not set
> # CONFIG_VIDEO_CQCAM is not set
> # CONFIG_VIDEO_CPIA is not set
> # CONFIG_VIDEO_PMS is not set
> # CONFIG_VIDEO_SAA5249 is not set
> # CONFIG_RADIO_SF16FMI is not set
> # CONFIG_RADIO_TYPHOON is not set
> # CONFIG_RADIO_ZOLTRIX is not set
> # CONFIG_VIDEO_ZORAN is not set
> # CONFIG_VIDEO_BUZ is not set
> # CONFIG_DTLK is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> 
> #
> # USB support
> #
> CONFIG_USB=y
> CONFIG_USB_DEBUG=y
> CONFIG_USB_DEVICEFS=y
> CONFIG_HOTPLUG=y
> # CONFIG_USB_BANDWIDTH is not set
> CONFIG_USB_UHCI=y
> # CONFIG_USB_OHCI is not set
> # CONFIG_USB_AUDIO is not set
> # CONFIG_USB_BLUETOOTH is not set
> # CONFIG_USB_STORAGE is not set
> # CONFIG_USB_ACM is not set
> CONFIG_USB_PRINTER=y
> # CONFIG_USB_HID is not set
> # CONFIG_USB_KBD is not set
> # CONFIG_USB_MOUSE is not set
> # CONFIG_INPUT_KEYBDEV is not set
> # CONFIG_INPUT_MOUSEDEV is not set
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_USB_WMFORCE is not set
> # CONFIG_USB_WACOM is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_USB_DC2XX is not set
> # CONFIG_USB_MDC800 is not set
> CONFIG_USB_SCANNER=y
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USB_IBMCAM is not set
> # CONFIG_USB_OV511 is not set
> # CONFIG_USB_DSBR is not set
> # CONFIG_USB_DABUSB is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PLUSB is not set
> # CONFIG_USB_PEGASUS is not set
> 
> #
> # USB Serial Converter support
> #
> # CONFIG_USB_SERIAL is not set
> # CONFIG_USB_RIO500 is not set
> 
> #
> # Filesystems
> #
> # CONFIG_QUOTA is not set
> CONFIG_AUTOFS_FS=y
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> CONFIG_FAT_FS=y
> # CONFIG_MSDOS_FS is not set
> # CONFIG_UMSDOS_FS is not set
> CONFIG_VFAT_FS=y
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_UDF_FS=y
> # CONFIG_UDF_RW is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_HPFS_FS is not set
> CONFIG_PROC_FS=y
> CONFIG_DEVPTS_FS=y
> # CONFIG_QNX4FS_FS is not set
> CONFIG_ROMFS_FS=y
> CONFIG_EXT2_FS=y
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_EFS_FS is not set
> 
> #
> # Network File Systems
> #
> # CONFIG_CODA_FS is not set
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> CONFIG_NFSD=y
> CONFIG_NFSD_V3=y
> # CONFIG_NFSD_TCP is not set
> CONFIG_SUNRPC=y
> CONFIG_LOCKD=y
> CONFIG_SMB_FS=y
> # CONFIG_SMB_NLS_DEFAULT is not set
> # CONFIG_NCP_FS is not set
> 
> #
> # Partition Types
> #
> # CONFIG_BSD_DISKLABEL is not set
> # CONFIG_MAC_PARTITION is not set
> # CONFIG_MINIX_SUBPARTITION is not set
> # CONFIG_SMD_DISKLABEL is not set
> # CONFIG_SOLARIS_X86_PARTITION is not set
> # CONFIG_UNIXWARE_DISKLABEL is not set
> CONFIG_NLS=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT="cp437"
> # CONFIG_NLS_CODEPAGE_437 is not set
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_ISO8859_1 is not set
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_RU is not set
> 
> #
> # Console drivers
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_VIDEO_SELECT=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_FB=y
> CONFIG_DUMMY_CONSOLE=y
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_ATY is not set
> CONFIG_FB_VESA=y
> # CONFIG_FB_VGA16 is not set
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_VIRTUAL is not set
> CONFIG_FBCON_ADVANCED=y
> # CONFIG_FBCON_MFB is not set
> # CONFIG_FBCON_CFB2 is not set
> # CONFIG_FBCON_CFB4 is not set
> CONFIG_FBCON_CFB8=y
> CONFIG_FBCON_CFB16=y
> CONFIG_FBCON_CFB24=y
> CONFIG_FBCON_CFB32=y
> # CONFIG_FBCON_AFB is not set
> # CONFIG_FBCON_ILBM is not set
> # CONFIG_FBCON_IPLAN2P2 is not set
> # CONFIG_FBCON_IPLAN2P4 is not set
> # CONFIG_FBCON_IPLAN2P8 is not set
> # CONFIG_FBCON_MAC is not set
> # CONFIG_FBCON_VGA_PLANES is not set
> # CONFIG_FBCON_VGA is not set
> # CONFIG_FBCON_FONTWIDTH8_ONLY is not set
> CONFIG_FBCON_FONTS=y
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> # CONFIG_FONT_SUN8x16 is not set
> # CONFIG_FONT_SUN12x22 is not set
> # CONFIG_FONT_6x11 is not set
> # CONFIG_FONT_PEARL_8x8 is not set
> # CONFIG_FONT_ACORN_8x8 is not set
> 
> #
> # Sound
> #
> CONFIG_SOUND=y
> # CONFIG_SOUND_CMPCI is not set
> # CONFIG_SOUND_CS4281 is not set
> # CONFIG_SOUND_FUSION is not set
> # CONFIG_SOUND_EMU10K1 is not set
> # CONFIG_SOUND_ES1370 is not set
> # CONFIG_SOUND_ES1371 is not set
> # CONFIG_SOUND_MAESTRO is not set
> # CONFIG_SOUND_MAESTRO3 is not set
> # CONFIG_SOUND_ESSSOLO1 is not set
> # CONFIG_SOUND_ICH is not set
> # CONFIG_SOUND_SONICVIBES is not set
> # CONFIG_SOUND_TRIDENT is not set
> # CONFIG_SOUND_MSNDCLAS is not set
> # CONFIG_SOUND_MSNDPIN is not set
> # CONFIG_SOUND_VIA82CXXX is not set
> CONFIG_SOUND_OSS=y
> # CONFIG_SOUND_DMAP is not set
> # CONFIG_SOUND_PAS is not set
> CONFIG_SOUND_SB=y
> CONFIG_SB_BASE"0
> CONFIG_SB_IRQ=5
> CONFIG_SB_DMA=1
> CONFIG_SB_DMA2=3
> CONFIG_SB_MPU_BASE30
> CONFIG_SB_MPU_IRQ=-1
> # CONFIG_SOUND_GUS is not set
> # CONFIG_SOUND_MPU401 is not set
> # CONFIG_SOUND_PSS is not set
> # CONFIG_SOUND_MSS is not set
> # CONFIG_SOUND_SSCAPE is not set
> # CONFIG_SOUND_TRIX is not set
> # CONFIG_SOUND_MAD16 is not set
> # CONFIG_SOUND_WAVEFRONT is not set
> # CONFIG_SOUND_CS4232 is not set
> # CONFIG_SOUND_OPL3SA2 is not set
> # CONFIG_SOUND_MAUI is not set
> # CONFIG_SOUND_SGALAXY is not set
> # CONFIG_SOUND_AD1816 is not set
> # CONFIG_SOUND_OPL3SA1 is not set
> # CONFIG_SOUND_SOFTOSS is not set
> # CONFIG_SOUND_YM3812 is not set
> # CONFIG_SOUND_VMIDI is not set
> # CONFIG_SOUND_UART6850 is not set
> # CONFIG_SOUND_NM256 is not set
> # CONFIG_SOUND_YMFPCI is not set
> 
> #
> # Additional low level sound drivers
> #
> # CONFIG_LOWLEVEL_SOUND is not set
> 
> #
> # Security options
> #
> CONFIG_SECURE_STACK=y
> CONFIG_SECURE_STACK_SMART=y
> CONFIG_SECURE_LINK=y
> CONFIG_SECURE_FIFO=y
> CONFIG_SECURE_PROC=y
> CONFIG_SECURE_FD_0_1_2=y
> CONFIG_SECURE_RLIMIT_NPROC=y
> CONFIG_SECURE_SHM=y
> 
> #
> # Kernel hacking
> #
> CONFIG_MAGIC_SYSRQ=y
