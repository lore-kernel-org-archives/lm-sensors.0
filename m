From: mlaia@fcav.unesp.br (Marcelo Luiz de Laia)
Date: Sun, 25 Sep 2005 00:47:00 +0000
Subject: [lm-sensors] my soyo syk7vem pro 1.0 shows 127 degrees for cpu
Message-Id: <4335D83A.3060608@fcav.unesp.br>
List-Id: <lm-sensors.vger.kernel.org>
References: <43304984.7090309@fcav.unesp.br>
In-Reply-To: <43304984.7090309@fcav.unesp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Marek,

Please, found below the sensors-detect output after unload all (i am not 
sure) modules.

root@lbmsala4b:/home/kurumin# sensors-detect

This program will help you determine which I2C/SMBus modules you need to 
load to use lm_sensors most effectively. You need to have i2c and 
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may 
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to 
all questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:07.4: VIA Technologies VT82C686 
Apollo ACPI
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-viapro' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang 
halfway  through; we can't really help that. Also, some chips will be 
double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you 
can  specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus Via Pro adapter at 5000
Do you want to scan it? (YES/no/selectively):
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 1, driver `lm80')
Probing for `National Semiconductor LM85 or LM96000'... Failed!
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `National Semiconductor LM93'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Winbond W83L785R'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Philips NE1619'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `Analog Devices ADM1030'... Failed!
Probing for `Analog Devices ADM1031'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `VIA VT1211 (I2C)'... Failed!
Probing for `ITE IT8712F'... Failed!
Probing for `ITE IT8705F / SiS 950'... Failed!
Probing for `ALi M5879'... Failed!
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
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Success!
    (confidence 9, driver `via686a')
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
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
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
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `lm80' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000'
    Busdriver `i2c-viapro', I2C address 0x2d
    Chip `National Semiconductor LM80' (confidence: 1)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000'
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus Via Pro adapter at 5000'
    Busdriver `i2c-viapro', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)

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
 I2C/SMBus (ISA/smbus)? ISA

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-viapro
i2c-isa
# I2C chip drivers
lm80
eeprom
via686a
#----cut here----

WARNING: Please note that i2c-viapro and via686a may conflict which
each other. If you get 'sensors not found', try loading only one module
at the same time.

Do you want to add these lines to /etc/modules automatically? (yes/NO)NO


Thank you very much

Marcelo
