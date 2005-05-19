From: fishor@gmx.net (Alexey Fisher)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: max1617a
Message-Id: <1703768730.20040510075627@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509133827.04734a7e.khali@linux-fr.org>
In-Reply-To: <20040509133827.04734a7e.khali@linux-fr.org>
To: lm-sensors@vger.kernel.org

Hi Jean

1* I'm running lm_sensors 2.8.6
2* Linux kernel 2.6.5 (but with some chenges in DRI section) i2c compilet as modules
3* Full output in attachment (sens.txt)

 >> (I guess max6650 and possibly eeprom)
You heve rite , it is.



-- 
Best regards,
 Alexey                            mailto:fishor@gmx.net
-------------- next part --------------
Script started on Mon 10 May 2004 07:41:59 AM CEST
[root@inna root]# sensors0[K-detect [K[K[K[K[K[K[K[K
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and done
'modprobe i2c_sensor'!
For older kernels, make sure you have done 'modprobe i2c-proc'!
[root@inna root]# sensors0[K-detect 

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
Use driver `i2c-piix4' for device 00:07.3: Intel 82371AB PIIX4 ACPI
Use driver `to-be-written' for device 01:01.0: S3 Savage IX MV
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no): 
Module loaded succesfully.
Load `to-be-written' (say NO if built into your kernel)? (YES/no): 
FATAL: Module to_be_written not found.
Loading failed... skipping.
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

Next adapter: SMBus PIIX4 adapter at 2180 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively): Client found at address 0x1f
Probing for `Maxim MAX6650/MAX6651'... Success!
    (confidence 4, driver `max6650')
Client found at address 0x30
Client found at address 0x4d
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Failed!
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Failed!
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
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
  Failed!
Probing for `ITE 8705F Super IO Sensors'
  Failed!
Probing for `ITE 8712F Super IO Sensors'
  Failed!
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87365 Super IO Sensors'
  Failed!
Probing for `Nat. Semi. PC87366 Super IO Sensors'
  Failed!
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed!
Probing for `VT1211 Super IO Sensors'
  Failed!
Probing for `Winbond W83627HF Super IO Sensors'
  Failed!
Probing for `Winbond W83627THF Super IO Sensors'
  Failed!
Probing for `Winbond W83637HF Super IO Sensors'
  Failed!
Probing for `Winbond W83697HF Super IO Sensors'
  Failed!
Probing for `Winbond W83697UF Super IO PWM'
  Failed!

Do you want to scan for secondary Super I/O sensors? (YES/no): 
Probing for `ITE 8702F Super IO Sensors'
  Failed!
Probing for `ITE 8705F Super IO Sensors'
  Failed!
Probing for `ITE 8712F Super IO Sensors'
  Failed!
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87365 Super IO Sensors'
  Failed!
Probing for `Nat. Semi. PC87366 Super IO Sensors'
  Failed!
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed!
Probing for `VT1211 Super IO Sensors'
  Failed!
Probing for `Winbond W83627HF Super IO Sensors'
  Failed!
Probing for `Winbond W83627THF Super IO Sensors'
  Failed!
Probing for `Winbond W83637HF Super IO Sensors'
  Failed!
Probing for `Winbond W83697HF Super IO Sensors'
  Failed!
Probing for `Winbond W83697UF Super IO PWM'
  Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 

Driver `max6650' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 2180' (Algorithm unavailable)
    Busdriver `i2c-piix4', I2C address 0x1f
    Chip `Maxim MAX6650/MAX6651' (confidence: 4)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 2180' (Algorithm unavailable)
    Busdriver `i2c-piix4', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? smbus

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
modprobe max6650
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): no

[root@inna root]# exit
exit

Script done on Mon 10 May 2004 07:43:24 AM CEST
