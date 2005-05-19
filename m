From: dark@verfeiert.org (Sven E.)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: Follow-UP to ticket 1578 as requested
Message-Id: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi LM sensors folks,

Khali asked to send soem additional info, for now, here's some output
from sensors-detect, as wished, first run recommends use of it87:

sensors-detect
 
This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.
 
 BIOS vendor (ACPI): IntelR
 System vendor (DMI): Intel Technologies, Inc.
 BIOS version (DMI): ASUS PC-DL ACPI BIOS Revision 1002
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.
 
 We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no): YES
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
no
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
 
Next adapter: bt848 #0 (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively): no
 
Next adapter: SMBus I801 adapter at 0500 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): no
 
 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): YES
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
  Trying address 0x0290... Success!
    (confidence 8, driver `it87')
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!
 
 Some Super I/O chips may also contain sensors. Super I/O probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for `SMSC 47M10x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed!
Probing for `VT1211 Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83627THF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x82)
 
 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:
 
Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)
 
Driver `w83627hf' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 8)
 
 
 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? ISA
 
If you want to load the modules at startup, generate a config file
below and make sure lm_sensors get started (eg. rc-update add lm_sensors
default).
 
To make the sensor modules behave correctly, add these lines to
/etc/modules.conf:
 
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----end cut here----
 
WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really
should
try these commands right now to make sure everything is working
properly.
Monitoring programs won't work until it's done.
To load everything that is needed, execute the commands above...
 
#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe it87
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----end cut here----
 
Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify
other file name?
  (yes/NO/s): YES
Done.

--- as described in the ticket, the chip is a winbond chip, and the it87
just gives totally bogus information.

Second run of sensors detect, this time ISA is skipped but super IO is
scanned again:

 sensors-detect
 
This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.
 
 BIOS vendor (ACPI): IntelR
 System vendor (DMI): Intel Technologies, Inc.
 BIOS version (DMI): ASUS PC-DL ACPI BIOS Revision 1002
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.
 
 We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
no
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
 
Next adapter: bt848 #0 (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively): no
 
Next adapter: SMBus I801 adapter at 0500 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): no
 
 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): no
 
 Some Super I/O chips may also contain sensors. Super I/O probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for `SMSC 47M10x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed!
Probing for `VT1211 Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83627THF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x82)
 
 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:
 
Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 8)
 
 
 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? ISA
 
If you want to load the modules at startup, generate a config file
below and make sure lm_sensors get started (eg. rc-update add lm_sensors
default).
 
To make the sensor modules behave correctly, add these lines to
/etc/modules.conf:
 
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----end cut here----
 
WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really
should
try these commands right now to make sure everything is working
properly.
Monitoring programs won't work until it's done.
To load everything that is needed, execute the commands above...
 
#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe w83627hf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----end cut here----
 
Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify
other file name?
  (yes/NO/s): YES
Done.

As one can see now the Winbond is recommended as expected. yet, if I use
the recommended modules:

sensors
w83627thf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
ERROR: Can't get alarm data!
ERROR: Can't get beep data!
ERROR: Can't get IN0 data!
ERROR: Can't get IN2 data!
ERROR: Can't get IN3 data!
ERROR: Can't get IN4 data!
ERROR: Can't get IN7 data!
ERROR: Can't get IN8 data!
ERROR: Can't get FAN1 data!
ERROR: Can't get FAN2 data!
ERROR: Can't get TEMP1 data!
ERROR: Can't get TEMP2 data!

Khali supposed the lib might be outdated, but where can I find the lib.
I am using gentoo, I patched the kernel since I need bttv I installed
all needed packages etc.

How can I investigate further if the libsensors is outdated and which
version is used ....

gentoo says I use lm-sensors 2.8.1 as well as i2c 2.8.1

Any help would be appreciated and I will try to investigate all issues
to my possibilities/skills.

Please inform me either by mail or by updating the ticket.

Thank you very much in advance

Regards

-Sven

