From: upgrdman@mindspring.com (Farrell Farahbod)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: sensors program library problems
Message-Id: <1058790442.16275.6.camel@farrell.freemans.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you guys may remember me from earlier this week with some questions
about sensors-detect. well, i jsut today compile by hand both i2c and
lm_sensors (both version are 2.8.0).

both compile without compile stopping errors and installed just fine as
far as i can tell.

i then ran sensors-detect, and after modifing that perl script twice
(chaning "modprobe" to "/sbin/modprobe" etc..) i got it to run without
errors.

but now when i run the program "sensors" i get this at the command line:

[root@farrell doc]# sensors
sensors: error while loading shared libraries: libsensors.so.2: cannot
open shared object file: No such file or directory
[root@farrell doc]#

did i do something wrong?

here is the full output of sensors-detect, if this helps:

[root@farrell doc]# /usr/local/sbin/sensors-detect
 This program will help you to determine which I2C/SMBus modules you
need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made
sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the
/dev/i2c[-/]* files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev
files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things
may
 seem a bit confusing, but they will still work.
 
 BIOS vendor (ACPI): KT400
 System vendor (DMI): VIA Technologies, Inc.
 BIOS version (DMI): 6.00 PG
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies
VT8233A/8235 South Bridge
Use driver `<DISABLED>' for device 01:00.0: GeForce2 MX
Probe succesfully concluded.
 
 We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.
 
 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).
 
Next adapter: SMBus Via Pro adapter at 5000 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85'... Failed!
Probing for `Analog Devices ADM1027 or ADT7463'... Failed!
Probing for `SMSC EMC6D100 and EMC6D101'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Winbond W83L785TS'... Success!
    (confidence 8, driver `to-be-written')
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
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
 
Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x2e
    Chip `Winbond W83L785TS' (confidence: 8)
 
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
 ISA bus access is faster, but you need to load an additional driver
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?
 
To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:
 
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
 
To load everything that is needed, add this to some /etc/rc* file:
 
#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
modprobe i2c-isa
# I2C chip drivers
modprobe to-be-written
modprobe eeprom
modprobe w83781d
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----
 
WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really
should
try these commands right now to make sure everything is working
properly.
Monitoring programs won't work until it's done.
 
Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.

i was so happy i got it all compiled and installed...but now senors wont
runs :-|

thanks again,

farrell farahbod

p.s. i use redhat9, with the kernel and kernel-source rpms installed for
2.4.20-18.9.
