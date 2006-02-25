From: meirf@attglobal.net (meir)
Date: Sat, 25 Feb 2006 19:07:42 +0000
Subject: [lm-sensors] lm_sensors install question (newbie)
Message-Id: <4400AAFE.6000602@attglobal.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I would appreciate anyone's suggestions on this.  I am
a user who is new to i2c/lm_sensors.

HARDWARE (2 MACHINES)
---------------------

1) Toshiba P25 S609 laptop
   Chipset: Intel 865PE + ICH5

2) Desktop with KT40A-ANH 'Mach 4' motherboard
   Chipset: Via KT400A CD + Via 8235CE

SOFTWARE ON BOTH MACHINES
--------------------------

Linux kernel 2.4.26
Slackware 10.0
lm_sensors  i2c 2.8.8.

TOSHIBA INSTALL
---------------

When I run sensors-detect I get the following message:

  Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5

The rest of the test fails to detect anything.

DESKTOP INSTALL
---------------

When I run sensor-detect I have more success detecting
devices.  It says:

  In /etc/modules.conf add:
    alias char-major-89 i2c-dev

  To load everything that is needed, add this to some /etc/rc* file:

  # I2C adapter drivers
  # modprobe unknown adapter bt848 #0
  modprobe i2c-isa
  # I2C chip drivers
  modprobe eeprom
  modprobe pca9540
  modprobe w83627hf
  # sleep 2 # optional
  /usr/local/bin/sensors -s # recommended

No problems modprobing i2c-dev.

I get MODPROBE ERROR "Can't locate module"
      FOR MODULES i2c-isa, eeprom, pca9450, w83627fh

QUESTIONS
---------

I think I need drivers:

  Toshiba: i2c-i801
  Desktop: i2c-isa, eeprom, pca9450, w83627fh

I don't think any of them are in i2c/lm_sensors 2.8.8 kernel 2.4.
Are these available? where?  I don't think I can switch to kernel 2.6 now.

(By the way, I also use bttv, video4linux for Hauppage WinTV card on the 
Desktop machine).

Thanks for any help.

Meir


**************** TOSHIBA FULLER LISTING OF SENSORS-DETECT **************

Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
modprobe: Can't locate module i2c-i801
Loading failedDo you want to scan the ISA bus? (YES/no):
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
... skipping.

 We can start with probing for (PCI) I2C or SMBus adapters.
 YDo you want to scan for Super I/O sensors? (YES/no):    
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0xfc00)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0xfc00)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0xfc00)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0xfc)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0xfc)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0xfc)
Probing for `SMSC 47M172 Super IO'
  Failed! (0xfc)
Probing for `VT1211 Super IO Sensors'
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
Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
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

 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.

**************** DESKTOP FULLER LISTING OF SENSORS-DETECT **************

Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies 
VT8233A/8235 South Bridge
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-viapro' (say NO if built into your kernel)? (YES/no):
modprobe: Can't locate module i2c-viapro
Loading failed... skipping.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

Next adapter: bt848 #0
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client at address 0x61 can not be probed - unload all client drivers first!
Client found at address 0x70
Probing for `Philips Semiconductors PCA9540'... Success!
    (confidence 1, driver `pca9540')
Client found at address 0x71
Client found at address 0x72
Client found at address 0x73
Probing for `FSC Poseidon'... Failed!
Probing for `FSC Scylla'... Failed!
Probing for `FSC Hermes'... Failed!
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
Probing for `Winbond W83697HF'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
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

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83697HF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x60)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x60)

Do you want to scan for secondary Super I/O sensors? (YES/no):
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

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `bt848 #0' (Bit-shift algorithm)
    Busdriver `UNKNOWN', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)

Driver `pca9540' (should be inserted):
  Detects correctly:
  * Bus `bt848 #0' (Bit-shift algorithm)
    Busdriver `UNKNOWN', I2C address 0x70
    Chip `Philips Semiconductors PCA9540' (confidence: 1)

Driver `w83781d' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF Super IO Sensors' (confidence: 9)





