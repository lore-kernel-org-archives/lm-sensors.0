From: tklc-sensors@kr4jb.net (Alan Porter)
Date: Wed, 03 Jan 2007 15:16:52 +0000
Subject: [lm-sensors] "sensors" no longer finding pcf8574 and pca9541
Message-Id: <459BC8E4.1010106@kr4jb.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello sensors people,

Where to start?  My name is Alan Porter, and I am in a little
over my head.  (Now I feel better).  I apologize in advance for
not being able to speak intelligently about what I am seeing,
but I am just now diving into this problem.

I just started a new job at a company that has a RedHat-based
distro that runs on telecom equipment.  We monitor the health of
our machines by running the "sensors" command and parsing the output
with a perl script.

Recently (within the last few months?), we have found that the
"sensors -A" command has stopped reporting some of our devices,
specifically:
 - the pcf8574 that monitors power supply health
 - the pca9541 -- not sure what this does

 From what I can tell, the kernel modules are loading properly,
because I get entries in the /sys filesystem.

   [root at doesnotwork i2c]# find /sys/bus/i2c
   /sys/bus/i2c
   /sys/bus/i2c/drivers
   /sys/bus/i2c/drivers/lm87
   /sys/bus/i2c/drivers/lm87/0-002d
   /sys/bus/i2c/drivers/pcf8574
   /sys/bus/i2c/drivers/pcf8574/0-0023
   /sys/bus/i2c/drivers/pcf8574/0-0022
   /sys/bus/i2c/drivers/pca9541
   /sys/bus/i2c/drivers/pca9541/0-0070
   /sys/bus/i2c/drivers/eeprom
   /sys/bus/i2c/drivers/eeprom/0-0057
   /sys/bus/i2c/drivers/eeprom/0-0053
   /sys/bus/i2c/drivers/lm93
   /sys/bus/i2c/drivers/lm93/0-002e
   /sys/bus/i2c/drivers/dev_driver
   /sys/bus/i2c/drivers/i2c_adapter
   /sys/bus/i2c/devices
   /sys/bus/i2c/devices/0-002d
   /sys/bus/i2c/devices/0-0023
   /sys/bus/i2c/devices/0-0022
   /sys/bus/i2c/devices/0-0070
   /sys/bus/i2c/devices/0-0057
   /sys/bus/i2c/devices/0-0053
   /sys/bus/i2c/devices/0-002e
   [root at doesnotwork i2c]#

The drivers appear to work.  They return "sane" data.  "128" means the
power supply is functioning properly with no warnings.

   [root at doesnotwork Driver]# cat /sys/bus/i2c/drivers/pcf8574/0-0022/read
   128
   [root at doesnotwork Driver]#

However, when I run "sensors -A", I no longer get the following entries
in the output:

   pcf8574-i2c-0-22
   pcf8574-i2c-0-23
   pca9541-i2c-0-70

When I load an older version of our platform (older kernel, same version of
lmsensors package), the "sensors -A" command includes these three entries.

I have included below some info about my two test systems (identical 
hardware,
I believe).

Hopefully someone on the list can shed a little light on why the "sensors"
command is reporting fewer devices now than it used to.

Thanks,

Alan

--------------------------------------------------------------------------------

[root at worksOK i2c]# uname -a
Linux localhost.localdomain 2.6.9-34.0.2.ELprerel3.0.0_60.17.0smp #1 SMP 
Wed Aug 23 16:58:48 EDT 2006 i686 i686 i386 GNU/Linux

[root at worksOK i2c]# i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX UU UU XX XX XX XX XX XX XX XX XX UU UU XX
30: 30 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX UU XX XX XX UU XX XX XX XX XX XX XX XX
60: XX XX 62 63 XX XX XX XX XX 69 XX XX XX XX 6e XX
70: UU XX XX XX XX XX XX XX

[root at worksOK i2c]# sensors -v
sensors version 2.10.0 with libsensors version 2.10.0

--------------------------------------------------------------------------------

[root at doesnotwork Driver]# uname -a
Linux doesnotwork 2.6.18-1.2849prerel3.0.0_60.31.0PAE #1 SMP Fri Dec 8 
15:37:48 EST 2006 i686 i686 i386 GNU/Linux

[root at doesnotwork Driver]# i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX UU UU XX XX XX XX XX XX XX XX XX UU UU XX
30: 30 31 32 33 34 35 36 37 XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: UU UU UU UU UU UU UU UU XX XX XX XX XX XX XX XX
60: XX XX 62 63 XX XX XX XX XX 69 XX XX XX XX 6e XX
70: UU XX XX XX XX XX XX XX

[root at doesnotwork Driver]# sensors -v
sensors version 2.10.0 with libsensors version 2.10.0

[root at doesnotwork Driver]# rmmod pcf8574
[root at doesnotwork Driver]# rmmod pca9541
[root at doesnotwork Driver]# rmmod eeprom
[root at doesnotwork Driver]# sensors-detect
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
Use driver `i2c-i801' for device 00:1f.3: Intel 6300ESB
Probe succesfully concluded.

We will now try to load each adapter module in turn.
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

Next adapter: SMBus I801 adapter at 0540
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x22
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Client found at address 0x23
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Client at address 0x2d can not be probed - unload all client drivers first!
Client at address 0x2e can not be probed - unload all client drivers first!
Client found at address 0x30
Client found at address 0x31
Client found at address 0x32
Client found at address 0x33
Client found at address 0x34
Client found at address 0x35
Client found at address 0x36
Client found at address 0x37
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
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x53
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x54
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x55
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x56
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x57
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `Sony Vaio EEPROM'... Failed!
Client found at address 0x62
Client found at address 0x63
Client found at address 0x69
Client found at address 0x6e
Client found at address 0x70
Probing for `Philips Semiconductors PCA9540'... Success!
    (confidence 1, driver `pca9540')

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
  Failed! (0xfc00)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0xfc00)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0xfc00)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0xfc)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0xfc)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0xfc)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0xfc)
Probing for `Nat. Semi. PCPC87427 Super IO'
  Failed! (0xfc)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `SMSC 47M172 Super IO'
  Failed! (0xfc)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0xfc)
Probing for `SMSC SCH5307-NS Super IO'
  Failed! (0xfc)
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
  * Bus `SMBus I801 adapter at 0540'
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0540'
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0540'
    Busdriver `i2c-i801', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0540'
    Busdriver `i2c-i801', I2C address 0x53
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0540'
    Busdriver `i2c-i801', I2C address 0x54
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0540'
    Busdriver `i2c-i801', I2C address 0x55
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0540'
    Busdriver `i2c-i801', I2C address 0x56
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0540'
    Busdriver `i2c-i801', I2C address 0x57
    Chip `SPD EEPROM' (confidence: 8)

Driver `pca9540' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0540'
    Busdriver `i2c-i801', I2C address 0x70
    Chip `Philips Semiconductors PCA9540' (confidence: 1)


I will now generate the commands needed to load the I2C modules.

To make the sensors modules behave correctly, add these lines to
/etc/modprobe.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
# I2C chip drivers
modprobe eeprom
# Warning: the required module pca9540 is not currently installed on 
your system.
# For status of 2.6 kernel ports see 
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the 
following line.
modprobe pca9540
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.

--------------------------------------------------------------------------------




