From: thomas.guignard@epfl.ch (Thomas Guignard)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: lm_sensors reads only zero-values
Message-Id: <423937F9.5090403@epfl.ch>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

First of all thanks for all your work on this fantastic piece of 
software and for the nice documentation that comes along.

I was able to compile and install lm_sensors and i2c, and I did detect 
some sensors, but I get nonsense output (see below): zero values, or -1? C.

I have an Intel D865-GBFL motherboard and am running RedHat9, kernel 
2.4.27. I compiled i2c 2.9.0 (with 2.9.0.1 patch) and lm_sensors 2.9.0. 
I had to hack bmcsensors.c according to this link: 
http://www.linuxquestions.org/questions/showthread.php?postid10834#post1510834
to avoir compile-time errors.

I guess this is all I can tell you. I hope I will be able to monitor my 
temperature and so be able to lower the noise level of my box. Please 
ask if you need more info.

Best,
Thomas


Some info about my system:

[tguignar@lemapc77 tguignar]$ uname -a
Linux lemapc77 2.4.27 #1 SMP Fri Sep 10 11:30:47 CEST 2004 i686 i686 
i386 GNU/Linux

Here's what I get out of sensors:

[tguignar@lemapc77 tguignar]$ sensors
lm85b-i2c-0-2e
Adapter: SMBus I801 adapter at c400
in0:        +3.32 V  (min =  +3.32 V, max =  +3.32 V)   ALARM
in1:        +2.99 V  (min =  +2.99 V, max =  +2.99 V)   ALARM
in2:        +4.38 V  (min =  +4.38 V, max =  +4.38 V)   ALARM
in3:       +6.64 V  (min =  +6.64 V, max =  +6.64 V)   ALARM
in4:      +15.94 V  (min = +15.94 V, max = +15.94 V)   ALARM
fan1:         0 RPM  (min =    0 RPM)                     ALARM
fan2:         0 RPM  (min =    0 RPM)                     ALARM
fan3:         0 RPM  (min =    0 RPM)                     ALARM
fan4:         0 RPM  (min =    0 RPM)                     ALARM
temp1:        -1?C  (low  =    -1?C, high =    -1?C)     ALARM FAULT
temp2:        -1?C  (low  =    -1?C, high =    -1?C)     ALARM
temp3:        -1?C  (low  =    -1?C, high =    -1?C)     ALARM FAULT
pwm1:      255
pwm2:      255
pwm3:      255
vid:      +0.275 V  (VRM Version 9.1)

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at c400
Unknown EEPROM type (255).

eeprom-i2c-0-52
Adapter: SMBus I801 adapter at c400
Unknown EEPROM type (255).

arp-i2c-0-61
Adapter: SMBus I801 adapter at c400



Here is the output of sensors-detect:

[root@lemapc77 lm_sensors-2.9.0]> ./prog/detect/sensors-detect

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
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
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
  If you found that the adapter hung after probing a certain address, 
you can
  specify that address to remain unprobed. That often
  includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at c400
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85 or LM96000'... Success!
     (confidence 7, driver `lm85')
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!
Probing for `SMSC EMC6D100 or EMC6D101'... Failed!
Probing for `Analog Devices ADT7467'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `National Semiconductor LM93'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Winbond W83L785TS-S'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `Analog Devices ADM1030'... Failed!
Probing for `Analog Devices ADM1031'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `Analog Devices ADM1028'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x30
Client found at address 0x32
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
     (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
     (confidence 8, driver `eeprom')
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
     (confidence 1, driver `smbus-arp')
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
   Failed! (0xf0d1)
Probing for `ITE 8705F Super IO Sensors'
   Failed! (0xf0d1)
Probing for `ITE 8712F Super IO Sensors'
   Failed! (0xf0d1)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
   Failed! (0xf0)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
   Failed! (0xf0)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
   Failed! (0xf0)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
   Failed! (0xf0)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
   Failed! (0xf0)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
   Failed! (0xf0)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
   Failed! (0xf0)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
   Failed! (0xf0)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
   Failed! (0xf0)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
   Failed! (0xf0)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
   Success... found at address 0x06e0
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
   Failed! (0xf0)
Probing for `Nat. Semi. PC8739x Super IO'
   Failed! (0xf0)
Probing for `Nat. Semi. PC8741x Super IO'
   Failed! (0xf0)
Probing for `SMSC 47B27x Super IO Fan Sensors'
   Failed! (0xf0)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
   Failed! (0xf0)
Probing for `SMSC 47M14x Super IO Fan Sensors'
   Failed! (0xf0)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
   Failed! (0xf0)
Probing for `SMSC 47S42x Super IO Fan Sensors'
   Failed! (0xf0)
Probing for `SMSC 47S45x Super IO Fan Sensors'
   Failed! (0xf0)
Probing for `SMSC 47M172 Super IO'
   Failed! (0xf0)
Probing for `SMSC LPC47B397-NC Super IO'
   Failed! (0xf0)
Probing for `VT1211 Super IO Sensors'
   Failed! (0xf0)
Probing for `Winbond W83627HF Super IO Sensors'
   Failed! (0xf0)
Probing for `Winbond W83627THF Super IO Sensors'
   Failed! (0xf0)
Probing for `Winbond W83637HF Super IO Sensors'
   Failed! (0xf0)
Probing for `Winbond W83697HF Super IO Sensors'
   Failed! (0xf0)
Probing for `Winbond W83697SF/UF Super IO PWM'
   Failed! (0xf0)
Probing for `Winbond W83L517D Super IO'
   Failed! (0xf0)

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

Driver `lm85' (should be inserted):
   Detects correctly:
   * Bus `SMBus I801 adapter at c400' (Non-I2C SMBus adapter)
     Busdriver `i2c-i801', I2C address 0x2e
     Chip `National Semiconductor LM85 or LM96000' (confidence: 7)

Driver `eeprom' (should be inserted):
   Detects correctly:
   * Bus `SMBus I801 adapter at c400' (Non-I2C SMBus adapter)
     Busdriver `i2c-i801', I2C address 0x50
     Chip `SPD EEPROM' (confidence: 8)
   * Bus `SMBus I801 adapter at c400' (Non-I2C SMBus adapter)
     Busdriver `i2c-i801', I2C address 0x52
     Chip `SPD EEPROM' (confidence: 8)

Driver `smbus-arp' (should be inserted):
   Detects correctly:
   * Bus `SMBus I801 adapter at c400' (Non-I2C SMBus adapter)
     Busdriver `i2c-i801', I2C address 0x61
     Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)

Driver `to-be-written' (should be inserted):
   Detects correctly:
   * ISA bus address 0x06e0 (Busdriver `i2c-isa')
     Chip `Nat. Semi. PC87372 Super IO Fan Sensors' (confidence: 9)


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
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
modprobe lm85
modprobe eeprom
modprobe smbus-arp
# no driver for Nat. Semi. PC87372 Super IO Fan Sensors yet
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


-- 
Thomas Guignard
Laboratoire d'Electromagn?tisme et d'Acoustique
Ecole Polytechnique F?d?rale de Lausanne
Swiss Federal Institute of Technology, Lausanne

email: thomas.guignard@epfl.ch  |  EPFL-STI-ITOP-LEMA, ELB, Station 11
tel:   ++41 21 693 56 42        |  CH-1015 Lausanne, Switzerland
fax:   ++41 21 693 26 73        |  office: ELB 016
