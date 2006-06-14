From: dan@dogsbody.org (Dogsbody)
Date: Wed, 14 Jun 2006 02:29:33 +0000
Subject: [lm-sensors] ASUS K8V-X SE should be supported?
Message-Id: <448F748D.5000703@dogsbody.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have just spent the last four hours on this and I seem to be going around in 
circles.  I really hope that I'm not about to ask a stupid question! :-\

I have a ASUS K8V-X SE motherboard with a VT8237R chip.  The chip seems to be 
discovered fine but all it can see is two eeprom's (two sticks of memory).  I 
can view the temperatures, fan speeds and voltages in the BIOS but not in 
lm_sensors.

Below is my diagnostic info.  I am ignoring the "rivatv" as I believe that is 
just for the graphics card which I don't use anyway and so thought pointless to 
install the drivers for.  I hope that is OK.

Thank you very much in advance for any help.

Regards, Dan


# uname -a
Linux 2.6.9-34.0.1.EL #1 Wed May 24 07:40:56 CDT 2006 i686 athlon i386 GNU/Linux

# sensors -v
sensors version 2.8.7 with libsensors version 2.8.7

# /usr/sbin/sensors-detect

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
Use driver `rivatv' for device 01:00.0: GeForce2 MX
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies VT8237 South Bridge
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `rivatv' (say NO if built into your kernel)? (YES/no):
FATAL: Module rivatv not found.
Loading failed... skipping.
** Note: rivatv module is available at http://rivatv.sourceforge.net/
Load `i2c-viapro' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
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

Next adapter: SMBus Via Pro adapter at 0400 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
     (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
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
   Failed! (0x88)
Probing for `Winbond W83627HF Super IO Sensors'
   Failed! (0x88)
Probing for `Winbond W83627THF Super IO Sensors'
   Failed! (0x88)
Probing for `Winbond W83637HF Super IO Sensors'
   Failed! (0x88)
Probing for `Winbond W83697HF Super IO Sensors'
   Failed! (0x88)
Probing for `Winbond W83697SF/UF Super IO PWM'
   Failed! (0x88)
Probing for `Winbond W83L517D Super IO'
   Failed! (0x88)

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

Driver `eeprom' (should be inserted):
   Detects correctly:
   * Bus `SMBus Via Pro adapter at 0400' (Algorithm unavailable)
     Busdriver `i2c-viapro', I2C address 0x50
     Chip `SPD EEPROM' (confidence: 8)
   * Bus `SMBus Via Pro adapter at 0400' (Algorithm unavailable)
     Busdriver `i2c-viapro', I2C address 0x51
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
modprobe i2c-viapro
# I2C chip drivers
modprobe eeprom
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


