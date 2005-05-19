From: jopr@tele2adsl.dk (Jonathan)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: Regardding Ticket #: 1791
Message-Id: <000001c4ad5f$6d5d83c0$843f4853@jonathan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I did not quite understand the part about ACPI
 
Here is the output of sensors-detect I hope it reveals something for
you.
 
Regards Jonathan
 
 
 
------------------------------------------------------------------------
------------------------------------------
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 6300ESB
Probe succesfully concluded.
 
We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no): NO
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.
 
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): NO
 Well, you will know best. We will just hope you edited
`/etc/modules.conf'
 for automatic loading of this module. If not,
 you won't be able to open any /dev/i2c/* file (unless youhave it
built-in
 into your kernel)
 
 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).
 
Next adapter: SMBus I801 adapter at 0400 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x42
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
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
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
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
  Failed! (0x52)
Probing for `Winbond W83627HF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x52)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x52)
 
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
  * Bus `SMBus I801 adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
 
Driver `w83781d' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF' (confidence: 8)
 
Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)
 

 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? smbus
 
If you want to load the modules at startup, generate a config file
below and make sure lm_sensors gets started; e.g
$ rc-update add lm_sensors default.
 
To make the sensors modules behave correctly, add these lines to
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
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
modprobe w83627hf
# sleep 2 # optional
/usr/bin/sensors -s # recommended
 
Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify
other file name?
  (yes/NO/s):
 
------------------------------------------------------------------------
-------------------------------------------------------
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041008/2ff677a0/attachment.html
