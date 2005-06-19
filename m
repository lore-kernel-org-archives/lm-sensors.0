From: chris@ripptech.com (Chris Ripp)
Date: Sun, 19 Jun 2005 15:44:01 +0000
Subject: [lm-sensors] Req for sensors help w/ Asus PC-DL
Message-Id: <42B57668.60502@ripptech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42B4EC0B.1020603@ripptech.com>
In-Reply-To: <42B4EC0B.1020603@ripptech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:

>Hi
>
>Please send us output of sensors-detect.
>
>Also can you visually confirm if you have W83792D on your motherboard?
>
>  
>
[snip]

Output of sensors-detect attached.    The machine is remotely located,
but I know for a fact there are sensors on this board as I've had them
working in the past... As can be seen here: (hey thats me! :] )
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket30

System is running gentoo, and like I said, I can probe the modules and I
get nothing in dmesg ,/sys/, /proc/ or sensors output... 
I appreciate it...


 # sensors-detect

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
Use driver `i2c-matroxfb' for device 03:09.0: MGA 1064SG [Mystique]
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-matroxfb' (say NO if built into your kernel)? (YES/no):
FATAL: Module i2c_matroxfb not found.
Loading failed... skipping.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 0500
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x2f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83791SD'... Success!
    (confidence 3, driver `not-a-sensor')
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `ITE IT8712F'... Failed!
Probing for `ITE IT8705F / SiS 950'... Failed!
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x48
Probing for `National Semiconductor LM75'... Failed!
Probing for `National Semiconductor LM77'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Maxim MAX6650/MAX6651'... Failed!
Probing for `National Semiconductor LM92'... Failed!
Probing for `National Semiconductor LM76'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x49
Probing for `National Semiconductor LM75'... Failed!
Probing for `National Semiconductor LM77'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `National Semiconductor LM92'... Failed!
Probing for `National Semiconductor LM76'... Failed!
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
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
    (confidence 1, driver `smbus-arp')
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
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x8282)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x8282)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x8282)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0x82)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0x82)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0x82)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0x82)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0x82)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x82)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x82)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x82)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0x82)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0x82)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0x82)
Probing for `SMSC 47M172 Super IO'
  Failed! (0x82)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0x82)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83627THF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x82)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x82)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (0x8282)

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

Driver `not-a-sensor' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0500'
    Busdriver `i2c-i801', I2C address 0x2f
    Chip `Winbond W83791SD' (confidence: 3)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0500'
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0500'
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0500'
    Busdriver `i2c-i801', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)

Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0500'
    Busdriver `i2c-i801', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)


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
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
# Warning: the required module smbus-arp is not currently installed on
your system.
# For status of 2.6 kernel ports see
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
modprobe smbus-arp
modprobe w83627hf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.

