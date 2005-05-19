From: Claus.Rosenberger@rocnet.de (Claus Rosenberger)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: sensors with K7S5A
Message-Id: <4759.10.20.10.15.1045744469.squirrel@deathstar.of.rocnet.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <34986.10.20.2.100.1045593851.squirrel@deathstar.of.rocnet.de>
In-Reply-To: <34986.10.20.2.100.1045593851.squirrel@deathstar.of.rocnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

some additional infos :

**** isadump 0x295 0x296
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 06 64 00 00 00 00 00 00 00 00 09 00 cf ff ff
10: e1 e1 e1 70 00 00 00 00 00 00 00 00 00 00 00 00
20: 6e 9c cc bc c1 ce 45 b6 ce 10 23 2d 00 00 00 00
30: 75 60 ac 8d 71 5d cc a8 d8 b2 72 5e 3d 33 cc a8
40: 3c 14 3c 14 3c 14 00 00 2d 00 00 00 00 00 00 00
50: ff 38 7f 7f 7f 00 00 00 90 56 00 00 00 00 00 00
60: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
70: 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00 00
80: 11 00 00 00 00 00 00 00 00 00 00 09 00 cf ff ff
90: e1 e1 e1 70 00 00 00 00 00 00 00 00 00 00 00 00
a0: 6e 9c cc bc c1 ce 45 b6 ce 10 23 2d 00 00 00 00
b0: 75 60 ac 8d 71 5d cc a8 d8 b2 72 5e 3d 33 cc a8
c0: 3c 14 3c 14 3c 14 00 00 2d 00 00 00 00 00 00 00
d0: ff 38 7f 7f 7f 00 00 00 90 56 00 00 00 00 00 00
e0: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
f0: 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00 00


**** installation procedure
- downloading kernel 2.4.20
- patching kernel with
http://home.attbi.com/~ac9410/albert/patches/2.4.20-i2c_sensors.tar.gz
first i2c patches then sensors patches
- compiling kernel (configuration appended later)
- installing kernel and modules, rebooting
- changing Makefile in lm_sensors_package
  COMPILE_KERNEL := 0
- make lm_sensors without errors
- make install lm_sensors without errors
- loading modules without errors
  i2c-proc, i2c-isa, it87
- running sensors


**** Kernel config
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS@
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE%3
CONFIG_AIC7XXX_RESET_DELAY_MS000
CONFIG_SCSI_NCR53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS2
CONFIG_SCSI_NCR53C8XX_SYNC 
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m
CONFIG_I2C_MAINBOARD=y
CONFIG_I2C_ISA=m
CONFIG_SENSORS=y
CONFIG_SENSORS_IT87=m
CONFIG_RTC=y
CONFIG_QUOTA=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_15=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y




hope you can help me with this problem

thanks

claus



ok. i changed something but without result. here are some infos :


**** lsmod
Module                  Size  Used by    Not tainted
i2c-isa                 1252   0  (unused)
it87                    6848   0  (unused)
i2c-dev                 4064   0  (unused)
loop                    8656   0  (autoclean)
i2c-proc                6624   0  [it87]
i2c-core               14944   0  [i2c-isa it87 i2c-dev i2c-proc]
nfsd                   68416   8  (autoclean)
lockd                  48832   1  (autoclean) [nfsd]
sunrpc                 60724   1  (autoclean) [nfsd lockd]

**** /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0290-0297 : it87
03c0-03df : vga+
0cf8-0cff : PCI conf1
d400-d47f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  d400-d47f : 00:11.0
d800-d80f : 3ware Inc 3ware 7000-series ATA-RAID
  d800-d80f : 3ware Storage Controller
dc00-dcff : Adaptec AHA-2940U/UW/D / AIC-7881U
ff00-ff0f : Silicon Integrated Systems [SiS] 5513 [IDE]


**** isadump 0x290 0x291
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
10: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
20: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
30: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
40: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
50: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
60: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
70: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
80: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
90: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
a0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
b0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
c0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
d0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
e0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
f0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11


**** dmesg
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
it87.o version 2.7.0 (20021208)
i2c-isa.o version 2.7.0 (20021208)
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)



**** sensors -v
sensors version 2.7.0


**** result of sensors
No sensors found!


Any ideas ?


> try loading i2c-isa.
> Don't load i2c-sis5595.
>
> Claus Rosenberger wrote:
>> Hi,
>>
>> i try to use lm_sensors with my K7S5A Mainboard.
>>
>> sensors-detect reports following result :
>>
>> Use driver `i2c-sis645' for device 00:00.0: Silicon Integrated
>> Systems SIS735 Use driver `i2c-sis5595' for device 00:02.0: Silicon
>> Integrated Systems SIS5595
>> Use driver `i2c-matroxfb' for device 01:00.0: MGA G200 AGP
>>
>> While loading this drivers i get failures because no devices deteced.
>>
>> In the mainboard list you linked too my mainbard has the SIS950
>> chipset which is in driver it87 included.
>>
>> Loading this drivers is ok but sensors reports "No sensors found!"
>>
>> What to do now ??
>>
>> Thanks,
>>    Claus


