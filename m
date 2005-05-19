From: mail@thorstenhau.de (Thorsten Haude)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: Cannot find via686a
Message-Id: <20041125010407.GA1267@eumel.yoo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I hope this is the best address for this kind of trouble report. If
not I would be grateful for pointers to a better place.


I want to use the sensors of my Abit KT7A-RAID motherboard, running
Debian Sarge. For this, I started sensors-detect, which told me use
the modules i2c-isa and via686a. I use a monolithic kernel, but I
double-checked that both items are part of my 2.6.9 kernel.

Alas, sensors can't find anything but the RAM:
- - - Schnipp - - -
yooden@eumel % sensors
eeprom-i2c-1-51
Adapter: SMBus Via Pro adapter at 5000
Memory type:            SDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-1-50
Adapter: SMBus Via Pro adapter at 5000
Memory type:            SDR SDRAM DIMM
Memory size (MB):       256
- - - Schnapp - - -


Here are some kernel option which I think are important:
- - - Schnipp - - -
#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=y
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=y
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
CONFIG_SENSORS_EEPROM=y
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
CONFIG_I2C_DEBUG_CHIP=y
- - - Schnapp - - -


I read around but can't find anything wrong. There is no error
message, my sensors are just not there.


What would solve problem? What can I do to find out more about the
problem? Is there any information that would help finding the cause?


Thanks in advance,

Thorsten
-- 
Once upon the time, the music industry had something to offer to us - they
distributed the music we would have never heard without them.
Now, they need laws that prevent us to do ourself what they do for money.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041125/28e1a23d/attachment.bin
