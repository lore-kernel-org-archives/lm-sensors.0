From: js@jonasstein.de (Jonas Stein)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: Controll CPU Cooler on MSI-NEO 2 Board
Message-Id: <4277D331.1060100@jonasstein.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <42772B44.8090204@jonasstein.de>
In-Reply-To: <42772B44.8090204@jonasstein.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Please include full output of sensors-detect

Here it goes:

[..]

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `to-be-written' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x09
    Chip `Smart Battery Charger' (confidence: 5)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x0a
    Chip `Smart Battery Manager/Selector' (confidence: 5)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x18
    Chip `Philips Semiconductors PCA9556' (confidence: 1)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x19
    Chip `Philips Semiconductors PCA9556' (confidence: 1)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x1a
    Chip `Philips Semiconductors PCA9556' (confidence: 1)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x1c
    Chip `Philips Semiconductors PCA9556' (confidence: 1)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x1d
    Chip `Philips Semiconductors PCA9556' (confidence: 1)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x1e
    Chip `Philips Semiconductors PCA9556' (confidence: 1)
  Misdetects:
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x1b
    Chip `Philips Semiconductors PCA9556' (confidence: 1)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x1f
    Chip `Philips Semiconductors PCA9556' (confidence: 1)

Driver `smartbatt' (should be inserted):
  Detects correctly:
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x0b
    Chip `Smart Battery' (confidence: 5)

Driver `max6650' (should be inserted):
  Detects correctly:
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x1b
    Chip `Maxim MAX6650/MAX6651' (confidence: 4)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x1f
    Chip `Maxim MAX6650/MAX6651' (confidence: 4)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x48
    Chip `Maxim MAX6650/MAX6651' (confidence: 4)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4b
    Chip `Maxim MAX6650/MAX6651' (confidence: 4)

Driver `saa1064' (should be inserted):
  Detects correctly:
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x38
    Chip `Philips Semiconductors SAA1064' (confidence: 4)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x39
    Chip `Philips Semiconductors SAA1064' (confidence: 4)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x3a
    Chip `Philips Semiconductors SAA1064' (confidence: 4)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x3b
    Chip `Philips Semiconductors SAA1064' (confidence: 4)

Driver `lm92' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x40
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x41
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x42
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x43
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x44
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x45
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x46
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x47
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  Misdetects:
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x48
    Chip `National Semiconductor LM76' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x48
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x49
    Chip `National Semiconductor LM76' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x49
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4a
    Chip `National Semiconductor LM76' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4a
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4b
    Chip `National Semiconductor LM76' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4b
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4c
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4d
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4e
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4f
    Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)

Driver `ds1621' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x49
    Chip `Dallas Semiconductor DS1621' (confidence: 3)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4a
    Chip `Dallas Semiconductor DS1621' (confidence: 3)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4c
    Chip `Dallas Semiconductor DS1621' (confidence: 3)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4d
    Chip `Dallas Semiconductor DS1621' (confidence: 3)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4e
    Chip `Dallas Semiconductor DS1621' (confidence: 3)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4f
    Chip `Dallas Semiconductor DS1621' (confidence: 3)
  Misdetects:
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x48
    Chip `Dallas Semiconductor DS1621' (confidence: 3)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x4b
    Chip `Dallas Semiconductor DS1621' (confidence: 3)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x53
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x54
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x55
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x56
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x57
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus Via Pro adapter at 0400'
    Busdriver `i2c-viapro', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)

Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)

Driver `pca9540' (should be inserted):
  Detects correctly:
  * Bus `SMBus stub driver'
    Busdriver `UNKNOWN', I2C address 0x70
    Chip `Philips Semiconductors PCA9540' (confidence: 1)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)

 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? i2c

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
# modprobe unknown adapter SMBus stub driver
i2c-viapro
i2c-isa
# I2C chip drivers
# no driver for Smart Battery Charger yet
# Warning: the required module smartbatt is not currently installed on
your system.
# For status of 2.6 kernel ports see
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
smartbatt
# Warning: the required module max6650 is not currently installed on
your system.
# For status of 2.6 kernel ports see
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
max6650
# Warning: the required module saa1064 is not currently installed on
your system.
# For status of 2.6 kernel ports see
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
saa1064
# Warning: the required module lm92 is not currently installed on your
system.
# For status of 2.6 kernel ports see
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
lm92
ds1621
# Warning: the required module eeprom is not currently installed on your
system.
# For status of 2.6 kernel ports see
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
eeprom
# Warning: the required module smbus-arp is not currently installed on
your system.
# For status of 2.6 kernel ports see
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
smbus-arp
# Warning: the required module pca9540 is not currently installed on
your system.
# For status of 2.6 kernel ports see
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
pca9540
w83627hf
#----cut here----

Do you want to add these lines to /etc/modules automatically? (yes/NO)y



> and full output of sensors command.
# sensors
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.42 V  (min =  +0.94 V, max =  +0.96 V)
+12V:     +11.92 V  (min = +10.82 V, max = +13.19 V)
+3.3V:     +0.64 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.01 V  (min =  +4.75 V, max =  +5.25 V)
-12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)
V5SB:      +5.05 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +3.49 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 56250 RPM, div = 2)
CPU Fan:     0 RPM  (min = 37500 RPM, div = 2)
fan3:        0 RPM  (min = 19285 RPM, div = 2)
M/B Temp:    +39 C  (high =   +25 C, hyst =    +1 C)   sensor = thermistor
CPU Temp:  +38.0 C  (high =   +80 C, hyst =   +75 C)   sensor = diode
temp3:     -48.0 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor
vid:      +0.275 V  (VRM Version 9.0)
alarms:
beep_enable:
          Sound alarm disabled



-- 
Mit besten Gr??en / best regards

Jonas Stein <js@jonasstein.de>
