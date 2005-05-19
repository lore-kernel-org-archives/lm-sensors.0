From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: sensors shows 0 values - More info
Message-Id: <3CDD3453.A4FD405C@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CDC83D9.9080306@persistcorp.com>
In-Reply-To: <3CDC83D9.9080306@persistcorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

doubt you have a velleman board - you would know if you did -
it is reporting a chip at all 128 locations.
don't insmod i2c-velleman.
Better yet rerun sensors-detect but don't say yes to undetectable
adapters.
Your motherboard i2c bus is probably on the 801.
But you don't have a 2413 device in lspci so you
will have to figure out how to turn that on. Look in the BIOS
for some way to enable it.

Gagan Bhatia wrote:
> 
> ==============================
> Hi ,
>  Please help newbie. I have read your FAQ but couldnt find the solution
> of this problem.
> 
> I have installed lm_sensors and i2c package. kernel version- 2.4.9
> I run sensors -s and sensors and get ) values for all the variables.
> 
> Please tell me what am I doing wrong ???
> 
> Thanks
> Gagan
> ==============================> More info:
> 
> LSMOD ::>>
> [root@zisu-1-7 lm_sensors-2.6.3]# lsmod
> Module                  Size  Used by
> lm75                    3248   0  (unused)
> i2c-velleman            1632   0
> i2c-dev                 4256   0
> i2c-i810                2512   0  (unused)
> i2c-algo-bit            7520   3  [i2c-velleman i2c-i810]
> ltc1710                 2688   0  (unused)
> eeprom                  3584   0  (unused)
> lm80                    5456   0  (unused)
> adm1021                 5488   0  (unused)
> lm78                    6992   0  (unused)
> i2c-proc                6576   0  [lm75 ltc1710 eeprom lm80 adm1021 lm78]
> i2c-core               13872   0  [lm75 i2c-dev i2c-algo-bit ltc1710
> eeprom lm80 adm1021 lm78 i2c-proc]
> 
> LSPCI >>
> [root@zisu-1-7 lm_sensors-2.6.3]# lspci -n
> 00:00.0 Class 0600: 8086:7124 (rev 03)
> 00:01.0 Class 0300: 8086:7125 (rev 03)
> 00:1e.0 Class 0604: 8086:2418 (rev 02)
> 00:1f.0 Class 0601: 8086:2410 (rev 02)
> 00:1f.1 Class 0101: 8086:2411 (rev 02)
> 00:1f.2 Class 0c03: 8086:2412 (rev 02)
> 00:1f.5 Class 0401: 8086:2415 (rev 02)
> 01:04.0 Class 0200: 8086:1229 (rev 08)
> 
> I2cDETECT>>
> 
> [root@zisu-1-7 lm_sensors-2.6.3]# prog/detect/i2cdetect
> Error: No i2c-bus specified!
> Syntax: i2cdetect I2CBUS
>   I2CBUS is an integer
>   Installed I2C busses:
>     i2c-0    i2c           I810/I815 I2C Adapter               Bit-shift
> algorithm
>     i2c-1    i2c           I810/I815 DDC Adapter               Bit-shift
> algorithm
>     i2c-2    i2c           Velleman K8000                      Bit-shift
> algorithm
> [root@zisu-1-7 lm_sensors-2.6.3]# prog/detect/i2cdetect i2c-2
> Error: First argument not a number!
> Syntax: i2cdetect I2CBUS
>   I2CBUS is an integer
>   Installed I2C busses:
>     i2c-0    i2c           I810/I815 I2C Adapter               Bit-shift
> algorithm
>     i2c-1    i2c           I810/I815 DDC Adapter               Bit-shift
> algorithm
>     i2c-2    i2c           Velleman K8000                      Bit-shift
> algorithm
> [root@zisu-1-7 lm_sensors-2.6.3]# prog/detect/i2cdetect 2
>   WARNING! This program can confuse your I2C bus, cause data loss and worse!
>   I will probe file /dev/i2c-2
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
> 10: 10 11 12 13 14 15 16 17 UU UU UU 1b 1c 1d 1e 1f
> 20: UU UU UU UU UU UU UU UU UU UU UU UU UU UU 2e 2f
> 30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
> 40: 40 41 42 43 44 45 46 47 48 49 4a 4b UU UU UU 4f
> 50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f
> 60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
> 70: 70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f
> 
> DMESG>>
> 
> Linux version 2.4.9 (root@dhcp-2-14) (gcc version 2.96 20000731 (Red Hat
> Linux 7.1 2.96-98)) #2 Fri May 10 10:47:20 PDT 2002
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
>  BIOS-e820: 000000000fef0000 - 000000000fef3000 (ACPI NVS)
>  BIOS-e820: 000000000fef3000 - 000000000ff00000 (ACPI data)
>  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
> On node 0 totalpages: 65264
> zone(0): 4096 pages.
> zone(1): 61168 pages.
> zone(2): 0 pages.
> Kernel command line: auto BOOT_IMAGE=gagan ro root05
> BOOT_FILE=/boot/bzImage.gagan.May10
> Initializing CPU#0
> Detected 564.764 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 1127.21 BogoMIPS
> Memory: 254088k/261056k available (1409k kernel code, 6584k reserved,
> 393k data, 196k init, 0k highmem)
> Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
> Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
> Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
> CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 128K
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
> CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
> CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
> CPU: Intel Celeron (Coppermine) stepping 06
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> Checking for popad bug... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: Intel
> PCI: PCI BIOS revision 2.10 entry at 0xfb0d0, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> Unknown bridge resource 2: assuming transparent
> PCI: Using IRQ router PIIX [8086/2410] at 00:1f.0
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v1.8
> Detected PS/2 Mouse Port.
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI ISAPNP enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> block: 128 slots per queue, batch
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev f9
> 
> PIIX4: chipset revision 2
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
> keyboard: Timeout - AT keyboard not present?
> keyboard: Timeout - AT keyboard not present?
> hda: Maxtor 96147H8, ATA DISK drive
> hdb: Maxtor 96147H8, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: 120060864 sectors (61471 MB) w/2048KiB Cache, CHSt73/255/63, UDMA(66)
> hdb: 120060864 sectors (61471 MB) w/2048KiB Cache, CHSt73/255/63, UDMA(66)
> Partition check:
>  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
>  hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 hdb11 >
> floppy0: no floppy controllers found
> task queue still active
> loop: loaded (max 8 devices)
> eepro100.c:v1.09j-t 9/29/99 Donald Becker
> http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
> eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
> <saw@saw.sw.com.sg> and others
> PCI: Found IRQ 15 for device 01:04.0
> PCI: Sharing IRQ 15 with 00:01.0
> eth0: OEM i82557/i82558 10/100 Ethernet, 00:03:B5:00:01:F2, IRQ 15.
>   Board assembly 558200-009, Physical connectors present: RJ45
>   Primary interface chip i82555 PHY #1.
>   General self-test: passed.
>   Serial sub-system self-test: passed.
>   Internal registers self-test: passed.
>   ROM checksum self-test: passed (0x04f4518b).
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 202M
> agpgart: Detected an Intel i810 E Chipset.
> agpgart: detected 4MB dedicated video ram.
> agpgart: AGP aperture is 64M @ 0xd0000000
> SCSI subsystem driver Revision: 1.00
> request_module[scsi_hostadapter]: Root fs not mounted
> md: linear personality registered
> md: raid0 personality registered
> md: raid1 personality registered
> md: raid5 personality registered
> raid5: measuring checksumming speed
>    8regs     :   936.000 MB/sec
>    32regs    :   500.000 MB/sec
>    pIII_sse  :  1160.000 MB/sec
>    pII_mmx   :  1268.400 MB/sec
>    p5_mmx    :  1322.800 MB/sec
> raid5: using function: pIII_sse (1160.000 MB/sec)
> md: md driver 0.90.0 MAX_MD_DEVS%6, MD_SB_DISKS'
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP: Hash tables configured (established 16384 bind 16384)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 196k freed
> Adding Swap: 265032k swap-space (priority -1)
> Adding Swap: 265032k swap-space (priority -2)
> (read) hda10's sb offset: 52452096 [events: 00000018]
> (read) hdb10's sb offset: 52452096 [events: 00000018]
> md: autorun ...
> md: considering hdb10 ...
> md:  adding hdb10 ...
> md:  adding hda10 ...
> md: created md0
> md: bind<hda10,1>
> md: bind<hdb10,2>
> md: running: <hdb10><hda10>
> md: now!
> md: hdb10's event counter: 00000018
> md: hda10's event counter: 00000018
> md0: max total readahead window set to 496k
> md0: 2 data-disks, max readahead per data-disk: 248k
> raid0: looking at hda10
> raid0:   comparing hda10(52452096) with hda10(52452096)
> raid0:   END
> raid0:   => UNIQUE
> raid0: 1 zones
> raid0: looking at hdb10
> raid0:   comparing hdb10(52452096) with hda10(52452096)
> raid0:   EQUAL
> raid0: FINAL 1 zones
> raid0: zone 0
> raid0: checking hda10 ... contained as device 0
>   (52452096) is smallest!.
> raid0: checking hdb10 ... contained as device 1
> raid0: zone->nb_dev: 2, size: 104904192
> raid0: current zone offset: 52452096
> raid0: done.
> raid0 : md_size is 104904192 blocks.
> raid0 : conf->smallest->size is 104904192 blocks.
> raid0 : nb_zone is 1.
> raid0 : Allocating 8 bytes for hash.
> md: updating md0 RAID superblock on device
> md: hdb10 [events: 00000019](write) hdb10's sb offset: 52452096
> md: hda10 [events: 00000019](write) hda10's sb offset: 52452096
> md: ... autorun DONE.
> reiserfs: checking transaction log (device 03:08) ...
> Using r5 hash to sort names
> ReiserFS version 3.6.25
> reiserfs: checking transaction log (device 03:06) ...
> Using r5 hash to sort names
> ReiserFS version 3.6.25
> reiserfs: checking transaction log (device 03:07) ...
> Using r5 hash to sort names
> ReiserFS version 3.6.25
> reiserfs: checking transaction log (device 03:0b) ...
> Using r5 hash to sort names
> ReiserFS version 3.6.25
> reiserfs: checking transaction log (device 09:00) ...
> Using r5 hash to sort names
> ReiserFS version 3.6.25
> eth0: 0 multicast blocks dropped.i2c-proc.o version 2.6.3 (20020322)
> lm78.o version 2.6.3 (20020322)
> adm1021.o version 2.6.3 (20020322)
> lm80.o version 2.6.3 (20020322)
> eeprom.o version 2.6.3 (20020322)
> ltc1710.o version 2.6.3 (20020322)
> i2c-algo-bit.o: i2c bit algorithm module version 2.6.3 (20020322)
> i2c-i810.o version 2.6.3 (20020322)
> i2c-i810.o: i810/i815 found.
> i2c-i810.o: I810/I815 I2C bus initialized
> i2c-i810.o: I810/I815 DDC bus initialized
> i2c-dev.o: i2c /dev entries driver module version 2.6.3 (20020322)
> i2c-dev.o: Registered 'I810/I815 I2C Adapter' as minor 0
> i2c-dev.o: Registered 'I810/I815 DDC Adapter' as minor 1
> i2c-algo-pcf.o: i2c pcf8584 algorithm module version 2.6.3 (20020322)
> i2c-elektor.o: i2c pcf8584-isa adapter module version 2.6.3 (20020322)
> i2c-algo-pcf.o: i2c pcf8584 algorithm module version 2.6.3 (20020322)
> i2c-elektor.o: i2c pcf8584-isa adapter module
> i2c-elv.o: i2c ELV parallel port adapter module version 2.6.3 (20020322)
> i2c-elv.o: Busy was low.
> i2c-elv.o: i2c ELV parallel port adapter module
> i2c-elv.o: Busy was low.
> i2c-velleman.o: i2c Velleman K8000 adapter module version 2.6.3 (20020322)
> i2c-dev.o: Registered 'Velleman K8000' as minor 2
> i2c-velleman.o: found device at 0x378.
> lm75.o version 2.6.3 (20020322)
> i2c-core.o: i2c core module version 2.6.3 (20020322)
> 
> Below is the result from sensor command:
> lm84-i2c-2-18
> Adapter: Velleman K8000
> Algorithm: Bit-shift algorithm
> Board:        +0?C  (min =   +0?C, max =   +0?C)
> CPU:          +0?C  (min =   +0?C, max =   +0?C)
> 
> lm84-i2c-2-19
> Adapter: Velleman K8000
> Algorithm: Bit-shift algorithm
> Board:        +0?C  (min =   +0?C, max =   +0?C)
> CPU:          +0?C  (min =   +0?C, max =   +0?C)
> 
> lm84-i2c-2-1a
> Adapter: Velleman K8000
> Algorithm: Bit-shift algorithm
> Board:        +0?C  (min =   +0?C, max =   +0?C)
> CPU:          +0?C  (min =   +0?C, max =   +0?C)
> 
> lm84-i2c-2-29
> Adapter: Velleman K8000
> Algorithm: Bit-shift algorithm
> Board:        +0?C  (min =   +0?C, max =   +0?C)
> CPU:          +0?C  (min =   +0?C, max =   +0?C)
> 
> lm84-i2c-2-2a
> Adapter: Velleman K8000
> Algorithm: Bit-shift algorithm
> Board:        +0?C  (min =   +0?C, max =   +0?C)
> CPU:          +0?C  (min =   +0?C, max =   +0?C)
> 
> lm84-i2c-2-2b
> Adapter: Velleman K8000
> Algorithm: Bit-shift algorithm
> Board:        +0?C  (min =   +0?C, max =   +0?C)
> CPU:          +0?C  (min =   +0?C, max =   +0?C)
> 
> lm84-i2c-2-4c
> Adapter: Velleman K8000
> Algorithm: Bit-shift algorithm
> Board:        +0?C  (min =   +0?C, max =   +0?C)
> CPU:          +0?C  (min =   +0?C, max =   +0?C)
> 
> lm84-i2c-2-4d
> Adapter: Velleman K8000
> Algorithm: Bit-shift algorithm
> Board:        +0?C  (min =   +0?C, max =   +0?C)
> CPU:          +0?C  (min =   +0?C, max =   +0?C)
> 
> lm84-i2c-2-4e
> Adapter: Velleman K8000
> Algorithm: Bit-shift algorithm
> Board:        +0?C  (min =   +0?C, max =   +0?C)
> CPU:          +0?C  (min =   +0?C, max =   +0?C)
> 
> lm80-i2c-2-20
> Adapter: Velleman K8000
> Algorithm: Bit-shift algorithmVTT:       +0.00 V  (min =  +0.00 V, max
> =  +0.00 V)
> +3.3V:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> +Vcore:    +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> +12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> -12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> -5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> fan1:       -1 RPM  (min =   -1 RPM, div = 1)
> fan2:       -1 RPM  (min =   -1 RPM, div = 1)
> temp:     +0.00 ?C (hot:limit =  +0?C,  hysteresis =  +0?C)
>         (os: limit =  +0?C,  hysteresis =  +0?C)
> 
> lm80-i2c-2-21
> Adapter: Velleman K8000
> Algorithm: Bit-shift algorithm
> +5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> VTT:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> +3.3V:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> +Vcore:    +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> +12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> -12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> -5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> fan1:       -1 RPM  (min =   -1 RPM, div = 1)
> fan2:       -1 RPM  (min =   -1 RPM, div = 1)
> temp:     +0.00 ?C (hot:limit =  +0?C,  hysteresis =  +0?C)
>         (os: limit =  +0?C,  hysteresis =  +0?C)
> 
> lm80-i2c-2-22
> Adapter: Velleman K8000
> Algorithm: Bit-shift algorithm
> +5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> VTT:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> +3.3V:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> +Vcore:    +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> +12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> -12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> -5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> fan1:       -1 RPM  (min =   -1 RPM, div = 1)
> fan2:       -1 RPM  (min =   -1 RPM, div = 1)
> temp:     +0.00 ?C (hot:limit =  +0?C,  hysteresis =  +0?C)
>         (os: limit =  +0?C,  hysteresis =  +0?C)
> 
> lm80-i2c-2-23
> Adapter: Velleman K8000
> Algorithm: Bit-shift algorithm
> +5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> VTT:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> +3.3V:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> +Vcore:    +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> +12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> -12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> -5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> fan1:       -1 RPM  (min =   -1 RPM, div = 1)
> fan2:       -1 RPM  (min =   -1 RPM, div = 1)
> temp:     +0.00 ?C (hot:limit =  +0?C,  hysteresis =  +0?C)
>         (os: limit =  +0?C,  hysteresis =  +0?C)
> 
> lm80-i2c-2-24
> Adapter: Velleman K8000
> 
> +5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> 
> ............
