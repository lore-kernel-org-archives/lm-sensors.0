From: john.sellers2@cox.net (John)
Date: Thu, 01 Mar 2007 22:27:30 +0000
Subject: [lm-sensors] doubly detected lm79 on ABIT BH6
Message-Id: <200703011727.31344.john.sellers2@cox.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm getting double readings of all my sensors and can't figure out how to fix it..  I've read the following faq... .

"Some sensors are doubly detected? ?

Yes, this is still a problem. It is partially solved by alias detection and confidence values in sensors-detect, but it is really tough.

Double detections can be caused by two things: sensors can be detected to both the ISA and the SMBus (and if you have loaded the approprate adapter drivers, it will be detected on both), and some chips simulate other chips (the Winbond W83781D simulates LM75 chips on the SMBus, for example). Remove the offending adapter or chip driver, or run sensors-detect and add the ignore= modprobe parameters it suggests. "

I can't figure out what the offending adapter or driver is or how to remove it.  I'm running the latest version of Simply Mepis on an ABIT BH6 r1.1 motherboard with ABIT slotket and 1.1MHz P3,  I also have an GeForce 6200 card installed, if that matters.  Below is the output from "sensors-detect."

root at 1[John]# sensors-detect
# sensors-detect revision 1.393 (2005/08/30 18:51:18)

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
 Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:07.3: Intel 82371AB PIIX4 ACPI
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

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively): y

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x37
Client found at address 0x3a
Probing for `Philips Semiconductors SAA1064'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Probing for `DDC monitor'... Success!
    (confidence 8, driver `eeprom'), other addresses: 0x51 0x52 0x53 0x54 0x55 0x56 0x57
Probing for `Maxim MAX6900'... Failed!

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively): y

Next adapter: SMBus PIIX4 adapter at 5000
Do you want to scan it? (YES/no/selectively): y
Client at address 0x2d can not be probed - unload all client drivers first!
Client found at address 0x30
Client found at address 0x31
Client found at address 0x32
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): y
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Success!
    (confidence 6, driver `lm78')
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

Do you want to scan for Super I/O sensors? (YES/no): y
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

Do you want to scan for secondary Super I/O sensors? (YES/no): y
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
  * Bus `NVIDIA I2C Device'
    Busdriver `UNKNOWN', I2C address 0x50 (and 0x51 0x52 0x53 0x54 0x55 0x56 0x57)
    Chip `DDC monitor' (confidence: 8)
  * Bus `SMBus PIIX4 adapter at 5000'
    Busdriver `i2c-piix4', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus PIIX4 adapter at 5000'
    Busdriver `i2c-piix4', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus PIIX4 adapter at 5000'
    Busdriver `i2c-piix4', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)

Driver `lm78' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `National Semiconductor LM79' (confidence: 6)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? isa

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
# modprobe unknown adapter NVIDIA I2C Device
# modprobe unknown adapter NVIDIA I2C Device
# modprobe unknown adapter NVIDIA I2C Device
i2c-piix4
i2c-isa
# I2C chip drivers
eeprom
lm78
#----cut here----

Do you want to add these lines to /etc/modules automatically? (yes/NO)y
root at 1[John]# sensors
lm79-isa-0290
Adapter: ISA adapter
VCore 1:   +1.78 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
VCore 2:   +1.50 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
+3.3V:     +3.30 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
+5V:       +5.08 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
+12V:     +11.80 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
-12V:     -11.40 V  (min =  -0.00 V, max =  -0.00 V)   ALARM
-5V:       -4.94 V  (min =  -0.00 V, max =  -0.00 V)   ALARM
fan1:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
fan2:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
fan3:     3770 RPM  (min =   -1 RPM, div = 2)          ALARM
temp:      +31.0?C  (high =    +0?C, hyst =    +0?C)
vid:       +1.75 V

lm79-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 5000
VCore 1:   +1.78 V  (min =  +0.00 V, max =  +0.00 V)
VCore 2:   +1.50 V  (min =  +0.00 V, max =  +0.00 V)
+3.3V:     +3.30 V  (min =  +0.00 V, max =  +0.00 V)
+5V:       +5.08 V  (min =  +0.00 V, max =  +0.00 V)
+12V:     +11.80 V  (min =  +0.00 V, max =  +0.00 V)
-12V:     -11.40 V  (min =  -0.00 V, max =  -0.00 V)
-5V:       -4.94 V  (min =  -0.00 V, max =  -0.00 V)
fan1:        0 RPM  (min =   -1 RPM, div = 2)
fan2:        0 RPM  (min =   -1 RPM, div = 2)
fan3:     3770 RPM  (min =   -1 RPM, div = 2)
temp:      +31.0?C  (high =    +0?C, hyst =    +0?C)
vid:       +1.75 V

root at 1[John]#                                                    
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070301/762edd95/attachment-0001.html 
