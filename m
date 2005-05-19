From: rouble@gmail.com (Pranab Mehta)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: 'Use the ddcmon and/or decode-edid.pl scripts' message
Message-Id: <a8007ab4050425164642962763@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

I run sensors-detect and it detects adapters and suggests the following 
drivers 
i2c-i810 and i2c-i801. These drivers get loaded succesfully. The adapters 
are 
scanned succesfully to, and clients are found. However there is no output 
after 
I issue 'sensors'.

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
Use driver `i2c-i810' for device 00:02.0: Intel 82815 GMCH
Use driver `i2c-i801' for device 00:1f.3: Intel 82801AA ICH
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-i810' already loaded.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

We are now going to do the adapter probings. Some adapters may hang halfway
through; we can't really help that. Also, some chips will be double 
detected;
we choose the one with the highest confidence value in that case.
If you found that the adapter hung after probing a certain address, you can
specify that address to remain unprobed. That often
includes address 0x69 (clock chip).

Next adapter: I810/I815 DDC Adapter
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x37

Client found at address 0x50

Probing for `SPD EEPROM'... Success!
(confidence 1, driver `eeprom')

Probing for `DDC monitor'... Success!
(confidence 8, driver `eeprom'), other addresses: 0x51 0x52 0x53 0x54 0x55 
0x56 0x57
Probing for `Maxim MAX6900'... Failed!

Next adapter: I810/I815 I2C Adapter
Do you want to scan it? (YES/no/selectively): 
Next adapter: SMBus I801 adapter at 1810
Do you want to scan it? (YES/no/selectively): Client found at address 0x30
Client found at address 0x31
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
(confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
(confidence 8, driver `eeprom')
Client found at address 0x54
Probing for `SPD EEPROM'... Success!
(confidence 1, driver `eeprom')
Client found at address 0x55
Probing for `SPD EEPROM'... Success!
(confidence 1, driver `eeprom')
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): Probing for `National 
Semiconductor LM78'
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
Probing for `Winbond W83697HF'
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
Failed! (0xe111)
Probing for `ITE 8705F Super IO Sensors'
Failed! (0xe111)
Probing for `ITE 8712F Super IO Sensors'
Failed! (0xe111)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
Failed! (0xe1)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
Success... found at address 0x0820
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
Failed! (0xe1)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
Failed! (0xe1)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
Failed! (0xe1)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
Failed! (0xe1)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
Failed! (0xe1)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
Failed! (0xe1)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
Failed! (0xe1)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
Failed! (0xe1)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
Failed! (0xe1)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
Failed! (0xe1)
Probing for `Nat. Semi. PC87591 Super IO'
Failed! (0xe1)
Probing for `Nat. Semi. PC87371 Super IO'
Failed! (0xe1)
Probing for `Nat. Semi. PC97371 Super IO'
Failed! (0xe1)
Probing for `Nat. Semi. PC8739x Super IO'
Failed! (0xe1)
Probing for `Nat. Semi. PC8741x Super IO'
Failed! (0xe1)
Probing for `SMSC 47B27x Super IO Fan Sensors'
Failed! (0xe1)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
Failed! (0xe1)
Probing for `SMSC 47M14x Super IO Fan Sensors'
Failed! (0xe1)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
Failed! (0xe1)
Probing for `SMSC 47S42x Super IO Fan Sensors'
Failed! (0xe1)
Probing for `SMSC 47S45x Super IO Fan Sensors'
Failed! (0xe1)
Probing for `SMSC 47M172 Super IO'
Failed! (0xe1)
Probing for `SMSC LPC47B397-NC Super IO'
Failed! (0xe1)
Probing for `VT1211 Super IO Sensors'
Failed! (0xe1)
Probing for `Winbond W83627HF Super IO Sensors'
Failed! (0xe1)
Probing for `Winbond W83627THF Super IO Sensors'
Failed! (0xe1)
Probing for `Winbond W83637HF Super IO Sensors'
Failed! (0xe1)
Probing for `Winbond W83697HF Super IO Sensors'
Failed! (0xe1)
Probing for `Winbond W83697SF/UF Super IO PWM'
Failed! (0xe1)
Probing for `Winbond W83L517D Super IO'
Failed! (0xe1)
Probing for `Winbond W83627EHF Super IO Sensors'
Failed! (0xe111)

Do you want to scan for secondary Super I/O sensors? (YES/no): 
Probing for `ITE 8702F Super IO Sensors'
Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
Failed! (skipping family)

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `eeprom' (should be inserted):
Detects correctly:
* Bus `I810/I815 DDC Adapter'
Busdriver `i2c-i810', I2C address 0x50 (and 0x51 0x52 0x53 0x54 0x55 0x56 
0x57)
Chip `DDC monitor' (confidence: 8)
* Bus `SMBus I801 adapter at 1810'
Busdriver `i2c-i801', I2C address 0x50
Chip `SPD EEPROM' (confidence: 8)
* Bus `SMBus I801 adapter at 1810'
Busdriver `i2c-i801', I2C address 0x51
Chip `SPD EEPROM' (confidence: 8)
* Bus `SMBus I801 adapter at 1810'
Busdriver `i2c-i801', I2C address 0x54
Chip `SPD EEPROM' (confidence: 1)
* Bus `SMBus I801 adapter at 1810'
Busdriver `i2c-i801', I2C address 0x55
Chip `SPD EEPROM' (confidence: 1)

Driver `pc87360' (should be inserted):
Detects correctly:
* ISA bus address 0x0820 (Busdriver `i2c-isa')
Chip `Nat. Semi. PC87360 Super IO Fan Sensors' (confidence: 9)


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
modprobe i2c-i810
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
modprobe pc87360
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


Now, when I follow all the instructions, and reboot my box, and run sensors 
I get:

~ #1004 > sensors
pc87360-isa-0820
Adapter: ISA adapter
fan1: 0 RPM (min = 952 RPM, div = 8) OVERFLOW
fan2: 0 RPM (min = 952 RPM, div = 8) OVERFLOW

eeprom-i2c-2-50
Adapter: I810/I815 DDC Adapter
Use the ddcmon and/or decode-edid.pl scripts.

eeprom-i2c-0-55
Adapter: SMBus I801 adapter at 1810
Unknown EEPROM type (48)

eeprom-i2c-0-54
Adapter: SMBus I801 adapter at 1810
Unknown EEPROM type (0)

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 1810
Memory type: SDR SDRAM DIMM
Memory size (MB): 128

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 1810
Memory type: SDR SDRAM DIMM
Memory size (MB): 128

what does it mean by 'Use the ddcmon and/or decode-edid.pl scripts' ?

and what am I doing wrong here. Any assistance is appreciated.

TIA,
rouble
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050425/06f2d17e/attachment.html
