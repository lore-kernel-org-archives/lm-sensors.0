From: keenanpepper@gmail.com (Keenan Pepper)
Date: Mon, 30 May 2005 01:03:52 +0000
Subject: [lm-sensors] SMSC LPC47M192 - "Device is disabled, will not use"
Message-Id: <429A4A2E.8040601@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <429A1930.6040409@gmail.com>
In-Reply-To: <429A1930.6040409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> It means that the logical device is disabled and it most cases it means that this chip is not used for hw. monitoring.

Disabled by what?

> Please can you tell us your motherboard brand and model?

The box is an HP pavilion a302x. I think the motherboard is a Trigem Imperial, 
with an 845GL northbridge and an ICH4 southbridge.

> Also please run sensors-detect script include whole output in your next email.

Attached.

> Tell us what version of kernel and lm_sensors you use.

Kernel 2.6.12-rc5-mm1, lm_sensors version 2.9.1.

-------------- next part --------------

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
 Do you want to probe now? (YES/no): Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801DB ICH4
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
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

Next adapter: SMBus I801 adapter at 1880
Do you want to scan it? (YES/no/selectively): Client found at address 0x08
Client found at address 0x0c
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85 or LM96000'... Failed!
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `National Semiconductor LM93'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Winbond W83L785R'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Philips NE1619'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `Analog Devices ADM1030'... Failed!
Probing for `Analog Devices ADM1031'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `VIA VT1211 (I2C)'... Failed!
Probing for `ITE IT8712F'... Failed!
Probing for `ITE IT8705F / SiS 950'... Failed!
Probing for `ALi M5879'... Failed!
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): Probing for `National Semiconductor LM78'
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

Do you want to scan for Super I/O sensors? (YES/no): Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x6001)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x6001)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x6001)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0x60)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0x60)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0x60)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0x60)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0x60)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x60)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x60)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x60)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Success... but not activated
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0x60)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0x60)
Probing for `SMSC 47M172 Super IO'
  Failed! (0x60)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0x60)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no): Probing for `ITE 8702F Super IO Sensors'
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
  * Bus `SMBus I801 adapter at 1880'
    Busdriver `i2c-i801', I2C address 0x50
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
modprobe i2c-i801
# I2C chip drivers
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO): 
