From: johnp@marine-boy.nu (John Post)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: loading module w83781d hangs system
Message-Id: <Pine.LNX.4.33.0111272015260.31923-100000@sid>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hi there,  I have just obtained and installed the lm_sensors-2.6.2 package.
I ran the sensors-detect program and have added the recommended  lines
to my /etc/modules.conf file.

I have a tyan thunder K7 motherboard with a Winbond w837812D.

When I perform a modprobe of the w83781d module,  my system hangs/crashes.


The Requested information

sid:/disk1/usr2/tmp/compile_tmp/lm_sensors-2.6.2/prog/detect$ ./sensors-detect
 This program will help you to determine which I2C/SMBus modules you need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-/]* files for some things. You can use prog/mkdev/mkdev.sh to create these /dev files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation,  just scanning
 the bus will break your thinkpad forever!

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
sid:/disk1/usr2/tmp/compile_tmp/lm_sensors-2.6.2/prog/detect$ sudo sh
sid:/disk1/usr2/tmp/compile_tmp/lm_sensors-2.6.2/prog/detect# ./sensors-detect
 This program will help you to determine which I2C/SMBus modules you need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-/]* files for some things. You can use prog/mkdev/mkdev.sh to create these /dev files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation,  just scanning
 the bus will break your thinkpad forever!

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-amd756' for device 00:07.3: AMD-766 Athlon ACPI
Use driver `i2c-riva' for device 01:05.0: GeForce GTS
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-amd756' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
Load `i2c-riva' (say NO if built into your kernel)? (YES/no):
modprobe: Can't locate module i2c-riva
Loading failed ()... skipping.
** Note: i2c-riva module is available at
** http://drama.obuda.kando.hu/~fero/cgi-bin/rivatv.shtml
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

Next adapter: SMBus AMD7X6 adapter at 80e0 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Success!
    (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x30
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Client found at address 0x31
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Client found at address 0x48
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Client found at address 0x49
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Client found at address 0x50
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x51
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x63
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!

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
Probing for `VIA Technologies VT 82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `w83781d' (should be inserted):
  Detects correctly:
  * Bus `SMBus AMD7X6 adapter at 80e0' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2d (and 0x48 0x49)
    Chip `Winbond W83782D' (confidence: 8)

Driver `lm75' (may not be inserted):
  Misdetects:
  * Bus `SMBus AMD7X6 adapter at 80e0' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x48
    Chip `National Semiconductor LM75' (confidence: 3)
  * Bus `SMBus AMD7X6 adapter at 80e0' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x49
    Chip `National Semiconductor LM75' (confidence: 3)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus AMD7X6 adapter at 80e0' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x50
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
  * Bus `SMBus AMD7X6 adapter at 80e0' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x51
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? smbus

WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-amd756
# I2C chip drivers
modprobe w83781d
modprobe eeprom
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
/dev/vmnet: open called by PID 709 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 720 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
i2c-core.o: i2c core module
i2c-amd756.o version 2.6.2 (20011118)
i2c-core.o: adapter SMBus AMD7X6 adapter at 80e0 registered as adapter 0.
i2c-amd756.o: AMD756/766 bus detected and initialized
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-dev.o: Registered 'SMBus AMD7X6 adapter at 80e0' as minor 0
i2c-amd756.o: SMBus collision!
i2c-amd756.o: SMBus collision!
i2c-amd756.o: SMBus collision!
i2c-amd756.o: SMBus collision!




sid:/disk1/usr2/tmp/compile_tmp/lm_sensors-2.6.2/prog/detect# lsmod
Module                  Size  Used by
i2c-dev                 3744   0
i2c-amd756              3236   0
i2c-core               13280   0  [i2c-dev i2c-amd756]
usb-ohci               17088   0  (unused)
visor                   9888   0  (unused)
usbserial              17184   0  [visor]
usbcore                55712   0  [usb-ohci visor usbserial]
vmnet                  18304   4
vmmon                  18804   0  (unused)
lp                      5376   0  (autoclean)




sid:/disk1/usr2/tmp/compile_tmp/lm_sensors-2.6.2# prog/detect/i2cdetect 0
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX XX
30: 30 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX 63 XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX



sid:/disk1/usr2/tmp/compile_tmp/lm_sensors-2.6.2# prog/dump/i2cdump 0 8
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x8, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX


sid:/disk1/usr2/tmp/compile_tmp/lm_sensors-2.6.2# prog/dump/i2cdump 0 26
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x1a, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX




sid:/disk1/usr2/tmp/compile_tmp/lm_sensors-2.6.2# prog/dump/i2cdump 0 48
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x30, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX



sid:/disk1/usr2/tmp/compile_tmp/lm_sensors-2.6.2# prog/dump/i2cdump 0 49
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x31, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX



sid:/disk1/usr2/tmp/compile_tmp/lm_sensors-2.6.2# prog/dump/i2cdump 0 50
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x32, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX




sid:/disk1/usr2/tmp/compile_tmp/lm_sensors-2.6.2# prog/dump/i2cdump 0 51
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x33, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX



sid:/disk1/usr2/tmp/compile_tmp/lm_sensors-2.6.2# prog/dump/i2cdump 0 63
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x3f, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX


From the motherboard documentation, the W83782D chip is my PC health
monitoring chip.

My motherboard is a thunder K7 (S2462).

The lm_sensors package I am trying is lm_sensors-2.6.2

The i2c package version is also 2.6.2

Kernel version is 2.4.14
Linux sid 2.4.14 #21 SMP Sat Nov 17 19:38:37 MST 2001 i686 unknown



Thanks for having a look at my problem.



John Post             | Email: johnp@marine-boy.nu
