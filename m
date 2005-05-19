From: norbert.roos@cluster-labs.com (Norbert Roos)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: W83697HF detection problem and sensor segmentation fault
Message-Id: <3EA16D32.7050109@cluster-labs.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello!

I'm having the following problems with lm-sensors:

lm-sensors version 2.7.0 with a 2.4.20 kernel, i2c used as module.
Hardware is a W83697HF connected to a SiS962 south bridge (with LPC bus).


First i start sensors-detect, which does not detect the sensor chip:


--- sensors-detect ----------

  BIOS vendor (ACPI): AWARD
  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-sis5595' for device 00:02.0: Silicon Integrated Systems 
SIS5595
Probe succesfully concluded.

  We will now try to load each adapter module in turn.
Load `i2c-sis5595' (say NO if built into your kernel)? (YES/no): yes
Module loaded succesfully.
  Do you now want to be prompted for non-detectable adapters? (yes/NO): no
  To continue, we need module `i2c-dev' to be loaded.
  If it is built-in into your kernel, you can safely skip this.
  i2c-dev is not loaded. Do you want to load it now? (YES/no): yes
  Module loaded succesfully.

  We are now going to do the adapter probings. Some adapters may hang 
halfway
  through; we can't really help that. Also, some chips will be double 
detected;
  we choose the one with the highest confidence value in that case.
  If you found that the adapter hung after probing a certain address, 
you can
  specify that address to remain unprobed. That often
  includes address 0x69 (clock chip).

Next adapter: SMBus SIS5595 adapter at 0137 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): yes

  Some chips are also accessible through the ISA bus. ISA probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this.  Do you want to scan the ISA bus? (YES/no): yes
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
   Trying general detect... Success!
     (confidence 9, driver `sis5595')
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

  Now follows a summary of the probes I have just done.
  Just press ENTER to continue:

Driver `sis5595' (should be inserted):
   Detects correctly:
   * ISA bus, undetermined address (Busdriver `i2c-isa')
     Chip `Silicon Integrated Systems SIS5595' (confidence: 9)


  I will now generate the commands needed to load the I2C modules.
  Sometimes, a chip is available both through the ISA bus and an I2C bus.
  ISA bus access is faster, but you need to load an additional driver module
  for it. If you have the choice, do you want to use the ISA bus or the
  I2C/SMBus (ISA/smbus)?

WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe sis5595
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

--------------------

--- dmesg ----------

i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-sis5595.o version 2.7.0 (20021208)
i2c-sis5595.o: SIS5595 bus detected and initialized
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
i2c-dev.o: Registered 'SMBus SIS5595 adapter at 0137' as minor 0

--------------------

--- lsmod ----------

Module                  Size  Used by    Not tainted
i2c-dev                 4164   0
i2c-sis5595             3820   0
i2c-core               13960   0  [i2c-dev i2c-sis5595]

--------------------





Next, i'm doing from what sensors-detect told me:

modprobe i2c-isa
modprobe sis5595


and additionally i do

modprobe w83781d

and run sensors-detect again; this time the W83697HF is detected:

--- sensors-detect ----------

[...]

Next adapter: SMBus SIS5595 adapter at 0137 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):

  Some chips are also accessible through the ISA bus. ISA probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this.  Do you want to scan the ISA bus? (YES/no):
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
   Trying address 0x0290... Success!
     (confidence 8, driver `w83781d')
Probing for `Silicon Integrated Systems SIS5595'
   Trying general detect... Success!
     (confidence 9, driver `sis5595')
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

[...]

-------------------------------

--- dmesg ----------

i2c-isa.o version 2.7.0 (20021208)
i2c-dev.o: Registered 'ISA main adapter' as minor 1
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-proc.o version 2.7.0 (20021208)
sis5595.o version 2.7.0 (20021208)
w83781d.o version 2.7.0 (20021208)

--------------------

--- lsmod ---------

Module                  Size  Used by    Not tainted
w83781d                19408   0
sis5595                 6536   0  (unused)
i2c-proc                6928   0  [w83781d sis5595]
i2c-isa                 1128   0  (unused)
i2c-dev                 4164   0
i2c-sis5595             3820   0
i2c-core               13960   0  [w83781d sis5595 i2c-proc i2c-isa 
i2c-dev i2c-sis5595]

--------------------



Because the directory /proc/sys/dev/sensors/w83697hf-isa-0290 exists, I 
assume that the sensor chip now has been correctly detected.

So, this is not the major problem, but maybe this results in the 
following behaviour:

1. When I run "sensors -s", a segmentation fault appears. Same without 
the -s option.

2. When I look at the values in 
/proc/sys/dev/sensors/w83697hf-isa-0290/temp[12], I always get the same 
results ("60.0 127.0 59.0" from temp1 and "60.0 50.0 127.5" from temp2), 
no matter if the fan is running or not. Any temperature change is 
obviously not detected.

Do you have any ideas how to proceed?


Thanks in advance
Norbert



