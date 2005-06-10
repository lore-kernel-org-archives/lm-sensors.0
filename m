From: jmkio@gmx.de (JMKio)
Date: Fri, 10 Jun 2005 16:30:24 +0000
Subject: [lm-sensors] 050610 Sensors einrichten. SuSE Linux 9.3 Prof.
Message-Id: <1118413481.26905.2.camel@linux.site>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo, 
 
als root habe ich mit diesem es versucht! 
  
 /usr/sbin/sensors-detect 
  
 This program will help you determine which I2C/SMBus modules you need
to 
 load to use lm_sensors most effectively. You need to have i2c and 
 lm_sensors installed before running this program. 
 Also, you need to be `root', or at least have access to the /dev/i2c-* 
 files, for most things. 
 If you have patched your kernel and have some drivers built in, you
can 
 safely answer NO if asked to load some modules. In this case, things
may 
 seem a bit confusing, but they will still work. 
  
 It is generally safe and recommended to accept the default answers to
all 
 questions, unless you know what you're doing. 
  
 We can start with probing for (PCI) I2C or SMBus adapters. 
 You do not need any special privileges for this. 
 Do you want to probe now? (YES/no): 
 Probing for PCI bus adapters... 
 Use driver `i2c-viapro' for device 00:11.0: VIA Technologies VT8237
South 
Bridge 
 Probe succesfully concluded. 
  
 We will now try to load each adapter module in turn. 
 Module `i2c-viapro' already loaded. 
 If you have undetectable or unsupported adapters, you can have them 
 scanned by manually loading the modules before running this script. 
  
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
  
 Next adapter: SMBus Via Pro adapter at 0400 
 Do you want to scan it? (YES/no/selectively): 
 Client found at address 0x1b 
 Probing for `Maxim MAX6650/MAX6651'... Failed! 
 Probing for `Philips Semiconductors PCA9556'... Failed! 
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
 Probing for `Asus AS99127F (rev.1)'... Failed! 
 Probing for `Asus AS99127F (rev.2)'... Failed! 
 Probing for `Asus ASB100 Bach'... Failed! 
 Probing for `Analog Devices ADM9240'... Failed! 
 Probing for `Dallas Semiconductor DS1780'... Failed! 
 Probing for `National Semiconductor LM81'... Failed! 
 Probing for `Analog Devices ADM1029'... Failed! 
 Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed! 
 Client found at address 0x30 
 Client found at address 0x50 
 Probing for `SPD EEPROM'... Success! 
 (confidence 8, driver `eeprom') 
 Probing for `DDC monitor'... Failed! 
 Probing for `Maxim MAX6900'... Failed! 
 Client found at address 0x52 
 Probing for `SPD EEPROM'... Success! 
 (confidence 8, driver `eeprom') 
 Client found at address 0x69 
 Client found at address 0x6a 
  
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
 Failed! (skipping family) 
 Probing for `Nat. Semi. PC87351 Super IO Fan Sensors' 
 Failed! (skipping family) 
 Probing for `SMSC 47B27x Super IO Fan Sensors' 
 Failed! (skipping family) 
 Probing for `VT1211 Super IO Sensors' 
 Failed! (0x60) 
 Probing for `Winbond W83627HF Super IO Sensors' 
 Failed! (0x60) 
 Probing for `Winbond W83627THF Super IO Sensors' 
 Failed! (0x60) 
 Probing for `Winbond W83637HF Super IO Sensors' 
 Failed! (0x60) 
 Probing for `Winbond W83697HF Super IO Sensors' 
 Success... found at address 0x0290 
 Probing for `Winbond W83697SF/UF Super IO PWM' 
 Failed! (0x60) 
 Probing for `Winbond W83L517D Super IO' 
 Failed! (0x60) 
  
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
  
 Driver `eeprom' (should be inserted): 
 Detects correctly: 
 * Bus `SMBus Via Pro adapter at 0400' (Algorithm unavailable) 
 Busdriver `i2c-viapro', I2C address 0x50 
 Chip `SPD EEPROM' (confidence: 8) 
 * Bus `SMBus Via Pro adapter at 0400' (Algorithm unavailable) 
 Busdriver `i2c-viapro', I2C address 0x52 
 Chip `SPD EEPROM' (confidence: 8) 
  
 Driver `w83627hf' (should be inserted): 
 Detects correctly: 
 * ISA bus address 0x0290 (Busdriver `i2c-isa') 
 Chip `Winbond W83697HF Super IO Sensors' (confidence: 9) 
  
  
 I will now generate the commands needed to load the I2C modules. 
 Sometimes, a chip is available both through the ISA bus and an I2C
bus. 
 ISA bus access is faster, but you need to load an additional driver
module 
 for it. If you have the choice, do you want to use the ISA bus or the 
 I2C/SMBus (ISA/smbus)? 
  
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
 modprobe i2c-isa 
 # I2C chip drivers 
 modprobe eeprom 
 modprobe w83627hf 
 # sleep 2 # optional 
 /usr/bin/sensors -s # recommended 
 #----cut here---- 
  
 WARNING! If you have some things built into your kernel, the list
above 
 will contain too many modules. Skip the appropriate ones! You really
should 
 try these commands right now to make sure everything is working
properly. 
 Monitoring programs won't work until it's done. 
  
 Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): 
 Copy /usr/share/doc/packages/sensors/prog/init/lm_sensors.init.suse 
 to /etc/init.d/lm_sensors for initialization at boot time. 
  
 Dieses wurde ausgegeben. 
  
 Dann habe ich in /etc/modprobe.conf.local eingetragen: 
 #----cut here---- 
 # I2C module options 
 alias char-major-89 i2c-dev 
 #----cut here---- 
 
 Dann habe ich in /etc/init.d/boot.local eingetragen 
 #----cut here---- 
 # I2C adapter drivers 
 modprobe i2c-viapro 
 modprobe i2c-isa 
 # I2C chip drivers 
 modprobe eeprom 
 modprobe w83627hf 
 # sleep 2 # optional 
 /usr/bin/sensors -s # recommended 
 #----cut here---- 
  
 Habe die Datei lm_sensors.init.suse kopiert wie es beschrieben steht. 
  
 Und neu gestartet. 
 
 Sensors 
 w83697hf-isa-0290 
 Adapter: ISA adapter 
 VCore: +1.66 V (min = +1.71 V, max = +1.89 V) 
 +3.3V: +2.93 V (min = +3.14 V, max = +3.47 V) 
 +5V: +4.92 V (min = +4.76 V, max = +5.24 V) 
 +12V: +11.49 V (min = +10.82 V, max = +13.19 V) 
 -12V: -12.28 V (min = -13.18 V, max = -10.80 V) 
 -5V: -5.15 V (min = -5.25 V, max = -4.75 V) 
 V5SB: +5.48 V (min = +4.76 V, max = +5.24 V) 
 VBat: +0.13 V (min = +2.40 V, max = +3.60 V) 
 fan1: 0 RPM (min = 19852 RPM, div = 2) 
 fan2: 0 RPM (min = 75000 RPM, div = 2) 
 temp1: +50?C (high = +11?C, hyst = -100?C) sensor = diode 
 temp2: +61.5?C (high = +80?C, hyst = +75?C) sensor = diode 
 alarms: 
 beep_enable: 
 Sound alarm enabled 
  
 eeprom-i2c-0-52 
 Adapter: SMBus Via Pro adapter at 0400 
 Memory type: DDR SDRAM DIMM 
 Memory size (MB): 512 
  
 eeprom-i2c-0-50 
 Adapter: SMBus Via Pro adapter at 0400 
 Memory type: DDR SDRAM DIMM 
 Memory size (MB): 512 
  
  
 Aber die Ventielatoren werden nicht angezeigt! 
 Und was ist mit dem dritten Ventilator? CPU; System, Northbridg! 
 
 Und kann man die Werte von der Grafikkarte auslesen? 
 ?ber Windoof gibt es von ASUS ein Tool mit dem man Spannung,
Temperatur, 
Ventilatoren auslesen kann. 
  
 Was mu? ich jetzt machen? 
 
 Ich habe einen AMD Athlon XP 3.200, MSI-7047 VIA KT880 Delta mit VIA
VT8237 Chipset und Winbond W8369HF Chip, ATI Readon 9800XT 256MB von
ASUS. Sensors 2.9.0 SuSE Linux 9.3 2.6.11.4-20a-default
 
Bitte helft mir weiter! 
 
Vielen herzlichen Dank! 
 
JMK!

