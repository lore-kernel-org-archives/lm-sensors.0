From: J.Kilb@gmx.de (Juergen Kilb)
Date: Sun, 27 Aug 2006 20:33:38 +0000
Subject: [lm-sensors] it8716 under 2.6
Message-Id: <200608272233.38164.J.Kilb@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060825084257.556030b7.khali@linux-fr.org>
In-Reply-To: <20060825084257.556030b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
here it is...
It seems that you are right. The script founds a ADT7475!!

====
prog/detect/sensors-detect
# sensors-detect revision 4116 (2006-08-27 21:51:38 +0200 (So, 27 Aug 2006))

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
 Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce4 SMBus 
(MCP55)
Probe successfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-nforce2' already loaded.
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

Next adapter: SMBus nForce2 adapter at 1c40
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x08
Client found at address 0x0c
Client found at address 0x22
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85 or LM96000'... Failed!
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'... Failed!
Probing for `Analog Devices ADT7462'... Failed!
Probing for `Analog Devices ADT7467 or ADT7468'... Failed!
Probing for `Analog Devices ADT7470'... Failed!
Probing for `Analog Devices ADT7473'... Failed!
Probing for `Analog Devices ADT7475'... Success!
    (confidence 5, driver `to-be-written')
Probing for `Analog Devices ADT7476'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `National Semiconductor LM93'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83793R/G'... Failed!
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
Probing for `Winbond W83627DHG'... Failed!
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
Probing for `Fintek F75373S/SG'... Failed!
Probing for `Fintek F75375S/SP'... Failed!
Probing for `Fintek F75387SG/RG'... Failed!
Probing for `Winbond W83791D'... Failed!

Next adapter: SMBus nForce2 adapter at 1c00
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x08
Client found at address 0x30
Client found at address 0x31
Client found at address 0x50
Probing for `Analog Devices ADM1033'... Failed!
Probing for `Analog Devices ADM1034'... Failed!
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `EDID EEPROM'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `Analog Devices ADM1033'... Failed!
Probing for `Analog Devices ADM1034'... Failed!
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')

Some chips are also accessible through the ISA I/O ports. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!

Do you want to scan the ISA I/O ports? (YES/no): yes
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
Probing for `Winbond W83627DHG'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `AMD K8 thermal sensors'
  Trying general detect... Success!
    (confidence 9, driver `k8temp')
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): yes
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x8716)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x8716)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x8716)
Probing for `ITE IT8716F Super IO Sensors'
  Success... found at address 0x0290
Probing for `ITE IT8718F Super IO Sensors'
  Failed! (0x8716)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no): yes
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

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 1c40'
    Busdriver `i2c-nforce2', I2C address 0x2e
    Chip `Analog Devices ADT7475' (confidence: 5)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 1c00'
    Busdriver `i2c-nforce2', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 1c00'
    Busdriver `i2c-nforce2', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

Driver `k8temp' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver `i2c-isa')
    Hint: Try forcing the chip address. Consult the documentation
          of particular chip for details and address value.
    Chip `AMD K8 thermal sensors' (confidence: 9)

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8716F Super IO Sensors' (confidence: 9)


I will now generate the commands needed to load the required modules.

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-nforce2
modprobe i2c-isa
# Chip drivers
# no driver for Analog Devices ADT7475 yet
modprobe eeprom
# Warning: the required module k8temp is not currently installed on your 
system.
# For status of 2.6 kernel ports see 
http://www.lm-sensors.org/wiki/SupportedDevices
# If driver is built-in to the kernel, or unavailable, comment out the 
following line.
modprobe k8temp
modprobe it87
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): n
===> > # Warning: the required module k8temp is not currently installed on your
> > system. # For status of 2.6 kernel ports see
> > http://www.lm-sensors.org/wiki/SupportedDevices # If driver is built-in
> > to the kernel, or unavailable, comment out the following line. modprobe
> > k8temp
>
> For this one you can pick these patches:
> http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-k8temp-new-driver.patch
> http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-k8temp-autoload.patch
>
> Thanks,

I will try these patches tomorrow.

good night...
Juergen

