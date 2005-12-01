From: kuolas@gmail.com (Alvaro Kuolas)
Date: Thu, 01 Dec 2005 01:38:48 +0000
Subject: [lm-sensors] W83782M... Yes "M". What is this?
Message-Id: <438E7DF5.4070506@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, my name is Alvaro.
I'm very pleased with the status of the project, it's very mature and 
well organized.
Well done!

but... i have a question:

Why the Winbond chip  W83782M (yes "M") is not listed?
I have a Soyo Sy-6VBA-133, in the manual says W83782M, but on the web 
(non soyo sites) apears as a W83782D.
the 'w83781d' driver works on my system, but i still have a doubt. Maybe 
this was only a typo  from SOYO, or not?

Source of the problem (the PDF manual):
http://www.soyo.com.tw/dl/manuals/686/m6vba13312.pdf

Here is my sensors-detect:
-----------------------
X530-Windsword:~ # sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:07.3: VIA Technologies VT82C596 
Apollo ACPI
Use driver `i2c-voodoo3' for device 01:00.0: 3Dfx Voodoo Banshee
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
Module `i2c-voodoo3' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): YES
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double 
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: DDC Voodoo3/Banshee adapter (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x03
Client found at address 0x06
Client found at address 0x07
Client found at address 0x08
Client found at address 0x09
Probing for `Smart Battery Charger'... Success!
    (confidence 5, driver `to-be-written')
Client found at address 0x0a
Probing for `Smart Battery Manager/Selector'... Success!
    (confidence 5, driver `to-be-written')
Client found at address 0x0b
Probing for `Smart Battery'... Success!
    (confidence 5, driver `smartbatt')
Client found at address 0x0c
Client found at address 0x0d
Client found at address 0x0e
Client found at address 0x0f
Client found at address 0x10
Client found at address 0x11
Client found at address 0x12
Client found at address 0x13
Client found at address 0x14
Client found at address 0x15
Client found at address 0x16
Client found at address 0x17
Client found at address 0x18
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Failed!
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Failed!
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `Maxim MAX1619'... Failed!
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Client found at address 0x19
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Failed!
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Failed!
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `Maxim MAX1619'... Failed!
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Client found at address 0x1a
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Failed!
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Failed!
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `Maxim MAX1619'... Failed!
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Client found at address 0x3b
Probing for `Philips Semiconductors SAA1064'... Failed!
Client found at address 0x41
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Success!
    (confidence 2, driver `lm92')
Client found at address 0x42
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x43
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x45
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x46
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x4d
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Failed!
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 3, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `Maxim MAX1619'... Failed!
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Probing for `National Semiconductor LM89/LM99'... Failed!
Probing for `Maxim MAX6659'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x54
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x55
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x56
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x57
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Probing for `Sony Vaio EEPROM'... Failed!
Client found at address 0x58
Client found at address 0x59
Client found at address 0x5a
Client found at address 0x5b
Client found at address 0x5c
Client found at address 0x5d
Client found at address 0x62
Client found at address 0x63
Client found at address 0x64
Client found at address 0x69
Client found at address 0x6a
Client found at address 0x6b
Client found at address 0x6c
Client found at address 0x6d
Client found at address 0x6e
Client found at address 0x6f
Client found at address 0x70
Probing for `Philips Semiconductors PCA9540'... Success!
    (confidence 1, driver `pca9540')
Client found at address 0x74
Client found at address 0x75
Client found at address 0x76

Next adapter: I2C Voodoo3/Banshee adapter (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: SMBus Via Pro adapter at 5000 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x30
Client found at address 0x33
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x51 can not be probed - unload all client drivers first!
Client at address 0x52 can not be probed - unload all client drivers first!
Client at address 0x53 can not be probed - unload all client drivers first!
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): YES
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
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
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no): YES
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Bus `DDC Voodoo3/Banshee adapter' (Algorithm unavailable)
    Busdriver `i2c-voodoo3', I2C address 0x09
    Chip `Smart Battery Charger' (confidence: 5)
  * Bus `DDC Voodoo3/Banshee adapter' (Algorithm unavailable)
    Busdriver `i2c-voodoo3', I2C address 0x0a
    Chip `Smart Battery Manager/Selector' (confidence: 5)

Driver `smartbatt' (should be inserted):
  Detects correctly:
  * Bus `DDC Voodoo3/Banshee adapter' (Algorithm unavailable)
    Busdriver `i2c-voodoo3', I2C address 0x0b
    Chip `Smart Battery' (confidence: 5)

Driver `lm92' (should be inserted):
  Detects correctly:
  * Bus `DDC Voodoo3/Banshee adapter' (Algorithm unavailable)
    Busdriver `i2c-voodoo3', I2C address 0x41
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)

Driver `adm1021' (should be inserted):
  Detects correctly:
  * Bus `DDC Voodoo3/Banshee adapter' (Algorithm unavailable)
    Busdriver `i2c-voodoo3', I2C address 0x4d
    Chip `National Semiconductor LM84' (confidence: 3)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `DDC Voodoo3/Banshee adapter' (Algorithm unavailable)
    Busdriver `i2c-voodoo3', I2C address 0x54
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `DDC Voodoo3/Banshee adapter' (Algorithm unavailable)
    Busdriver `i2c-voodoo3', I2C address 0x55
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `DDC Voodoo3/Banshee adapter' (Algorithm unavailable)
    Busdriver `i2c-voodoo3', I2C address 0x56
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `DDC Voodoo3/Banshee adapter' (Algorithm unavailable)
    Busdriver `i2c-voodoo3', I2C address 0x57
    Chip `SPD EEPROM' (confidence: 1)

Driver `pca9540' (should be inserted):
  Detects correctly:
  * Bus `DDC Voodoo3/Banshee adapter' (Algorithm unavailable)
    Busdriver `i2c-voodoo3', I2C address 0x70
    Chip `Philips Semiconductors PCA9540' (confidence: 1)

Driver `w83781d' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83782D' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? ISA
Use of uninitialized value in numeric eq (=) at 
/usr/sbin/sensors-detect line 4423.
Use of uninitialized value in numeric eq (=) at 
/usr/sbin/sensors-detect line 4423.

To make the sensors modules behave correctly, add these lines to
/etc/modprobe.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
modprobe i2c-voodoo3
modprobe i2c-isa
# I2C chip drivers
# no driver for Smart Battery Charger yet
modprobe smartbatt
modprobe lm92
modprobe adm1021
modprobe eeprom
modprobe pca9540
modprobe w83781d
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): YES
Copy /usr/share/doc/packages/sensors/prog/init/lm_sensors.init.suse
to /etc/init.d/lm_sensors for initialization at boot time.
-----------------------

Thank for all!

 .
