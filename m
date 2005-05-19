From: haimat@lame.at (Matthias F. Brandstetter)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: lm_sensors: output for all sensors?
Message-Id: <200406161648.26117.haimat@lame.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406161539.50952.haimat@lame.at>
In-Reply-To: <200406161539.50952.haimat@lame.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

---------- quoting Rudolf Marek ----------
> Please can you take a look to dmesg or syslog if there is something
> interresting ? (copy here)

attached.

> Also what does the output of sensors-detect just before it terminates
> says? There should be "recommneded modules".

This is the output, I added it to rc scripts:

## I2C adapter drivers
#modprobe i2c-viapro
## I2C chip drivers
#modprobe eeprom
#sleep 2
#/usr/local/bin/sensors -s

And this is output from lspci:
root@debian:~# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev=20
05)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]=20
(rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus=20
Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev=20
40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97=20
Audio Controller (rev 50)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd.=20
RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 (rev =

6a)

Does this help?
Greetings, Matthias

--=20
I know you're mad at me right now, and I'm kinda mad too ... I mean, we
could sit here and try to figure out who forgot to pick up who till the
cows come home.  But let's just say we're both wrong and that'll be that.

		-- Homer Simpson
		   Brother from the Same Planet
-------------- next part --------------
Linux version 2.4.22 (root@debian) (gcc version 3.2.2) #1 Tue Oct 14 11:59:=
15 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000b7f0000 (usable)
 BIOS-e820: 000000000b7f0000 - 000000000b7f3000 (ACPI NVS)
 BIOS-e820: 000000000b7f3000 - 000000000b800000 (ACPI data)
 BIOS-e820: 000000000b800000 - 000000000c000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
183MB LOWMEM available.
On node 0 totalpages: 47088
zone(0): 4096 pages.
zone(1): 42992 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=3DLinux ro root=900
Initializing CPU#0
Detected 1130.483 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2254.43 BogoMIPS
Memory: 183564k/188352k available (1498k kernel code, 4404k reserved, 530k =
data, 96k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III CPU             1133MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI ISAPNP enabled
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST380011A, ATA DISK drive
blk: queue c033ba80, I/O limit 4095Mb (mask 0xffffffff)
hdc: QSI CD-ROM SCR-242, ATAPI CD/DVD-ROM drive
hdd: ST380011A, ATA DISK drive
blk: queue c033c010, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area =3D> 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(10=
0)
hdd: attached ide-disk driver.
hdd: host protected area =3D> 1
hdd: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(10=
0)
hdc: attached ide-cdrom driver.
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2
 hdd: hdd1 hdd2
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2084.000 MB/sec
   32regs    :  1052.800 MB/sec
   pIII_sse  :  2668.800 MB/sec
   pII_mmx   :  2517.200 MB/sec
   p5_mmx    :  2667.200 MB/sec
raid5: using function: pIII_sse (2668.800 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS%6, MD_SB_DISKS'
md: Autodetecting RAID arrays.
 [events: 00000064]
 [events: 00000064]
md: autorun ...
md: considering hdd1 ...
md:  adding hdd1 ...
md:  adding hda1 ...
md: created md0
md: bind<hda1,1>
md: bind<hdd1,2>
md: running: <hdd1><hda1>
md: hdd1's event counter: 00000064
md: hda1's event counter: 00000064
md: md0: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdd1 operational as mirror 0
raid1: device hda1 operational as mirror 1
raid1: raid set md0 not clean; reconstructing mirrors
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: hdd1 [events: 00000065]<6>(write) hdd1's sb offset: 77915136
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000 KB/s=
ec) for reconstruction.
md: using 124k window, over a total of 77915136 blocks.
md: hda1 [events: 00000065]<6>(write) hda1's sb offset: 77915136
md: ... autorun DONE.
LVM version 1.0.5+(22/07/2002)
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 96k freed
Adding Swap: 232932k swap-space (priority -1)
Adding Swap: 232932k swap-space (priority -2)
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,0), internal journal
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 11 for device 00:0d.0
eth0: RealTek RTL8139 Fast Ethernet at 0xe800, 00:20:ed:35:49:14, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability =
45e1.
md: md0: sync done.
i2c-core.o: i2c core module version 2.8.7 (20040611)
i2c-proc.o version 2.8.7 (20040611)
i2c-viapro.o version 2.8.7 (20040611)
i2c-dev.o: i2c /dev entries driver module version 2.8.7 (20040611)
i2c-dev.o: Registered 'SMBus Via Pro adapter at 5000' as minor 0
eeprom.o version 2.8.7 (20040611)
via686a.o version 2.8.7 (20040611)
