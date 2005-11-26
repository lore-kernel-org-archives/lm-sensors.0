From: a_titov82@mail.ru (Alexey Titov)
Date: Sat, 26 Nov 2005 07:47:49 +0000
Subject: [lm-sensors] Ticket #2103
Message-Id: <op.s0t5dwepn40jst@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I don?t think we ever saw an IT8705F or IT8712F chip, it?s usually found  
> in
> desktop systems. It may be a misdetection. Please follow up on our  
> mailing list,
> provide the complete output of "sensors detect".

Thank you for answer. Here is my sensors-detect output. It would be nice,  
if you can help...

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

  IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
  IBM Thinkpads have a severely broken i2c/SMBus implementation, just  
scanning
  the bus will break your Thinkpad forever!
  If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We have
  had users reporting system breakage on other IBM systems as well.

  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-sis96x' for device 00:02.1: Silicon Integrated Systems  
SMBus Controller
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-sis96x' already loaded.
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

Next adapter: SiS96x SMBus adapter at 0xe800
Do you want to scan it? (YES/no/selectively):
[root@alex120 ~]# sensors-detect

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

  IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
  IBM Thinkpads have a severely broken i2c/SMBus implementation, just  
scanning
  the bus will break your Thinkpad forever!
  If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We have
  had users reporting system breakage on other IBM systems as well.

  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-sis96x' for device 00:02.1: Silicon Integrated Systems  
SMBus Controller
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-sis96x' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

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

Next adapter: SiS96x SMBus adapter at 0xe800
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x10
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
     (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
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
   Failed! (0x8705)
Probing for `ITE 8705F Super IO Sensors'
   Success... found at address 0x0800
Probing for `ITE 8712F Super IO Sensors'
   Failed! (0x8705)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
   Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
   Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
   Failed! (skipping family)

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
   * Bus `SiS96x SMBus adapter at 0xe800' (Algorithm unavailable)
     Busdriver `i2c-sis96x', I2C address 0x50
     Chip `SPD EEPROM' (confidence: 8)
   * Bus `SiS96x SMBus adapter at 0xe800' (Algorithm unavailable)
     Busdriver `i2c-sis96x', I2C address 0x51
     Chip `SPD EEPROM' (confidence: 8)

Driver `it87' (should be inserted):
   Detects correctly:
   * ISA bus address 0x0800 (Busdriver `i2c-isa')
     Chip `ITE 8705F Super IO Sensors' (confidence: 9)


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
modprobe i2c-sis96x
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
modprobe it87
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.
