From: awolfego@telusplanet.net (Adam Wolfe Gordon)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: Support ticket #1593
Message-Id: <1000000.1078109984@[192.168.1.3]>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is the output of sensors-detect:

> [root@linux /home/adam]# sensors-detect
>  This program will help you to determine which I2C/SMBus modules you need
> to  load to use lm_sensors most effectively.
>  You need to have done a `make install', issued a `depmod -a' and made
> sure  `/etc/modules.conf' (or `/etc/conf.modules') contains the
> appropriate  module path before you can use some functions of this
> utility. Read  doc/modules for more information.
>  Also, you need to be `root', or at least have access to the
> /dev/i2c[-/]* files for some things if you do not have them already.  If
> you have patched your kernel and have some drivers built-in you can
>  safely answer NO if asked to load some modules. In this case, things may
>  seem a bit confusing, but they will still work.
>
>   BIOS vendor (ACPI): Nvidia
>  System vendor (DMI): ASUSTeK Computer INC.
>  BIOS version (DMI): ASUS A7N8X2.0 ACPI BIOS Rev 1005
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce2
> SMBus (MCP) Probe succesfully concluded.
>
>   We will now try to load each adapter module in turn.
> Load `i2c-nforce2' (say NO if built into your kernel)? (YES/no):
> Module loaded succesfully.
>  Do you now want to be prompted for non-detectable adapters? (yes/NO):
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
>  i2c-dev is not loaded. Do you want to load it now? (YES/no):
>  Module loaded succesfully.
>
>  We are now going to do the adapter probings. Some adapters may hang
> halfway  through; we can't really help that. Also, some chips will be
> double detected;  we choose the one with the highest confidence value in
> that case.  If you found that the adapter hung after probing a certain
> address, you can  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
>
> Next adapter: SMBus nForce2 adapter at 5000 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x08
> Client found at address 0x50
> Probing for `Serial EEPROM'... Success!
>     (confidence 1, driver `eeprom')
> Probing for `DDC monitor'... Failed!
> Client found at address 0x51
> Probing for `Serial EEPROM'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x53
> Probing for `Serial EEPROM'... Success!
>     (confidence 1, driver `eeprom')
>
> Next adapter: SMBus nForce2 adapter at 5500 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x08
> Client found at address 0x2d
> Probing for `Myson MTP008'... Failed!
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Failed!
> Probing for `National Semiconductor LM85'... Failed!
> Probing for `Analog Devices ADM1027 or ADT7463'... Failed!
> Probing for `SMSC EMC6D100 and EMC6D101'... Failed!
> Probing for `National Semiconductor LM87'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83791D'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Winbond W83L784R/AR'... Failed!
> Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
> Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
> Probing for `Genesys Logic GL520SM'... Failed!
> Probing for `Genesys Logic GL525SM'... Failed!
> Probing for `Analog Devices ADM9240'... Failed!
> Probing for `Dallas Semiconductor DS1780'... Failed!
> Probing for `National Semiconductor LM81'... Failed!
> Probing for `Analog Devices ADM1026'... Failed!
> Probing for `Analog Devices ADM1025'... Failed!
> Probing for `Analog Devices ADM1024'... Failed!
> Probing for `Analog Devices ADM1022'... Failed!
> Probing for `Texas Instruments THMC50'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x2f
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83791D'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Winbond W83L784R/AR'... Failed!
> Probing for `Analog Devices ADM9240'... Failed!
> Probing for `Dallas Semiconductor DS1780'... Failed!
> Probing for `National Semiconductor LM81'... Failed!
> Probing for `Analog Devices ADM1022'... Failed!
> Probing for `Texas Instruments THMC50'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x37
> Client found at address 0x48
> Probing for `National Semiconductor LM75'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Probing for `Philips Semiconductors PCF8591'... Success!
>     (confidence 1, driver `pcf8591')
> Client found at address 0x49
> Probing for `National Semiconductor LM75'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Probing for `Philips Semiconductors PCF8591'... Success!
>     (confidence 1, driver `pcf8591')
> Client found at address 0x4b
> Probing for `National Semiconductor LM75'... Success!
>     (confidence 2, driver `lm75')
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Probing for `Philips Semiconductors PCF8591'... Success!
>     (confidence 1, driver `pcf8591')
> Client found at address 0x6a
>
>  Some chips are also accessible through the ISA bus. ISA probes are
>  typically a bit more dangerous, as we have to write to I/O ports to do
>  this.  Do you want to scan the ISA bus? (YES/no):
> Probing for `National Semiconductor LM78'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM78-J'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM79'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83781D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83782D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83627HF'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83697HF'
>   Trying address 0x0290... Failed!
> Probing for `Silicon Integrated Systems SIS5595'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT82C686 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT8231 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'
>   Trying address 0x0290... Failed!
> Probing for `IPMI BMC KCS'
>   Trying address 0x0ca0... Failed!
> Probing for `IPMI BMC SMIC'
>   Trying address 0x0ca8... Failed!
>
>  Some Super I/O chips may also contain sensors. Super I/O probes are
>  typically a bit more dangerous, as we have to write to I/O ports to do
>  this.  Do you want to scan for Super I/O sensors? (YES/no):
> Probing for `SMSC 47M1xx Super IO Fan Sensors'
>   Failed! (0x87)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (0x87)
> Probing for `Winbond W83627HF Super IO Sensors'
>   Failed! (0x87)
> Probing for `Winbond W83627THF Super IO Sensors'
>   Failed! (0x87)
> Probing for `Winbond W83697HF Super IO Sensors'
>   Failed! (0x87)
>
>  Now follows a summary of the probes I have just done.
>  Just press ENTER to continue:
>
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus nForce2 adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-nforce2', I2C address 0x50
>     Chip `Serial EEPROM' (confidence: 1)
>   * Bus `SMBus nForce2 adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-nforce2', I2C address 0x51
>     Chip `Serial EEPROM' (confidence: 1)
>   * Bus `SMBus nForce2 adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-nforce2', I2C address 0x53
>     Chip `Serial EEPROM' (confidence: 1)
>
> Driver `pcf8591' (should be inserted but causes problems):
>   Detects correctly:
>   * Bus `SMBus nForce2 adapter at 5500' (Non-I2C SMBus adapter)
>     Busdriver `i2c-nforce2', I2C address 0x48
>     Chip `Philips Semiconductors PCF8591' (confidence: 1)
>   * Bus `SMBus nForce2 adapter at 5500' (Non-I2C SMBus adapter)
>     Busdriver `i2c-nforce2', I2C address 0x49
>     Chip `Philips Semiconductors PCF8591' (confidence: 1)
>   Misdetects:
>   * Bus `SMBus nForce2 adapter at 5500' (Non-I2C SMBus adapter)
>     Busdriver `i2c-nforce2', I2C address 0x4b
>     Chip `Philips Semiconductors PCF8591' (confidence: 1)
>
> Driver `lm75' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus nForce2 adapter at 5500' (Non-I2C SMBus adapter)
>     Busdriver `i2c-nforce2', I2C address 0x4b
>     Chip `National Semiconductor LM75' (confidence: 2)
>
>
>  I will now generate the commands needed to load the I2C modules.
>  Sometimes, a chip is available both through the ISA bus and an I2C bus.
>  ISA bus access is faster, but you need to load an additional driver
> module  for it. If you have the choice, do you want to use the ISA bus or
> the  I2C/SMBus (ISA/smbus)?
>
> To make the sensors modules behave correctly, add these lines to either
> /etc/modules.conf or /etc/conf.modules:
>
># ----cut here----
># I2C module options
> alias char-major-89 i2c-dev
> options pcf8591 ignore=1,0x4b
># ----cut here----
>
> To load everything that is needed, add this to some /etc/rc* file:
>
># ----cut here----
># I2C adapter drivers
> modprobe i2c-nforce2
># I2C chip drivers
> modprobe eeprom
> modprobe pcf8591
> modprobe lm75
># sleep 2 # optional
> /usr/local/bin/sensors -s # recommended
># ----cut here----
>
> WARNING! If you have some things built into your kernel, the list above
> will contain too many modules. Skip the appropriate ones! You really
> should try these commands right now to make sure everything is working
> properly. Monitoring programs won't work until it's done.
>
> Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
> Copy /usr/share/doc/packages/sensors/prog/init/lm_sensors.init
> to /etc/init.d/lm_sensors for initialization at boot time.

----------
Adam Wolfe Gordon
Email: awolfego@telusplanet.net
Public Key: http://www3.telus.net/awolfego
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040229/0431b834/attachment.bin
