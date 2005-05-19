From: homer@lightlink.com (Homer Wilson Smith)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: Xeon II motherboard and CPU temp readings
Message-Id: <Pine.GSU.4.58.0406181602240.12794@adore.lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


     Running Redhat 8.0, 2.4.20-24.8smp, sensors 2.6.3

     Dual Xeon motherboard only shows one temp reading for
CPU's and no fan readings at all.

     Using the w83627hf-isa-0290 driver.

     Am I doing something wrong or can this been fixed?

     Pointers to RTFM welcome.

     Thanks  Homer


w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
in0 VCore 1:
           +1.48 V  (min =  +4.08 V, max =  +4.08 V)
in1 VCore 2:
           +1.79 V  (min =  +4.08 V, max =  +4.08 V)
in2 +3.3V: +3.28 V  (min =  +3.13 V, max =  +3.45 V)
in3 +5V:   +4.99 V  (min =  +4.72 V, max =  +5.24 V)
in4 +12V: +12.62 V  (min = +10.79 V, max = +13.19 V)
in5 -12V:  +1.59 V  (min = -13.21 V, max = -10.90 V)
in6 -5V:   +0.17 V  (min =  -5.26 V, max =  -4.76 V)
in7 V5SB:  +5.58 V  (min =  +4.72 V, max =  +5.24 V)
in8 VBat:  +2.97 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 3000 RPM, div = 2)
fan2:        0 RPM  (min = 3000 RPM, div = 2)
fan3:        0 RPM  (min = 3000 RPM, div = 2)
temp1:       +54C  (limit =  +70C, hysteresis =  +80C) sensor = PII/Celeron diode
temp2:    +127.5C  (limit =  +70C, hysteresis =  +80C) sensor = PII/Celeron diode   ALARM
temp3:    +127.5C  (limit =  +70C, hysteresis =  +80C) sensor = PII/Celeron diode   ALARM
vid:      +13.50 V
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

Script started on Fri Jun 18 16:09:50 2004
superoot ej0/root: sensors-detect
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

 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation,  just scanning
 the bus will break your thinkpad forever!

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801CA/CAM ICH3
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
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

Next adapter: SMBus I801 adapter at 7020 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client at address 0x18 can not be probed - unload all client drivers first!
Client found at address 0x19
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Analog Devices ADM1021'... Success!
    (confidence 6, driver `adm1021')
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')

Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Failed!
Probing for `Genesys Logic GL523SM'... Failed!
Client found at address 0x1b
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Client found at address 0x2c
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Success!
    (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
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
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
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
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x50
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
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
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x53
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x54
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x55
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x57
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x69

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): Probing for `National Semiconductor LM78'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
    Alias of the chip on I2C bus `SMBus I801 adapter at 7020', address 0x002c
Probing for `Winbond W83697HF'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `adm1021' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus I801 adapter at 7020' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x19
    Chip `Analog Devices ADM1021' (confidence: 6)
  Misdetects:
  * Bus `SMBus I801 adapter at 7020' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x19
    Chip `Maxim MAX1617' (confidence: 3)

Driver `w83781d' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 7020' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x2c (and 0x48 0x49)
    ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF' (confidence: 8)

Driver `lm75' (may not be inserted):
  Misdetects:
  * Bus `SMBus I801 adapter at 7020' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x48
    Chip `National Semiconductor LM75' (confidence: 3)
  * Bus `SMBus I801 adapter at 7020' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x49
    Chip `National Semiconductor LM75' (confidence: 3)

Driver `pcf8591' (may not be inserted):
  Misdetects:
  * Bus `SMBus I801 adapter at 7020' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x48
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus I801 adapter at 7020' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x49
    Chip `Philips Semiconductors PCF8591' (confidence: 1)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 7020' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
  * Bus `SMBus I801 adapter at 7020' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x51
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
  * Bus `SMBus I801 adapter at 7020' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x53
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 1)
  * Bus `SMBus I801 adapter at 7020' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x54
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
  * Bus `SMBus I801 adapter at 7020' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x55
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
  * Bus `SMBus I801 adapter at 7020' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x57
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 1)


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
modprobe i2c-isa
# I2C chip drivers
modprobe adm1021
modprobe w83781d
modprobe eeprom
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
options adm1021 ignore=0,0x19
options w83781d ignore=0,0x2c
#----cut here----
superoot ej0/root:
superoot ej0/root:
superoot ej0/root: em s[K[K[K^Dexit

Script done on Fri Jun 18 16:10:21 2004
