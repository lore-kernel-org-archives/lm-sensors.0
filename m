From: brian@rapsure.net (Brian Beardall)
Date: Sun, 18 Jun 2006 17:16:49 +0000
Subject: [lm-sensors] CPU Temp on ECS NFORCE3-A939
Message-Id: <1150651009.20238.0.camel@rapsure.rapsure.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c69295$f481af80$7001a8c0@parisi02>
In-Reply-To: <000f01c69295$f481af80$7001a8c0@parisi02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2006-06-18 at 18:55 +0200, Jean Delvare wrote:
> Hi Brian,
> 
> Please stop dropping Lou from the loop, he is certainly interested in
> your case and may not be subscribed to the mailing list.
> 
> > Next adapter: SMBus PIIX4 adapter at 0400
> > Do you want to scan it? (YES/no/selectively):
> > Client found at address 0x30
> > Client found at address 0x31
> > Client found at address 0x4c
> > Probing for `National Semiconductor LM75'... Failed!
> > Probing for `Dallas Semiconductor DS1621'... Failed!
> > Probing for `Analog Devices ADM1021'... Failed!
> > Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
> > Probing for `Maxim MAX1617'... Failed!
> > Probing for `Maxim MAX1617A'... Failed!
> > Probing for `TI THMC10'... Failed!
> > Probing for `National Semiconductor LM84'... Failed!
> > Probing for `Genesys Logic GL523SM'... Failed!
> > Probing for `Onsemi MC1066'... Failed!
> > Probing for `Maxim MAX1619'... Failed!
> > Probing for `National Semiconductor LM82/LM83'... Failed!
> > Probing for `National Semiconductor LM90'... Failed!
> > Probing for `National Semiconductor LM89/LM99'... Failed!
> > Probing for `National Semiconductor LM86'... Failed!
> > Probing for `Analog Devices ADM1032'... Failed!
> > Probing for `Maxim MAX6657/MAX6658/MAX6659'... Failed!
> > Probing for `National Semiconductor LM63'... Failed!
> > Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
> > Probing for `Analog Devices ADT7461'... Failed!
> 
> 0x4c is a typical address for secondary temperature sensors. This
> version of sensors-detect failed to identify it. Please try the latest
> version:
> http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
> 

My output from the latest sensors-detect:
# sensors-detect revision $Revision$ ($Date$)

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to
all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:14.0: ATI Technologies Inc ATI
SMBus
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus PIIX4 adapter at 0400
Do you want to scan it? (YES/no/selectively):
Client found at address 0x30
Client found at address 0x31
Client found at address 0x4c
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
Probing for `Maxim MAX1619'... Failed!
Probing for `National Semiconductor LM82/LM83'... Failed!
Probing for `National Semiconductor LM90'... Failed!
Probing for `National Semiconductor LM89/LM99'... Failed!
Probing for `National Semiconductor LM86'... Failed!
Probing for `Analog Devices ADM1032'... Failed!
Probing for `Maxim MAX6657/MAX6658/MAX6659'... Failed!
Probing for `National Semiconductor LM63'... Failed!
Probing for `Fintek F75363SG'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Probing for `Analog Devices ADT7461'... Failed!
Probing for `Fintek F75383S/M'... Success!
    (confidence 7, driver `to-be-written')
Client at address 0x50 can not be probed - unload all client drivers
first!
Client at address 0x51 can not be probed - unload all client drivers
first!
Client found at address 0x69

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively):
Client found at address 0x37
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Probing for `DDC monitor'... Success!
    (confidence 8, driver `eeprom'), other addresses: 0x51 0x52 0x53
0x54 0x55 0x56 0x57
Probing for `Maxim MAX6900'... Failed!

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
Probing for `Winbond W83627DHG'
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
  Failed! (0x8712)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x8712)
Probing for `ITE 8712F Super IO Sensors'
  Success... found at address 0x0228
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

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 0400'
    Busdriver `i2c-piix4', I2C address 0x4c
    Chip `Fintek F75383S/M' (confidence: 7)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `NVIDIA I2C Device'
    Busdriver `UNKNOWN', I2C address 0x50 (and 0x51 0x52 0x53 0x54 0x55
0x56 0x57)
    Chip `DDC monitor' (confidence: 8)

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0228 (Busdriver `i2c-isa')
    Chip `ITE 8712F Super IO Sensors' (confidence: 9)


I will now generate the commands needed to load the I2C modules.

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
# modprobe unknown adapter NVIDIA I2C Device
# modprobe unknown adapter NVIDIA I2C Device
# modprobe unknown adapter NVIDIA I2C Device
modprobe i2c-isa
# I2C chip drivers
# no driver for Fintek F75383S/M yet
modprobe eeprom
modprobe it87
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really
should
try these commands right now to make sure everything is working
properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): no



