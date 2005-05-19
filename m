From: mablanquer@mi.madritel.es (Miguel Angel Blanquer Sierra)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: Problem with sensors
Message-Id: <1056830820.13883.10.camel@LinuxPentiumIV>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

My problem is that i2cdetect , not detect nothing. I have all i2c
modules loaded (4).

Features :

Sensors version : 2.7.0
Kernel Version : 2.4.21
MotherBoard : Asus P4C800
Sensor Chip (I think) : W83627

I attach the log files.

Thanks.
-------------- next part --------------
Linux version 2.4.21 (root@LinuxPentiumIV) (gcc versi?n 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 SMP mi? jun 25 21:21:01 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
 BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
 BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 130864
zone(0): 4096 pages.
zone(1): 126768 pages.
zone(2): 0 pages.
ACPI: Searched entire block, no RSDP was found.
ACPI: RSDP located at physical address c00f9fb0
RSD PTR  v0 [ACPIAM]
__va_range(0x1ff30000, 0x68): idx=8 mapped at ffff6000
ACPI table found: RSDT v1 [A M I  OEMRSDT  1280.774]
__va_range(0x1ff30200, 0x24): idx=8 mapped at ffff6000
__va_range(0x1ff30200, 0x81): idx=8 mapped at ffff6000
ACPI table found: FACP v2 [A M I  OEMFACP  1280.774]
__va_range(0x1ff30390, 0x24): idx=8 mapped at ffff6000
__va_range(0x1ff30390, 0x5c): idx=8 mapped at ffff6000
ACPI table found: APIC v1 [A M I  OEMAPIC  1280.774]
__va_range(0x1ff30390, 0x5c): idx=8 mapped at ffff6000
LAPIC (acpi_id[0x0001] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16

LAPIC (acpi_id[0x0002] id[0x81] enabled[0])
CPU 1 (0x8100) disabled
IOAPIC (id[0x1] address[0xfec00000] global_irq_base[0x0])
INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
2 CPUs total
Local APIC address fee00000
__va_range(0x1ff40040, 0x24): idx=8 mapped at ffff6000
__va_range(0x1ff40040, 0x3f): idx=8 mapped at ffff6000
ACPI table found: OEMB v1 [A M I  OEMBIOS  1280.774]
Enabling the CPU's according to the ACPI table
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTek  Product ID: P4C800       APIC at: 0xFEE00000
I/O APIC #1 Version 32 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 1
Kernel command line: ro root=/dev/hda3 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 2806.425 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5596.77 BogoMIPS
Memory: 515048k/523456k available (1278k kernel code, 8020k reserved, 488k data, 104k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 07
per-CPU timeslice cutoff: 1462.73 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
Setting 1 in the phys_id_present_map
..changing IO-APIC physical APIC ID to 1 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-5, 1-7, 1-10, 1-11, 1-21 not connected.
.TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 23.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................

IO APIC #1......
... register #00: 01000000
......    : physical APIC id: 01
......    : Delivery Type: 0
......    : LTS          : 0
... register #01: 00178020
......     : max redirection entries: 0017
......     : PRQ implemented: 1
......     : IO APIC version: 0020
... register #02: 00178020
......     : arbitration: 00
An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org
... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 000 00  1    0    0   0   0    0    0    00
 08 001 01  0    0    0   0   0    1    1    59
 09 001 01  0    0    0   0   0    1    1    61
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    69
 0d 001 01  0    0    0   0   0    1    1    71
 0e 001 01  0    0    0   0   0    1    1    79
 0f 001 01  0    0    0   0   0    1    1    81
 10 001 01  1    1    0   1   0    1    1    89
 11 001 01  1    1    0   1   0    1    1    89
 12 001 01  1    1    0   1   0    1    1    91
 13 001 01  1    1    0   1   0    1    1    99
 14 001 01  1    1    0   1   0    1    1    89
 15 000 00  1    0    0   0   0    0    0    00
 16 001 01  1    1    0   1   0    1    1    89
 17 001 01  1    1    0   1   0    1    1    A1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:18
IRQ6 -> 0:6
IRQ7 -> 0:19
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:16-> 0:17-> 0:20-> 0:22
IRQ11 -> 0:23
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
.... CPU clock speed is 2806.5248 MHz.
.... host bus clock speed is 133.6440 MHz.
cpu: 0, clocks: 1336440, slice: 668220
CPU0<T0:1336432,T1:668208,D:4,S:668220,C:1336440>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Using IRQ router default [8086/24d0] at 00:1f.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Unsupported Intel chipset (device id: 2578), you might want to try agp_try_unsupported=1.
agpgart: no supported devices found.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST3120022A, ATA DISK drive
blk: queue c032d880, I/O limit 4095Mb (mask 0xffffffff)
hdc: HL-DT-ST GCE-8481B, ATAPI CD/DVD-ROM drive
hdd: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS593/255/63, UDMA(100)
hdd: attached ide-cdrom driver.
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 > hda3 hda4
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Setting latency timer of device 00:1d.0 to 64
host/uhci.c: USB UHCI at I/O 0xef00, IRQ 10
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
host/uhci.c: USB UHCI at I/O 0xef20, IRQ 7
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
host/uhci.c: USB UHCI at I/O 0xef40, IRQ 5
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.3 to 64
host/uhci.c: USB UHCI at I/O 0xef80, IRQ 10
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 104k freed
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
Adding Swap: 2522196k swap-space (priority -1)
SCSI subsystem driver Revision: 1.00
hdc: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HL-DT-ST  Model: CD-RW GCE-8481B   Rev: 1.10
  Type:   CD-ROM                             ANSI SCSI revision: 02
-------------- next part --------------
Module                  Size  Used by    Tainted: P  
i2c-proc                9264   0 
i2c-algo-bit            8872   0  (unused)
i2c-dev                 5700   0  (unused)
i2c-core               19812   0  [i2c-proc i2c-algo-bit i2c-dev]
ext2                   39200   0  (autoclean)
snd-pcm-oss            45732   0  (autoclean)
snd-mixer-oss          16600   1  (autoclean) [snd-pcm-oss]
snd-intel8x0           24964   1  (autoclean)
snd-pcm                87712   0  (autoclean) [snd-pcm-oss snd-intel8x0]
snd-timer              21064   0  (autoclean) [snd-pcm]
snd-mpu401-uart         5180   0  (autoclean) [snd-intel8x0]
snd-rawmidi            19520   0  (autoclean) [snd-mpu401-uart]
snd-seq-device          6448   0  (autoclean) [snd-rawmidi]
snd-ac97-codec         45216   0  (autoclean) [snd-intel8x0]
snd                    45860   0  (autoclean) [snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-pcm snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device snd-ac97-codec]
snd-page-alloc          9072   0  (autoclean) [snd-intel8x0 snd-pcm]
nvidia               1670816  10  (autoclean)
autofs4                12788   0  (autoclean) (unused)
3c2000                136356   1 
ipt_REJECT              3992   6  (autoclean)
iptable_filter          2412   1  (autoclean)
ip_tables              15864   2  [ipt_REJECT iptable_filter]
sg                     32780   0  (autoclean)
sr_mod                 16184   0  (autoclean)
ide-scsi               12400   0 
scsi_mod              102772   3  [sg sr_mod ide-scsi]
keybdev                 2944   0  (unused)
mousedev                5688   1 
input                   6144   0  [keybdev mousedev]
hid                    11868   0  (unused)
-------------- next part --------------
Error: No i2c-bus specified!
Syntax: i2cdetect I2CBUS
  I2CBUS is an integer
  Installed I2C busses:
-------------- next part --------------
[root@LinuxPentiumIV /]# sensors-detect
 This program will help you to determine which I2C/SMBus modules you need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-/]* files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 System vendor: To Be Filled By O.E.M.
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Sorry, no PCI bus adapters found.

 We will now try to load each adapter module in turn.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
Character in "C" format wrapped at /usr/local/sbin/sensors-detect line 1075.
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
Character in "C" format wrapped at /usr/local/sbin/sensors-detect line 1075.
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
Character in "C" format wrapped at /usr/local/sbin/sensors-detect line 1075.
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
Character in "C" format wrapped at /usr/local/sbin/sensors-detect line 1075.
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
Character in "C" format wrapped at /usr/local/sbin/sensors-detect line 1075.
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
Character in "C" format wrapped at /usr/local/sbin/sensors-detect line 1075.
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
Character in "C" format wrapped at /usr/local/sbin/sensors-detect line 1075.
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
Character in "C" format wrapped at /usr/local/sbin/sensors-detect line 1075.
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
# I2C chip drivers
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): no
