From: yann.savenye@wanadoo.fr (Yann SAVENYE)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Cannot have lm-sensors work with my NV7m ABIT motherboard
Message-Id: <1048326224.4015.63.camel@Ordiyann>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I own a ABIT NV7m motherboard with a AMD ATHLON CPU, based on the nVIDIA
nForce 420D chipset. The built-in chip appears to be a Winbond W83627HF,
which is normally supported by lm-sensors.

But when I do sensors-detect (as root), here is what I get:



This program will help you to determine which I2C/SMBus modules you need
to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made
sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the
/dev/i2c[-/]* files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev
files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things
may
 seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): Nvidia
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-amd756' for device 00:01.1: nVidia nForce SMBus
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Module `i2c-amd756' already loaded.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
yes
Load `i2c-elektor' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.21-0.11mdk/kernel/drivers/i2c/i2c-elektor.o.gz:
init_module: No
 such device
Hint: insmod errors can be caused by incorrect module parameters,
including inva
lid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
modprobe: insmod
/lib/modules/2.4.21-0.11mdk/kernel/drivers/i2c/i2c-elektor.o.gz
 failed
modprobe: insmod i2c-elektor failed
Loading failed... skipping.
Load `i2c-elv' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.21-0.11mdk/kernel/drivers/i2c/i2c-elv.o.gz:
init_module: No suc
h device
Hint: insmod errors can be caused by incorrect module parameters,
including inva
lid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
modprobe: insmod
/lib/modules/2.4.21-0.11mdk/kernel/drivers/i2c/i2c-elv.o.gz fai
led
modprobe: insmod i2c-elv failed
Loading failed... skipping.
Load `i2c-philips-par' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
Load `i2c-velleman' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.21-0.11mdk/kernel/drivers/i2c/i2c-velleman.o.gz:
init_module: N
o such device
Hint: insmod errors can be caused by incorrect module parameters,
including inva
lid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
modprobe: insmod
/lib/modules/2.4.21-0.11mdk/kernel/drivers/i2c/i2c-velleman.o.g
z failed
modprobe: insmod i2c-velleman failed
Loading failed... skipping.
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

Next adapter: bt848 #0 (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively): no

Next adapter: SMBus nVidia nForce adapter at ec00 (Non-I2C SMBus
adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x00
Client found at address 0x01
Client found at address 0x02
Client found at address 0x03
Client found at address 0x04
Client found at address 0x05
Client found at address 0x06
Client found at address 0x07
Client found at address 0x08
Client found at address 0x09
Client found at address 0x0a
Client found at address 0x0b
Probing for `Smart Battery'... Failed!
Client found at address 0x0c
Client found at address 0x0d
Client found at address 0x0e
Client found at address 0x0f
Client found at address 0x10
Client found at address 0x11
Client found at address 0x12
Client found at address 0x13
Client found at address 0x14
Client found at address 0x15
Client found at address 0x16
Client found at address 0x17
Client at address 0x18 can not be probed - unload all client drivers
first!
Client at address 0x19 can not be probed - unload all client drivers
first!
Client at address 0x1a can not be probed - unload all client drivers
first!
Client found at address 0x1b
Client found at address 0x1c
Client found at address 0x1d
Client found at address 0x1e
Client found at address 0x1f
Client at address 0x20 can not be probed - unload all client drivers
first!
Client at address 0x21 can not be probed - unload all client drivers
first!
Client at address 0x22 can not be probed - unload all client drivers
first!
Client at address 0x23 can not be probed - unload all client drivers
first!
Client at address 0x24 can not be probed - unload all client drivers
first!
Client at address 0x25 can not be probed - unload all client drivers
first!
Client at address 0x26 can not be probed - unload all client drivers
first!
Client at address 0x27 can not be probed - unload all client drivers
first!
Client at address 0x28 can not be probed - unload all client drivers
first!
Client at address 0x29 can not be probed - unload all client drivers
first!
Client at address 0x2a can not be probed - unload all client drivers
first!
Client at address 0x2b can not be probed - unload all client drivers
first!
Client at address 0x2c can not be probed - unload all client drivers
first!
Client at address 0x2d can not be probed - unload all client drivers
first!
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `National Semiconductor LM85'... Failed!
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
Client found at address 0x2f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
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
Client found at address 0x30
Client found at address 0x31
Client found at address 0x32
Client found at address 0x33
Client found at address 0x34
Client found at address 0x35
Client found at address 0x36
Client found at address 0x37
Client found at address 0x38
Client found at address 0x39
Client found at address 0x3a
Client found at address 0x3b
Client found at address 0x3c
Client found at address 0x3d
Client found at address 0x3e
Client found at address 0x3f
Client found at address 0x40
Client found at address 0x41
Client found at address 0x42
Client found at address 0x43
Client found at address 0x44
Client found at address 0x45
Client found at address 0x46
Client found at address 0x47
Client found at address 0x48
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x49
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x4a
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x4b
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client at address 0x4c can not be probed - unload all client drivers
first!
Client at address 0x4d can not be probed - unload all client drivers
first!
Client at address 0x4e can not be probed - unload all client drivers
first!
Client found at address 0x4f
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x50
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x51
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x52
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x53
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x54
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x55
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x56
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x57
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x58
Probing for `LTC1710'... Success!
    (confidence 1, driver `ltc1710')
Client found at address 0x59
Probing for `LTC1710'... Success!
    (confidence 1, driver `ltc1710')
Client found at address 0x5a
Probing for `LTC1710'... Success!
    (confidence 1, driver `ltc1710')
Client found at address 0x5b
Client found at address 0x5c
Client found at address 0x5d
Client found at address 0x5e
Client found at address 0x5f
Client found at address 0x60
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
    (confidence 1, driver `smbus-arp')
Client found at address 0x62
Client found at address 0x63
Client found at address 0x64
Client found at address 0x65
Client found at address 0x66
Client found at address 0x67
Client found at address 0x68
Client found at address 0x69
Client found at address 0x6a
Client found at address 0x6b
Client found at address 0x6c
Client found at address 0x6d
Client found at address 0x6e
Client found at address 0x6f
Client found at address 0x70
Client found at address 0x71
Client found at address 0x72
Client found at address 0x73
Probing for `FSC poseidon chip'... Failed!
Probing for `FSC Scylla chip'... Failed!
Client found at address 0x74
Client found at address 0x75
Client found at address 0x76
Client found at address 0x77
Client found at address 0x78
Client found at address 0x79
Client found at address 0x7a
Client found at address 0x7b
Client found at address 0x7c
Client found at address 0x7d
Client found at address 0x7e
Client found at address 0x7f

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): no

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `lm80' (should be inserted):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2e
    Chip `National Semiconductor LM80' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2f
    Chip `National Semiconductor LM80' (confidence: 3)

Driver `lm75' (should be inserted):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x48
    Chip `National Semiconductor LM75' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x49
    Chip `National Semiconductor LM75' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4a
    Chip `National Semiconductor LM75' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4b
    Chip `National Semiconductor LM75' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4f
    Chip `National Semiconductor LM75' (confidence: 3)

Driver `pcf8591' (may not be inserted):
  Misdetects:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x48
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x49
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4a
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4b
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4f
    Chip `Philips Semiconductors PCF8591' (confidence: 1)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x50
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x51
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x52
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x53
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x54
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x55
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x56
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x57
    Chip `Serial EEPROM' (confidence: 8)

Driver `ltc1710' (should be inserted):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x58
    Chip `LTC1710' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x59
    Chip `LTC1710' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x5a
    Chip `LTC1710' (confidence: 1)

Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? smbus

WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
# modprobe unknown adapter bt848 #0 using Bit-shift algorithm
modprobe i2c-amd756
# I2C chip drivers
modprobe lm80
modprobe lm75
modprobe eeprom
modprobe ltc1710
modprobe smbus-arp
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


I tried to use it "as is", but I get no values for fan speed, voltages
or CPU temperature...

Here is the output of i2cdetect:

Error: No i2c-bus specified!
Syntax: i2cdetect I2CBUS
  I2CBUS is an integer
  Installed I2C busses:
    i2c-0       i2c             bt848 #0                               
Bit-shift algorithm
    i2c-1       smbus           SMBus nVidia nForce adapter at ec00    
Non-I2C SMBus adapter

Therefore, I did a "i2cdetect 1" (as root), and here is the output:

  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-1
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
10: 10 11 12 13 14 15 16 17 UU UU UU 1b 1c 1d 1e 1f
20: UU UU UU UU UU UU UU UU UU UU UU UU UU UU 2e 2f
30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
40: 40 41 42 43 44 45 46 47 48 49 4a 4b UU UU UU 4f
50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f
60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
70: 70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f


Thank you for your help!

Regards

Yann
