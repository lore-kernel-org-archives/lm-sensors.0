From: olli.zimmermann@gmx.net (olli.zimmermann@gmx.net)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: get no informations on laptop acer extensa: Especially smart battery:
Message-Id: <200411152320.53143.olli.zimmermann@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello

i bought an acer extensa 3002 laptop and install SuSE 9.1 with Kernel 4.6.1=
0.=20
Acpi is supported and i can get many informations but there is no battery=20
support. I disassembled the DSDT and dont?t find any error. With=20
Windows XP the control manager dosn?t list a ACPI battery support but use=20
smart battery with SMBus. So i install lm_sensor latest version and do=20
sensors-detect. The script found i2c-i801 and load the module. But there is=
=20
only the eeprom module found, no other sensors/chips etc. sensors listed on=
ly=20
the eeprom and i2cdetect dosn?t find anything, i2cdump only list i2c-0=20
unknown  SMBus I801 adapter at 1880  Algorithm unavailable. So i think, tha=
ts=20
not o.k. Also i?m not able to fiind a way to compile the smartbat.c module =
in=20
the subdirectory of lm_sensors.=20
What?s wrong?

i attached my lspci -v, my boot.msg and DSDT. Please help me.


Thanks

Zimmermann=09
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lspci.log
Type: text/x-log
Size: 5897 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041115=
/676641fa/lspci.bin
-------------- next part --------------
Inspecting /boot/System.map-2.6.10-rc1
Loaded 32728 symbols from /boot/System.map-2.6.10-rc1.
Symbols match kernel version 2.6.10.
No module symbols loaded - kernel modules not enabled.

klogd 1.4.1, log source =3D ksyslog started.
<4>Linux version 2.6.10-rc1 (root@laptop) (gcc version 3.3.3 (SuSE Linux)) =
#9 Sat Nov 13 14:42:02 CET 2004
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
<4> BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000001fee0000 (usable)
<4> BIOS-e820: 000000001fee0000 - 000000001feec000 (ACPI data)
<4> BIOS-e820: 000000001feec000 - 000000001ff00000 (ACPI NVS)
<4> BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
<4> BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
<4> BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
<4> BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
<5>0MB HIGHMEM available.
<5>510MB LOWMEM available.
<7>On node 0 totalpages: 130784
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 126688 pages, LIFO batch:16
<7>  HighMem zone: 0 pages, LIFO batch:1
<6>DMI present.
<7>ACPI: RSDP (v000 ACER                                  ) @ 0x000f62c0
<7>ACPI: RSDT (v001 ACER   Kestrel  0x20020909  LTP 0x00000000) @ 0x1fee6205
<7>ACPI: FADT (v001 ACER   Kestrel  0x20020909 PTL  0x00000050) @ 0x1feebf2c
<7>ACPI: HPET (v001 ACER   Kestrel  0x20020909 PTL  0x00000000) @ 0x1feebfa0
<7>ACPI: BOOT (v001 ACER   Kestrel  0x20020909  LTP 0x00000001) @ 0x1feebfd8
<7>ACPI: DSDT (v001 ACER   Kestrel  0x20020909 MSFT 0x0100000e) @ 0x00000000
<6>ACPI: PM-Timer IO Port: 0x1008
<4>Built 1 zonelists
<4>Kernel command line: root=3D/dev/hda3 vga=3D0x317 desktop resume=3D/dev/=
hda5 splash=3Dsilent PROFILE=3Dzuhause acpi=3Dforce acpi_os_name=3D\"Window=
s 2001\"
<6>Initializing CPU#0
<4>PID hash table entries: 2048 (order: 11, 32768 bytes)
<4>Detected 1599.250 MHz processor.
<6>Using pmtmr for high-res timesource
<4>Console: colour dummy device 80x25
<4>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
<4>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
<6>Memory: 514680k/523136k available (2053k kernel code, 7868k reserved, 69=
3k data, 176k init, 0k highmem)
<4>Checking if this processor honours the WP bit even in supervisor mode...=
 Ok.
<7>Calibrating delay loop... 3170.30 BogoMIPS (lpj=1585152)
<6>Security Framework v1.0.0 initialized
<6>SELinux:  Initializing.
<6>SELinux:  Starting in permissive mode
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<7>CPU: After generic identify, caps: afe9fbbf 00000000 00000000 00000000
<7>CPU: After vendor identify, caps:  afe9fbbf 00000000 00000000 00000000
<6>CPU: L1 I cache: 32K, L1 D cache: 32K
<6>CPU: L2 cache: 2048K
<7>CPU: After all inits, caps:        afe9fbbf 00000000 00000000 00000040
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<4>CPU: Intel(R) Pentium(R) M processor 1.60GHz stepping 06
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>ACPI: IRQ9 SCI: Edge set to Level Trigger.
<6>checking if image is initramfs...it isn't (ungzip failed); looks like an=
 initrd
<6>Freeing initrd memory: 21k freed
<6>NET: Registered protocol family 16
<6>PCI: PCI BIOS revision 2.10 entry at 0xfd782, last bus=3D2
<6>PCI: Using configuration type 1
<6>mtrr: v2.0 (20020519)
<6>ACPI: Subsystem revision 20040816
<6>ACPI: Interpreter enabled
<6>ACPI: Using PIC for interrupt routing
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<6>PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
<6>PCI: Transparent bridge - 0000:00:1e.0
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs *6)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs *6)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs *6)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, disabled.
<4>ACPI: PCI Interrupt Link [LNKG] (IRQs 6) *0, disabled.
<4>ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
<6>ACPI: Embedded Controller [EC0] (gpe 29)
<6>ACPI: Power Resource [PFN0] (off)
<6>ACPI: Power Resource [PFN1] (off)
<4>toshiba: not a supported Toshiba laptop
<6>PCI: Using ACPI for IRQ routing
<4>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 6
<6>ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 6 (level, low) -> IRQ 6
<4>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
<6>ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 6 (level, low) -> IRQ 6
<4>ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 6
<6>ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 6 (level, low) -> IRQ 6
<4>ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
<6>ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
<6>ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 6 (level, low) -> IRQ 6
<4>ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
<6>ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
<6>ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
<6>ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
<6>ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 6 (level, low) -> IRQ 6
<6>ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 6 (level, low) -> IRQ 6
<6>ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 10 (level, low) -> IRQ 10
<4>ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
<6>ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
<6>ACPI: PCI interrupt 0000:02:06.2[A] -> GSI 10 (level, low) -> IRQ 10
<6>ACPI: PCI interrupt 0000:02:06.3[A] -> GSI 10 (level, low) -> IRQ 10
<6>Simple Boot Flag at 0x37 set to 0x1
<6>audit: initializing netlink socket (disabled)
<3>audit(1100465481.624:0): initialized
<4>Total HugeTLB memory allocated, 0
<5>VFS: Disk quotas dquot_6.5.1
<4>Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
<6>NTFS driver 2.1.21 [Flags: R/W].
<6>SELinux:  Registering netfilter hooks
<6>Initializing Cryptographic API
<6>vesafb: framebuffer at 0xd8000000, mapped to 0xe0880000, using 3072k, to=
tal 65536k
<6>vesafb: mode is 1024x768x16, linelength 48, pagesA
<6>vesafb: protected mode interface info at c000:56e3
<6>vesafb: scrolling: redraw
<6>vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
<4>Console: switching to colour frame buffer device 128x48
<6>fb0: VESA VGA frame buffer device
<6>Real Time Clock Driver v1.12
<6>i8042.c: Detected active multiplexing controller, rev 1.1.
<6>serio: i8042 AUX0 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX1 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX2 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX3 port at 0x60,0x64 irq 12
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
<4>ttyS1 at I/O 0x2f8 (irq =3D 3) is a NS16550A
<6>ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
<4>io scheduler noop registered
<4>io scheduler anticipatory registered
<4>io scheduler deadline registered
<4>io scheduler cfq registered
<4>RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
<6>loop: loaded (max 8 devices)
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=
=3Dxx
<6>ICH4: IDE controller at PCI slot 0000:00:1f.1
<4>PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
<6>ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 6 (level, low) -> IRQ 6
<6>ICH4: chipset revision 3
<6>ICH4: not 100%% native mode: will probe irqs later
<6>    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
<6>    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
<7>Probing IDE interface ide0...
<4>hda: HTS424040M9AT00, ATA DISK drive
<4>elevator: using anticipatory as default io scheduler
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<7>Probing IDE interface ide1...
<4>hdc: Slimtype DVDRW SOSW-852S, ATAPI CD/DVD-ROM drive
<4>ide1 at 0x170-0x177,0x376 on irq 15
<7>Probing IDE interface ide2...
<7>ide2: Wait for ready failed before probe !
<7>Probing IDE interface ide3...
<7>ide3: Wait for ready failed before probe !
<7>Probing IDE interface ide4...
<7>ide4: Wait for ready failed before probe !
<7>Probing IDE interface ide5...
<7>ide5: Wait for ready failed before probe !
<6>hda: max request size: 1024KiB
<6>hda: 78140160 sectors (40007 MB) w/1739KiB Cache, CHS=16383/255/63, UDMA=
(100)
<7>hda: cache flushes supported
<6> hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
<7>ieee1394: Initialized config rom entry `ip1394'
<6>mice: PS/2 mouse device common for all mice
<6>input: AT Translated Set 2 keyboard on isa0060/serio0
<6>Synaptics Touchpad, model: 1
<6> Firmware: 5.9
<6> Sensor: 18
<6> new absolute packet format
<6> Touchpad has extended capability bits
<6> -> 4 multi-buttons, i.e. besides standard buttons
<6> -> multifinger detection
<6> -> palm detection
<6>input: SynPS/2 Synaptics TouchPad on isa0060/serio4
<6>input: PC Speaker
<6>NET: Registered protocol family 2
<6>IP: routing cache hash table of 4096 buckets, 32Kbytes
<6>TCP: Hash tables configured (established 32768 bind 65536)
<6>NET: Registered protocol family 1
<6>NET: Registered protocol family 8
<6>NET: Registered protocol family 20
<6>ACPI: (supports S0 S3 S4 S5)
<4>ACPI wakeup devices:=20
<4>GLAN MPCI T394 MDM0 USB1 USB2 USB3=20
<5>RAMDISK: Couldn't find valid RAM disk image starting at 0.
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3-fs: mounted filesystem with ordered data mode.
<4>VFS: Mounted root (ext3 filesystem) readonly.
<6>Freeing unused kernel memory: 176k freed
<6>Adding 2104472k swap on /dev/hda5.  Priority:42 extents:1
<6>EXT3 FS on hda3, internal journal
<6>device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
<6>kjournald starting.  Commit interval 5 seconds
<4>EXT3-fs warning: maximal mount count reached, running e2fsck is recommen=
ded
<6>EXT3 FS on hda6, internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<6>kjournald starting.  Commit interval 5 seconds
<4>EXT3-fs warning: maximal mount count reached, running e2fsck is recommen=
ded
<6>EXT3 FS on hda7, internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<6>subfs 0.9
<4>hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
<6>Uniform CD-ROM driver Revision: 3.20
<4>hdc: CHECK for good STATUS
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

Boot logging started on /dev/tty1(/dev/console) at Sun Nov 14 20:51:39 2004

Master Resource Control: previous runlevel: N, switching to runlevel: 5
<notice>start services (random isdn hotplug)
Hotplug is already active  (disable with  NOHOTPLUG=3D1 at the boot prompt)=
done
Initializing random number generatordone
<notice>exit status of (random isdn hotplug) is (0 0 0)
<notice>start services (coldplug)
coldplug scanning input: ***done
         scanning pci: *WW*******.*WWW*****done
         scanning usb: done
         .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  =
.  .done
<notice>exit status of (coldplug) is (0)
<notice>start services (pcmcia)
Starting PCMCIA <notice>startproc: execve (/sbin/cardmgr) [ /sbin/cardmgr ]=
, [ CONSOLE=3D/dev/console TERM=3Dlinux SHELL=3D/bin/sh PROFILE=3Dzuhause p=
rogress$ INIT_VERSION=3Dsysvinit-2.85 REDIRECT=3D/dev/tty1 COLUMNS=128 PATH=
=3D/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=3D0x317 RUNLEVEL=3D5 P=
WD=3D/ PREVLEVEL=3DN acpi=3Dforce LINESH SHLVL=3D2 splash=3Dsilent sscripts=
F _=3D/sbin/startproc DAEMON=3D/sbin/cardmgr ]
done
<notice>exit status of (pcmcia) is (0)
<notice>start services (network)
Setting up network interfaces:
    lo      =20
    lo        IP address: 127.0.0.1/8  =20
done    eth0      device: Broadcom Corporation BCM4401 100Base-T (rev 01)
    eth0      configuration: eth-id-00:c0:9f:55:f0:2b
    eth0      IP address: 192.168.1.13/24  =20
done    ppp0    =20
    ppp0      Startmode is 'manual'
skippedSetting up service network  .  .  .  .  .  .  .  .  .  .  .  .  .  .=
  .  .done
<notice>exit status of (network) is (0)
<notice>start services (syslog)
Starting syslog services<notice>startproc: execve (/sbin/syslogd) [ /sbin/s=
yslogd -a /var/lib/ntp/dev/log ], [ CONSOLE=3D/dev/console TERM=3Dlinux SHE=
LL=3D/bin/sh PROFILE=3Dzuhause progress& INIT_VERSION=3Dsysvinit-2.85 REDIR=
ECT=3D/dev/tty1 COLUMNS=128 PATH=3D/usr/local/sbin:/sbin:/bin:/usr/sbin:/us=
r/bin vga=3D0x317 RUNLEVEL=3D5 PWD=3D/ PREVLEVEL=3DN acpi=3Dforce LINESH SH=
LVL=3D2 splash=3Dsilent sscriptsF _=3D/sbin/startproc DAEMON=3D/sbin/syslog=
d ]
<notice>startproc: execve (/sbin/klogd) [ /sbin/klogd -c 1 -2 ], [ CONSOLE=
=3D/dev/console TERM=3Dlinux SHELL=3D/bin/sh PROFILE=3Dzuhause progress& IN=
IT_VERSION=3Dsysvinit-2.85 REDIRECT=3D/dev/tty1 COLUMNS=128 PATH=3D/usr/loc=
al/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=3D0x317 RUNLEVEL=3D5 PWD=3D/ PREV=
LEVEL=3DN acpi=3Dforce LINESH SHLVL=3D2 splash=3Dsilent sscriptsF _=3D/sbin=
/startproc DAEMON=3D/sbin/klogd ]
done
<notice>exit status of (syslog) is (0)
<notice>start services (smbfs)
Mount SMB/ CIFS File Systems unused
<notice>exit status of (smbfs) is (6)
<notice>start services (splash_early resmgr portmap)
<notice>startproc: execve (/sbin/portmap) [ /sbin/portmap ], [ CONSOLE=3D/d=
ev/console TERM=3Dlinux SHELL=3D/bin/sh PROFILE=3Dzuhause progress( INIT_VE=
RSION=3Dsysvinit-2.85 REDIRECT=3D/dev/tty1 COLUMNS=128 PATH=3D/usr/local/sb=
in:/sbin:/bin:/usr/sbin:/usr/bin vga=3D0x317 RUNLEVEL=3D5 PWD=3D/ PREVLEVEL=
=3DN acpi=3Dforce LINESH SHLVL=3D2 splash=3Dsilent sscriptsF _=3D/sbin/star=
tproc DAEMON=3D/sbin/portmap ]
<notice>startproc: execve (/sbin/resmgrd) [ /sbin/resmgrd ], [ CONSOLE=3D/d=
ev/console TERM=3Dlinux SHELL=3D/bin/sh PROFILE=3Dzuhause progress( INIT_VE=
RSION=3Dsysvinit-2.85 REDIRECT=3D/dev/tty1 COLUMNS=128 PATH=3D/usr/local/sb=
in:/sbin:/bin:/usr/sbin:/usr/bin vga=3D0x317 RUNLEVEL=3D5 PWD=3D/ PREVLEVEL=
=3DN acpi=3Dforce LINESH SHLVL=3D2 splash=3Dsilent sscriptsF _=3D/sbin/star=
tproc DAEMON=3D/sbin/resmgrd ]
Starting RPC portmap daemondone
Starting resource managerdone
<notice>exit status of (splash_early resmgr portmap) is (0 0 0)
<notice>start services (nfsboot)
Starting nfsboot (sm-notify) done
<notice>exit status of (nfsboot) is (0)
<notice>start services (sshd smpppd slmodemd powersaved fbset alsasound)
<notice>startproc: execve (/usr/sbin/slmodemd) [ /usr/sbin/slmodemd --count=
ry=3DGERMANY /dev/slamr0 ], [ CONSOLE=3D/dev/console TERM=3Dlinux SHELL=3D/=
bin/sh PROFILE=3Dzuhause progress2 INIT_VERSION=3Dsysvinit-2.85 REDIRECT=3D=
/dev/tty1 COLUMNS=128 PATH=3D/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin =
vga=3D0x317 RUNLEVEL=3D5 PWD=3D/ PREVLEVEL=3DN acpi=3Dforce LINESH SHLVL=3D=
2 splash=3Dsilent sscriptsF _=3D/sbin/startproc DAEMON=3D/usr/sbin/slmodemd=
 ]
<notice>startproc: execve (/usr/sbin/smpppd) [ /usr/sbin/smpppd ], [ CONSOL=
E=3D/dev/console TERM=3Dlinux SHELL=3D/bin/sh PROFILE=3Dzuhause progress2 I=
NIT_VERSION=3Dsysvinit-2.85 REDIRECT=3D/dev/tty1 COLUMNS=128 PATH=3D/usr/lo=
cal/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=3D0x317 RUNLEVEL=3D5 PWD=3D/ PRE=
VLEVEL=3DN acpi=3Dforce LINESH SHLVL=3D2 splash=3Dsilent sscriptsF _=3D/sbi=
n/startproc DAEMON=3D/usr/sbin/smpppd ]
Starting SmartLink Modem driver for slamr0: done
Starting SMPPPDdone
<notice>startproc: execve (/usr/sbin/sshd) [ /usr/sbin/sshd -o PidFile=3D/v=
ar/run/sshd.init.pid ], [ CONSOLE=3D/dev/console TERM=3Dlinux SHELL=3D/bin/=
sh PROFILE=3Dzuhause progress2 INIT_VERSION=3Dsysvinit-2.85 REDIRECT=3D/dev=
/tty1 COLUMNS=128 PATH=3D/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=
=3D0x317 RUNLEVEL=3D5 PWD=3D/ PREVLEVEL=3DN acpi=3Dforce LINESH SHLVL=3D2 s=
plash=3Dsilent sscriptsF _=3D/sbin/startproc DAEMON=3D/usr/sbin/sshd ]
Starting SSH daemondone
<notice>startproc: execve (/usr/sbin/powersaved) [ /usr/sbin/powersaved -d =
-a all -e /etc/powersave.conf -v 3 ], [ CONSOLE=3D/dev/console TERM=3Dlinux=
 SHELL=3D/bin/sh PROFILE=3Dzuhause progress2 INIT_VERSION=3Dsysvinit-2.85 R=
EDIRECT=3D/dev/tty1 COLUMNS=128 PATH=3D/usr/local/sbin:/sbin:/bin:/usr/sbin=
:/usr/bin vga=3D0x317 RUNLEVEL=3D5 PWD=3D/ PREVLEVEL=3DN acpi=3Dforce LINES=
H SHLVL=3D2 splash=3Dsilent sscriptsF _=3D/sbin/startproc DAEMON=3D/usr/sbi=
n/powersaved ]
loading ACPI modules (ac battery button fan processor thermal ) Starting po=
wersaved done
Starting sound driver:  intel8x0done
Restoring the previous sound settingdone
<notice>exit status of (sshd smpppd slmodemd powersaved fbset alsasound) is=
 (0 0 0 0 0 0)
<notice>start services (splash postfix kbd cups)
<notice>startproc: execve (/usr/sbin/cupsd) [ /usr/sbin/cupsd ], [ CONSOLE=
=3D/dev/console TERM=3Dlinux SHELL=3D/bin/sh PROFILE=3Dzuhause progress8 IN=
IT_VERSION=3Dsysvinit-2.85 REDIRECT=3D/dev/tty1 COLUMNS=128 PATH=3D/usr/loc=
al/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=3D0x317 RUNLEVEL=3D5 PWD=3D/ PREV=
LEVEL=3DN acpi=3Dforce LINESH SHLVL=3D2 splash=3Dsilent sscriptsF _=3D/sbin=
/startproc DAEMON=3D/usr/sbin/cupsd ]
Starting cupsddone
Starting mail service (Postfix)done
Loading keymap qwertz/de-latin1-nodeadkeys.map.gz
doneLoading compose table latin1.adddone
Start Unicode mode
doneLoading console font lat9w-16.psfu  -m trivial (K
done<notice>exit status of (splash postfix kbd cups) is (5 0 0 0)
<notice>start services (nscd hwscan cron)
Starting hardware scan on boot<notice>startproc: execve (/usr/sbin/nscd) [ =
/usr/sbin/nscd ], [ CONSOLE=3D/dev/console TERM=3Dlinux SHELL=3D/bin/sh PRO=
FILE=3Dzuhause progressB INIT_VERSION=3Dsysvinit-2.85 REDIRECT=3D/dev/tty1 =
COLUMNS=128 PATH=3D/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=3D0x31=
7 RUNLEVEL=3D5 PWD=3D/ PREVLEVEL=3DN acpi=3Dforce LINESH SHLVL=3D2 splash=
=3Dsilent sscriptsF _=3D/sbin/startproc DAEMON=3D/usr/sbin/nscd ]
<notice>startproc: execve (/usr/sbin/cron) [ /usr/sbin/cron ], [ CONSOLE=3D=
/dev/console TERM=3Dlinux SHELL=3D/bin/sh PROFILE=3Dzuhause progressB INIT_=
VERSION=3Dsysvinit-2.85 REDIRECT=3D/dev/tty1 COLUMNS=128 PATH=3D/usr/local/=
sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=3D0x317 RUNLEVEL=3D5 PWD=3D/ PREVLEV=
EL=3DN acpi=3Dforce LINESH SHLVL=3D2 splash=3Dsilent sscriptsF _=3D/sbin/st=
artproc DAEMON=3D/usr/sbin/cron ]
Starting Name Service Cache Daemondone
Starting CRON daemondone
<notice>exit status of (nscd hwscan cron) is (0 0 0)
<notice>start services (xdm splash_late)
Starting service kdm<notice>startproc: execve (/opt/kde3/bin/kdm) [ /opt/kd=
e3/bin/kdm ], [ LC_MONETARY=3D CONSOLE=3D/dev/console TERM=3Dlinux SHELL=3D=
/bin/sh PROFILE=3Dzuhause LC_NUMERIC=3D QTDIR=3D/usr/lib/qt3 LC_ALL=3D prog=
ressE INIT_VERSION=3Dsysvinit-2.85 KDEROOTHOME=3D/root/.kdm REDIRECT=3D/dev=
/tty1 COLUMNS=128 PATH=3D/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin LC_M=
ESSAGES=3D vga=3D0x317 RUNLEVEL=3D5 LC_COLLATE=3D PWD=3D/ LANG=DE_DE.UTF-8 =
PREVLEVEL=3DN acpi=3Dforce LINESH SHLVL=3D2 XCURSOR_THEME=3Dcrystalwhite no=
_proxy=3Dlocalhost WINDOWMANAGER=3D/usr/X11R6/bin/kde LC_CTYPE=DE_DE.UTF-8 =
splash=3Dsilent sscriptsF LC_TIME=3D _=3D/sbin/startproc DAEMON=3D/opt/kde3=
/bin/kdm ]
done
<notice>exit status of (xdm splash_late) is (0 0)
Master Resource Control: runlevel 5 has been reached
Skipped services in runlevel 5: smbfs splash
<notice>killproc: kill(1587,3)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dsdt.dsl
Type: text/x-csrc
Size: 203286 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041115=
/676641fa/dsdt.bin
