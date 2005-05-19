From: cat@zip.com.au (CaT)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: Sensors whackyness under 2.6.x
Message-Id: <20030911074145.GA533@zip.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030815110924.GC501@zip.com.au>
In-Reply-To: <20030815110924.GC501@zip.com.au>
To: lm-sensors@vger.kernel.org

On Fri, Aug 29, 2003 at 06:29:58PM +0200, Jean Delvare wrote:
> > > I would like you to try with i2c-CVS and lm_sensors-CVS. We made a
> > > change to the i2c-piix4 driver recently that could influence your
> > > problem. Download instructions are to be found here:
> > > http://secure.netroedge.com/~lm78/download.html#cvs
> > 
> > Do you still want me to do this?
> 
> Sure I want.

Ok. Here it is. And I have a new PC (an AMD, totally different from the
laptop) that also has the adm1021 sensor and that is also broken. More
on that later.

First, nothing really changed with the sensors stuff with the current
cvs copy (current as of about 12hrs ago). The end result is a complete
slowdown of the system and whacky results from the sensor. What follows
is a screen text log of the session and then the dmesg output. The bits
beginning with '>>> ' are my comments. Please note there are 3 sets of
these. The first is using the sensors via SMBus, the 2nd via ISA and 3rd
is for the AMD system.

The log of the session:

---8<---
This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): PTLTD 
 Could not find dmidecode, which should have been installed with lm_sensors.
 Runing dmidecode would help us determining your system vendor, which allows
 safer operations. Please provide one of the following:
  /usr/local/sbin/dmidecode
  /usr/sbin/dmidecode
 You can still go on, but you are encouraged to fix the problem first.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:07.3: Intel 82371AB PIIX4 ACPI
Use driver `to-be-written' for device 01:01.0: S3 Savage IX MV
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no): 
Module loaded succesfully.
Load `to-be-written' (say NO if built into your kernel)? (YES/no): 
modprobe: Can't locate module to-be-written
Loading failed... skipping.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): 
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): 
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus PIIX4 adapter at 2180 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x1f
Probing for `Maxim MAX6650/MAX6651'... Success!
    (confidence 4, driver `max6650')
Client found at address 0x30
Client found at address 0x4d
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Success!
    (confidence 6, driver `adm1021')
Probing for `National Semiconductor LM84'... Failed!
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x69

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): 
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Some Super I/O chips may also contain sensors. Super I/O probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan for Super I/O sensors? (YES/no): 
Probing for `SMSC 47M1xx Super IO Fan Sensors'
  Failed!
Probing for `VT1211 Super IO Sensors'
  Failed!
Probing for `Winbond W83627HF Super IO Sensors'
  Failed!
Probing for `Winbond W83627THF Super IO Sensors'
  Failed!
Probing for `Winbond W83697HF Super IO Sensors'
  Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 

Driver `max6650' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 2180' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x1f
    Chip `Maxim MAX6650/MAX6651' (confidence: 4)

Driver `adm1021' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 2180' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x4d
    Chip `TI THMC10' (confidence: 6)
  Misdetects:
  * Bus `SMBus PIIX4 adapter at 2180' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x4d
    Chip `Maxim MAX1617' (confidence: 3)

Driver `pcf8591' (may not be inserted):
  Misdetects:
  * Bus `SMBus PIIX4 adapter at 2180' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x4d
    Chip `Philips Semiconductors PCF8591' (confidence: 1)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 2180' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? smbus

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
options adm1021 ignore=0,0x4d
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-piix4
# I2C chip drivers
modprobe max6650
modprobe adm1021
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): 
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
0 [16:45:29] root@theirongiant:/root>> modprobe i2c-piix4
0 [16:46:09] root@theirongiant:/root>> lsmod
Module                  Size  Used by    Not tainted
i2c-dev                 3648   0 
i2c-piix4               4992   0 
dmi_scan                1604   0  [i2c-piix4]
i2c-core               14464   0  [i2c-dev i2c-piix4]
0 [16:46:11] root@theirongiant:/root>> lsmodmodprobe i2c-piix4[Ksensors 
modprobe: Can't locate module sensor
0 [16:46:15] root@theirongiant:/root>> modprobe sensors
modprobe: Can't locate module sensors
0 [16:46:16] root@theirongiant:/root>> modprobe sensors[Kadm1021
0 [16:46:24] root@theirongiant:/root>> modprobe adm1021sensors[K[10Plsmod
Module                  Size  Used by    Not tainted
adm1021                 5728   0  (unused)
i2c-proc                6016   0  [adm1021]
i2c-dev                 3648   0 
i2c-piix4               4992   0 
dmi_scan                1604   0  [i2c-piix4]
i2c-core               14464   0  [adm1021 i2c-proc i2c-dev i2c-piix4]
0 [16:46:28] root@theirongiant:/root>> senso
sensors         sensors-detect  
0 [16:46:28] root@theirongiant:/root>> sensors
Could not locate or open config file!
0 [16:46:35] root@theirongiant:/root>> sensors -f /usr/local/lmsensors/etc/sensors.conf 
Parse error in chip name `/usr/local/lmsensors/etc/sensors.conf'
Try `sensors -h' for more information
0 [16:46:41] root@theirongiant:/root>> sensors -f /usr/local/lmsensors/etc/sensors.conf [K[K-h
Usage: sensors [OPTION]... [CHIP]...
  -c, --config-file     Specify a config file
  -h, --help            Display this help text
  -s, --set             Execute `set' statements too (root only)
  -f, --fahrenheit      Show temperatures in degrees fahrenheit
  -A, --no-adapter      Do not show adapter and algorithm for each chip
  -u, --unknown         Treat chips as unknown ones (testing only)
  -v, --version         Display the program version

By default, a list of directories is examined for config file `sensors.conf'.
Use `-' after `-c' to read the config file from stdin.
If no chips are specified, all chip info will be printed.
Example chip names:
	lm78-i2c-0-2d	*-i2c-0-2d
	lm78-i2c-0-*	*-i2c-0-*
	lm78-i2c-*-2d	*-i2c-*-2d
	lm78-i2c-*-*	*-i2c-*-*
	lm78-isa-0290	*-isa-0290
	lm78-isa-*	*-isa-*
	lm78-*
0 [16:46:46] root@theirongiant:/root>> sensors -hf /usr/local/lmsensors/etc/sensors.conf sensors -f /u[1P[1@c
thmc10-i2c-0-4d
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
Board:       +53?C  (low =  +20?C, high =  +60?C)        
CPU:         +52?C  (low =  +20?C, high =  +60?C)        

0 [16:46:52] root@theirongiant:/root>> sensors -c /usr/local/lmsensors/etc/sensors.conf [1@w[1@h[1@i[1@l[1@e[1@ [1@t[1@r[1@u[1@e[1@;[1@ [1@d[1@o[1@ sensors -c /usr/local/lmsensors/etc/sensors.conf  ; sleep 10; done
>>> as I type the above, the system slows
thmc10-i2c-0-4d
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
Board:      -101?C  (low = -101?C, high = -101?C)        
CPU:        -101?C  (low = -101?C, high =  +60?C)        ALARM (HIGH)


 [16:47:04] root@theirongiant:/root>> while true; do sensors -c /usr/local/lmsensors/etc/sensors.conf; sleep 10; done[1@ [1P[1P
thmc10-i2c-0-4d
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
Board:      -101?C  (low =  +20?C, high = -101?C)        
CPU:        -101?C  (low =  +20?C, high = -101?C)        ALARM (LOW,HIGH)

thmc10-i2c-0-4d
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
Board:      -101?C  (low =  +20?C, high = -101?C)        
CPU:        -101?C  (low =  +20?C, high = -101?C)        ALARM (LOW,HIGH)

thmc10-i2c-0-4d
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
Board:      -101?C  (low = -101?C, high = -101?C)        
CPU:         +83?C  (low =  +20?C, high = -101?C)        ALARM (LOW,HIGH)


0 [16:47:08] root@theirongiant:/root>> while true; do sensors -c /usr/local/lmsensors/etc/sensors.conf; sleep 1; done[Kdate; done
thmc10-i2c-0-4d
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
Board:      -101?C  (low = -101?C, high = -101?C)        
CPU:         +83?C  (low =  +20?C, high = -101?C)        ALARM (LOW,HIGH)

Thu Sep 11 16:47:09 EST 2003
thmc10-i2c-0-4d
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
Board:      -101?C  (low = -101?C, high =  +60?C)        
CPU:         +88?C  (low = -101?C, high = -101?C)        ALARM (LOW,HIGH)

Thu Sep 11 16:47:11 EST 2003
>>> even though the time indicates 1-2seconds have passed, in reality a HELL
>>> of a lot more time has passed
thmc10-i2c-0-4d
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
Board:      -101?C  (low = -101?C, high =  +60?C)        
CPU:         +88?C  (low = -101?C, high = -101?C)        ALARM (LOW,HIGH)
---8<---

serial console log:

---8<---
Connecting to /dev/ttyS1, speed 115200.
The escape character is Ctrl-\ (ASCII 28, FS)
Type the escape character followed by C to get back,
or followed by ? to see other options.
----------------------------------------------------
Linux version 2.4.22 (root@theirongiant) (gcc version 2.95.4 20011002 (Debian prerelease)) #4 Thu Sep 11 16:38:59 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e5c00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
 BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6bb0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040006  LTP 0x00000000) @ 0x0fff9eb9
ACPI: FADT (v001 GATEWA SOLO5300 0x06040006 PTL  0x000f4240) @ 0x0ffffb8c
ACPI: DSDT (v001 GATEWA SOLO5300 0x06040006 MSFT 0x0100000b) @ 0x00000000
Kernel command line: BOOT_IMAGE=t24 ro root06 video=mtrr console=ttyS0,115200n8 console=tty0 acpi=force PS_SYSTEM_MAP=/boot/System.test
Initializing CPU#0
Detected 701.593 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1399.19 BogoMIPS
Memory: 255832k/262080k available (1904k kernel code, 5860k reserved, 745k data, 104k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030813
PCI: PCI BIOS revision 2.10 entry at 0xfd96e, last bus=1
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:............................................................................................................
Table [DSDT](id F004) - 551 Objects with 49 Devices 108 Methods 27 Regions
ACPI Namespace successfully loaded at root c03c389c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000800C on int 9
Completing Region/Field/Buffer/Package initialization:.................................................................................................
Initialized 27/27 Regions 4/4 Fields 31/31 Buffers 35/35 Packages (559 nodes)
Executing all Device _STA and_INI methods:....[ACPI Debug] String: ISA_INI
[ACPI Debug] String: LPT Decode Enabled At Boot
[ACPI Debug] Integer: 0000000000000378
[ACPI Debug] String: COM1 Decode Enabled At Boot
[ACPI Debug] Integer: 00000000000003F8
[ACPI Debug] String: FDC Decode Enabled At Boot
[ACPI Debug] Integer: 00000000000003F0
[ACPI Debug] String: General-Purpose Decode #12 Enabled At Boot
[ACPI Debug] Integer: 000000000000FE00
[ACPI Debug] String: General-Purpose Decode #13 Enabled At Boot
[ACPI Debug] Integer: 0000000000000398
..................................[ACPI Debug] String: MOON_2 Status
.....
45 Devices found containing: 45 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4bios S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
[ACPI Debug] Buffer: Length 06
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 10, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 11, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: Embedded Controller [EC0] (gpe 9)
[ACPI Debug] String: MOON_2 Status
evregion-0345: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0422 [21] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.AC0_._STA] (Node c12ec484), AE_BAD_PARAMETER
evregion-0345: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0422 [21] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node c12ec8c4), AE_BAD_PARAMETER
evregion-0345: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0422 [21] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.BAT1._STA] (Node c12ecf24), AE_BAD_PARAMETER
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
[ACPI Debug] Buffer: Length 06
[ACPI Debug] Buffer: Length 06
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
vesafb: framebuffer at 0xf0000000, mapped to 0xd0819000, size 3072k
vesafb: mode is 1024x768x16, linelength 48, pages=4
vesafb: protected mode interface info at c000:88db
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
PCI: Enabling device 00:0d.1 (0000 -> 0003)
Redundant entry in serial pci_table.  Please send the output of
lspci -vv, this message (115d,00d3,8086,2411)
and the manufacturer and name of serial board or modem board
to serial-pci-info@lists.sourceforge.net.
register_serial(): autoconfig failed
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xec000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1040-0x1047, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1048-0x104f, BIOS settings: hdc:pio, hdd:pio
hda: IC25N020ATCS04-0, ATA DISK drive
blk: queue c03dca80, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS%84/240/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
maestro3: version 1.23 built at 16:18:54 Sep 11 2003
PCI: Enabling device 00:0c.0 (0000 -> 0003)
maestro3: Configuring ESS Maestro3(i)hw found at IO 0x1400 IRQ 11
maestro3:  subvendor id: 0x5300107b
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 00:08.0 (0000 -> 0002)
PCI: Enabling device 00:08.1 (0000 -> 0002)
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
Yenta IRQ list 0038, PCI irq10
Socket status: 30000006
Yenta IRQ list 0038, PCI irq10
Socket status: 30000006
ip6_tables: (C) 2000-2002 Netfilter core team
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
..
i2c-core.o: i2c core module version 2.8.0 (20030714)
i2c-piix4.o version 2.8.0 (20030714)
Found Intel Corp. 82371AB/EB/MB PIIX4 ACPI device
dmi_scan.o version 2.8.0 (20030714)
dmi_scan.o: SM BIOS found
i2c-dev.o: i2c /dev entries driver module version 2.8.0 (20030714)
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-proc.o version 2.8.0 (20030714)
adm1021.o version 2.8.0 (20030714)
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
Starting adm1021 update
Starting adm1021 update
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : Emergency Sync
Syncing device 03:06 ... OK
Syncing device 03:02 ... OK
Syncing device 03:07 ... OK
Syncing device 03:08 ... OK
Syncing device 03:09 ... OK
Syncing device 03:0a ... OK
Syncing device 03:01 ... OK
>>> the syncs are about .5 to 1 second apart - the system is -slow-
Done.
Starting adm1021 update
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : Emergency Sync
Syncing device 03:06 ... OK
Syncing device 03:02 ... OK
Syncing device 03:07 ... OK
Syncing device 03:08 ... OK
Syncing device 03:09 ... OK
Syncing device 03:0a ... OK
Syncing device 03:01 ... OK
Done.
Starting adm1021 update
SysRq : Emergency Sync
Syncing device 03:06 ... OK
Syncing device 03:02 ... OK
Syncing device 03:07 ... OK
Syncing device 03:08 ... OK
Syncing device 03:09 ... OK
Syncing device 03:0a ... OK
Syncing device 03:01 ... OK
Done.
SysRq : Emergency Sync
Syncing device 03:06 ... OK
Syncing device 03:02 ... OK
Syncing device 03:07 ... OK
Syncing device 03:08 ... OK
Syncing device 03:09 ... OK
Syncing device 03:0a ... OK
Syncing device 03:01 ... OK
Done.
Starting adm1021 update
SysRq : Emergency Sync
Syncing device 03:06 ... <6>SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : Emergency Sync
OK
Syncing device 03:02 ... OK
Syncing device 03:07 ... OK
Syncing device 03:08 ... OK
Syncing device 03:09 ... OK
Syncing device 03:0a ... OK
Syncing device 03:01 ... OK
Done.
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmount 
SysRq : Emergency Sync
Syncing device 03:06 ... OK
Syncing device 03:02 ... OK
Syncing device 03:07 ... OK
Syncing device 03:08 ... OK
Syncing device 03:09 ... OK
Syncing device 03:0a ... OK
Syncing device 03:01 ... OK
Done.
Starting adm1021 update

>>> at this point I gave up and powercycled my laptop after c-a-d failed to do
>>> much of anything - good thing too as the cpu was overheating

---8<---

After the reboot I try again, this time telling lmsensors to use the ISA
bus for its readings. In this case, no slowdown and everything is rosy.

session text log:

--- 8< ---
0 [16:58:10] root@theirongiant:/root>> 
0 [16:58:11] root@theirongiant:/root>> 
0 [16:58:12] root@theirongiant:/root>> sens
sensible-editor  sensible-pager   sensors          sensors-detect   
0 [16:58:12] root@theirongiant:/root>> senso
sensors         sensors-detect  
0 [16:58:12] root@theirongiant:/root>> sensors-detect 

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): PTLTD 
 Could not find dmidecode, which should have been installed with lm_sensors.
 Runing dmidecode would help us determining your system vendor, which allows
 safer operations. Please provide one of the following:
  /usr/local/sbin/dmidecode
  /usr/sbin/dmidecode
 You can still go on, but you are encouraged to fix the problem first.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:07.3: Intel 82371AB PIIX4 ACPI
Use driver `to-be-written' for device 01:01.0: S3 Savage IX MV
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no): 
Module loaded succesfully.
Load `to-be-written' (say NO if built into your kernel)? (YES/no): 
modprobe: Can't locate module to-be-written
Loading failed... skipping.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): 
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): 
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus PIIX4 adapter at 2180 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x1f
Probing for `Maxim MAX6650/MAX6651'... Success!
    (confidence 4, driver `max6650')
Client found at address 0x30
Client found at address 0x4d
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Success!
    (confidence 6, driver `adm1021')
Probing for `National Semiconductor LM84'... Failed!
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x69

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): 
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Some Super I/O chips may also contain sensors. Super I/O probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan for Super I/O sensors? (YES/no): 
Probing for `SMSC 47M1xx Super IO Fan Sensors'
  Failed!
Probing for `VT1211 Super IO Sensors'
  Failed!
Probing for `Winbond W83627HF Super IO Sensors'
  Failed!
Probing for `Winbond W83627THF Super IO Sensors'
  Failed!
Probing for `Winbond W83697HF Super IO Sensors'
  Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 

Driver `max6650' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 2180' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x1f
    Chip `Maxim MAX6650/MAX6651' (confidence: 4)

Driver `adm1021' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 2180' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x4d
    Chip `TI THMC10' (confidence: 6)
  Misdetects:
  * Bus `SMBus PIIX4 adapter at 2180' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x4d
    Chip `Maxim MAX1617' (confidence: 3)

Driver `pcf8591' (may not be inserted):
  Misdetects:
  * Bus `SMBus PIIX4 adapter at 2180' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x4d
    Chip `Philips Semiconductors PCF8591' (confidence: 1)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 2180' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? ISA

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
options adm1021 ignore=0,0x4d
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-piix4
# I2C chip drivers
modprobe max6650
modprobe adm1021
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): no

0 [16:59:01] root@theirongiant:/root>> modprobe i2c-piix4
0 [16:59:13] root@theirongiant:/root>> 
[17P(reverse-i-search)`': w': chown hogarth.users . -Rc[7Ph': ll `which umount`[1@i': ll `
[25Pll `
0 [16:59:18] root@theirongiant:/root>> while true; do date; /usr/local/lmsensors/bin/sensors -c /usr/local/lmsensors/etc/sensors.
.conf  ; sleep 1; doneMeirongiant:/root>> #while true; do date; /usr/local/lmsensors/bin/sensors -c /usr/local/lmsensors/etc/sensors[1@.M[16:59:18] root@theirongiant:/root>> #

0 [16:59:41] root@theirongiant:/root>> #while true; do date; /usr/local/lmsensors/bin/sensors -c /usr/local/lmsensors/etc/sensors
s.conf; sleep 1; doneMirongiant:/root>> modprobe i2c-piix4[K

[KM0 [16:59:41] root@theirongiant:/root>> modprobe i2c-piix4[Kmax6650
0 [16:59:46] root@theirongiant:/root>> modprobe max6650[Kadm1021
0 [16:59:54] root@theirongiant:/root>> modprobe adm1021max6650#while true; do date; /usr/local/lmsensors/bin/sensors -c /usr/local/lmsensors/etc/sensors
s.conf; sleep 1; doneMirongiant:/root>> #while true; do date; /usr/local/lmsensors/bin/sensors -c /usr/local/lmsensors/etc/sensors.[1PM [16:59:54] root@theirongiant:/root>> 

Thu Sep 11 16:59:59 EST 2003
max6650-i2c-0-1f
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
fan1:     configured 6614 RPM, actual  960 RPM.
fan2:        0 RPM  
fan3:      960 RPM  
fan4:        0 RPM  

thmc10-i2c-0-4d
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
Board:       +60?C  (low =  +20?C, high =  +60?C)        
CPU:         +58?C  (low =  +20?C, high =  +60?C)        

Thu Sep 11 17:00:01 EST 2003
max6650-i2c-0-1f
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
fan1:     configured 6614 RPM, actual  960 RPM.
fan2:        0 RPM  
fan3:      960 RPM  
fan4:        0 RPM  

thmc10-i2c-0-4d
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
Board:       +60?C  (low =  +20?C, high =  +60?C)        
CPU:         +58?C  (low =  +20?C, high =  +60?C)        

..
Thu Sep 11 17:03:32 EST 2003
max6650-i2c-0-1f
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
fan1:     configured 6614 RPM, actual  960 RPM.
fan2:        0 RPM  
fan3:      960 RPM  
fan4:        0 RPM  

thmc10-i2c-0-4d
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
Board:       +51?C  (low =  +20?C, high =  +60?C)        
CPU:         +50?C  (low =  +20?C, high =  +60?C)        

Thu Sep 11 17:03:42 EST 2003
max6650-i2c-0-1f
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
fan1:     configured 6614 RPM, actual  960 RPM.
fan2:        0 RPM  
fan3:      960 RPM  
fan4:        0 RPM  

thmc10-i2c-0-4d
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
Board:       +51?C  (low =  +20?C, high =  +60?C)        
CPU:         +50?C  (low =  +20?C, high =  +60?C)        

Thu Sep 11 17:03:52 EST 2003
max6650-i2c-0-1f
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
fan1:     configured 6614 RPM, actual  960 RPM.
fan2:        0 RPM  
fan3:      960 RPM  
fan4:        0 RPM  

thmc10-i2c-0-4d
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
Board:       +51?C  (low =  +20?C, high =  +60?C)        
CPU:         +49?C  (low =  +20?C, high =  +60?C)        

--- 8< ---

serial console output:

--- 8< ---
..
i2c-core.o: i2c core module version 2.8.0 (20030714)
i2c-piix4.o version 2.8.0 (20030714)
Found Intel Corp. 82371AB/EB/MB PIIX4 ACPI device
dmi_scan.o version 2.8.0 (20030714)
dmi_scan.o: SM BIOS found
i2c-dev.o: i2c /dev entries driver module version 2.8.0 (20030714)
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-proc.o version 2.8.0 (20030714)
max6650.o version 2.8.0 (20030714)
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
adm1021.o version 2.8.0 (20030714)
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
i2c-piix4.o: Error: no response!
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
max6650.o: Updating max6650 data.
Starting adm1021 update
--- 8< ---

And now for the AMD system. This exhibits different problems in that it
doesn't slow the system down any, but the readings given are static (ie
no updates) in both 2.4 and 2.6 series kernels.

screen text log:

--- 8< ---
[KM0 [17:17:49] root@lexx:/root>> sensors-detect 

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): Nvidia
 Could not find dmidecode, which should have been installed with lm_sensors.
 Runing dmidecode would help us determining your system vendor, which allows
 safer operations. Please provide one of the following:
  /usr/local/sbin/dmidecode
  /usr/sbin/dmidecode
 You can still go on, but you are encouraged to fix the problem first.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce2 SMBus (MCP)
Use driver `rivatv' for device 03:00.0: GeForce2 MX
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-nforce2' (say NO if built into your kernel)? (YES/no): 
Module loaded succesfully.
Load `rivatv' (say NO if built into your kernel)? (YES/no): 
modprobe: Can't locate module rivatv
Loading failed... skipping.
** Note: rivatv module is available at http://rivatv.sourceforge.net/
 Do you now want to be prompted for non-detectable adapters? (yes/NO): 
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): 
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus nForce2 adapter at 1c00 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x08
Client found at address 0x30
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!

Next adapter: SMBus nForce2 adapter at 2000 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x00
Client found at address 0x08
Client found at address 0x4e
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): no

 Some Super I/O chips may also contain sensors. Super I/O probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan for Super I/O sensors? (YES/no): 
Probing for `SMSC 47M1xx Super IO Fan Sensors'
  Failed!
Probing for `VT1211 Super IO Sensors'
  Failed!
Probing for `Winbond W83627HF Super IO Sensors'
  Failed!
Probing for `Winbond W83627THF Super IO Sensors'
  Failed!
Probing for `Winbond W83697HF Super IO Sensors'
  Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 1c00' (Non-I2C SMBus adapter)
    Busdriver `i2c-nforce2', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)

Driver `adm1021' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 2000' (Non-I2C SMBus adapter)
    Busdriver `i2c-nforce2', I2C address 0x4e
    Chip `National Semiconductor LM84' (confidence: 6)
  Misdetects:
  * Bus `SMBus nForce2 adapter at 2000' (Non-I2C SMBus adapter)
    Busdriver `i2c-nforce2', I2C address 0x4e
    Chip `Maxim MAX1617' (confidence: 3)

Driver `pcf8591' (may not be inserted):
  Misdetects:
  * Bus `SMBus nForce2 adapter at 2000' (Non-I2C SMBus adapter)
    Busdriver `i2c-nforce2', I2C address 0x4e
    Chip `Philips Semiconductors PCF8591' (confidence: 1)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? smbus

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
options adm1021 ignore=1,0x4e
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-nforce2
# I2C chip drivers
modprobe eeprom
modprobe adm1021
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO): 
0 [17:18:33] root@lexx:/root>> modprobe i2c-nforce2
0 [17:18:44] root@lexx:/root>> modprobe i2c-nforce2[Kadm1021
0 [17:18:48] root@lexx:/root>> sensors
Could not locate or open config file!
0 [17:18:51] root@lexx:/root>> sensors -c /usr/local/lmsensors/etc/sensors.conf  
M
lm84-i2c-1-4e
Adapter: SMBus nForce2 adapter at 2000
Algorithm: Non-I2C SMBus adapter
Board:       +38?C  (low =  +15?C, high = -128?C)        
CPU:          +8?C  (low =   +0?C, high = -128?C)        

0 [17:18:57] root@lexx:/root>> sensors -c /usr/local/lmsensors/etc/sensors.conf  
M
lm84-i2c-1-4e
Adapter: SMBus nForce2 adapter at 2000
Algorithm: Non-I2C SMBus adapter
Board:       +38?C  (low =  +15?C, high = -128?C)        
CPU:          +8?C  (low =   +0?C, high = -128?C)        

0 [17:19:03] root@lexx:/root>> sensors -c /usr/local/lmsensors/etc/sensors.conf  
M
lm84-i2c-1-4e
Adapter: SMBus nForce2 adapter at 2000
Algorithm: Non-I2C SMBus adapter
Board:       +38?C  (low =  +15?C, high = -128?C)        
CPU:          +8?C  (low =   +0?C, high = -128?C)        

0 [17:19:13] root@lexx:/root>> sensors -c /usr/local/lmsensors/etc/sensors.conf  
M
lm84-i2c-1-4e
Adapter: SMBus nForce2 adapter at 2000
Algorithm: Non-I2C SMBus adapter
Board:       +38?C  (low =  +15?C, high = -128?C)        
CPU:          +8?C  (low =   +0?C, high = -128?C)        

0 [17:19:15] root@lexx:/root>> sensors -c /usr/local/lmsensors/etc/sensors.conf  
M
lm84-i2c-1-4e
Adapter: SMBus nForce2 adapter at 2000
Algorithm: Non-I2C SMBus adapter
Board:       +38?C  (low =  +15?C, high = -128?C)        
CPU:          +8?C  (low =   +0?C, high = -128?C)        

0 [17:19:22] root@lexx:/root>> sensors -c /usr/local/lmsensors/etc/sensors.conf  
M
lm84-i2c-1-4e
Adapter: SMBus nForce2 adapter at 2000
Algorithm: Non-I2C SMBus adapter
Board:       +38?C  (low =  +15?C, high = -128?C)        
CPU:          +8?C  (low =   +0?C, high = -128?C)        

0 [17:19:23] root@lexx:/root>> sensors -c /usr/local/lmsensors/etc/sensors.conf  
M
lm84-i2c-1-4e
Adapter: SMBus nForce2 adapter at 2000
Algorithm: Non-I2C SMBus adapter
Board:       +38?C  (low =  +15?C, high = -128?C)        
CPU:          +8?C  (low =   +0?C, high = -128?C)        

0 [17:19:24] root@lexx:/root>> sensors -c /usr/local/lmsensors/etc/sensors.conf  
M
lm84-i2c-1-4e
Adapter: SMBus nForce2 adapter at 2000
Algorithm: Non-I2C SMBus adapter
Board:       +38?C  (low =  +15?C, high = -128?C)        
CPU:          +8?C  (low =   +0?C, high = -128?C)        

0 [17:20:32] root@lexx:/root>> sensors -c /usr/local/lmsensors/etc/sensors.conf  
M
lm84-i2c-1-4e
Adapter: SMBus nForce2 adapter at 2000
Algorithm: Non-I2C SMBus adapter
Board:       +38?C  (low =  +15?C, high = -128?C)        
CPU:          +8?C  (low =   +0?C, high = -128?C)        
--- 8< ---

serial console output:

--- 8< ---
i2c-core.o: i2c core module version 2.8.0 (20030714)
i2c-nforce2.o version 2.8.0 (20030714)
i2c-nforce2.o: nForce2 SMBus adapter at 0x1c00
i2c-nforce2.o: nForce2 SMBus adapter at 0x2000
i2c-dev.o: i2c /dev entries driver module version 2.8.0 (20030714)
i2c-proc.o version 2.8.0 (20030714)
adm1021.o version 2.8.0 (20030714)
Starting adm1021 update
Starting adm1021 update
Starting adm1021 update
Starting adm1021 update
Starting adm1021 update
Starting adm1021 update
Starting adm1021 update
Starting adm1021 update
--- 8< ---

Not sure what further info I can give you. If you can think of something
then please shout. :)

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
