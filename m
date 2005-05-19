From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Ticket # 888
Message-Id: <3CF8F392.28D59901@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <004101c20731$826eb300$6501a8c0@nv.cox.net>
In-Reply-To: <004101c20731$826eb300$6501a8c0@nv.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

try i2cdumps of one of your eeproms (50-53) after the 'crash'
to see if they work. If not, the problem is in the piix4.
If so, the problem is in mtp008.
There were no clues in dmesg?

Paul Preston wrote:
> 
> lm_sensors/i2c 2.6.3, Linux RH 2.4.9-31smp
> MTP008 Tyan Thunder 2510 sensors crash
> 
> What I mean by crash is that sensors correctly displays values for a few times but then stops doing
> so.
> This is also mentioned in the FAQ
> 
> ############
> From the FAQ:
> ############
> 4.17C "...Also, MTP008 chips seem to randomly refuse to respond, for unknown reasons. You can see
> this as 'XX' entries in i2cdump..."
> 
> Is there anything that can be done?
> 
> Example output from proc:
> 
> [root@neptune mtp008-i2c-0-2c]# pwd
> /proc/sys/dev/sensors/mtp008-i2c-0-2c
> 
> [root@neptune mtp008-i2c-0-2c]# less temp1
> -1.0 -1.0 -1.0
> 
> [root@neptune mtp008-i2c-0-2c]# less fan1
> 0 0
> 
> I examined tickets for the Tyan 2510 but did not find any answers.  Please let me know if there is
> anything I can do to debug and ultimately fix this problem.
> 
> Thanks in advance
> 
> Paul Preston
> CyberSurfers Inc.
> 
> Following is debug information:
> 
> ##################
> OUTPUT FROM lsmod
> ##################
> 
> [root@neptune mtp008-i2c-0-2c]# lsmod
> Module                  Size  Used by    Not tainted
> i2c-dev                 3904   0  (autoclean)
> eeprom                  3616   0
> mtp008                  8064   1
> i2c-proc                6304   1  [eeprom mtp008]
> i2c-piix4               4068   0
> i2c-core               14088   0  [i2c-dev eeprom mtp008 i2c-proc i2c-piix4]
> eepro100               18128   2
> ext3                   65760   7
> jbd                    44580   7  [ext3]
> DAC960                 61696   8
> sd_mod                 11900   0  (unused)
> scsi_mod              101592   1  [sd_mod]
> 
> ##################
> OUTPUT FROM dmesg
> ##################
> 
> [root@neptune mtp008-i2c-0-2c]# less /var/log/dmesg
> Linux version 2.4.9-31smp (bhcompile@daffy.perf.redhat.com) (gcc version 2.96 20000731 (Red Hat
> Linux 7.1 2.96-98)) #1 SMP T
> ue Feb 26 06:55:00 EST 2002
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000080000000 (usable)
>  BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> Scanning bios EBDA for MXT signature
> 1152MB HIGHMEM available.
> found SMP MP-table at 000ff780
> hm, page 000ff000 reserved twice.
> hm, page 00100000 reserved twice.
> hm, page 000f0000 reserved twice.
> hm, page 000f1000 reserved twice.
> On node 0 totalpages: 524288
> zone(0): 4096 pages.
> zone(1): 225280 pages.
> zone(2): 294912 pages.
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> OEM ID: AMI      Product ID: CNB30LE      APIC at: 0xFEE00000
> Processor #0 Pentium(tm) Pro APIC version 17
> Processor #1 Pentium(tm) Pro APIC version 17
> I/O APIC #4 Version 17 at 0xFEC00000.
> I/O APIC #5 Version 17 at 0xFEC01000.
> Processors: 2
> Kernel command line: auto BOOT_IMAGE=linux ro root01d BOOT_FILE=/boot/vmlinuz-2.4.9-31smp
> Initializing CPU#0
> Detected 996.894 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 1985.74 BogoMIPS
> Memory: 2056368k/2097152k available (1889k kernel code, 38348k reserved, 103k data, 244k init,
> 1179648k highmem)
> Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
> Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
> Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
> Page-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 256K
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
> CPU serial number disabled.
> CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
> CPU:             Common caps: 0383fbff 00000000 00000000 00000000
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: Intel
> CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 256K
> Intel machine check reporting enabled on CPU#0.
> CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
> CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
> CPU:             Common caps: 0383fbff 00000000 00000000 00000000
> CPU0: Intel Pentium III (Coppermine) stepping 0a
> per-CPU timeslice cutoff: 731.68 usecs.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000004
> ESR value after enabling vector: 00000000
> Booting processor 1/1 eip 2000
> Initializing CPU#1
> masked ExtINT on CPU#1
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Calibrating delay loop... 1992.29 BogoMIPS
> CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 256K
> Intel machine check reporting enabled on CPU#1.
> CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
> CPU serial number disabled.
> CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
> CPU:             Common caps: 0383fbff 00000000 00000000 00000000
> CPU1: Intel Pentium III (Coppermine) stepping 0a
> Total of 2 processors activated (3978.03 BogoMIPS).
> ENABLING IO-APIC IRQs
> ...changing IO-APIC physical APIC ID to 4 ... ok.
> ...changing IO-APIC physical APIC ID to 5 ... ok.
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 4-0, 4-5, 4-9, 4-10, 5-0, 5-1, 5-2, 5-3, 5-6, 5-7, 5-8, 5-9, 5-10, 5-12, 5-13,
> 5-14, 5-15 not connecte
> d.
> ..TIMER: vector=0x31 pin1=2 pin2=0
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> ...trying to set up timer (IRQ0) through the 8259A ...
> ..... (found pin 0) ...works.
> number of MP IRQ sources: 16.
> number of IO-APIC #4 registers: 16.
> number of IO-APIC #5 registers: 16.
> testing the IO APIC.......................
> 
> IO APIC #4......
> .... register #00: 04000000
> .......    : physical APIC id: 04
> .... register #01: 000F0011
> .......     : max redirection entries: 000F
> .......     : IO APIC version: 0011
> .... register #02: 00000000
> .......     : arbitration: 00
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 003 03  0    0    0   0   0    1    1    31
>  01 003 03  0    0    0   0   0    1    1    39
>  02 000 00  1    0    0   0   0    0    0    00
>  03 003 03  0    0    0   0   0    1    1    41
>  04 003 03  0    0    0   0   0    1    1    49
>  05 000 00  1    0    0   0   0    0    0    00
>  06 003 03  0    0    0   0   0    1    1    51
>  07 003 03  0    0    0   0   0    1    1    59
>  08 003 03  0    0    0   0   0    1    1    61
>  09 000 00  1    0    0   0   0    0    0    00
>  0a 000 00  1    0    0   0   0    0    0    00
>  0b 003 03  0    0    0   0   0    1    1    69
>  0c 003 03  0    0    0   0   0    1    1    71
>  0d 003 03  0    0    0   0   0    1    1    79
>  0e 003 03  0    0    0   0   0    1    1    81
>  0f 003 03  0    0    0   0   0    1    1    89
> 
> IO APIC #5......
> .... register #00: 05000000
> .......    : physical APIC id: 05
> .... register #01: 000F0011
> .......     : max redirection entries: 000F
> .......     : IO APIC version: 0011
> .... register #02: 01000000
> .......     : arbitration: 01
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 000 00  1    0    0   0   0    0    0    00
>  01 000 00  1    0    0   0   0    0    0    00
>  02 000 00  1    0    0   0   0    0    0    00
>  03 000 00  1    0    0   0   0    0    0    00
>  04 003 03  1    1    0   1   0    1    1    91
>  05 003 03  1    1    0   1   0    1    1    99
>  06 000 00  1    0    0   0   0    0    0    00
>  07 000 00  1    0    0   0   0    0    0    00
>  08 000 00  1    0    0   0   0    0    0    00
>  09 000 00  1    0    0   0   0    0    0    00
>  0a 000 00  1    0    0   0   0    0    0    00
>  0b 003 03  1    1    0   1   0    1    1    A1
>  0c 000 00  1    0    0   0   0    0    0    00
>  0d 000 00  1    0    0   0   0    0    0    00
>  0e 000 00  1    0    0   0   0    0    0    00
>  0f 000 00  1    0    0   0   0    0    0    00
> IRQ to pin mappings:
> IRQ0 -> 0:2
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ6 -> 0:6
> IRQ7 -> 0:7
> IRQ8 -> 0:8
> IRQ11 -> 0:11
> IRQ12 -> 0:12
> IRQ13 -> 0:13
> IRQ14 -> 0:14
> IRQ15 -> 0:15
> IRQ20 -> 1:4
> IRQ21 -> 1:5
> IRQ27 -> 1:11
> .................................... done.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 996.7109 MHz.
> ..... host bus clock speed is 132.8945 MHz.
> cpu: 0, clocks: 1328945, slice: 442981
> CPU0<T0:1328944,T1:885952,D:11,S:442981,C:1328945>
> cpu: 1, clocks: 1328945, slice: 442981
> CPU1<T0:1328944,T1:442976,D:6,S:442981,C:1328945>
> checking TSC synchronization across CPUs: passed.
> PCI: PCI BIOS revision 2.10 entry at 0xfdbc1, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Discovered primary peer bus 01 [IRQ]
> PCI: Using IRQ router ServerWorks [1166/0200] at 00:0f.0
> PCI->APIC IRQ transform: (B0,I4,P0) -> 20
> PCI->APIC IRQ transform: (B0,I5,P0) -> 21
> PCI->APIC IRQ transform: (B1,I2,P0) -> 27
> PCI: Cannot allocate resource region 0 of device 00:0f.2
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> apm: BIOS not found.
> mxt_scan_bios: enter
> Starting kswapd v1.8
> allocated 64 pages and 64 bhs reserved for the highmem bounces
> VFS: Diskquotas version dquot_6.5.0 initialized
> Detected PS/2 Mouse Port.
> pty: 2048 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP
> enabled
> Real Time Clock Driver v1.10e
> block: queued sectors max/low 1365258kB/1234186kB, 4032 slots per queue
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
> ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
> ServerWorks OSB4: chipset revision 0
> ServerWorks OSB4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
> hda: SR242S, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> md: md driver 0.90.0 MAX_MD_DEVS%6, MD_SB_DISKS'
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> pci_hotplug: PCI Hot Plug PCI Core version: 0.3
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 16384 buckets, 128Kbytes
> TCP: Hash tables configured (established 524288 bind 65536)
> Linux IP multicast router 0.06 plus PIM-SM
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 429k freed
> VFS: Mounted root (ext2 filesystem).
> SCSI subsystem driver Revision: 1.00
> DAC960: ***** DAC960 RAID Driver Version 2.4.11 of 11 October 2001 *****
> DAC960: Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
> DAC960#0: Configuring Mylex AcceleRAID 160 PCI RAID Controller
> DAC960#0:   Firmware Version: 7.00-03, Channels: 1, Memory Size: 16MB
> DAC960#0:   PCI Bus: 1, Device: 2, Function: 0, I/O Address: Unassigned
> DAC960#0:   PCI Address: 0xFB000000 mapped at 0xF882F000, IRQ Channel: 27
> DAC960#0:   Controller Queue Depth: 512, Maximum Blocks per Command: 2048
> DAC960#0:   Driver Queue Depth: 511, Scatter/Gather Limit: 128 of 257 Segments
> DAC960#0:   Physical Devices:
> DAC960#0:     0:1  Vendor: IBM       Model: DDYS-T36950M      Revision: S96H
> DAC960#0:          Wide Synchronous at 160 MB/sec
> DAC960#0:          Serial Number:         4FFPB009
> DAC960#0:          Disk Status: Online, 71651328 blocks
> DAC960#0:     0:2  Vendor: IBM       Model: DDYS-T36950M      Revision: S96H
> DAC960#0:          Wide Synchronous at 160 MB/sec
> DAC960#0:          Serial Number:         5FFP7060
> DAC960#0:          Disk Status: Online, 71651328 blocks
> DAC960#0:     0:3  Vendor: IBM       Model: DDYS-T36950M      Revision: S96H
> DAC960#0:          Wide Synchronous at 160 MB/sec
> DAC960#0:          Serial Number:         4FFP0963
> DAC960#0:          Disk Status: Online, 71651328 blocks
> DAC960#0:     0:7  Vendor: MYLEX     Model: AcceleRAID 160    Revision: 0700
> DAC960#0:          Wide Synchronous at 160 MB/sec
> DAC960#0:          Serial Number:
> DAC960#0:   Logical Drives:
> DAC960#0:     /dev/rd/c0d0: RAID-5, Online, 98304 blocks
> DAC960#0:                   Logical Device Initialized, BIOS Geometry: 255/63
> DAC960#0:                   Stripe Size: 64KB, Segment Size: 8KB
> DAC960#0:                   Read Cache Disabled, Write Cache Disabled
> DAC960#0:     /dev/rd/c0d1: RAID-5, Online, 62914560 blocks
> DAC960#0:                   Logical Device Initialized, BIOS Geometry: 255/63
> DAC960#0:                   Stripe Size: 64KB, Segment Size: 8KB
> DAC960#0:                   Read Cache Disabled, Write Cache Disabled
> DAC960#0:     /dev/rd/c0d2: RAID-5, Online, 50331648 blocks
> DAC960#0:                   Logical Device Initialized, BIOS Geometry: 255/63
> DAC960#0:                   Stripe Size: 64KB, Segment Size: 8KB
> DAC960#0:                   Read Cache Disabled, Write Cache Disabled
> DAC960#0:     /dev/rd/c0d3: RAID-5, Online, 29958144 blocks
> DAC960#0:                   Logical Device Initialized, BIOS Geometry: 255/63
> DAC960#0:                   Stripe Size: 64KB, Segment Size: 8KB
> DAC960#0:                   Read Cache Disabled, Write Cache Disabled
> Partition check:
>  rd/c0d0: rd/c0d0p1
>  rd/c0d1: rd/c0d1p1
>  rd/c0d2: rd/c0d2p1
>  rd/c0d3: rd/c0d3p1 rd/c0d3p2 rd/c0d3p3 rd/c0d3p4 < rd/c0d3p5 rd/c0d3p6 >
> Journalled Block Device driver loaded
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> Freeing unused kernel memory: 244k freed
> Adding Swap: 514040k swap-space (priority -1)
> EXT3 FS 2.4-0.9.11, 3 Oct 2001 on dac960(48,29), internal journal
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.11, 3 Oct 2001 on dac960(48,1), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.11, 3 Oct 2001 on dac960(48,9), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.11, 3 Oct 2001 on dac960(48,27), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.11, 3 Oct 2001 on dac960(48,26), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.11, 3 Oct 2001 on dac960(48,25), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.11, 3 Oct 2001 on dac960(48,17), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> 
> #########################
> Step 1. Identify the I2C Busses
> #########################
> 
> [root@neptune mtp008-i2c-0-2c]# /opt/lm_sensors/lm_sensors-2.6.3/prog/detect/i2cdetect
> Error: No i2c-bus specified!
> Syntax: i2cdetect I2CBUS
>   I2CBUS is an integer
>   Installed I2C busses:
>     i2c-0       smbus           SMBus PIIX4 adapter at 0580             Non-I2C SMBus adapter
> 
> #####################
> Step 2. Query the I2C Bus
> #####################
> 
> [root@neptune mtp008-i2c-0-2c]# /opt/lm_sensors/lm_sensors-2.6.3/prog/detect/i2cdetect 0
>   WARNING! This program can confuse your I2C bus, cause data loss and worse!
>   I will probe file /dev/i2c-0
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX UU XX UU XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 50: UU UU UU UU XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 
> [root@neptune mtp008-i2c-0-2c]# /opt/lm_sensors/lm_sensors-2.6.3/prog/dump/i2cdump 0 0x2c
> Warning: no size specified (using byte-data access)
>   WARNING! This program can confuse your I2C bus, cause data loss and worse!
>   I will probe file /dev/i2c-0, address 0x2c, mode byte
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 
> [root@neptune mtp008-i2c-0-2c]# /opt/lm_sensors/lm_sensors-2.6.3/prog/dump/i2cdump 0 0x2e
> Warning: no size specified (using byte-data access)
>   WARNING! This program can confuse your I2C bus, cause data loss and worse!
>   I will probe file /dev/i2c-0, address 0x2e, mode byte
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> [root@neptune mtp008-i2c-0-2c]#
> 
> [root@neptune mtp008-i2c-0-2c]# /opt/lm_sensors/lm_sensors-2.6.3/prog/dump/i2cdump 0 0x2d
> Warning: no size specified (using byte-data access)
>   WARNING! This program can confuse your I2C bus, cause data loss and worse!
>   I will probe file /dev/i2c-0, address 0x2d, mode byte
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 
> [root@neptune mtp008-i2c-0-2c]# /opt/lm_sensors/lm_sensors-2.6.3/prog/dump/i2cdump 0 0x2f
> Warning: no size specified (using byte-data access)
>   WARNING! This program can confuse your I2C bus, cause data loss and worse!
>   I will probe file /dev/i2c-0, address 0x2f, mode byte
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
