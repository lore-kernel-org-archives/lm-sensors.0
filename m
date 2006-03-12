From: harald.dunkel@t-online.de (Harald Dunkel)
Date: Sun, 12 Mar 2006 16:19:13 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <44144A01.2050207@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi folks,

Configuring a barebone (Aopen MZ915-M) I tried the sensors stuff.
After running sensors-detect this is what sensors reports:

w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.36 V  (min =  +1.94 V, max =  +1.94 V)       ALARM
+12V:     +12.28 V  (min = +10.82 V, max = +13.19 V)
+3.3V:     +3.18 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.93 V  (min =  +4.75 V, max =  +5.25 V)
-12V:     -12.11 V  (min = -13.18 V, max = -10.80 V)
V5SB:      +5.05 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +3.10 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min =  664 RPM, div = 8)              ALARM
CPU Fan:     0 RPM  (min =  664 RPM, div = 8)              ALARM
fan3:        0 RPM  (min =  664 RPM, div = 8)              ALARM
M/B Temp:     +7 C  (high =   +45 C, hyst =  +101 C)   sensor = diode
CPU Temp:   -5.5 C  (high =   +80 C, hyst =   +75 C)   sensor = diode
temp3:      +7.5 C  (high =   +80 C, hyst =   +75 C)   sensor = diode           (beep)
alarms:
beep_enable:
          Sound alarm enabled


Esp. CPU fan, M/B and CPU temperature look unreasonable. If I reboot
and look into the bios, then it says the fan is at 3150 rpm, CPU temp.
is 53C, and sys temperature is 49C. There is no second fan.

Below you can find the output of sensors-detect after manually
unloading the sensor modules. Any help would be highly appreciated.


Regards

Harri
----------------------------------------------------------------------
{root at bugs:harri 999} sensors-detect
# sensors-detect revision 1.413 (2006/01/19 20:28:00)

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
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801FB ICH6
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 5000
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85 or LM96000'... Failed!
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'... Failed!
Probing for `Analog Devices ADT7476'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `National Semiconductor LM93'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Winbond W83L785R'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Philips NE1619'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `Analog Devices ADM1030'... Failed!
Probing for `Analog Devices ADM1031'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `VIA VT1211 (I2C)'... Failed!
Probing for `ITE IT8712F'... Failed!
Probing for `ALi M5879'... Failed!
Probing for `SMSC LPC47M15x, LPC47M192 or LPC47M997'... Failed!
Client found at address 0x2f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `ITE IT8712F'... Failed!
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no):
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
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x8285)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x8285)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x8285)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0x82)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0x82)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0x82)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0x82)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0x82)
Probing for `Nat. Semi. PCPC87427 Super IO'
  Failed! (0x82)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x82)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x82)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x82)
Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0x82)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0x82)
Probing for `SMSC 47M172 Super IO'
  Failed! (0x82)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0x82)
Probing for `SMSC SCH5307-NS Super IO'
  Failed! (0x82)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83627THF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83687THF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x82)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x82)
Probing for `Fintek F71805F/FG Super IO Sensors'
  Failed! (0x8285)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (0x8285)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 5000'
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 5000'
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)


I will now generate the commands needed to load the I2C modules.

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-i801
i2c-isa
# I2C chip drivers
eeprom
w83627hf
#----cut here----

Do you want to add these lines to /etc/modules automatically? (yes/NO)yes
{root at bugs:harri 999} modprobe i2c-i801
{root at bugs:harri 999} modprobe i2c-isa
{root at bugs:harri 999} modprobe eeprom
{root at bugs:harri 1000} modprobe w83627hf
{root at bugs:harri 1000} sensors
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.34 V  (min =  +1.94 V, max =  +1.94 V)       ALARM
+12V:     +12.28 V  (min = +10.82 V, max = +13.19 V)
+3.3V:     +3.17 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.93 V  (min =  +4.75 V, max =  +5.25 V)
-12V:     -12.11 V  (min = -13.18 V, max = -10.80 V)
V5SB:      +5.05 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +3.10 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min =  664 RPM, div = 8)              ALARM
CPU Fan:     0 RPM  (min =  664 RPM, div = 8)              ALARM
fan3:        0 RPM  (min =  664 RPM, div = 8)              ALARM
M/B Temp:     +8 C  (high =   +41 C, hyst =  +125 C)   sensor = thermistor
CPU Temp:   -7.5 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor
temp3:      +7.5 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor           (beep)
alarms:
beep_enable:
          Sound alarm enabled

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 258 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060312/fb8c31f0/signature-0001.bin
