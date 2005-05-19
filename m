From: a.bitz@gmx.net (Annette Bitz)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: Asus P4PE-XS
Message-Id: <200403251128.45259.a.bitz@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo,

eigentlich sollte das Board einen Asus asb100 (Bach) - Chip haben. Aber der 
wird nicht erkannt. Nach modprobe asb100 von Hand erhalte ich immerhin 
folgende Ausgabe:

# sensors
asb100-i2c-0-2d
Adapter: SMBus I801 adapter at e800
Algorithm: Non-I2C SMBus adapter

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at e800
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
Memory size (MB):       512


In /prov/sys/dev... stehen z.B. und temp1 auch Werte, aber diese werden nicht 
ausgelesen.


Hier noch der gew?nschte Output:

=====
# sensors-detect
 This program will help you to determine which I2C/SMBus modules you need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made sure
 `/etc/modules.conf' (or `/etc/conf.modules') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-/]* 
files
 for some things if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): ASUS
 System vendor (DMI): System Manufacturer
 BIOS version (DMI): ASUS P4PE-X/SE ACPI BIOS Revision 1006
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801DB ICH4
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
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

Next adapter: SMBus I801 adapter at e800 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client at address 0x2d can not be probed - unload all client drivers first!
Client found at address 0x44
Client at address 0x48 can not be probed - unload all client drivers first!
Client at address 0x49 can not be probed - unload all client drivers first!
Client found at address 0x50
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 1137.
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 1137.
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 1137.
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 1137.
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 1137.
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 1137.
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 1137.
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 1137.
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `Serial EEPROM' (confidence: 8)


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
modprobe i2c-i801
# I2C chip drivers
modprobe eeprom
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
Copy /usr/share/doc/packages/sensors/prog/init/lm_sensors.init
to /etc/init.d/lm_sensors for initialization at boot time.


=====

# prog/dump/isadump 0x295 0x296
  WARNING! Running this program can cause system crashes, data loss and worse!
  I will probe address register 0x0295 and data register 0x0296.
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff



=====

# prog/dump/i2cdump 1 0x23 b
Error: Could not open file `/dev/i2c-1' : No such device


=====


MfG
Annette Bitz
