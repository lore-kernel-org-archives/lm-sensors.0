From: walt_h@lorettotel.net (Walt H)
Date: Fri, 19 Jan 2007 00:18:31 +0000
Subject: [lm-sensors] F71882FG driver request
Message-Id: <45B00E57.5030008@lorettotel.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Just wanted to add another to the list of requests for this driver. 
This is in a MSI P965 Platinum M/B, and a recent version of 
sensors-detect reports thusly:


# sensors-detect revision $Revision$

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801H ICH8

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: NVIDIA i2c adapter 2 at 1:00.0 (i2c-3)
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter 1 at 1:00.0 (i2c-2)
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter 0 at 1:00.0 (i2c-1)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x37
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Success!
     (confidence 1, driver `eeprom')
Probing for `EDID EEPROM'...                                Success!
     (confidence 8, driver `eeprom'), other addresses: 0x51 0x52 0x53
0x54 0x55 0x56 0x57
Probing for `Maxim MAX6900'...                              No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Success!
     (confidence 1, driver `eeprom')
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Success!
     (confidence 1, driver `eeprom')
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Success!
     (confidence 1, driver `eeprom')
Client found at address 0x54
Probing for `SPD EEPROM'...                                 Success!
     (confidence 1, driver `eeprom')
Client found at address 0x55
Probing for `SPD EEPROM'...                                 Success!
     (confidence 1, driver `eeprom')
Client found at address 0x56
Probing for `SPD EEPROM'...                                 Success!
     (confidence 1, driver `eeprom')
Client found at address 0x57
Probing for `SPD EEPROM'...                                 Success!
     (confidence 1, driver `eeprom')
Probing for `Sony Vaio EEPROM'...                           No

Next adapter: SMBus I801 adapter at 0400 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x2f
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM78-J'...              No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Winbond W83791SD'...                           No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG'...                          No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1029'...                     No
Probing for `ITE IT8712F'...                                No
Probing for `Fintek custom power control IC'...             No
Probing for `Winbond W83791D'...                            No
Client found at address 0x36
Client found at address 0x46
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x50
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x52
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x69

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Fintek F71882FG Super IO Sensors'                    Success!
     (address 0xa10, driver `to-be-written')

Some CPUs or memory controllers may also contain embedded sensors.
Do you want to scan for them? (YES/no):
AMD K8 thermal sensors...                                   No
Intel Core family thermal sensor...                         Success!
     (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `eeprom' (should be inserted):
   Detects correctly:
   * Bus `NVIDIA i2c adapter 0 at 1:00.0'
     Busdriver `UNKNOWN', I2C address 0x50 (and 0x51 0x52 0x53 0x54 0x55
0x56 0x57)
     Chip `EDID EEPROM' (confidence: 8)
   * Bus `SMBus I801 adapter at 0400'
     Busdriver `i2c-i801', I2C address 0x50
     Chip `eeprom' (confidence: 6)
   * Bus `SMBus I801 adapter at 0400'
     Busdriver `i2c-i801', I2C address 0x52
     Chip `eeprom' (confidence: 6)

   EEPROMs are *NOT* sensors! They are data storage chips commonly
   found on memory modules (SPD), in monitors (EDID), or in some
   laptops, for example.

Driver `to-be-written' (should be inserted):
   Detects correctly:
   * ISA bus, address 0xa10
     Chip `Fintek F71882FG Super IO Sensors' (confidence: 9)

Driver `coretemp' (should be inserted):
   Detects correctly:
   * Chip `Intel Core family thermal sensor' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
# modprobe unknown adapter NVIDIA i2c adapter 0 at 1:00.0
# modprobe unknown adapter NVIDIA i2c adapter 1 at 1:00.0
# modprobe unknown adapter NVIDIA i2c adapter 2 at 1:00.0
modprobe i2c-i801
# Chip drivers
modprobe eeprom
# no driver for Fintek F71882FG Super IO Sensors yet
# Warning: the required module coretemp is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
modprobe coretemp
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO): no


I've got some coding background, although it's a bit rough.  I've had a
few small patches integrated with the Linux kernel, but I'm mostly a
hack :)  I'm willing to test/help if I can. Thanks,

-Walt




