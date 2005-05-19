From: margitsw@t-online.de (Margit Schubert-While)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: Intel M/B D845PESV not supported ?
Message-Id: <4.3.2.7.2.20030108200803.00b60c40@mail.dns-host.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
	Version 2.7.0 Linux 2.4.20
	Is this correct that I need LM85 which hasn't been written ?
	If yes, what's the status ?

	Cheers

	Margit

 >lspci
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host 
Bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge 
(rev 02)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW 
[Radeon 7500]
02:01.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
02:01.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
02:04.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH 
A1 ISDN [Fritz] (rev 02)
02:05.0 SCSI storage controller: Adaptec AIC-7861 (rev 03)
02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (LOM) Ethernet 
Controller (rev 82)
 >lspci -n
00:00.0 Class 0600: 8086:2560 (rev 02)
00:01.0 Class 0604: 8086:2561 (rev 02)
00:1d.0 Class 0c03: 8086:24c2 (rev 02)
00:1d.1 Class 0c03: 8086:24c4 (rev 02)
00:1d.2 Class 0c03: 8086:24c7 (rev 02)
00:1d.7 Class 0c03: 8086:24cd (rev 02)
00:1e.0 Class 0604: 8086:244e (rev 82)
00:1f.0 Class 0601: 8086:24c0 (rev 02)
00:1f.1 Class 0101: 8086:24cb (rev 02)
00:1f.3 Class 0c05: 8086:24c3 (rev 02)
00:1f.5 Class 0401: 8086:24c5 (rev 02)
01:00.0 Class 0300: 1002:5157
02:01.0 Class 0100: 9005:00c0 (rev 01)
02:01.1 Class 0100: 9005:00c0 (rev 01)
02:04.0 Class 0280: 1244:0a00 (rev 02)
02:05.0 Class 0100: 9004:6178 (rev 03)
02:08.0 Class 0200: 8086:1039 (rev 82)

 >sensors-detect

  BIOS vendor (ACPI): ACPIAM
  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801DB ICH4
Probe succesfully concluded.

  We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
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

Next adapter: SMBus I801 adapter at e000 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85'... Success!
     (confidence 7, driver `Unwritten: lm85')
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x30
Client found at address 0x44
Client found at address 0x50
Probing for `Serial EEPROM'... Success!
     (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x69
Client found at address 0x7f

  Some chips are also accessible through the ISA bus. ISA probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this.  Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
Character in "C" format wrapped at /disk01/sensors-detect.txt line 1260.
   Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
Character in "C" format wrapped at /disk01/sensors-detect.txt line 1260.
   Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
Character in "C" format wrapped at /disk01/sensors-detect.txt line 1260.
   Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
Character in "C" format wrapped at /disk01/sensors-detect.txt line 1260.
   Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
Character in "C" format wrapped at /disk01/sensors-detect.txt line 1260.
   Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
Character in "C" format wrapped at /disk01/sensors-detect.txt line 1260.
   Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
Character in "C" format wrapped at /disk01/sensors-detect.txt line 1260.
   Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
   Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
   Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
   Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
Character in "C" format wrapped at /disk01/sensors-detect.txt line 1260.
   Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
   Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
   Trying address 0x0ca8... Failed!

  Some Super I/O chips may also contain sensors. Super I/O probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this.  Do you want to scan for Super I/O sensors? (YES/no):
Probing for `SMSC 47M1xx Super IO Fan Sensors'
   Failed!
Probing for `VT1211 Super IO Sensors'
   Failed!
Probing for `Winbond W83627HF Super IO Sensors'
   Failed!
Probing for `Winbond W83697HF Super IO Sensors'
   Failed!

  Now follows a summary of the probes I have just done.
  Just press ENTER to continue:

Driver `Unwritten: lm85' (should be inserted):
   Detects correctly:
   * Bus `SMBus I801 adapter at e000' (Non-I2C SMBus adapter)
     Busdriver `i2c-i801', I2C address 0x2e
     Chip `National Semiconductor LM85' (confidence: 7)

Driver `eeprom' (should be inserted):
   Detects correctly:
   * Bus `SMBus I801 adapter at e000' (Non-I2C SMBus adapter)
     Busdriver `i2c-i801', I2C address 0x50
     Chip `Serial EEPROM' (confidence: 8)


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
modprobe i2c-i801
# I2C chip drivers
modprobe Unwritten: lm85
modprobe eeprom
# Next 2 lines are optional
sleep 3
/usr/local/bin/sensors -s
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
