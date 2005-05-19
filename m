From: hyc@highlandsun.com (Howard Chu)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Asus A8V Deluxe
Message-Id: <42120C36.6000107@highlandsun.com>
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

I just got SuSE 9.2 running on my Asus system, with AMD A64 3000+ 
processor, and tried to get some meaningful sensors output. Since the 
bundled sensors package seemed a bit old, I downloaded and built the 2.9 
source.

There are a couple of detected chips that aren't totally supported, but 
I see that one (w83792d) should be appearing soon. Also it detects some 
SPD EEPROMs on my Fusion HDTV3-T tuner card, but doesn't do anything 
else with them.

Just for reference, I've attached the output from sensors-detect and 
from sensors... fan1 read as zero until I set its divisor to 8. I also 
tweaked fan2 a bit because even though it was reporting a believable fan 
speed, the min value was way off. Also I haven't figured out yet which 
of fan1/fan3 is the case fan vs the PSU fan.

The +/-12V values are pretty far off, still need to look into that. 
Since this board has been around for a while - does anyone have 
suggested settings to use here?

% sensors
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.75 V  (min =  +1.74 V, max =  +1.91 V)
+12V:     +11.37 V  (min = +10.82 V, max = +13.19 V)
+3.3V:     +3.28 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.93 V  (min =  +4.75 V, max =  +5.25 V)
-12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)
V5SB:      +5.08 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +0.03 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     1140 RPM  (min = 1394 RPM, div = 8)
CPU Fan:  3068 RPM  (min = 1328 RPM, div = 4)
fan3:     1205 RPM  (min = 1394 RPM, div = 8)
M/B Temp:    +25??C  (high =   -78??C, hyst =  -126??C)   sensor = 
thermistor
CPU Temp:  +34.5??C  (high =   +80??C, hyst =   +75??C)   sensor = 
thermistor
vid:      +1.825 V  (VRM Version 9.0)
alarms:
beep_enable:
           Sound alarm disabled

eeprom-i2c-1-51
Adapter: SMBus Via Pro adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-1-50
Adapter: SMBus Via Pro adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-57
Adapter: cx88[0]
Unknown EEPROM type (255).

eeprom-i2c-0-56
Adapter: cx88[0]
Unknown EEPROM type (255).

eeprom-i2c-0-55
Adapter: cx88[0]
Unknown EEPROM type (255).

eeprom-i2c-0-54
Adapter: cx88[0]
Unknown EEPROM type (255).

eeprom-i2c-0-53
Adapter: cx88[0]
Unknown EEPROM type (255).

eeprom-i2c-0-52
Adapter: cx88[0]
Unknown EEPROM type (255).

eeprom-i2c-0-51
Adapter: cx88[0]
Unknown EEPROM type (255).

eeprom-i2c-0-50
Adapter: cx88[0]
Unknown EEPROM type (255).
-- 
   -- Howard Chu
   Chief Architect, Symas Corp.       Director, Highland Sun
   http://www.symas.com               http://highlandsun.com/hyc
   Symas: Premier OpenSource Development and Support
-------------- next part --------------
Script started on Tue 15 Feb 2005 05:48:42 AM PST
shell-init: error retrieving current directory: getcwd: cannot access parent directories: No such file or directory
mandolin:/sys/bus/i2c/drivers/w83627hf/2-0290 # s[Kcd /
chdir: error retrieving current directory: getcwd: cannot access parent directories: No such file or directory
mandolin:/ # sensorsd[K-detect

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
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies VT8237 South Bridge
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-viapro' (say NO if built into your kernel)? (YES/no): 
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

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

Next adapter: SMBus Via Pro adapter at 0400
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x2f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Success!
    (confidence 8, driver `to-be-written'), other addresses: 0x48 0x49
Probing for `Winbond W83791SD'... Success!
    (confidence 3, driver `not-a-sensor')
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x48
Probing for `National Semiconductor LM75'... Failed!
Probing for `National Semiconductor LM77'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Maxim MAX6650/MAX6651'... Failed!
Probing for `National Semiconductor LM92'... Failed!
Probing for `National Semiconductor LM76'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x49
Probing for `National Semiconductor LM75'... Failed!
Probing for `National Semiconductor LM77'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `National Semiconductor LM92'... Failed!
Probing for `National Semiconductor LM76'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
    (confidence 1, driver `smbus-arp')
Client found at address 0x69

Next adapter: cx88[0]
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x0e
Client found at address 0x43
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x53
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
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
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
    (confidence 1, driver `smbus-arp')

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
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): 
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83627THF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x82)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x82)

Do you want to scan for secondary Super I/O sensors? (YES/no): 
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
  * Bus `SMBus Via Pro adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x2f (and 0x48 0x49)
    Chip `Winbond W83792D' (confidence: 8)

Driver `not-a-sensor' (may not be inserted):
  Misdetects:
  * Bus `SMBus Via Pro adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x2f
    Chip `Winbond W83791SD' (confidence: 3)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus Via Pro adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `cx88[0]' (Algorithm unavailable)
    Busdriver `UNKNOWN', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `cx88[0]' (Algorithm unavailable)
    Busdriver `UNKNOWN', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `cx88[0]' (Algorithm unavailable)
    Busdriver `UNKNOWN', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `cx88[0]' (Algorithm unavailable)
    Busdriver `UNKNOWN', I2C address 0x53
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `cx88[0]' (Algorithm unavailable)
    Busdriver `UNKNOWN', I2C address 0x54
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `cx88[0]' (Algorithm unavailable)
    Busdriver `UNKNOWN', I2C address 0x55
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `cx88[0]' (Algorithm unavailable)
    Busdriver `UNKNOWN', I2C address 0x56
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `cx88[0]' (Algorithm unavailable)
    Busdriver `UNKNOWN', I2C address 0x57
    Chip `SPD EEPROM' (confidence: 1)

Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)
  * Bus `cx88[0]' (Algorithm unavailable)
    Busdriver `UNKNOWN', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)

Driver `it87' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? 

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
# modprobe unknown adapter cx88[0]
modprobe i2c-isa
# I2C chip drivers
# no driver for Winbond W83792D yet
modprobe eeprom
modprobe smbus-arp
modprobe w83627hf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): 
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
Script done on Tue 15 Feb 2005 05:54:36 AM PST
