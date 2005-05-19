From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: Strange sensors output
Message-Id: <3CEC0714.9E37B191@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <002201c2000c$f90a3b00$0f01a8c0@art>
In-Reply-To: <002201c2000c$f90a3b00$0f01a8c0@art>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Did sensors-detect find a w83782d?
Do you really have a w83782d (look at your board)?
send us the output of i2cdump 0 0x2d if it's not all FF's.

> Chad McKay wrote:
> 
> 
>  This is the output from the sensors program :
>  ------
>  # sensors
>  w83782d-i2c-0-2d
>  Adapter: SMBus PIIX4 adapter at 5000
>  Algorithm: Non-I2C SMBus adapter
>  VCore 1:   +4.08 V  (min =  +4.08 V, max =  +4.08 V)
>  VCore 2:   +4.08 V  (min =  +4.08 V, max =  +4.08 V)
>  +3.3V:     +4.08 V  (min =  +4.08 V, max =  +4.08 V)
>  +5V:       +6.85 V  (min =  +6.85 V, max =  +6.85 V)
>  +12V:     +15.50 V  (min = +15.50 V, max = +15.50 V)       ALARM  (beep)
>  -12V:      +6.06 V  (min =  +6.06 V, max =  +6.06 V)       ALARM  (beep)
>  -5V:       +5.10 V  (min =  +5.10 V, max =  +5.10 V)       ALARM  (beep)
>  V5SB:      +6.85 V  (min =  +6.85 V, max =  +6.85 V)       ALARM  (beep)
>  VBat:      +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
>  fan1:        0 RPM  (min =    0 RPM, div = 128)
>  fan2:        0 RPM  (min =    0 RPM, div = 128)
>  fan3:        0 RPM  (min =    0 RPM, div = 128)              ALARM
> (beep)
>  temp1:    -1.0?C   (limit =  -1?C, hysteresis =  -1?C) sensor = PII/Celeron diode
>  temp2:    +255.5?C   (limit = +256?C, hysteresis = +256?C) sensor = 3904 transistor
>  temp3:    +25.0?C   (limit = +60?C, hysteresis = +50?C) sensor =  thermistor   ALARM   (beep)
>  vid:      +0.00 V
>  alarms:   Chassis intrusion detection                      ALARM  (beep)
>  beep_enable:
>            Sound alarm enabled
>  -----
> 
>  None of this is anywhere near correct (obviously?).
> 
>  Is this a problem with my system or have I got something configured
> wrong. The first time I booted the system the speaker started beeping
> after a few seconds and never stopped - however the system runs fine
> (65 days uptime at one point). I also ran win2000 on it for about 2
> years with no problems.
> 
>  Thanks for your help
> 
>  Chad McKay
> 
>  Some system info:
> 
>  standard /etc/sensors.conf file
> 
>  Red Hat Linux release 7.2 (Enigma)
>  Kernel 2.4.7-10smp on a 2-processor i686
> 
>  lm_sensors installed via RPM
>  # sensors -v
>  sensors version 1.3
> 
>  Abit bp6 MB w/ 2 clereron 366 OC @ 550 (same problems @ 366)
> 
>  dmesg output:
> 
>  Linux version 2.4.7-10smp (bhcompile@stripples.devel.redhat.com) (gcc
> version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 SMP Thu Sep 6
> 17:09:31 EDT 2001
>  BIOS-provided physical RAM map:
>   BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>   BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>   BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
>   BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
>   BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
>   BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>   BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>   BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
>  Scanning bios EBDA for MXT signature
>  found SMP MP-table at 000f5ae0
>  hm, page 000f5000 reserved twice.
>  hm, page 000f6000 reserved twice.
>  hm, page 000f1000 reserved twice.
>  hm, page 000f2000 reserved twice.
>  On node 0 totalpages: 131056
>  zone(0): 4096 pages.
>  zone(1): 126960 pages.
>  zone(2): 0 pages.
>  Intel MultiProcessor Specification v1.1
>      Virtual Wire compatibility mode.
>  OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
>  Processor #0 Pentium(tm) Pro APIC version 17
>  Processor #1 Pentium(tm) Pro APIC version 17
>  I/O APIC #2 Version 17 at 0xFEC00000.
>  Processors: 2
>  Kernel command line: ro root=/dev/hda2
>  Initializing CPU#0
>  Detected 551.260 MHz processor.
>  Console: colour VGA+ 80x25
>  Calibrating delay loop... 1101.00 BogoMIPS
>  Memory: 510252k/524224k available (1396k kernel code, 11524k reserved,
> 102k data, 240k init, 0k highmem)
>  Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
>  Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
>  Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
>  Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
>  Page-cache hash table entries: 131072 (order: 8, 1048576 bytes)
>  CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
>  CPU: L1 I cache: 16K, L1 D cache: 16K
>  CPU: L2 cache: 128K
>  Intel machine check architecture supported.
>  Intel machine check reporting enabled on CPU#0.
>  CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
>  CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
>  CPU:             Common caps: 0183fbff 00000000 00000000 00000000
>  Enabling fast FPU save and restore... done.
>  Checking 'hlt' instruction... OK.
>  POSIX conformance testing by UNIFIX
>  mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
>  mtrr: detected mtrr type: Intel
>  CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
>  CPU: L1 I cache: 16K, L1 D cache: 16K
>  CPU: L2 cache: 128K
>  Intel machine check reporting enabled on CPU#0.
>  CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
>  CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
>  CPU:             Common caps: 0183fbff 00000000 00000000 00000000
>  CPU0: Intel Celeron (Mendocino) stepping 05
>  per-CPU timeslice cutoff: 365.65 usecs.
>  enabled ExtINT on CPU#0
>  ESR value before enabling vector: 00000000
>  ESR value after enabling vector: 00000000
>  Booting processor 1/1 eip 2000
>  Initializing CPU#1
>  masked ExtINT on CPU#1
>  ESR value before enabling vector: 00000000
>  ESR value after enabling vector: 00000000
>  Calibrating delay loop... 1101.00 BogoMIPS
>  CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
>  CPU: L1 I cache: 16K, L1 D cache: 16K
>  CPU: L2 cache: 128K
>  Intel machine check reporting enabled on CPU#1.
>  CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
>  CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
>  CPU:             Common caps: 0183fbff 00000000 00000000 00000000
>  CPU1: Intel Celeron (Mendocino) stepping 05
>  Total of 2 processors activated (2202.00 BogoMIPS).
>  ENABLING IO-APIC IRQs
>  ...changing IO-APIC physical APIC ID to 2 ... ok.
>  init IO_APIC IRQs
>   IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-12, 2-17, 2-20, 2-21, 2-22,
> 2-23 not connected.
>  ..TIMER: vector=0x31 pin1=2 pin2=0
>  number of MP IRQ sources: 16.
>  number of IO-APIC #2 registers: 24.
>  testing the IO APIC.......................
> 
>  IO APIC #2......
>  .... register #00: 02000000
>  .......    : physical APIC id: 02
>  .... register #01: 00170011
>  .......     : max redirection entries: 0017
>  .......     : IO APIC version: 0011
>  .... register #02: 00000000
>  .......     : arbitration: 00
>  .... IRQ redirection table:
>   NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>   00 000 00  1    0    0   0   0    0    0    00
>   01 003 03  0    0    0   0   0    1    1    39
>   02 003 03  0    0    0   0   0    1    1    31
>   03 003 03  0    0    0   0   0    1    1    41
>   04 003 03  0    0    0   0   0    1    1    49
>   05 003 03  0    0    0   0   0    1    1    51
>   06 003 03  0    0    0   0   0    1    1    59
>   07 003 03  0    0    0   0   0    1    1    61
>   08 003 03  0    0    0   0   0    1    1    69
>   09 003 03  0    0    0   0   0    1    1    71
>   0a 000 00  1    0    0   0   0    0    0    00
>   0b 000 00  1    0    0   0   0    0    0    00
>   0c 000 00  1    0    0   0   0    0    0    00
>   0d 003 03  0    0    0   0   0    1    1    79
>   0e 003 03  0    0    0   0   0    1    1    81
>   0f 003 03  0    0    0   0   0    1    1    89
>   10 003 03  1    1    0   1   0    1    1    91
>   11 000 00  1    0    0   0   0    0    0    00
>   12 003 03  1    1    0   1   0    1    1    99
>   13 003 03  1    1    0   1   0    1    1    A1
>   14 000 00  1    0    0   0   0    0    0    00
>   15 000 00  1    0    0   0   0    0    0    00
>   16 000 00  1    0    0   0   0    0    0    00
>   17 000 00  1    0    0   0   0    0    0    00
>  IRQ to pin mappings:
>  IRQ0 -> 0:2
>  IRQ1 -> 0:1
>  IRQ3 -> 0:3
>  IRQ4 -> 0:4
>  IRQ5 -> 0:5
>  IRQ6 -> 0:6
>  IRQ7 -> 0:7
>  IRQ8 -> 0:8
>  IRQ9 -> 0:9
>  IRQ10 -> 0:19
>  IRQ11 -> 0:18
>  IRQ12 -> 0:16
>  IRQ13 -> 0:13
>  IRQ14 -> 0:14
>  IRQ15 -> 0:15
>  .................................... done.
>  Using local APIC timer interrupts.
>  calibrating APIC timer ...
>  ..... CPU clock speed is 551.2717 MHz.
>  ..... host bus clock speed is 100.2310 MHz.
>  cpu: 0, clocks: 1002310, slice: 334103
>  CPU0<T0:1002304,T1:668192,D:9,S:334103,C:1002310>
>  cpu: 1, clocks: 1002310, slice: 334103
>  CPU1<T0:1002304,T1:334096,D:2,S:334103,C:1002310>
>  checking TSC synchronization across CPUs: passed.
>  mtrr: your CPUs had inconsistent fixed MTRR settings
>  mtrr: probably your BIOS does not setup all CPUs
>  PCI: PCI BIOS revision 2.10 entry at 0xfb5c0, last bus=1
>  PCI: Using configuration type 1
>  PCI: Probing PCI hardware
>  PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
>  Limiting direct PCI/PCI transfers.
>  isapnp: Scanning for PnP cards...
>  isapnp: No Plug & Play device found
>  Linux NET4.0 for Linux 2.4
>  Based upon Swansea University Computer Society NET3.039
>  Initializing RT netlink socket
>  apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
>  apm: disabled - APM is not SMP safe.
>  mxt_scan_bios: enter
>  Starting kswapd v1.8
>  VFS: Diskquotas version dquot_6.5.0 initialized
>  Detected PS/2 Mouse Port.
>  pty: 2048 Unix98 ptys configured
>  Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT
> SHARE_IRQ SERIAL_PCI ISAPNP enabled
>  ttyS00 at 0x03f8 (irq = 4) is a 16550A
>  ttyS01 at 0x02f8 (irq = 3) is a 16550A
>  Real Time Clock Driver v1.10d
>  block: queued sectors max/low 338757kB/207685kB, 1024 slots per queue
>  RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
>  Uniform Multi-Platform E-IDE driver Revision: 6.31
>  ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
>  PIIX4: IDE controller on PCI bus 00 dev 39
>  PIIX4: chipset revision 1
>  PIIX4: not 100% native mode: will probe irqs later
>      ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
>      ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
>  HPT366: onboard version of chipset, pin1=1 pin2=2
>  HPT366: IDE controller on PCI bus 00 dev 98
>  HPT366: chipset revision 1
>  HPT366: not 100% native mode: will probe irqs later
>      ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:pio, hdf:pio
>  HPT366: IDE controller on PCI bus 00 dev 99
>  HPT366: chipset revision 1
>  HPT366: not 100% native mode: will probe irqs later
>      ide3: BM-DMA at 0xec00-0xec07, BIOS settings: hdg:pio, hdh:pio
>  hda: ST38410A, ATA DISK drive
>  hdc: LTN382, ATAPI CD/DVD-ROM drive
>  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>  ide1 at 0x170-0x177,0x376 on irq 15
>  hda: 16841664 sectors (8623 MB) w/512KiB Cache, CHS48/255/63,
> UDMA(33)
>  ide-floppy driver 0.97
>  Partition check:
>   hda: hda1 hda2 hda3 < hda5 hda6 >
>  Floppy drive(s): fd0 is 1.44M
>  FDC 0 is a post-1991 82077
>  ide-floppy driver 0.97
>  md: md driver 0.90.0 MAX_MD_DEVS%6, MD_SB_DISKS'
>  md: Autodetecting RAID arrays.
>  md: autorun ...
>  md: ... autorun DONE.
>  NET4: Linux TCP/IP 1.0 for NET4.0
>  IP Protocols: ICMP, UDP, TCP, IGMP
>  IP: routing cache hash table of 4096 buckets, 32Kbytes
>  TCP: Hash tables configured (established 32768 bind 32768)
>  Linux IP multicast router 0.06 plus PIM-SM
>  NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>  RAMDISK: Compressed image found at block 0
>  Freeing initrd memory: 323k freed
>  VFS: Mounted root (ext2 filesystem).
>  Journalled Block Device driver loaded
>  kjournald starting.  Commit interval 5 seconds
>  EXT3-fs: mounted filesystem with ordered data mode.
>  Freeing unused kernel memory: 240k freed
>  Adding Swap: 136512k swap-space (priority -1)
>  Adding Swap: 519160k swap-space (priority -2)
>  EXT3 FS 2.4-0.9.8, 25 Aug 2001 on ide0(3,2), internal journal
>  kjournald starting.  Commit interval 5 seconds
>  EXT3 FS 2.4-0.9.8, 25 Aug 2001 on ide0(3,5), internal journal
>  EXT3-fs: mounted filesystem with ordered data mode.
>  kjournald starting.  Commit interval 5 seconds
>  EXT3 FS 2.4-0.9.8, 25 Aug 2001 on ide0(3,6), internal journal
>  EXT3-fs: mounted filesystem with ordered data mode.
>  ip_tables: (c)2000 Netfilter core team
>  ip_conntrack (4095 buckets, 32760 max)
>  via-rhine.c:v1.10-LK1.1.10  07/12/2001  Written by Donald Becker
>    http://www.scyld.com/network/via-rhine.html
>  eth0: VIA VT3043 Rhine at 0xd400, 00:a0:0c:c0:0e:a2, IRQ 10.
>  eth0: MII PHY found at address 1, status 0x782d advertising 05e1 Link
> 0000.
>  wd.c: Presently autoprobing (not recommended) for a single card.
>  wd.c:v1.10 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)
>  eth1: WD80x3 at 0x280, 00 00 C0 CC 27 1C WD8003, IRQ 3, shared memory
> at 0xd0000-0xd1fff.
>  i2c-core.o: i2c core module
>  piix4.o version 2.5.5 (20010115)
>  i2c-core.o: adapter SMBus PIIX4 adapter at 5000 registered as adapter 0.
>  i2c-piix4.o: PIIX4 bus detected and initialized
>  sensors.o version 2.5.5 (20010115)
>  w83781d.o version 2.5.5 (20010115)
>  i2c-core.o: driver W83781D sensor driver registered.
>  i2c-core.o: client [W83782D chip] registered to adapter [SMBus PIIX4
> adapter at 5000](pos. 0).
>  i2c-core.o: client [W83782D subclient] registered to adapter [SMBus
> PIIX4 adapter at 5000](pos. 1).
>  i2c-core.o: client [W83782D subclient] registered to adapter [SMBus
> PIIX4 adapter at 5000](pos. 2).
>  parport0: PC-style at 0x378 [PCSPP,TRISTATE]
>  parport0: cpp_daisy: aa5500ff(38)
>  parport0: assign_addrs: aa5500ff(38)
>  parport0: cpp_daisy: aa5500ff(38)
>  parport0: assign_addrs: aa5500ff(38)
