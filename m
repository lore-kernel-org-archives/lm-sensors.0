From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: No sensors reported! WIth i2c-801 (intel 82801/CAM SMbus). SAGER laptop.
Message-Id: <3C9D236A.8070009@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C9C1E6E.9101676D@bnl.gov>
In-Reply-To: <3C9C1E6E.9101676D@bnl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If you have sensors then we don't support them.
Sorry. Your best bet is to find out what and where your sensors are
from the board manufacturer.
mds

David Ewan Kahana wrote:
> I'm very sorry if this is a duplicate message, but I've tried posting
> the report 3 times on the support database, and my ticket never seems
> to show up on the web page.
> 
> best regards, David Ewan Kahana <dek@bnl.gov>
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I have been working hard for a few days trying to get the
> lm_sensors running on my new laptop.
> 
> I have been disappointed to find out though that it appears
> to have no sensors attached at all (the sensors command
> reports: No sensors detected!)  despite the computer having
> a perfectly well detected, installed, and apparently
> supported by i2c-i801.o, SMBus controller (Intel 82801). The
> only device that turns up on the SMbus during sensors-detect
> is at 0x69, presumably a timer chip as pointed out in the
> documentation.  There is no message of success or failure
> for it.
> 
> It seems to me to be rather unlikely that there are no
> sensors at all since the system is a pretty new laptop. It
> has a P4 processor, and there ought to be at least a
> temperature sensor for this.  The fan turns on and off
> automatically when linux is running, depending I suppose on
> some determination of how hot the CPU is, so some on some
> level at least the system is managing this. The BIOS is some
> modified PHOENIX version and is rather uninformative about
> what's in the system. ACPI support is included, though I
> have enabled APM in the kernel for the purposes of this
> report. I've tried recompiling and installing the lm_sensors
> and the i2c with APCI enabled instead and there seems to be
> no real difference in the results I get (no sensors are
> detected either way).
> 
> I am using the modules method for i2c and lm_sensors: I have
> not not patched the kernel tree. The kernel is version
> 2.4.18 downloaded from kernel.org and recompiled
> specifically for my system, and using modules patched for
> the latest DRM support, as this was needed for the video
> card 3D support. I can include a .config if it should prove
> necessary. I haven't tried running windows yet. I preferred
> not to install it if possible, but if it can help to find
> more information I would be willing to try it, too ...
> 
> The computer is a SAGER 5620-C notebook (I found out that
> the motherboard is manufactured by CLEVO:
> http://www.clevo.com.tw/, but I have not been able to find
> any detailed information at all about the board from anyone
> I've asked, and this URL I provided is actually no help at
> all, I only include it on the off chance that someone also
> has my system).
> 
> I've included lspci output below as well as edited dmesg, so
> one can see what is included on the PCI bus.
> 
> There is a resource conflict mentioned there, having to do
> with the IDE controller. But the IDE disk and DVD are both
> working apparently with no problems. Possibly though, this
> is an issue that needs to be addressed first?
> 
> The lm_sensors version is 2.6.2, and the i2c version is also
> 2.6.2, both downloaded directly from
> 
> http://www2.lm-sensors.nu/
> 
> There was no difficulty at all with either of the builds.
> 
> I will also be happy to try to look at the motherboard if
> someone could suggest to me what to look for in the way of
> sensor chips.
> 
> If anyone has any hint at all for me to try, I would be
> most grateful!
> 
> cheers!
> 
> - - dave k.
> 
> 
> Complete output of the various requested dumps and commands
> is included below:
> 
> 
> 
> root@burster> ./sensors-detect
>  This program will help you to determine which I2C/SMBus modules you
> need to
>  load to use lm_sensors most effectively.
>  You need to have done a `make install', issued a `depmod -a' and made
> sure
>  `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
>  module path before you can use some functions of this utility. Read
>  doc/modules for more information.
>  Also, you need to be `root', or at least have access to the
> /dev/i2c[-/]* files
>  for some things. You can use prog/mkdev/mkdev.sh to create these /dev
> files
>  if you do not have them already.
>  If you have patched your kernel and have some drivers built-in you can
>  safely answer NO if asked to load some modules. In this case, things
> may
>  seem a bit confusing, but they will still work.
> 
>  IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
>  IBM Thinkpads have a severely broken i2c/SMBus implementation,  just
> scanning
>  the bus will break your thinkpad forever!
> 
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no): 
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 00:1f.3: Intel 82801CA/CAM ICH3
> Probe succesfully concluded.
> 
>  We will now try to load each adapter module in turn.
> Load `i2c-i801' (say NO if built into your kernel)? (YES/no): 
> Module loaded succesfully.
>  Do you now want to be prompted for non-detectable adapters? (yes/NO): 
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
>  i2c-dev is not loaded. Do you want to load it now? (YES/no): 
>  Module loaded succesfully.
> 
>  We are now going to do the adapter probings. Some adapters may hang
> halfway
>  through; we can't really help that. Also, some chips will be double
> detected;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address, you
> can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
> 
> Next adapter: SMBus I801 adapter at 1100 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively): 
> Client found at address 0x69
> 
>  Some chips are also accessible through the ISA bus. ISA probes are
>  typically a bit more dangerous, as we have to write to I/O ports to do
>  this.  Do you want to scan the ISA bus? (YES/no): 
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
> Probing for `Winbond W83697HF'
>   Trying address 0x0290... Failed!
> Probing for `Silicon Integrated Systems SIS5595'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT 82C686 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'
>   Trying address 0x0290... Failed!
> 
>  Now follows a summary of the probes I have just done.
>  Just press ENTER to continue: 
> 
> 
>  I will now generate the commands needed to load the I2C modules.
>  Sometimes, a chip is available both through the ISA bus and an I2C bus.
>  ISA bus access is faster, but you need to load an additional driver
> module
>  for it. If you have the choice, do you want to use the ISA bus or the
>  I2C/SMBus (ISA/smbus)? smbus
> 
> WARNING! If you have some things built into your kernel, the 
> below list will contain too many modules. Skip the appropriate ones!
> To load everything that is needed, add this to some /etc/rc* file:
> 
> #----cut here----
> # I2C adapter drivers
> # I2C chip drivers
> #----cut here----
> 
> To make the sensors modules behave correctly, add these lines to either
> /etc/modules.conf or /etc/conf.modules:
> 
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
> 
> 
> /*** I DID AS SUGGESTED HERE ***/
> 
> -
> ------------------------------------------------------------------------------------------------
> 
> Modules installed after running sensors-detect:
> 
> root@burster> lsmod
> Module                  Size  Used by
> i2c-proc                6192   0  (autoclean) (unused)
> i2c-dev                 3648   0 
> i2c-i801                4592   0 
> i2c-core               12992   0  [i2c-proc i2c-dev i2c-i801]
> soundcore               3984   0  (autoclean)
> radeon                 45312   0 
> drmlib                 47872   0  [radeon]
> mousedev                4032   0  (unused)
> hid                    18336   0  (unused)
> input                   3488   0  [mousedev hid]
> pcmcia_core            40480   0 
> 8139too                17632   1  (autoclean)
> 
> -
> --------------------------------------------------------------------------------------------------
> 
> root@burster> cat demsg.out
> Linux version 2.4.18 (root@burster) (gcc version 2.95.3 20010315 (SuSE))
> #2 Tue Mar 19 11:55:04 EST 2002
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
>  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
>  BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
>  BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
>  BIOS-e820: 000000000ff00000 - 000000000ff80000 (usable)
>  BIOS-e820: 000000000ff80000 - 0000000010000000 (reserved)
>  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
>  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
> 
> No local APIC present or hardware disabled
> Detected 1595.308 MHz processor.
> 
> PCI: PCI BIOS revision 2.10 entry at 0xfd9c0, last bus=2
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> Unknown bridge resource 2: assuming transparent
> PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> 
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
> Starting kswapd
> ACPI: APM is already active, exiting
> 
> PCI: Found IRQ 11 for device 00:1f.6
> PCI: Sharing IRQ 11 with 00:1f.3
> PCI: Sharing IRQ 11 with 00:1f.5
> 
> PCI: Device 00:1f.1 not available because of resource collisions
> PIIX4: chipset revision 2
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
> 
> hda: FUJITSU MHM2200AT, ATA DISK drive
> hdc: TOSHIBA DVD-ROM SD-C2512, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS$32/255/63,
> UDMA(66)
> hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> 
> agpgart: Maximum main memory to use for agp memory: 203M
> agpgart: Detected Intel i845 chipset
> agpgart: AGP aperture is 64M @ 0xec000000
> 
> PCI: Found IRQ 11 for device 00:1d.0
> PCI: Sharing IRQ 11 with 02:04.0
> PCI: Setting latency timer of device 00:1d.0 to 64
> uhci.c: USB UHCI at I/O 0x1800, IRQ 11
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> PCI: Assigned IRQ 9 for device 00:1d.1
> PCI: Sharing IRQ 9 with 02:06.0
> PCI: Setting latency timer of device 00:1d.1 to 64
> uhci.c: USB UHCI at I/O 0x1820, IRQ 9
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected
> 
> 8139too Fast Ethernet driver 0.9.24
> PCI: Found IRQ 9 for device 02:06.0
> PCI: Sharing IRQ 9 with 00:1d.1
> eth0: RealTek RTL8139 Fast Ethernet at 0xd083e800, 00:90:f5:0e:24:56,
> IRQ 9
> eth0:  Identified 8139 chip type 'RTL-8139C'
> eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
> Linux Kernel Card Services 3.1.22
>   options:  [pci] [cardbus] [pm]
> ds: no socket drivers loaded!
> usb.c: registered new driver hiddev
> usb.c: registered new driver hid
> hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
> hid-core.c: USB HID support drivers
> mice: PS/2 mouse device common for all mice
> [drm] AGP 0.99 on Unknown @ 0xec000000 64MB
> [drm] Initialized radeon 1.0.0 20010105 on minor 63
> eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
> 
> /** PRODUCED DURING sensors-detect **/
> i2c-core.o: i2c core module
> i2c-i801.o version 2.6.2 (20011118)
> i2c-core.o: adapter SMBus I801 adapter at 1100 registered as adapter 0.
> i2c-i801.o: I801 bus detected and initialized
> i2c-dev.o: i2c /dev entries driver module
> i2c-core.o: driver i2c-dev dummy driver registered.
> i2c-dev.o: Registered 'SMBus I801 adapter at 1100' as minor 0
> i2c-proc.o version 2.6.1 (20010825)
> 
> -
> ---------------------------------------------------------------------------------------
> 
> 
> root@burster> lspci -v > lspci.out; cat lspci.out
> 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host
> Bridge (rev 04)
> 	Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
> 	Flags: bus master, fast devsel, latency 0
> 	Memory at ec000000 (32-bit, prefetchable) [sizedM]
> 	Capabilities: [e4] #09 [d104]
> 	Capabilities: [a0] AGP version 2.0
> 
> 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge
> (rev 04) (prog-if 00 [Normal decode])
> 	Flags: bus master, 66Mhz, fast devsel, latency 96
> 	Bus: primary , secondary, subordinate, sec-latencyd
> 	I/O behind bridge: 00003000-00003fff
> 	Memory behind bridge: e8100000-e81fffff
> 	Prefetchable memory behind bridge: f0000000-f7ffffff
> 
> 00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02)
> (prog-if 00 [UHCI])
> 	Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
> 	Flags: bus master, medium devsel, latency 0, IRQ 11
> 	I/O ports at 1800 [size2]
> 
> 00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02)
> (prog-if 00 [UHCI])
> 	Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
> 	Flags: bus master, medium devsel, latency 0, IRQ 9
> 	I/O ports at 1820 [size2]
> 
> 00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
> (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary , secondary, subordinate, sec-latencyd
> 	I/O behind bridge: 00004000-00004fff
> 	Memory behind bridge: e8200000-e82fffff
> 
> 00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
> 	Flags: bus master, medium devsel, latency 0
> 
> 00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if
> 8a [Master SecP PriP])
> 	Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
> 	Flags: bus master, medium devsel, latency 0
> 	I/O ports at <unassigned> [size=8]
> 	I/O ports at <unassigned> [size=4]
> 	I/O ports at <unassigned> [size=8]
> 	I/O ports at <unassigned> [size=4]
> 	I/O ports at 1860 [size]
> 	Memory at 10000000 (32-bit, non-prefetchable) [disabled] [size=1K]
> 
> 00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
> 	Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
> 	Flags: medium devsel, IRQ 11
> 	I/O ports at 1100 [size2]
> 
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio
> (rev 02)
> 	Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
> 	Flags: bus master, medium devsel, latency 0, IRQ 11
> 	I/O ports at 1c00 [size%6]
> 	I/O ports at 18c0 [sized]
> 
> 00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02) (prog-if 00
> [Generic])
> 	Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
> 	Flags: bus master, medium devsel, latency 0, IRQ 11
> 	I/O ports at 2400 [size%6]
> 	I/O ports at 2000 [size8]
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility
> M6 LW (prog-if 00 [VGA])
> 	Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
> 	Flags: stepping, fast Back2Back, 66Mhz, medium devsel, IRQ 11
> 	Memory at f0000000 (32-bit, prefetchable) [size8M]
> 	I/O ports at 3000 [size%6]
> 	Memory at e8100000 (32-bit, non-prefetchable) [sizedK]
> 	Expansion ROM at <unassigned> [disabled] [size8K]
> 	Capabilities: [58] AGP version 2.0
> 	Capabilities: [50] Power Management version 2
> 
> 02:04.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8023
> (prog-if 10 [OHCI])
> 	Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
> 	Flags: bus master, medium devsel, latency 64, IRQ 11
> 	Memory at e8204000 (32-bit, non-prefetchable) [size=2K]
> 	Memory at e8200000 (32-bit, non-prefetchable) [sizeK]
> 	Capabilities: [44] Power Management version 2
> 
> 02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
> (rev 10)
> 	Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
> 	Flags: bus master, medium devsel, latency 64, IRQ 9
> 	I/O ports at 4000 [size%6]
> 	Memory at e8204800 (32-bit, non-prefetchable) [size%6]
> 	Capabilities: [50] Power Management version 2
> 
> 02:07.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
> Controller (rev 01)
> 	Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
> 	Flags: medium devsel
> 	Memory at e8205000 (32-bit, non-prefetchable) [disabled] [size=4K]
> 	Bus: primary, secondary, subordinate, sec-latencyd
> 	I/O window 0: 00000000-00000003 [disabled]
> 	I/O window 1: 00000000-00000003 [disabled]
> 	16-bit legacy interface ports at 0001
> 
> -
> ------------------------------------------------------------------------------
> 
> root@burster:/home/dkahana/lm_sensors-2.6.2/prog/dump > ./i2cdump 0 0x69
> b
>   WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
>   I will probe file /dev/i2c-0, address 0x69, mode byte
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> 10: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> 20: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> 30: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> 40: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> 50: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> 60: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> 70: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> 80: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> 90: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> a0: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> b0: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> c0: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> d0: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> e0: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> f0: 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 
> 
> -
> ----------------------------------------------------------------------------
> This scan seems a bit more interesting.
> 
> root@burster:/home/dkahana/lm_sensors-2.6.2/prog/dump > ./i2cdump 0 0x69
> s
>   WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
>   I will probe file /dev/i2c-0, address 0x69, mode smbus block
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 99 87 7f c7 3f 00 08 00 XX XX XX XX XX XX XX XX 
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 
> -
> ---------------------------------------------------------------------------------
> 
> root@burster> ./isadump 0x295 0x296 
>   WARNING! Running this program can cause system crashes, data loss and
> worse!
>   I will probe address register 0x0295 and data register 0x0296.
>   You have five seconds to reconsider and press CTRL-C!
> 
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
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.6 (GNU/Linux)
> Comment: For info see http://www.gnupg.org
> 
> iD8DBQE8nBxjzLVudks1kJkRAuYJAJ4h4eUYq/k6tS7QywAWqzDAxCVLuwCdFKqv
> 3TVQmhDQimpSotg3Un+ef8M> =rmqh
> -----END PGP SIGNATURE-----
> 


