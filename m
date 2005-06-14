From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Tue, 14 Jun 2005 08:53:30 +0000
Subject: [lm-sensors] w83781d.o: Subclient 0 registration at address 0x49
Message-Id: <253818670506132351784d3e74@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ef564dc05061302175b8427fd@mail.gmail.com>
In-Reply-To: <2ef564dc05061302175b8427fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The odd thing is that NO subclient address are then scanned. Weird.
> Could mean that they are disabled, the w83627hf driver does that so it
> wouldn't be that surprising if you loaded it and did not reboot since.
> It's quite possible that the "force_subclients" option of the w83781d
> driver can change the addresses but not reenable disabled subclients.
> 
> Maybe you could try sensors-detect again after a cold reboot and the
> subclients will show. If you load w83781d with force_subclients before
> ever loading w83627hf, it might work.
> 

Ok, here it is after a cold reboot, looks a bit different:

-----------------------------------
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
Use driver `i2c-amd756' for device 00:07.3: AMD-8111 ACPI
Use driver `i2c-amd8111' for device 00:07.2: AMD-8111 SMBus 2.0
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-amd756' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
Load `i2c-amd8111' (say NO if built into your kernel)? (YES/no):
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

Next adapter: SMBus2 AMD8111 adapter at cc00
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08

Next adapter: SMBus AMD8111 adapter at 10e0
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x10
Client found at address 0x28
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83627HF'... Success!
    (confidence 7, driver `w83781d')
Probing for `Winbond W83627EHF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `ITE IT8712F'... Failed!
Probing for `ITE IT8705F / SiS 950'... Failed!
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85 or LM96000'... Failed!
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Success!
    (confidence 8, driver `lm85')
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'... Failed!
Probing for `Analog Devices ADT7467'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `National Semiconductor LM93'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
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
Probing for `ITE IT8712F'... Failed!
Probing for `ITE IT8705F / SiS 950'... Failed!
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
    (confidence 8, driver `eeprom')
Client found at address 0x55
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
  Trying address 0x0ca0... Success!
    (confidence 4, driver `bmcsensors')
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
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (0x5241)

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

Driver `w83781d' (should be inserted):
  Detects correctly:
  * Bus `SMBus AMD8111 adapter at 10e0'
    Busdriver `i2c-amd756', I2C address 0x28
    Chip `Winbond W83627HF' (confidence: 7)

Driver `lm85' (should be inserted):
  Detects correctly:
  * Bus `SMBus AMD8111 adapter at 10e0'
    Busdriver `i2c-amd756', I2C address 0x2e
    Chip `Analog Devices ADM1027, ADT7460 or ADT7463' (confidence: 8)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus AMD8111 adapter at 10e0'
    Busdriver `i2c-amd756', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus AMD8111 adapter at 10e0'
    Busdriver `i2c-amd756', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus AMD8111 adapter at 10e0'
    Busdriver `i2c-amd756', I2C address 0x54
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus AMD8111 adapter at 10e0'
    Busdriver `i2c-amd756', I2C address 0x55
    Chip `SPD EEPROM' (confidence: 8)

Driver `bmcsensors' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0ca0 (Busdriver `i2c-isa')
    Chip `IPMI BMC KCS' (confidence: 4)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

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
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.
To load everything that is needed, execute the commands above...

#----cut here----
# I2C adapter drivers
modprobe i2c-amd756
modprobe i2c-isa
# You must also install and load the IPMI modules
modprobe i2c-ipmi
# I2C chip drivers
modprobe w83781d
modprobe lm85
modprobe eeprom
# Warning: the required module bmcsensors is not currently installed
on your system.
# For status of 2.6 kernel ports see
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
modprobe bmcsensors
modprobe w83627hf
# sleep 2 # optional
/usr/bin/sensors -s # recommended
-----------------------------------

> 2.6 kernel with CONFIG_PNPACPI? Check /proc/ioports, see if there's
> something conflicting at 0x290-0x297.
Running 2.6.11.12 with CONFIG_PNPACPI=y and in /proc/ioports:
-----------------------------------
...
0295-0296 : pnp 00:07
..
-----------------------------------

modprobe w83781d force_subclients=1,0x28,0x4a,0x4b seems to fail with
the same message again even though the w83627hf driver hasn't been
loaded.

Thanks,
Yani
