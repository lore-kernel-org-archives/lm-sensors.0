From: m.pedersen@lancaster.ac.uk (jmp)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: KT400a / VT8235
Message-Id: <1075043549.1154.39.camel@flaptop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


hi,

(sorry about the previous message -went by mistake-)

My problem is related to a Fujitsu-Siemens (AMILO A 7620) laptop.

It seems that chipsets are supported, but I cannot successfully run
sensors-detect AND probe 'non-detectable'.

However, I have succeeded in running sensors-detect WITHOUT probing
'non-detectable', but the output from sensors is only:

[root@flaptop root]# sensors
eeprom-i2c-0-51
Adapter: SMBus Via Pro adapter at 0400
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

_____________________________

This is what I have got:


-The dmesg or syslog output if applicable:
______________________________________________

i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-dev.o: Registered 'SMBus Via Pro adapter at 0400' as minor 0
i2c-algo-pcf.o: i2c pcf8584 algorithm module
i2c-elektor.o: i2c pcf8584-isa adapter module
i2c-elektor.o: requested I/O region (0x330:2) is in use.
i2c-algo-bit.o: i2c bit algorithm module
i2c-elv.o: i2c ELV parallel port adapter module
i2c-dev.o: Registered 'ELV Parallel port adaptor' as minor 1
i2c-core.o: adapter ELV Parallel port adaptor registered as adapter 1.
i2c-elv.o: found device at 0x378.
i2c-algo-pcf.o: i2c pcf8584 algorithm module
i2c-elektor.o: i2c pcf8584-isa adapter module
i2c-elektor.o: requested I/O region (0x330:2) is in use.
i2c-algo-pcf.o: i2c pcf8584 algorithm module
i2c-elektor.o: i2c pcf8584-isa adapter module
i2c-elektor.o: requested I/O region (0x330:2) is in use.
i2c-philips-par.o: i2c Philips parallel port adapter module
i2c-velleman.o: i2c Velleman K8000 adapter module
i2c-velleman.o: Port 0x378 already in use.
____________________________


  * The output of (as root) prog/detect/sensors-detect
______________________________________

[root@flaptop root]# sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): AMI
 System vendor (DMI): FUJITSU SIEMENS
 BIOS version (DMI): 0.28
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies
VT8233A/8235 South Bridge
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): y
Load `i2c-elektor' (say NO if built into your kernel)? (YES/no): y
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-elektor.o:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-elektor.o:
insmod
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-elektor.o
failed
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-elektor.o:
insmod i2c-elektor failed
Loading failed... skipping.
Load `i2c-elv' (say NO if built into your kernel)? (YES/no): y
Module loaded succesfully.
Load `i2c-philips-par' (say NO if built into your kernel)? (YES/no): y
Module loaded succesfully.
Load `i2c-velleman' (say NO if built into your kernel)? (YES/no): y
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-velleman.o:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-velleman.o:
insmod
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-velleman.o
failed
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-velleman.o:
insmod i2c-velleman failed
Loading failed... skipping.
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus Via Pro adapter at 0400 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): y
Client at address 0x51 can not be probed - unload all client drivers
first!
Client found at address 0x69

Next adapter: ELV Parallel port adaptor (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively): y
^X^X^X^X

[root@flaptop root]#

_______________________________

  * The output of lsmod:

__________________________

[root@flaptop root]# lsmod
Module                  Size  Used by    Not tainted
i2c-philips-par         3356   0  (unused)
parport                36800   0  [i2c-philips-par]
i2c-elv                 2404   0
i2c-algo-bit            8776   1  [i2c-philips-par i2c-elv]
i2c-dev                 5060   0
udf                    92992   0  (autoclean)
via82cxxx_audio        23672   1  (autoclean)
ac97_codec             16648   0  (autoclean) [via82cxxx_audio]
uart401                 7972   0  (autoclean) [via82cxxx_audio]
sound                  71444   0  (autoclean) [via82cxxx_audio uart401]
soundcore               6500   4  (autoclean) [via82cxxx_audio sound]
eeprom                  4948   0  (unused)
i2c-proc                8400   0  [eeprom]
i2c-viapro              5008   0
i2c-core               18916   0  [i2c-algo-bit i2c-dev eeprom i2c-proc
i2c-viapro]
autofs                 12052   0  (autoclean) (unused)
via-rhine              14672   1
mii                     3992   0  [via-rhine]
sg                     34796   0  (autoclean)
sr_mod                 17016   0  (autoclean)
ide-scsi               11856   0
scsi_mod              109384   3  [sg sr_mod ide-scsi]
ide-cd                 34176   0
cdrom                  34048   0  [sr_mod ide-cd]
ohci1394               28520   0  (unused)
ieee1394              203940   0  [ohci1394]
nls_iso8859-1           3548   1  (autoclean)
nls_cp437               5180   1  (autoclean)
vfat                   12268   1  (autoclean)
fat                    37592   0  (autoclean) [vfat]
keybdev                 2624   0  (unused)
mousedev                5204   0  (unused)
hid                    23652   0  (unused)
input                   5824   0  [keybdev mousedev hid]
ehci-hcd               19784   0  (unused)
usb-uhci               25740   0  (unused)
usbcore                77984   1  [hid ehci-hcd usb-uhci]
thermal                 8032   0  (unused)
processor              10584   0  [thermal]
fan                     2240   0  (unused)
button                  3500   0  (unused)
battery                 6848   0  (unused)
asus_acpi               9596   0  (unused)
ac                      2528   0  (unused)
ext3                   70980   4
jbd                    51084   4  [ext3]



If a PCI chip problem: 
      * The output of lspci -n

___________________________

[root@flaptop root]# lspci -n
00:00.0 Class 0600: 1106:3189 (rev 80)
00:01.0 Class 0604: 1106:b198
00:09.0 Class 0c00: 1106:3044 (rev 80)
00:0b.0 Class 0607: 1217:6972 (rev 20)
00:10.0 Class 0c03: 1106:3038 (rev 80)
00:10.1 Class 0c03: 1106:3038 (rev 80)
00:10.2 Class 0c03: 1106:3038 (rev 80)
00:10.3 Class 0c03: 1106:3104 (rev 82)
00:11.0 Class 0601: 1106:3177
00:11.1 Class 0101: 1106:0571 (rev 06)
00:11.5 Class 0401: 1106:3059 (rev 50)
00:11.6 Class 0780: 1106:3068 (rev 80)
00:12.0 Class 0200: 1106:3065 (rev 74)
01:00.0 Class 0300: 1002:4c66 (rev 01)

_____________________________

UNSURE ABOUT THESE SECTIONS ;-(


  * If an I2C sensor chip problem: 
      * The output of (as root) prog/detect/i2cdetect X where X = the
        bus number (run i2cdetect with no arguments to list the busses)
        (please send this only if it's not all XX)
      * The output of (as root) prog/dump/i2cdump X 0xXX where XX = the
        address of each chip you see in the output of i2cdetect. (run
        once for each chip) (please send this only if it's not all ff)
  * If an ISA sensor chip problem: 
      * The output of (as root) prog/dump/isadump 0x295 0x296 (only if
        it's not all XX)

__________________

  * Part numbers of chips on your motherboard you think are the sensor
    chips (look at your motherboard)

VIA KT400a / VIA VT8235



  * Motherboard type

AMILO A 7620


  * Sensors version

[root@flaptop root]# rpm -q lm_sensors
lm_sensors-2.8.1-1


  * Kernel version


[root@flaptop root]# uname -a
Linux flaptop 2.4.22-1.2149.nptl #1 Wed Jan 7 12:57:33 EST 2004 i686
athlon i386 GNU/Linux

