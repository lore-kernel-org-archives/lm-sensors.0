From: ander1@wanadoo.es (Ander)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: lm78 needs vrm 9.0
Message-Id: <1069704436.540.23.camel@agaliaretph>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069701990.540.3.camel@agaliaretph>
In-Reply-To: <1069701990.540.3.camel@agaliaretph>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I have a P4 mother board with the lm78 chip, and I can not set vrm
> > 9.0.
> 
> You're unlikely to have such an old chip on a P4 system. Which
> motherboard is it? Which version of lm_sensors is it? Send the output of
> sensors-detect for analysis.

The mother board is a Space Walker AV45GT.
lm_sensors version 2.6.5.

sensors-detect output:

 This program will help you to determine which I2C/SMBus modules you
need to
 load to use lm_sensors most effectively.
 You need to have installed lm-sensors modules before you can use
 some functions of this utility.
 Also, you need to be `root', or at least have access to
 the /dev/i2c[-/]* files for some things.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things
may
 seem a bit confusing, but they will still work.
 
 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation,  just
scanning
 the bus will break your thinkpad forever!
 
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies VT8233
VLink South Bridge
Probe succesfully concluded.
 
 We will now try to load each adapter module in turn.
Load `i2c-viapro' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): no
 Well, you will know best. We will just hope you edited
`/etc/conf.modules'
 (or `/etc/modules.conf') for automatic loading of this module. If not,
 you won't be able to open any /dev/i2c[-/]* file (unless youhave it
built-in
 into your kernel)
 
 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).
 
Next adapter: SMBus Via Pro adapter at 0500 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x1f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Client found at address 0x37
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
Client found at address 0x69
 
 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Success!
    (confidence 7, driver `lm78')
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
  Trying address 0x0290... Success!
    (confidence 7, driver `it87')
 
 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:
 
Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 0500' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
 
Driver `lm78' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `National Semiconductor LM78' (confidence: 7)
 
Driver `it87' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 7)
 
 
 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?
 
WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, edit /etc/modules and add the modules
 listed here to it:
 
#----cut here----
# I2C adapter drivers
i2c-viapro
i2c-isa
# I2C chip drivers
eeprom
lm78
#----cut here----
 
Then, run /etc/init.d/modutils
 
 
To make the sensors modules behave correctly, add these lines to
/etc/modutils/local and run update-modules:
 
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----


And the output of sensors:

eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at 0500
Algorithm: Non-I2C SMBus adapter
 
lm78-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.47 V  (min =  +0.00 V, max =  +0.57 V)
VCore 2:   +3.10 V  (min =  +0.00 V, max =  +0.00 V)
+3.3V:     +3.12 V  (min =  +2.97 V, max =  +0.00 V)
+5V:       +5.48 V  (min =  +4.50 V, max =  +5.48 V)
+12V:      +5.62 V  (min = +10.79 V, max = +13.11 V)
-12V:     -11.06 V  (min = -13.18 V, max = -10.78 V)
-5V:       -1.57 V  (min =  -5.48 V, max =  -4.50 V)
fan1:     6750 RPM  (min = 6000 RPM, div = 1)
fan2:     42187 RPM  (min = 6000 RPM, div = 1)
fan3:     19852 RPM  (min = 3000 RPM, div = 2)
temp:       +0.0?C  (limit =  +60?C, hysteresis =  +50?C)
vid:       +3.50 V


-- 

Ander Lozano P?rez
ander1@wanadoo.es

Desarrollador de DiaSCE
http://diasce.es.gnome.org
diasce@es.gnome.org
irc.gnome.org #DiaSCE
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Esta parte del mensaje esta firmada digitalmente
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031124/d81669df/attachment.bin
