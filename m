From: BAGSOFCHOICE@oldtolley.fsnet.co.uk (John Richard Smith)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: LM_sensors   /   Slackware9.1
Message-Id: <414B714D.4080300@oldtolley.fsnet.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

root@Root:~# dmesg
Linux version 2.4.22 (root@midas) (gcc version 3.2.3) #6 Tue Sep 2 
17:43:01 PDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=SW91-2.4.22 ro root0b devfs=mount 
acpi=ht resume=/dev/hda11 splash=silent hdc=ide-scsi hdd=ide-scsi
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 1921.027 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3827.30 BogoMIPS
Memory: 515364k/524224k available (1813k kernel code, 8472k reserved, 
614k data, 116k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm)  stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfbbd0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router default [10de/01e0] at 00:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
vesafb: framebuffer at 0xdc000000, mapped to 0xe080d000, size 3072k
vesafb: mode is 1024x768x16, linelength 48, pages=0
vesafb: protected mode interface info at c000:b7d0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M, fd1 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 7777K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
AMD_IDE: nVidia Corporation nForce2 IDE (rev a2) UDMA100 controller on 
pci00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y120L0, ATA DISK drive
blk: queue c03a9d80, I/O limit 4095Mb (mask 0xffffffff)
hdc: Pioneer DVD-ROM ATAPIModel DVD-116 0122, ATAPI CD/DVD-ROM drive
hdd: CR-48X9TE, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS946/255/63, 
UDMA(100)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 
hda15 hda16 >
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2755.200 MB/sec
   32regs    :  1577.600 MB/sec
   pIII_sse  :  4477.200 MB/sec
   pII_mmx   :  4499.600 MB/sec
   p5_mmx    :  5741.200 MB/sec
raid5: using function: pIII_sse (4477.200 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS%6, MD_SB_DISKS'
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.5+(22/07/2002)
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
FAT: bogus logical sector size 0
UMSDOS: msdos_read_super failed, mount aborted.
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,11)) ...
for (ide0(3,11))
ide0(3,11):Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 116k freed
Adding Swap: 1028120k swap-space (priority -1)
NTFS driver v1.1.22 [Flags: R/O MODULE]
NTFS: Warning! NTFS volume version is Win2k+: Mounting read-only
NTFS: Warning! NTFS volume version is Win2k+: Mounting read-only
NTFS: Warning! NTFS volume version is Win2k+: Mounting read-only
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,8)) ...
for (ide0(3,8))
ide0(3,8):Using r5 hash to sort names
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,9)) ...
for (ide0(3,9))
ide0(3,9):Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,12), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,13), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,14), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected NVIDIA nForce2 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
hdc: attached ide-scsi driver.
hdd: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PIONEER   Model: DVD-ROM DVD-116   Rev: 1.22
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MITSUMI   Model: CR-48X9TE         Rev: 1.0C
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Intel PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
ds: no socket drivers loaded!
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xe0e08000, 00:40:f4:88:0e:62, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
PCI: Setting latency timer of device 00:06.0 to 64
intel8x0: clocking to 47489
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:02.2 to 64
ehci_hcd 00:02.2: nVidia Corporation nForce2 USB Controller
ehci_hcd 00:02.2: irq 11, pci mem e0e5d000
usb.c: new USB bus registered, assigned bus number 1
PCI: 00:02.2 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:02.2 PCI cache line size corrected to 16.
ehci_hcd 00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 6 ports detected
PCI: Setting latency timer of device 00:02.0 to 64
usb-ohci.c: USB OHCI at membase 0xe0e65000, IRQ 5
usb-ohci.c: usb-00:02.0, nVidia Corporation nForce2 USB Controller
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Setting latency timer of device 00:02.1 to 64
usb-ohci.c: USB OHCI at membase 0xe0e67000, IRQ 10
usb-ohci.c: usb-00:02.1, nVidia Corporation nForce2 USB Controller (#2)
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 3 ports detected
uhci.c: USB Universal Host Controller Interface driver v1.1
usb-uhci.c: $Revision: 1.275 $ time 18:40:47 Sep  2 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:02.2-5, assigned address 2
usb.c: USB device 2 (vend/prod 0x4b8/0x11b) is not claimed by any active 
driver.
hub.c: new USB device 00:02.1-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x733/0x1310) is not claimed by any 
active driver.
hub.c: new USB device 00:02.1-2, assigned address 3
usb.c: USB device 3 (vend/prod 0xaec/0x5010) is not claimed by any 
active driver.
hub.c: new USB device 00:02.1-3, assigned address 4
usb.c: USB device 4 (vend/prod 0x43d/0x54) is not claimed by any active 
driver.
usb.c: registered new driver usbscanner
scanner.c: USB scanner device (0x04b8/0x011b) now attached to scanner0
scanner.c: 0.4.13:USB Scanner Driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor:           Model: 1.3M DigitalCAM   Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 16384 512-byte hdwr sectors (8 MB)
sda: test WP failed, assume Write Enabled
 sda: sda1
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
scsi2 : SCSI emulation for USB Mass Storage devices
  Vendor: Generic   Model: USB Storage-SMC   Rev: 0090
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sdb at scsi2, channel 0, id 0, lun 0
SCSI device sdb: 128001 512-byte hdwr sectors (66 MB)
sdb: Write Protect is off
 sdb: sdb1
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3
USB Mass Storage support registered.
usb.c: registered new driver usblp
printer.c: usblp0: USB Bidirectional printer dev 4 if 0 alt 0 proto 2 
vid 0x043D pid 0x0054
printer.c: v0.11: USB Printer Device Class driver
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PPP BSD Compression module registered
PPP Deflate Compression module registered
PPP BSD Compression module registered
PPP Deflate Compression module registered
PPP BSD Compression module registered
PPP Deflate Compression module registered
PPP BSD Compression module registered
PPP Deflate Compression module registered
PPP BSD Compression module registered
PPP Deflate Compression module registered
root@Root:~#

root@Root:~# sensors
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and done
'modprobe i2c_sensor'!
For older kernels, make sure you have done 'modprobe i2c-proc'!


My SW9.1 is not using a 2.6 kernel, so I don't know what it refers to.

root@Root:~# ls /var/adm/packages | grep -i  kernel
kernel-headers-2.4.22-i386-1
kernel-ide-2.4.22-i486-2
kernel-modules-2.4.22-i486-2
kernel-source-2.4.22-noarch-3

Installed packages,
i2c-2.8.7.tgz
lm_sensors-2.8.7.tgz


Quickstart for i2c option 1 (modules) and lm_sensors option 1 (modules).
This is by far the EASIEST METHOD.
Other methods are described in INSTALL.
------------------------------------------

  * Verify you are running a 2.4 kernel, 2.4.9 or later.
I am.
    If you are running a 2.5/2.6 kernel, the ONLY thing you need to
    do is 'make user' and 'make user_install'. Do NOT follow the rest
    of these instructions.

  * Do you require additional i2c-related
    2.4 kernel modules (bttv, i2c-matrox, rivatv, zoran...) ???
    See the information in README.
    Do NOT follow the rest of these instructions.
Package installed

  * Make sure you have the kernel tree corresponding to your current
    kernel in /lib/modules/(uname -r)/build.
    Even if the source is there, it may not correspond to your running
    kernel. If so, you will have to recompile your kernel.

  * Verify that your i2c support in the kernel is configured as
    modules or is disabled. If it is compiled-in, you obviously
    cannot replace it with modules in the next step.

  * Do `lsmod'. If there are any old i2c or sensors modules loaded,
    you MUST remove them (as root) with `rmmod'.
root@Root:~# lsmod
Module                  Size  Used by    Not tainted
ppp_deflate             3288   0  (autoclean)
zlib_deflate           18200   0  (autoclean) [ppp_deflate]
bsd_comp                4312   0  (autoclean)
ppp_async               7552   1  (autoclean)
ppp_generic            15452   3  (autoclean) [ppp_deflate bsd_comp 
ppp_async]
slhc                    5040   0  (autoclean) [ppp_generic]
snd-pcm-oss            37252   1
snd-mixer-oss          11992   0  [snd-pcm-oss]
printer                 7040   0
usb-storage            65536   0
scanner                10488   0  (unused)
usb-ohci               18888   0  (unused)
ehci-hcd               16872   0  (unused)
usbcore                58400   1  [printer usb-storage scanner usb-ohci 
ehci-hcd]
snd-intel8x0           17156   1
snd-pcm                55904   0  [snd-pcm-oss snd-intel8x0]
snd-timer              13252   0  [snd-pcm]
snd-ac97-codec         37240   0  [snd-intel8x0]
snd-page-alloc          6004   0  [snd-intel8x0 snd-pcm]
snd-mpu401-uart         3136   0  [snd-intel8x0]
snd-rawmidi            12512   0  [snd-mpu401-uart]
snd-seq-device          3920   0  [snd-rawmidi]
snd                    27460   0  [snd-pcm-oss snd-mixer-oss 
snd-intel8x0 snd-pcm snd-timer snd-ac97-codec snd-mpu401-uart 
snd-rawmidi snd-seq-device]
soundcore               3332   4  [snd]
8139too                15240   0  (unused)
mii                     2304   0  [8139too]
crc32                   2880   0  [8139too]
pcmcia_core            40032   0
ide-scsi                9424   0
agpgart                39576   0  (unused)
ntfs                   51040   3  (autoclean)
root@Root:~#

  * Download, build, and install the latest i2c package,
    (i2c-2.8.1 or later). The i2c subsystem found in the Linux 2.4
    kernel trees, even the latest ones, is outdated and won't work.
    Quickstart for i2c: make; make install; depmod -a
Have done

  * Go back to the lm_sensors directory. Do `make'.
    The warnings about .d files at the start are harmless.
    If you have compile problems, you probably should not have skipped 
step 3.
    Go back and install the latest i2c package.
    If you still have compile problems, you probably should not
    have skipped the i2c step above.

  * Do (as root) `make install'.
Have done

  * Do (as root) `depmod -a'.
Have done

  * Verify that /usr/local/lib is listed in /etc/ld.so.conf;
    add it if it isn't.
It is

  * Do (as root) `ldconfig'.
I did

  * Run (as root) `prog/mkdev/mkdev.sh' to create the device files,
    unless you already have them or are running devfs.
I did and it did do so.

  * Run (as root) `prog/detect/sensors-detect' to detect your hardware,
Completed this task satisfactorily, I believe

    put the lines it suggests into /etc/modules.conf
    and enter the modprobe lines sensors-detect suggests.
    Add the line `sensors -s' after the modprobe lines.

  * Reboot, or else type in the modprobe lines and `sensors -s'.
I rebooted

  * Run `sensors' to see your output.
root@Root:~# sensors
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and done
'modprobe i2c_sensor'!
For older kernels, make sure you have done 'modprobe i2c-proc'!

  * That's it! If you have problems, read our excellent FAQ
    (doc/FAQ or doc/lm_sensors-FAQ.html).

Have read FAQ



Can you help me ?

I know from previously installed lm_sensors in other linux OS's (MD10.0) 
I don't have any special thermistors.

Slackware seems to do things slightly different to madrake, and I may be 
missing something.

John
