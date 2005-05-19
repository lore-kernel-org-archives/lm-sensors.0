From: jargon@hurg.org (Johannes =?utf-8?B?V2Vpw59s?=)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: Ticket #1376
Message-Id: <20030824171457.GA1055@hurg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030817003245.GA12961@hurg.org>
In-Reply-To: <20030817003245.GA12961@hurg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 2003-08-24 10:24:50, Jean Delvare wrote:
> The i2c-viapro module is used by the eeprom module. This is only useful
> to read the SPD EEPROMs found on your memory modules, and I guess you
> can live without it, so feel free to remove i2c-viapro and eeprom from
> the list for faster operations.

Yes, I think that I don't need them ...

> Before you do that, however, I'm interested in the adm1021 problem. You
> don't seem to have such a chip on your system, so I wonder why
> sensors-detect told you to use it. Could you please provide a full log
> of sensors-detect? Please unload all chip drivers (adm1021, eeprom,
> w83781d) before running sensors-detect again.

I've attached a "LOG" file ...

> The two suspects left are: libsensors, and sensors itself. I'm not fully
> qualified to track that kind of bug. I think that Philip Pokorny would
> be much more that I am. In a similar case, he suggested to use "strace
> -o /tmp/sensors.strace sensors -s". Maybe we can start with that.

here it is

> Maybe the problem is that sensors drops its root priviledges at some
> point. But I don't know why nor how it could do that. All I know is that
> only Debian-system-based (or clones) users have reported the problem,
> which is probably not a simpe coincidence. What's more, I think I
> remember the i2c-isa module was in use each time. That too is probably
> not a coincidence. What do Debian systems have particular, and what does
> the i2c-isa module do that other bus drivers don't?

hmm, as far as I know, Debian is nearly completely FHS compatible ...
and the module-handling is different from the other distributions
(update-modules, /etc/modutils, ...)

I've never used another distribution, so I don't know what's different.

-- 
cu,
Johannes Wei?l
-------------- next part --------------
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

 BIOS vendor (ACPI): VIA694
 System vendor (DMI): VIA Technologies, Inc.
 BIOS version (DMI): 6.00 PG
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies VT8233A/8235 South Bridge
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
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

Next adapter: SMBus Via Pro adapter at 5000 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x2b
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
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
Probing for `National Semiconductor LM83'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x30
Client found at address 0x37
Client found at address 0x50
Probing for `Serial EEPROM'... Success!
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
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
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
  Failed! (0x60)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83697HF Super IO Sensors'
  Success... found at address 0x0290

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 

Driver `adm1021' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x2b
    Chip `National Semiconductor LM84' (confidence: 6)
  Misdetects:
  * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x2b
    Chip `Maxim MAX1617' (confidence: 3)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `Serial EEPROM' (confidence: 8)

Driver `w83781d' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF' (confidence: 8)

Driver `w83627hf' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF Super IO Sensors' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? 

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
options adm1021 ignore=0,0x2b
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
modprobe i2c-isa
# I2C chip drivers
modprobe adm1021
modprobe eeprom
modprobe w83781d
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):
-------------- next part --------------
execve("/usr/local/bin/sensors", ["sensors", "-s"], [/* 33 vars */]) = 0
uname({sys="Linux", node="kronos", ...}) = 0
brk(0)                                  = 0x805e948
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40013000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_sizeG150, ...}) = 0
old_mmap(NULL, 47150, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/usr/local/lib/libsensors.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0$T\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size7478, ...}) = 0
old_mmap(NULL, 109796, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40020000
old_mmap(0x4002d000, 53248, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xd000) = 0x4002d000
old_mmap(0x4003a000, 3300, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4003a000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\224]\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size42224, ...}) = 0
old_mmap(NULL, 1151748, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4003b000
old_mmap(0x4014d000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x111000) = 0x4014d000
old_mmap(0x40152000, 8964, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40152000
close(3)                                = 0
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0006\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size4100, ...}) = 0
old_mmap(NULL, 136656, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40155000
old_mmap(0x40176000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x20000) = 0x40176000
close(3)                                = 0
munmap(0x40014000, 47150)               = 0
brk(0)                                  = 0x805e948
brk(0x807f948)                          = 0x807f948
brk(0)                                  = 0x807f948
brk(0x8080000)                          = 0x8080000
open("/etc/sensors.conf", O_RDONLY)     = 3
_sysctl({{CTL_DEV, 2, 1}, 3, 0x40039be0, 80, (nil), 0}) = 0
open("/proc/bus/i2c", O_RDONLY)         = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
read(4, "i2c-0\tsmbus    \tSMBus Via Pro ad"..., 4096) = 165
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x40014000, 4096)                = 0
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbfffe840) = -1 ENOTTY (Inappropriate ioctl for device)
fstat64(3, {st_mode=S_IFREG|0644, st_sizeH531, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
read(3, "# Sensors configuration file use"..., 8192) = 8192
read(3, "p\' lines, this will run-time\n# b"..., 8192) = 8192
read(3, "\n    label in4 \"+12V\"\n    label "..., 8192) = 8192
read(3, " 1)\n    compute in5 (160/35.7)*("..., 8192) = 8192
read(3, "g resistors, rather\n# than exter"..., 8192) = 8192
read(3, "to load the it87 module as follo"..., 8192) = 7571
read(3, "", 4096)                       = 0
read(3, "", 8192)                       = 0
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbfffe830) = -1 ENOTTY (Inappropriate ioctl for device)
_sysctl({{CTL_DEV, 2, 101, 3e8}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3e8}, 4, (nil), 1074247997, 0x40039be0, 4}) = 0
_sysctl({{CTL_DEV, 2, 101, 3e8}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3e8}, 4, (nil), 1074247997, 0x40039be0, 8}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ea}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ea}, 4, (nil), 1074247997, 0x40039be0, 4}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ea}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ea}, 4, (nil), 1074247997, 0x40039be0, 8}) = 0
_sysctl({{CTL_DEV, 2, 101, 3eb}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3eb}, 4, (nil), 1074247997, 0x40039be0, 4}) = 0
_sysctl({{CTL_DEV, 2, 101, 3eb}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3eb}, 4, (nil), 1074247997, 0x40039be0, 8}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ec}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ec}, 4, (nil), 1074247997, 0x40039be0, 4}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ec}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ec}, 4, (nil), 1074247997, 0x40039be0, 8}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ed}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ed}, 4, (nil), 1074247997, 0x40039be0, 8}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ed}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ed}, 4, (nil), 1074247997, 0x40039be0, 4}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ee}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ee}, 4, (nil), 1074247997, 0x40039be0, 8}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ee}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ee}, 4, (nil), 1074247997, 0x40039be0, 4}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ef}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ef}, 4, (nil), 1074247997, 0x40039be0, 4}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ef}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3ef}, 4, (nil), 1074247997, 0x40039be0, 8}) = 0
_sysctl({{CTL_DEV, 2, 101, 3f0}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3f0}, 4, (nil), 1074247997, 0x40039be0, 4}) = 0
_sysctl({{CTL_DEV, 2, 101, 3f0}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 3f0}, 4, (nil), 1074247997, 0x40039be0, 8}) = 0
_sysctl({{CTL_DEV, 2, 101, 4b0}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 4b0}, 4, (nil), 1074247997, 0x40039be0, 4}) = 0
_sysctl({{CTL_DEV, 2, 101, 4b0}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 4b0}, 4, (nil), 1074247997, 0x40039be0, 8}) = 0
_sysctl({{CTL_DEV, 2, 101, 4b1}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 4b1}, 4, (nil), 1074247997, 0x40039be0, 4}) = 0
_sysctl({{CTL_DEV, 2, 101, 4b1}, 4, 0x40039be0, 12, (nil), 0}) = 0
_sysctl({{CTL_DEV, 2, 101, 4b1}, 4, (nil), 1074247997, 0x40039be0, 8}) = 0
_sysctl({{CTL_DEV, 2, 101, 4b2}, 4, 0x40039be0, 4096, (nil), 0}) = -1 ENOTDIR (Not a directory)
_sysctl({{CTL_DEV, 2, 101, 4b2}, 4, 0x40039be0, 4096, (nil), 0}) = -1 ENOTDIR (Not a directory)
write(2, "w83697hf-isa-0290: Can\'t access "..., 56) = 56
write(2, "Run as root?\n", 13)          = 13
exit_group(0)                           = ?
