From: spider@ir-club.ru (Alexey Belyaev)
Date: Sat, 21 May 2005 08:49:38 +0000
Subject: [lm-sensors] Help me with VT82C686 [Apollo Super ACPI]
Message-Id: <1777131136.20050521102201@ir-club.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

???????????, sensors! 

HELP!

# sensors -A
>eeprom-i2c-0-51
>Memory type:            SDR SDRAM DIMM
>Memory size (MB):       256

>eeprom-i2c-0-50
>Memory type:            SDR SDRAM DIMM
>Memory size (MB):       256

>lm80-i2c-0-2d
>+5V:       +4.71 V  (min =  +4.74 V, max =  +0.00 V)   ALARM
>VTT:       +1.50 V  (min =  +1.90 V, max =  +2.10 V)   ALARM
>+3.3V:     +2.55 V  (min =  +3.14 V, max =  +3.47 V)   ALARM
>+Vcore:    +0.37 V  (min =  +1.80 V, max =  +1.99 V)   ALARM
>+12V:     +13.26 V  (min = +11.43 V, max = +12.63 V)
>-12V:     -10.10 V  (min = -12.62 V, max = -11.42 V)
>-5V:       -3.87 V  (min =  -5.25 V, max =  -4.74 V)
>fan1:     10546 RPM  (min = 6053 RPM, div = 1)          ALARM
>fan2:     10150 RPM  (min =    0 RPM, div = 1)
>temp:     -128.00?C (hot: limit = -23?C, hyst =  -1?C) ALARM
>:                  (os:  limit =  +0?C, hyst = -70?C)
>alarms:   Board temperature input (LM75)               ALARM
>alarms:   Chassis intrusion detection                  ALARM

why "temp" < 0? why fan1/fan2 so high?

# sensors-detect

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
Use driver `i2c-viapro' for device 00:07.4: VIA Technologies VT82C686 Apollo ACPI
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
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

Next adapter: SMBus Via Pro adapter at 5000
Do you want to scan it? (YES/no/selectively):
Client at address 0x2d can not be probed - unload all client drivers first!
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x51 can not be probed - unload all client drivers first!
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
>Probing for `VIA Technologies VT82C686 Integrated Sensors'
>  Trying general detect... Success!
>    (confidence 9, driver `via686a')
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

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `via686a' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver `i2c-isa')
Hint: Try forcing the chip address. Consult the documentation
of particular chip for details and address value.
    Chip `VIA Technologies VT82C686 Integrated Sensors' (confidence: 9)


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
modprobe i2c-isa
# I2C chip drivers
modprobe via686a
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

______________________________________________________________________
? ?????????? ???????????, Alexey!
* Origin: H? ??? ?? ????????, ??? ??????. (25 ????? 2005 ?. 10:06:42)
?????? ??????: spider@omskart.ru
Under:Windows XP 5.1 Build 2600 Service Pack 2
WEB: http://kotlowan.net.ru


