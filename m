From: tebbens@yahoo.com (Mathew Tebbens)
Date: Tue, 27 Jun 2006 13:14:51 +0000
Subject: [lm-sensors] Support for Intel 82801GR (ICH7 Family)
Message-Id: <20060627131452.28668.qmail@web36810.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A125CA.3000603@correiolivre.serpro.gov.br>
In-Reply-To: <44A125CA.3000603@correiolivre.serpro.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm also running the same chipset
  lm_sensors is not working for me also.
   
  Let me know if you get yours working, and how.
   
  Here is my setup....
   
  [root at localhost tebbens]# /sbin/lspci
00:00.0 Host bridge: Intel Corporation 955X Memory Controller Hub
00:01.0 PCI bridge: Intel Corporation 955X PCI Express Graphics Port
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01)
00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express Port 5 (rev 01)
00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express Port 6 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01)
00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family) Serial ATA Storage Controllers cc=AHCI (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc R480 [Radeon X850XT Platinum (PCIE)]
01:00.1 Display controller: ATI Technologies Inc R480 [Radeon X850XT Platinum (PCIE)] (Secondary)
04:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751 Gigabit Ethernet PCI Express (rev 01)
05:03.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
05:03.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 04)
05:03.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04)
05:0a.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
[root at localhost tebbens]#
   
  ---------------------------------------------------------------------
   
  [root at localhost ~]# /usr/sbin/sensors-detect
# sensors-detect revision 1.393 (2005/08/30 18:51:18)
  This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.
  It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.
   We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel ICH7
Probe succesfully concluded.
  We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.
   To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.
   We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).
  Next adapter: SMBus I801 adapter at ece0
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x08
Client found at address 0x30
Client found at address 0x31
Client found at address 0x32
Client found at address 0x33
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x53
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69
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
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
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
  Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x7901)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x7901)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x7901)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0x79)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0x79)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0x79)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0x79)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0x79)
Probing for `Nat. Semi. PCPC87427 Super IO'
  Failed! (0x79)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x79)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x79)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x79)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0x79)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0x79)
Probing for `SMSC 47M172 Super IO'
  Failed! (0x79)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0x79)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)
  Do you want to scan for secondary Super I/O sensors? (YES/no): YES
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)
   Now follows a summary of the probes I have just done.
 Just press ENTER to continue:
  Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at ece0'
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at ece0'
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at ece0'
    Busdriver `i2c-i801', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at ece0'
    Busdriver `i2c-i801', I2C address 0x53
    Chip `SPD EEPROM' (confidence: 8)
  
 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? I2C/SMBus
  To make the sensors modules behave correctly, add these lines to
/etc/modprobe.conf:
  #----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
  To load everything that is needed, add this to some /etc/rc* file:
  #----cut here----
# I2C adapter drivers
modprobe i2c-i801
# I2C chip drivers
modprobe eeprom
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----
  WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.
  Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): YES
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
[root at localhost ~]#
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060627/5d8d1038/attachment-0001.html 
