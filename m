From: juanpedro@fibertel.com.ar (Juan Pedro Pereyra)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Constant beep and ALARM warnings on ALI1535
Message-Id: <200402011238.42152.juanpedro@fibertel.com.ar>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401311948.50570.juanpedro@fibertel.com.ar>
In-Reply-To: <200401311948.50570.juanpedro@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> In fact I don't think you have an LM78 on this motherboard. It's too
> recent, LM78 have been replaced by other chips since Pentium II's or
> similar.

Ok, but some indicators, like temp, seem to work pretty well and the 
"i2c-ali1535" makes some sense provided that the k7ada uses an ALI chipset.

> Please provide the full output of sensors-detect for your system (after
> unloading lm78 and eeprom and any other chip driver you would have
> loaded). I think that the chipset you have is misdetected.

Here you go, the WHOLE output:

athos:~# sensors-detect
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
 Do you want to probe now? (YES/no): YESProbing for PCI bus adapters...
Use driver `i2c-ali15x3' for device 00:11.0: Acer Labs 1533/1543
Use driver `i2c-ali1535' for device 00:11.0: Acer Labs 1535
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-ali15x3' (say NO if built into your kernel)? (YES/no): YES
/lib/modules/2.4.24/kernel/drivers/i2c/busses/i2c-ali15x3.o: init_module: No 
such device
Hint: insmod errors can be caused by incorrect module parameters, including 
invalid IO or IRQ parameters
/lib/modules/2.4.24/kernel/drivers/i2c/busses/i2c-ali15x3.o: insmod /lib/
modules/2.4.24/kernel/drivers/i2c/busses/i2c-ali15x3.o failed
/lib/modules/2.4.24/kernel/drivers/i2c/busses/i2c-ali15x3.o: insmod 
i2c-ali15x3 failed
Loading failed ()... skipping.
Load `i2c-ali1535' (say NO if built into your kernel)? (YES/no): YES
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): NO
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): YES
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus ALI1535 adapter at 0400 (Non-i2c SMBus adapter)
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x2c
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Success!
    (confidence 7, driver `lm78')
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
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
Client found at address 0x69

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):YESProbing for `National 
Semiconductor LM78'
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
Driver `lm78' (should be inserted):
  Detects correctly:
  * Bus `SMBus ALI1535 adapter at 0400' (Non-i2c SMBus adapter)
    Busdriver `i2c-ali1535', I2C address 0x2c
    Chip `National Semiconductor LM78' (confidence: 7)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus ALI1535 adapter at 0400' (Non-i2c SMBus adapter)
    Busdriver `i2c-ali1535', I2C address 0x50
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?
WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, edit /etc/modules and add the modules
 listed here to it:

#----cut here----
# I2C adapter drivers
i2c-ali1535
# I2C chip drivers
lm78
eeprom
#----cut here----

Then, run /etc/init.d/modutils


To make the sensors modules behave correctly, add these lines to
/etc/modutils/local and run update-modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
athos:~#

> Also, please provide the output of "i2cdump 0 0x2c" (after unloading
> lm78, too).

athos:/dev# i2cdump 0 0x2c
Warning: no size specified (using byte-data access)
Error: Could not open file `/dev/i2c-0' : No such device
athos:/dev#

<quote> `/dev/i2c-0' exists in filesystem </quote>

I guess that's all, let me know if I can help you with anything else.

Best regards,
Juan Pedro Pereyra

-- 
Juan Pedro Pereyra <juanpedro@fibertel.com.ar>
Ciudad de Buenos Aires, Argentina
athos server @ athos.thesource.com.ar
Linux User  # 344472
