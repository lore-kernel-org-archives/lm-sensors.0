From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 06 Jul 2006 11:31:37 +0000
Subject: [lm-sensors] [i2c] Winbond W83627HF
Message-Id: <20060706113137.GF8979@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Albert:

BTW: your question better belongs to the lm-sensors mailing list
rather than the i2c one... so I'm cc'ing there (and leaving all
of the original text).  One comment inline...

* Albert <albertvd at gmail.com> [2006-07-06 12:17:45 +0200]:
> On 06/07/06, Albert <albertvd at gmail.com> wrote:
> > I have a Pentium M board from Ampro with a Winbond W83627HF chip
> > running SuSE 9.3.
>=20
> It is an Ampro Readyboard 800 with a Pentium M 1.1
> (http://www.ampro.com/html/EPIC_FormFactor_ReadyBoard_800.html). In
> the reference manual it states it uses a Winbond W83627HF super I/O
> controller to monitor temperatures etc.
>=20
> The machine is running SuSE 9.2 with Kernel 2.6.11.4-20a-default. (I
> checked again and it is SuSE 9.2 and not SuSE 9.3)
>=20
> Help would really be appreciated. It seems that the chip cannot be found.
>=20
> # sensors -v
> sensors version 2.9.0 with libsensors version 2.9.0
>=20
> # modprobe i2c-isa
> # modprobe w83627hf
> FATAL: Error inserting w83627hf
> (/lib/modules/2.6.11.4-20a-default/kernel/drivers/i2c/chips/w83627hf.ko):
> No such device
>=20
> Output from dmesg:
> # dmesg
> Linux version 2.6.11.4-20a-default (geeko at buildhost) (gcc version 3.3.=
5 20050117
>  (prerelease) (SUSE Linux)) #1 Wed Mar 23 21:52:37 UTC 2005
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
>  BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001ede8000 (usable)
>  BIOS-e820: 000000001ede8000 - 000000001f000000 (reserved)
>  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
> 0MB HIGHMEM available.
> 493MB LOWMEM available.
> On node 0 totalpages: 126440
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 122344 pages, LIFO batch:16
>   HighMem zone: 0 pages, LIFO batch:1
> DMI not present.
> ACPI: Unable to locate RSDP
> Allocating PCI resources starting at 1f000000 (gap: 1f000000:e0f00000)
> Built 1 zonelists
> Kernel command line: auto BOOT_IMAGE=3DSUSE_LINUX_9.3 root02 selinux=3D0 =
splash=3Dsi
> lent resume=3D/dev/hda3 showopts
> bootsplash: silent mode.
> Initializing CPU#0
> PID hash table entries: 2048 (order: 11, 32768 bytes)
> Detected 1000.094 MHz processor.
> Using tsc for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 496464k/505760k available (1865k kernel code, 8752k reserved, 659=
k data,
>  204k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... =
Ok.
> Calibrating delay loop... 1978.36 BogoMIPS (lpj=989184)
> Security Framework v1.0.0 initialized
> SELinux:  Disabled at boot.
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU: After generic identify, caps: afe9f9ff 00100000 00000000 00000000 00=
000000
> 00000000 00000000
> CPU: After vendor identify, caps: afe9f9ff 00100000 00000000 00000000 000=
00000 0
> 0000000 00000000
> CPU: L1 I cache: 32K, L1 D cache: 32K
> CPU: L2 cache: 512K
> CPU: After all inits, caps: afe9f9ff 00100000 00000000 00000040 00000000 =
0000000
> 0 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: Intel(R) Celeron(R) M processor         1.00GHz stepping 08
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> checking if image is initramfs... it is
> Freeing initrd memory: 1244k freed
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xff6b1, last bus=3D2
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20050211
> ACPI: Interpreter disabled.
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI: disabled
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> PCI: Transparent bridge - 0000:00:1e.0
> TC classifier action (bugs to netdev at oss.sgi.com cc hadi at cyberus.ca)
> apm: BIOS not found.
> audit: initializing netlink socket (disabled)
> audit(1152115920.079:0): initialized
> Total HugeTLB memory allocated, 0
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> Initializing Cryptographic API
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Real Time Clock Driver v1.12
> PNP: No PS/2 controller found. Probing ports directly.
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
> ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
> ttyS2 at I/O 0x3e8 (irq =3D 4) is a 16550A
> ttyS3 at I/O 0x2e8 (irq =3D 3) is a 16550A
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> floppy0: no floppy controllers found
> RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
> loop: loaded (max 8 devices)
> mice: PS/2 mouse device common for all mice
> input: PC Speaker
> md: md driver 0.90.1 MAX_MD_DEVS%6, MD_SB_DISKS'
> NET: Registered protocol family 2
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP established hash table entries: 16384 (order: 5, 131072 bytes)
> TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> NET: Registered protocol family 1
> PM: Checking swsusp image.
> PM: Resume from disk failed.
> Freeing unused kernel memory: 204k freed
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=
=3Dxx
> ICH4: IDE controller at PCI slot 0000:00:1f.1
> ICH4: chipset revision 2
> ICH4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> hda: ST930218A, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hda: max request size: 1024KiB
> hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(=
100)
> hda: cache flushes supported
>  hda: hda1 hda2 hda3
> Attempting manual resume
> PM: Checking swsusp image.
> swsusp: Suspend partition has wrong signature?
> PM: Resume from disk failed.
> ReiserFS: hda2: found reiserfs format "3.6" with standard journal
> ReiserFS: hda2: using ordered data mode
> reiserfs: using flush barriers
> ReiserFS: hda2: journal params: device hda2, size 8192, journal first blo=
ck 18,
> max trans len 1024, max batch 900, max commit age 30, max trans age 30
> ReiserFS: hda2: checking transaction log (hda2)
> ReiserFS: hda2: Using r5 hash to sort names
> ReiserFS: hda2: Removing [128 432266 0x0 SD]..done
> ReiserFS: hda2: Removing [128 390746 0x0 SD]..done
> ReiserFS: hda2: Removing [128 49879 0x0 SD]..done
> ReiserFS: hda2: Removing [128 49870 0x0 SD]..done
> ReiserFS: hda2: Removing [460 49830 0x0 SD]..done
> ReiserFS: hda2: There were 5 uncompleted unlinks/truncates. Completed
> hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> ide0: reset: success
> hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> ide0: reset: success
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> Adding 2136636k swap on /dev/hda3.  Priority:42 extents:1
> device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel at redhat.c=
om
> Capability LSM initialized
> ieee1394: Initialized config rom entry `ip1394'
> ieee1394: raw1394: /dev/raw1394 device initialized
> video1394: Installed video1394 module
> lp: driver loaded but no devices found
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> USB Universal Host Controller Interface driver v2.2
> uhci_hcd 0000:00:1d.0: UHCI Host Controller
> PCI: Setting latency timer of device 0000:00:1d.0 to 64
> uhci_hcd 0000:00:1d.0: irq 5, io base 0xf400
> uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> uhci_hcd 0000:00:1d.1: UHCI Host Controller
> PCI: Setting latency timer of device 0000:00:1d.1 to 64
> uhci_hcd 0000:00:1d.1: irq 9, io base 0xf000
> uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> ehci_hcd 0000:00:1d.7: EHCI Host Controller
> PCI: Setting latency timer of device 0000:00:1d.7 to 64
> ehci_hcd 0000:00:1d.7: irq 5, pci mem 0xf0080000
> ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 3
> PCI: cache line size of 32 is not supported by device 0000:00:1d.7
> ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 6 ports detected
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected an Intel 855 Chipset.
> agpgart: Maximum main memory to use for agp memory: 422M
> agpgart: Detected 16252K stolen memory.
> agpgart: AGP aperture is 128M @ 0xe8000000
> e100: Intel(R) PRO/100 Network Driver, 3.4.1-NAPI
> e100: Copyright(c) 1999-2005 Intel Corporation
> e100: eth0: e100_probe: addr 0xf0100000, irq 5, MAC addr 00:08:9B:68:05:44
> Intel(R) PRO/1000 Network Driver - version 5.6.10.1-k2-NAPI
> Copyright (c) 1999-2004 Intel Corporation.
> e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
> e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
> SCSI subsystem initialized
> st: Version 20041025, fixed bufsize 32768, s/g segs 256
> BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
> Non-volatile memory driver v1.2
> NET: Registered protocol family 10
> Disabled Privacy Extensions on device c033d600(lo)
> IPv6 over IPv4 tunneling driver
> Disabled Privacy Extensions on device dd0bb000(sit0)
> powernow: This module only works with AMD K7 CPUs
> eth0: no IPv6 routers present
> spurious 8259A interrupt: IRQ7.
> i2c /dev entries driver
> i2c /dev entries driver
>=20
>=20
> Output from sensors-detect:
> # sensors-detect
>=20
> This program will help you determine which I2C/SMBus modules you need to
> load to use lm_sensors most effectively. You need to have i2c and
> lm_sensors installed before running this program.
> Also, you need to be `root', or at least have access to the /dev/i2c-*
> files, for most things.
> If you have patched your kernel and have some drivers built in, you can
> safely answer NO if asked to load some modules. In this case, things may
> seem a bit confusing, but they will still work.
>=20
> It is generally safe and recommended to accept the default answers to all
> questions, unless you know what you're doing.
>=20
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 00:1f.3: Intel 82801DB ICH4
> Probe succesfully concluded.
>=20
> We will now try to load each adapter module in turn.
> Module `i2c-i801' already loaded.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
>=20
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
> i2c-dev is already loaded.
>=20
>  We are now going to do the adapter probings. Some adapters may hang half=
way
>  through; we can't really help that. Also, some chips will be double dete=
cted;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address, you =
can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
>=20
> Next adapter: SMBus I801 adapter at d800
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x50
> Probing for `SPD EEPROM'... Success!
>     (confidence 8, driver `eeprom')
> Probing for `DDC monitor'... Failed!
> Probing for `Maxim MAX6900'... Failed!
> Client found at address 0x69
>=20
> Some chips are also accessible through the ISA bus. ISA probes are
> typically a bit more dangerous, as we have to write to I/O ports to do
> this. This is usually safe though.
>=20
> Do you want to scan the ISA bus? (YES/no):
> Probing for `National Semiconductor LM78'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM78-J'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM79'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83781D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83782D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83627HF'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83697HF'
>   Trying address 0x0290... Failed!
> Probing for `Silicon Integrated Systems SIS5595'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT82C686 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT8231 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'
>   Trying address 0x0290... Failed!
> Probing for `IPMI BMC KCS'
>   Trying address 0x0ca0... Failed!
> Probing for `IPMI BMC SMIC'
>   Trying address 0x0ca8... Failed!
>=20
> Some Super I/O chips may also contain sensors. Super I/O probes are
> typically a bit more dangerous, as we have to write to I/O ports to do
> this. This is usually safe though.
>=20
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for `ITE 8702F Super IO Sensors'
>   Failed! (skipping family)
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (skipping family)
> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (skipping family)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (0x52)
> Probing for `Winbond W83627HF Super IO Sensors'
>   Success... but not activated

Well, here it is.  I'm not very familiar with this driver though.  Can this
chip be 'activated' somehow?

> Probing for `Winbond W83627THF Super IO Sensors'
>   Failed! (0x52)
> Probing for `Winbond W83637HF Super IO Sensors'
>   Failed! (0x52)
> Probing for `Winbond W83697HF Super IO Sensors'
>   Failed! (0x52)
> Probing for `Winbond W83697SF/UF Super IO PWM'
>   Failed! (0x52)
> Probing for `Winbond W83L517D Super IO'
>   Failed! (0x52)
>=20
> Do you want to scan for secondary Super I/O sensors? (YES/no):
> Probing for `ITE 8702F Super IO Sensors'
>   Failed! (skipping family)
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (skipping family)
> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (skipping family)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (skipping family)
>=20
>  Now follows a summary of the probes I have just done.
>  Just press ENTER to continue:
>=20
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at d800' (Algorithm unavailable)
>     Busdriver `i2c-i801', I2C address 0x50
>     Chip `SPD EEPROM' (confidence: 8)
>=20
>=20
>  I will now generate the commands needed to load the I2C modules.
>  Sometimes, a chip is available both through the ISA bus and an I2C bus.
>  ISA bus access is faster, but you need to load an additional driver modu=
le
>  for it. If you have the choice, do you want to use the ISA bus or the
>  I2C/SMBus (ISA/smbus)? ISA
>=20
> To make the sensors modules behave correctly, add these lines to
> /etc/modprobe.conf:
>=20
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
>=20
> To load everything that is needed, add this to some /etc/rc* file:
>=20
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-i801
> # I2C chip drivers
> modprobe eeprom
> # sleep 2 # optional
> /usr/bin/sensors -s # recommended
> #----cut here----
>=20
> WARNING! If you have some things built into your kernel, the list above
> will contain too many modules. Skip the appropriate ones! You really shou=
ld
> try these commands right now to make sure everything is working properly.
> Monitoring programs won't work until it's done.
>=20
> Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
> Copy /usr/share/doc/packages/sensors/prog/init/lm_sensors.init.suse
> to /etc/init.d/lm_sensors for initialization at boot time.
>=20
> Output from lsmod:
> # lsmod
> Module                  Size  Used by
> i2c_sensor              3584  0
> i2c_isa                 2048  0
> i2c_dev                 9216  0
> i2c_i801                8588  0
> i2c_core               21776  4 i2c_sensor,i2c_isa,i2c_dev,i2c_i801
> ipv6                  236672  19
> speedstep_lib           4100  0
> freq_table              4484  0
> processor              23732  0
> nvram                   8200  0
> edd                    10080  0
> evdev                   8832  0
> joydev                  9664  0
> sg                     36256  0
> st                     37788  0
> sd_mod                 17936  0
> sr_mod                 16548  0
> scsi_mod              125256  4 sg,st,sd_mod,sr_mod
> e1000                  83508  0
> e100                   35968  0
> mii                     4864  1 e100
> intel_agp              21532  1
> agpgart                32296  1 intel_agp
> ehci_hcd               31624  0
> uhci_hcd               30224  0
> usbcore               108760  3 ehci_hcd,uhci_hcd
> parport_pc             38212  0
> lp                     11076  0
> parport                33864  2 parport_pc,lp
> video1394              17612  0
> ohci1394               31492  1 video1394
> raw1394                28140  0
> ieee1394               97976  3 video1394,ohci1394,raw1394
> capability              3256  0
> dm_mod                 56316  0
> reiserfs              242928  1
> ide_cd                 37892  0
> cdrom                  36640  2 sr_mod,ide_cd
> ide_disk               16640  4
> piix                    9988  0 [permanent]
> ide_core              120020  3 ide_cd,ide_disk,piix
>=20
> Output from isadump:
> # isadump 0x295 0x296
> WARNING! Running this program can cause system crashes, data loss and wor=
se!
> I will probe address register 0x295 and data register 0x296.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Regards,

--=20
Mark M. Hoffman
mhoffman at lightlink.com


