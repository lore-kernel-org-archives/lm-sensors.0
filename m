From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: sensors with K7S5A
Message-Id: <3E6A6D18.1090105@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <34986.10.20.2.100.1045593851.squirrel@deathstar.of.rocnet.de>
In-Reply-To: <34986.10.20.2.100.1045593851.squirrel@deathstar.of.rocnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

that looks like an it87 to me. Don't know why things aren't working.
try 'modprobe it87 force_it87=9191,0x290' and let me know how it works.

Claus Rosenberger wrote:
> some additional infos :
>=20
> **** isadump 0x295 0x296
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 11 06 64 00 00 00 00 00 00 00 00 09 00 cf ff ff
> 10: e1 e1 e1 70 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 6e 9c cc bc c1 ce 45 b6 ce 10 23 2d 00 00 00 00
> 30: 75 60 ac 8d 71 5d cc a8 d8 b2 72 5e 3d 33 cc a8
> 40: 3c 14 3c 14 3c 14 00 00 2d 00 00 00 00 00 00 00
> 50: ff 38 7f 7f 7f 00 00 00 90 56 00 00 00 00 00 00
> 60: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
> 70: 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 11 00 00 00 00 00 00 00 00 00 00 09 00 cf ff ff
> 90: e1 e1 e1 70 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 6e 9c cc bc c1 ce 45 b6 ce 10 23 2d 00 00 00 00
> b0: 75 60 ac 8d 71 5d cc a8 d8 b2 72 5e 3d 33 cc a8
> c0: 3c 14 3c 14 3c 14 00 00 2d 00 00 00 00 00 00 00
> d0: ff 38 7f 7f 7f 00 00 00 90 56 00 00 00 00 00 00
> e0: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
> f0: 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00 00
>=20
>=20
> **** installation procedure
> - downloading kernel 2.4.20
> - patching kernel with
> http://home.attbi.com/~ac9410/albert/patches/2.4.20-i2c_sensors.tar.gz
> first i2c patches then sensors patches
> - compiling kernel (configuration appended later)
> - installing kernel and modules, rebooting
> - changing Makefile in lm_sensors_package
>   COMPILE_KERNEL :=3D 0
> - make lm_sensors without errors
> - make install lm_sensors without errors
> - loading modules without errors
>   i2c-proc, i2c-isa, it87
> - running sensors
>=20
>=20
> **** Kernel config
> CONFIG_X86=3Dy
> CONFIG_UID16=3Dy
> CONFIG_EXPERIMENTAL=3Dy
> CONFIG_MODULES=3Dy
> CONFIG_MODVERSIONS=3Dy
> CONFIG_KMOD=3Dy
> CONFIG_MK7=3Dy
> CONFIG_X86_WP_WORKS_OK=3Dy
> CONFIG_X86_INVLPG=3Dy
> CONFIG_X86_CMPXCHG=3Dy
> CONFIG_X86_XADD=3Dy
> CONFIG_X86_BSWAP=3Dy
> CONFIG_X86_POPAD_OK=3Dy
> CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> CONFIG_X86_L1_CACHE_SHIFT=3D6
> CONFIG_X86_HAS_TSC=3Dy
> CONFIG_X86_GOOD_APIC=3Dy
> CONFIG_X86_USE_3DNOW=3Dy
> CONFIG_X86_PGE=3Dy
> CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
> CONFIG_X86_F00F_WORKS_OK=3Dy
> CONFIG_X86_MCE=3Dy
> CONFIG_NOHIGHMEM=3Dy
> CONFIG_MTRR=3Dy
> CONFIG_X86_TSC=3Dy
> CONFIG_NET=3Dy
> CONFIG_PCI=3Dy
> CONFIG_PCI_GOANY=3Dy
> CONFIG_PCI_BIOS=3Dy
> CONFIG_PCI_DIRECT=3Dy
> CONFIG_ISA=3Dy
> CONFIG_PCI_NAMES=3Dy
> CONFIG_HOTPLUG=3Dy
> CONFIG_SYSVIPC=3Dy
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_SYSCTL=3Dy
> CONFIG_KCORE_ELF=3Dy
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_PNP=3Dy
> CONFIG_ISAPNP=3Dy
> CONFIG_BLK_DEV_FD=3Dm
> CONFIG_BLK_DEV_LOOP=3Dm
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_MMAP=3Dy
> CONFIG_FILTER=3Dy
> CONFIG_UNIX=3Dy
> CONFIG_INET=3Dy
> CONFIG_SCSI=3Dy
> CONFIG_BLK_DEV_SD=3Dy
> CONFIG_SD_EXTRA_DEVS@
> CONFIG_CHR_DEV_ST=3Dy
> CONFIG_BLK_DEV_SR=3Dy
> CONFIG_BLK_DEV_SR_VENDOR=3Dy
> CONFIG_SR_EXTRA_DEVS=3D2
> CONFIG_CHR_DEV_SG=3Dy
> CONFIG_SCSI_DEBUG_QUEUES=3Dy
> CONFIG_SCSI_MULTI_LUN=3Dy
> CONFIG_SCSI_CONSTANTS=3Dy
> CONFIG_BLK_DEV_3W_XXXX_RAID=3Dy
> CONFIG_SCSI_AIC7XXX=3Dy
> CONFIG_AIC7XXX_CMDS_PER_DEVICE%3
> CONFIG_AIC7XXX_RESET_DELAY_MS=15000
> CONFIG_SCSI_NCR53C8XX=3Dy
> CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=3D4
> CONFIG_SCSI_NCR53C8XX_MAX_TAGS2
> CONFIG_SCSI_NCR53C8XX_SYNC=20
> CONFIG_NETDEVICES=3Dy
> CONFIG_DUMMY=3Dy
> CONFIG_NET_ETHERNET=3Dy
> CONFIG_NET_VENDOR_3COM=3Dy
> CONFIG_VORTEX=3Dy
> CONFIG_VT=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_I2C=3Dm
> CONFIG_I2C_ALGOBIT=3Dm
> CONFIG_I2C_CHARDEV=3Dm
> CONFIG_I2C_PROC=3Dm
> CONFIG_I2C_MAINBOARD=3Dy
> CONFIG_I2C_ISA=3Dm
> CONFIG_SENSORS=3Dy
> CONFIG_SENSORS_IT87=3Dm
> CONFIG_RTC=3Dy
> CONFIG_QUOTA=3Dy
> CONFIG_EXT3_FS=3Dy
> CONFIG_JBD=3Dy
> CONFIG_FAT_FS=3Dm
> CONFIG_MSDOS_FS=3Dm
> CONFIG_VFAT_FS=3Dm
> CONFIG_RAMFS=3Dy
> CONFIG_ISO9660_FS=3Dm
> CONFIG_JOLIET=3Dy
> CONFIG_PROC_FS=3Dy
> CONFIG_DEVFS_FS=3Dy
> CONFIG_EXT2_FS=3Dy
> CONFIG_NFS_FS=3Dm
> CONFIG_NFS_V3=3Dy
> CONFIG_NFSD=3Dm
> CONFIG_NFSD_V3=3Dy
> CONFIG_SUNRPC=3Dm
> CONFIG_LOCKD=3Dm
> CONFIG_LOCKD_V4=3Dy
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_NLS=3Dy
> CONFIG_NLS_DEFAULT=3D"iso8859-15"
> CONFIG_NLS_CODEPAGE_850=3Dm
> CONFIG_NLS_ISO8859_15=3Dm
> CONFIG_VGA_CONSOLE=3Dy
> CONFIG_VIDEO_SELECT=3Dy
>=20
>=20
>=20
>=20
> hope you can help me with this problem
>=20
> thanks
>=20
> claus
>=20
>=20
>=20
> ok. i changed something but without result. here are some infos :
>=20
>=20
> **** lsmod
> Module                  Size  Used by    Not tainted
> i2c-isa                 1252   0  (unused)
> it87                    6848   0  (unused)
> i2c-dev                 4064   0  (unused)
> loop                    8656   0  (autoclean)
> i2c-proc                6624   0  [it87]
> i2c-core               14944   0  [i2c-isa it87 i2c-dev i2c-proc]
> nfsd                   68416   8  (autoclean)
> lockd                  48832   1  (autoclean) [nfsd]
> sunrpc                 60724   1  (autoclean) [nfsd lockd]
>=20
> **** /proc/ioports
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-007f : rtc
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0290-0297 : it87
> 03c0-03df : vga+
> 0cf8-0cff : PCI conf1
> d400-d47f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
>   d400-d47f : 00:11.0
> d800-d80f : 3ware Inc 3ware 7000-series ATA-RAID
>   d800-d80f : 3ware Storage Controller
> dc00-dcff : Adaptec AHA-2940U/UW/D / AIC-7881U
> ff00-ff0f : Silicon Integrated Systems [SiS] 5513 [IDE]
>=20
>=20
> **** isadump 0x290 0x291
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> 10: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> 20: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> 30: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> 40: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> 50: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> 60: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> 70: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> 80: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> 90: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> a0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> b0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> c0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> d0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> e0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
> f0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11
>=20
>=20
> **** dmesg
> i2c-core.o: i2c core module version 2.7.0 (20021208)
> i2c-proc.o version 2.7.0 (20021208)
> it87.o version 2.7.0 (20021208)
> i2c-isa.o version 2.7.0 (20021208)
> i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
>=20
>=20
>=20
> **** sensors -v
> sensors version 2.7.0
>=20
>=20
> **** result of sensors
> No sensors found!
>=20
>=20
> Any ideas ?
>=20
>=20
>=20
>>try loading i2c-isa.
>>Don't load i2c-sis5595.
>>
>>Claus Rosenberger wrote:
>>
>>>Hi,
>>>
>>>i try to use lm_sensors with my K7S5A Mainboard.
>>>
>>>sensors-detect reports following result :
>>>
>>>Use driver `i2c-sis645' for device 00:00.0: Silicon Integrated
>>>Systems SIS735 Use driver `i2c-sis5595' for device 00:02.0: Silicon
>>>Integrated Systems SIS5595
>>>Use driver `i2c-matroxfb' for device 01:00.0: MGA G200 AGP
>>>
>>>While loading this drivers i get failures because no devices deteced.
>>>
>>>In the mainboard list you linked too my mainbard has the SIS950
>>>chipset which is in driver it87 included.
>>>
>>>Loading this drivers is ok but sensors reports "No sensors found!"
>>>
>>>What to do now ??
>>>
>>>Thanks,
>>>   Claus
>=20
>=20
>=20
>=20
