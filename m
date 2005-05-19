From: joe.roback@gmail.com (Joe Roback)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: w83627hf - i2c - chip
Message-Id: <501c1e0304101519251491cf42@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <JZj4crVb.1097829064.8415090.khali@gcu.info>
In-Reply-To: <JZj4crVb.1097829064.8415090.khali@gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If you need any other info, I would be happy to help.
I know it is hard to collect data when developing for hardware you do
not have ;)

See my responses to your questions below.

cheers,
joe

On Fri, 15 Oct 2004 10:31:04 +0200 (CEST), Jean Delvare
<khali@linux-fr.org> wrote:
> 
> >I am just curious.
> >I have a dual AMD motherboard, gigabyte.
> >It has a winbond chip, w83627hf
> >
> >Why do the temperatures always seem skewed - they seem low...?
> >Why wouldn't the winbond chip just return the correct temperatures?
> >(not something that needs to have a calculation after it is returned
> >to userspace)
> >
> >How would I go about verifing the temperatures are correct? Maybe my
> >numbers are correct...
> >
> >Sample output:
> >joe@jedi /usr/src/linux-2.6.9-rc4/drivers/i2c/chips $ sensors
> >w83627hf-isa-0290
> >Adapter: ISA adapter
> >VCore 1:   +1.52 V  (min =  +0.00 V, max =  +0.00 V)
> >VCore 2:   +1.54 V  (min =  +0.00 V, max =  +0.00 V)
> >+3.3V:     +3.25 V  (min =  +3.14 V, max =  +3.47 V)
> >+5V:       +4.84 V  (min =  +4.76 V, max =  +5.24 V)
> >+12V:     +11.67 V  (min = +10.82 V, max = +13.19 V)
> >-12V:     -12.61 V  (min = -13.18 V, max = -10.80 V)
> >-5V:       -5.25 V  (min =  -5.25 V, max =  -4.75 V)
> >V5SB:      +5.24 V  (min =  +4.76 V, max =  +5.24 V)
> >VBat:      +3.01 V  (min =  +2.40 V, max =  +3.60 V)
> >fan1:        0 RPM  (min =    0 RPM, div = 2)
> >fan2:        0 RPM  (min =    0 RPM, div = 2)
> >fan3:        0 RPM  (min =    0 RPM, div = 2)
> >M/B:         +29 C  (high =   +45 C, hyst =   +42 C)   sensor = thermistor
> >CPU1:      +32.0 C  (high =   +80 C, hyst =   +77 C)   sensor = thermistor
> >CPU2:      +42.5 C  (high =   +80 C, hyst =   +77 C)   sensor = thermistor
> >ERROR: Can't get VID data!
> >alarms:
> >beep_enable:
> >          Sound alarm disabled
> 
> Easy. The reported temperatures are those of the CPU socket, below the
> CPU. Not the internal CPU temperature which would be way higher and
> change much faster.
> 
> >if i use a calculated value like from another chip in sensors.conf i get
> >these:
> >M/B:         +52 C  (high =   +45 C, hyst =   +43 C)   sensor > >thermistor   ALARM
> >CPU1:      +53.3 C  (high =   +80 C, hyst =   +77 C)   sensor = thermistor
> >CPU2:      +56.8 C  (high =   +80 C, hyst =   +77 C)   sensor = thermistor
> 
> These computations are weird ways to approximate the CPU temperature from
> the socket temperature. They do not correspond to a real temperature.
> Some motherboard makers (Asus...) do such computations in the BIOS setup
> screen too (and after that, user complain because lm_sensors yields
> different values). I don't think it's clever. Internal CPU temperature
> changes very fast (like +10 degree C in a second), while the socket
> temperature varies very slowly. Also, there is no simple correlation
> between socket and CPU temperature. Depends on the CPU, heatsink, fan
> and ambient temperature. I prefer to have a real, physical temperature
> value for the socket than a guessed (and wrong) value for the CPU
> temperature.
> 
> >Also, my motherboard manual says I have a w83627hf, but lm90 also
> >works, but it only displays MB temp and CPU1 temp and from what I
> >understand, lm90 does not support 3 temperatures...
> 
> What is your motherboard brand/model?

Gigabyte 7DPXDW-P
http://www.giga-byte.com/Server/Products/Products_ServerBoard_GA-7DPXDW-P.htm

> 
> You are right, the LM90 only supports one local and one remote
> temperature sensor. However, it is possible that the LM90 is
> multiplexed, either on the SMBus (two LM90 chips) or at the diode level
> (one LM90 but two thermal sensors).
> 
> Please provide the output of sensors-detect (after unloading all the
> monitoring chip drivers).

jedi ~ # sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c/*
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
Use driver `i2c-amd756' for device 00:07.3: AMD-768 System Management
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-amd756' (say NO if built into your kernel)? (YES/no):
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

Next adapter: SMBus AMD756 adapter at 50e0 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
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
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Probing for `National Semiconductor LM90'... Success!
    (confidence 8, driver `lm90')
Probing for `National Semiconductor LM89/LM99'... Failed!
Probing for `National Semiconductor LM86'... Failed!
Probing for `Analog Devices ADM1032'... Failed!
Probing for `Maxim MAX6657/MAX6658/MAX6659'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Probing for `Analog Devices ADT7461'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
    (confidence 1, driver `smbus-arp')
Client found at address 0x69
Client found at address 0x70
Probing for `Philips Semiconductors PCA9540'... Failed!

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

Driver `lm90' (should be inserted):
  Detects correctly:
  * Bus `SMBus AMD756 adapter at 50e0' (Algorithm unavailable)
    Busdriver `i2c-amd756', I2C address 0x4c
    Chip `National Semiconductor LM90' (confidence: 8)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus AMD756 adapter at 50e0' (Algorithm unavailable)
    Busdriver `i2c-amd756', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus AMD756 adapter at 50e0' (Algorithm unavailable)
    Busdriver `i2c-amd756', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)

Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus AMD756 adapter at 50e0' (Algorithm unavailable)
    Busdriver `i2c-amd756', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)

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
# I2C chip drivers
modprobe lm90
modprobe eeprom
modprobe smbus-arp
modprobe w83627hf
# sleep 2 # optional
/usr/bin/sensors -s # recommended

Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify
other file name?
  (yes/NO/s):

> It's kind of fun since we were just discussing the way we are going to
> handle the SMBus multiplexing on another board (and all boards which
> need it in general).
> 
> Jean Delvare
> 


-- 
1.618
