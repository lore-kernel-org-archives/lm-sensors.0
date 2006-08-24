From: prakash@punnoor.de (Prakash Punnoor)
Date: Thu, 24 Aug 2006 08:01:10 +0000
Subject: [lm-sensors] Asus M2NPV-VM and lm-sensors not working
Message-Id: <200608241001.14052.prakash@punnoor.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

the mobo has nforce430 (MCP51) chipset. sensors-detect tells me the it87 
driver should be the right one, but it doesn't seem to help:

lsmod:
Module                  Size  Used by
i2c_dev                 9992  0
it87                   23140  0
hwmon_vid               3456  1 it87
i2c_isa                 4736  1 it87
eeprom                  6736  0
loop                   57172  0
powernow_k8            12640  1
i2c_nforce2             7488  0
nvidia               5424340  12
i2c_core               19776  6 i2c_dev,it87,i2c_isa,eeprom,i2c_nforce2,nvidia

sensors:
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!
For older kernels, make sure you have done 'modprobe i2c-proc'!

I am using 2.6.18-rc4 kernel with lm-sensors 2.10.0

Any idea what to do? Thx.


# sensors-detect revision 1.413 (2006/01/19 20:28:00)

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
Sorry, no PCI bus adapters found.

We will now try to load each adapter module in turn.
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

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Probing for `DDC monitor'... Success!
    (confidence 8, driver `eeprom'), other addresses: 0x51 0x52 0x53 0x54 0x55 
0x56 0x57
Probing for `Maxim MAX6900'... Failed!

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus nForce2 adapter at 4c40
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08

Next adapter: SMBus nForce2 adapter at 4c00
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client at address 0x52 can not be probed - unload all client drivers first!
Client at address 0x53 can not be probed - unload all client drivers first!

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
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Success!
    (confidence 8, driver `it87')
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
  Failed! (0x8716)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x8716)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x8716)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
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
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `NVIDIA I2C Device'
    Busdriver `UNKNOWN', I2C address 0x50 (and 0x51 0x52 0x53 0x54 0x55 0x56 
0x57)
    Chip `DDC monitor' (confidence: 8)

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8712F' (confidence: 8)


I will now generate the commands needed to load the I2C modules.

If you want to load the modules at startup, generate a config file
below and make sure lm_sensors gets started at boot time; e.g
$ rc-update add lm_sensors default

To make the sensors modules behave correctly, add these lines to
/etc/modules.d/lm_sensors and run modules-update:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----end cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.
To load everything that is needed, execute the commands below...

#----cut here----
# I2C adapter drivers
# modprobe unknown adapter NVIDIA I2C Device
# modprobe unknown adapter NVIDIA I2C Device
# modprobe unknown adapter NVIDIA I2C Device
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
modprobe it87
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----end cut here----

Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify other file 
name?
  (yes/NO/s):


-- 
(?=                 =?)
//\ Prakash Punnoor /\\
V_/                 \_V
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060824/a6cfb9fe/attachment.bin 
