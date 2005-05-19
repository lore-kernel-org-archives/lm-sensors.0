From: lists@localguru.de (Marcus Schopen)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: i2c-piix4 problem
Message-Id: <200408060107.17169.lists@localguru.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408041637.21472.lists@localguru.de>
In-Reply-To: <200408041637.21472.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 05 August 2004 08:06, Jean Delvare wrote:
> > > > The following kernel modules are loaded:
> > > >
> > > > # lsmod:
> > > > Module                  Size  Used by    Tainted: P
> > > > i2c-proc                6272   0
> > > > i2c-dev                 3680   0
> > > > i2c-piix4               3908   0
> > > > i2c-core               12160   0  [i2c-proc i2c-dev i2c-piix4]
> > >
> > > i2c-piix4 is a bus driver. You need an additional chip driver to get
> > > temperature readings. Try "sensors-detect" to find out which one you
> > > need.
> >
> > That's what sensors-detect found out / loaded.
>
> A.k.a. no sensors found, unless a problem occured. If you're certain
> that there is a hardware monitoring chip on that board and
> sensors-detect missed it, please give us:
> 1* The brand and name of the motherboard.
> 2* The full output of sensors-detect.
> 3* The brand and name of the monitoring chipset we are after.

I have physical access to the machine tomorrow or is there a way to check that 
remote. Here is the sensors-detect output: 

--------------------------------------------------------
# sensors-detect
 This program will help you to determine which I2C/SMBus modules you need to
 load to use lm_sensors most effectively.
 You need to have installed lm-sensors modules before you can use
 some functions of this utility.
 Also, you need to be `root', or at least have access to
 the /dev/i2c[-/]* files for some things.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation,  just scanning
 the bus will break your thinkpad forever!

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:07.3: Intel 82371AB PIIX4 ACPI
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
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

Next adapter: SMBus PIIX4 adapter at 5f00 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x30
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Client found at address 0x50
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x51
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 8, driver `eeprom')

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
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT 82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 5f00' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x50
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
  * Bus `SMBus PIIX4 adapter at 5f00' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x51
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)

 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? ISA

WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, edit /etc/modules and add the modules
 listed here to it:

#----cut here----
# I2C adapter drivers
i2c-piix4
# I2C chip drivers
eeprom
#----cut here----

Then, run /etc/init.d/modutils


To make the sensors modules behave correctly, add these lines to
/etc/modutils/local and run update-modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

---------------------------------------------------------------


Cheers,
Marcus
