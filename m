From: james-hunsaker@uiowa.edu (James A Hunsaker IV)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: SMBus I801: Can't open /dev/i2c-2
Message-Id: <1079342270.1650.182683010@webmail.messagingengine.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm emailing this because the support systems gives *no* acknowledgement
that it received it.


lm_sensors-2.8.5-0_23.rh9.at, kernel-2.4.20-30_37.rh9.at

Hello, I have an Intel CA810 motherboard.  During sensors-detect, I get
the following error:

Next adapter: SMBus I801 adapter at 0540 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Can't open /dev/i2c-2

I searched but cannot find why i2c-2 does not exist (despite
sensors-detect expecting it to).

Please help.

Thanks

PS Why does it say "confidence 1, driver `eeprom'" and then not include
"modprobe eeprom" in the script?  When I modprobe it, I do get valid
entries when running "sensors".


******* lspci ********


00:00.0 Host bridge: Intel Corp. 82810 GMCH [Graphics Memory Controller
Hub] (rev 02)
00:01.0 VGA compatible controller: Intel Corp. 82810 CGC [Chipset
Graphics Controller] (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 01)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 01)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 01)
00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 01)
01:07.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
06)
01:08.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00e7 (rev
01)
01:09.0 Ethernet controller: Lite-On Communications Inc LNE100TX [Linksys
EtherFast 10/100] (rev 25)
01:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.: Unknown
device 8180 (rev 20)


******* sensors-detect ********

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.
 
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i810' for device 00:01.0: Intel 82810 GMCH
Use driver `i2c-i801' for device 00:1f.3: Intel 82801AA ICH
Probe succesfully concluded.
 
 We will now try to load each adapter module in turn.
Load `i2c-i810' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.
 
 We are now going to do the adapter probings. Some adapters may hang
 halfway
 through; we can't really help that. Also, some chips will be double
 detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
 can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).
 
Next adapter: I810/I815 I2C Adapter (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively):
 
Next adapter: I810/I815 DDC Adapter (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Probing for `DDC monitor'... Success!
    (confidence 8, driver `ddcmon'), other addresses: 0x51 0x52 0x53 0x54
    0x55 0x56 0x57
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x53
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x54
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x55
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x56
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x57
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Probing for `Sony Vaio EEPROM'... Failed!
 
Next adapter: SMBus I801 adapter at 0540 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Can't open /dev/i2c-2
 
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
 this.  Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x5101)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x5101)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x5101)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87365 Super IO Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87366 Super IO Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Success... found at address 0x0800
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x51)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x51)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83697UF Super IO PWM'
  Failed! (0x51)
 
 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:
 
Driver `eeprom' (may not be inserted):
  Misdetects:
  * Bus `I810/I815 DDC Adapter' (Bit-shift algorithm)
    Busdriver `i2c-i810', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `I810/I815 DDC Adapter' (Bit-shift algorithm)
    Busdriver `i2c-i810', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `I810/I815 DDC Adapter' (Bit-shift algorithm)
    Busdriver `i2c-i810', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `I810/I815 DDC Adapter' (Bit-shift algorithm)
    Busdriver `i2c-i810', I2C address 0x53
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `I810/I815 DDC Adapter' (Bit-shift algorithm)
    Busdriver `i2c-i810', I2C address 0x54
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `I810/I815 DDC Adapter' (Bit-shift algorithm)
    Busdriver `i2c-i810', I2C address 0x55
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `I810/I815 DDC Adapter' (Bit-shift algorithm)
    Busdriver `i2c-i810', I2C address 0x56
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `I810/I815 DDC Adapter' (Bit-shift algorithm)
    Busdriver `i2c-i810', I2C address 0x57
    Chip `SPD EEPROM' (confidence: 1)
 
Driver `ddcmon' (should be inserted):
  Detects correctly:
  * Bus `I810/I815 DDC Adapter' (Bit-shift algorithm)
    Busdriver `i2c-i810', I2C address 0x50 (and 0x51 0x52 0x53 0x54 0x55
    0x56 0x57)
    Chip `DDC monitor' (confidence: 8)
 
Driver `to-be-written' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0800 (Busdriver `i2c-isa')
    Chip `SMSC 47B27x Super IO Fan Sensors' (confidence: 9)
 
 
 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver
 module
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
modprobe i2c-i810
modprobe i2c-isa
# I2C chip drivers
modprobe ddcmon
# no driver for SMSC 47B27x Super IO Fan Sensors yet, ask us for one!
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----
 
WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really
should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.
 
Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): no
 
