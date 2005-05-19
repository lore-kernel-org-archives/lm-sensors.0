From: R.Gregory@liverpool.ac.uk (Richard Gregory)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: #1787 Wrong temps on dual 533FSB Xeon with i7505 chipset
Message-Id: <416FDE52.2040804@liv.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Below is the output of the CVS version of sensors-detect, as requested.

Some other points:
The winbound sensor chip is the only one present on the board, there are 
6 fan headers but the manual states only 3 have an RPM sensor. The exact 
part number is WinBond 83627HF

init=0 did not help, the temps were even more wrong.

The xeontemp docs say xeontemp only works for 400FSB xeons, as the 
533FSB xeons do not have an on chip sensor. As a result of this and the 
fact that the xeontemp driver is missing from my install, I did not try it.

Forcing other modules did not help, none ever detected the given hardware.

Can access the same not-quite-right sensor output over a different bus, 
I2C or SMBus ocmes back with the same data.


Richard

....
  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801DB ICH4
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no): YES
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

  To continue, we need module `i2c-dev' to be loaded.
  If it is built-in into your kernel, you can safely skip this.
  i2c-dev is not loaded. Do you want to load it now? (YES/no): YES
  Module loaded succesfully.

  We are now going to do the adapter probings. Some adapters may hang 
halfway through; we can't really help that. Also, some chips will be 
double detected; we choose the one with the highest confidence value in 
that case. If you found that the adapter hung after probing a certain 
address, you can specify that address to remain unprobed. That often
  includes address 0x69 (clock chip).
Error: First argument not a number!
Syntax: i2cdetect I2CBUS
   I2CBUS is an integer
   Installed I2C busses:
     i2c-0       smbus           SMBus I801 adapter at 18a0 
  Non-I2C SMBus adapter

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): YES
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

Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for `ITE 8702F Super IO Sensors'
   Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
   Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
   Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
   Failed! (0x52)
Probing for `Winbond W83627HF Super IO Sensors'
   Success... found at address 0x0c00
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

Do you want to scan for secondary Super I/O sensors? (YES/no): YES
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

Driver `w83627hf' (should be inserted):
   Detects correctly:
   * ISA bus address 0x0c00 (Busdriver `i2c-isa')
     Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)


  I will now generate the commands needed to load the I2C modules.
  Sometimes, a chip is available both through the ISA bus and an I2C bus.
  ISA bus access is faster, but you need to load an additional driver 
module for it. If you have the choice, do you want to use the ISA bus or 
the I2C/SMBus (ISA/smbus)? ISA
Error: First argument not a number!
Syntax: i2cdetect I2CBUS
   I2CBUS is an integer
   Installed I2C busses:
     i2c-0       smbus           SMBus I801 adapter at 18a0 
  Non-I2C SMBus adapter

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
modprobe w83627hf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really 
should try these commands right now to make sure everything is working 
properly. Monitoring programs won't work until it's done.
