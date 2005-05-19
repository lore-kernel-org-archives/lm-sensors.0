From: jim.chen@hytec-electronics.co.uk (Jim Chen)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: lm_sensors doesn't detect voltage measurements on HP Proliant DL320
Message-Id: <000201c49a51$c73208b0$aa790251@hytecelectronics.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Skipped content of type multipart/alternative-------------- next part --------------
[root@localhost root]# sensors-detect
 
This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things mUntitled 1ay
seem a bit confusing, but they will still work.
 
It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.
 
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:0f.0: ServerWorks CSB6 South Bridge
Probe succesfully concluded.
 
We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no):
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
 
Next adapter: SMBus PIIX4 adapter at 0700 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x33
Client found at address 0x53
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x60
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
  Failed! (0xee15)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0xee15)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0xee15)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC8741x Super IO'
  Success... (no hardware monitoring capabilities)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M172 Super IO'
  Failed! (0xee)
Probing for `VT1211 Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0xee)
Probing for `Winbond W83L517D Super IO'
  Failed! (0xee)
 
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
  * Bus `SMBus PIIX4 adapter at 0700' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x53
    Chip `SPD EEPROM' (confidence: 8)
 
 
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
modprobe i2c-piix4
# I2C chip drivers
modprobe eeprom
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
[root@localhost root]# modprobe i2c-piix4
[root@localhost root]# modprobe eeprom
[root@localhost root]# sensors -s
[root@localhost root]# sensors
eeprom-i2c-0-53
Adapter: SMBus PIIX4 adapter at 0700
Memory type:            DDR SDRAM DIMM
Memory size (MB):       128
 
[root@localhost root]# sensors-detect
 
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
Use driver `i2c-piix4' for device 00:0f.0: ServerWorks CSB6 South Bridge
Probe succesfully concluded.
 
We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.
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
 
Next adapter: SMBus PIIX4 adapter at 0700 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x33
Client at address 0x53 can not be probed - unload all client drivers first!
Client found at address 0x60
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
  Failed! (0xee15)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0xee15)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0xee15)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC8741x Super IO'
  Success... (no hardware monitoring capabilities)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M172 Super IO'
  Failed! (0xee)
Probing for `VT1211 Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0xee)
Probing for `Winbond W83L517D Super IO'
  Failed! (0xee)
 
Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
 
 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.
 See doc/FAQ, doc/lm_sensors-FAQ.html, or
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
 (FAQ #4.24.3) for further information.
 If you find out what chips are on your board, see
 http://secure.netroedge.com/~lm78/newdrivers.html for driver status.
[root@localhost root]#
