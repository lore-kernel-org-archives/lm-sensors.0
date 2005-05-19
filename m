From: naundorf@aei-potsdam.mpg.de (Holger Naundorf)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: Ticket No 793
Message-Id: <Pine.LNX.4.21.0201211015450.22357-100000@xeon17.aei-potsdam.mpg.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
with the newest CVS version, the sensors seem to work correctly. There is
one unresolved symbol in the modules:

depmod: *** Unresolved symbols in
/lib/modules/2.4.18-pre4/misc/i2c-philips-par.o
depmod: 	parport_unregister_driver_Rsmp_cd2aff4a
depmod: 	parport_register_driver_Rsmp_a747e6da
depmod: 	parport_register_device_Rsmp_75a20b73
depmod: 	parport_unregister_device_Rsmp_0cffd5b6
depmod: 	parport_release_Rsmp_e2338255
depmod: 	parport_claim_or_block_Rsmp_aa1965f8

sensors-detect then gives:

 This program will help you to determine which I2C/SMBus modules you need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-/]* files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation,  just scanning
 the bus will break your thinkpad forever!

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): Probing for PCI bus adapters...
Use driver `i2c-amd756' for device 00:07.3: AMD-768 System Management
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-amd756' (say NO if built into your kernel)? (YES/no): Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):  To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):  Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus AMD7X6 adapter at e4e0 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): Client found at address 0x08
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Client found at address 0x0c
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Client found at address 0x0d
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Client found at address 0x0e
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Client found at address 0x0f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Success!
    (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x48
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM75'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x49
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): Probing for `National Semiconductor LM78'
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
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 
Driver `w83781d' (should be inserted):
  Detects correctly:
  * Bus `SMBus AMD7X6 adapter at e4e0' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2d (and 0x48 0x49)
    Chip `Winbond W83782D' (confidence: 8)

Driver `pcf8591' (may not be inserted):
  Misdetects:
  * Bus `SMBus AMD7X6 adapter at e4e0' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x48
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus AMD7X6 adapter at e4e0' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x49
    Chip `Philips Semiconductors PCF8591' (confidence: 1)

Driver `lm75' (may not be inserted):
  Misdetects:
  * Bus `SMBus AMD7X6 adapter at e4e0' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x49
    Chip `National Semiconductor LM75' (confidence: 3)


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
modprobe i2c-amd756
# I2C chip drivers
modprobe w83781d
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----



After inserting the modules
Module                  Size  Used by
w83781d                18160   0  (unused)
i2c-proc                6256   0  [w83781d]
i2c-dev                 3616   0 
i2c-amd756              3104   0 
i2c-core               13600   0  [w83781d i2c-proc i2c-dev i2c-amd756]



sensors gives this output:
Adapter: SMBus AMD7X6 adapter at e4e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.76 V  (min =  +1.66 V, max =  +2.03 V)              (beep)
VCore 2:   +1.77 V  (min =  +1.66 V, max =  +2.03 V)              (beep)
+3.3V:     +3.29 V  (min =  +2.97 V, max =  +3.63 V)              (beep)
+5V:       +4.91 V  (min =  +4.50 V, max =  +5.48 V)              (beep)
+12V:     +11.78 V  (min = +10.79 V, max = +13.11 V)              
-12V:     -11.05 V  (min = -13.21 V, max = -10.90 V)              
-5V:       -6.17 V  (min =  -5.51 V, max =  -4.51 V)              
V5SB:      +0.13 V  (min =  +0.13 V, max =  +0.13 V)              
VBat:      +0.08 V  (min =  +0.08 V, max =  +0.08 V)              
fan1:     4856 RPM  (min = 3000 RPM, div = 2)                     (beep)
fan2:      314 RPM  (min =  187 RPM, div = 32)                     (beep)
fan3:     2689 RPM  (min = 3000 RPM, div = 2)                     
temp1:       +25?C  (limit =  +60?C, hysteresis =  +50?C) sensor thermistor           (beep)
temp2:     +47.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor thermistor           (beep)
temp3:     +47.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904
transistor           
vid:       +1.85 V
alarms:   
beep_enable:
          Sound alarm disabled


This will require some tweaking in the sensors.conf to get the divisors
right, but otherwite looks very resonable to me.

Thanks for the quick support.

Holger

-- 
Holger Naundorf                            naundorf@aei-potsdam.mpg.de
MPI f?r Gravitationsphysik                 Phone (++49)(+331)567-7364 
Albert-Einstein-Institut                   Fax   (++49)(+331)567-7298 


