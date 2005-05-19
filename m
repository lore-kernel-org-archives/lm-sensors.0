From: nekrasov@mytrix.ru (Andrey Nekrasov)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: double file name in "/proc/sys/dev/sensors/"
Message-Id: <3E5CA690.5060608@mytrix.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello.

I am use "linux-2.4.20-suse1/2" from Hubert Mante. (SuSE).

I use a monolithic kernel, without modules.

Has detected something strange:

an:/proc/sys/dev/sensors# ls -la
  total 0
  dr-xr-xr-x    5 root     root            0 2003-02-20 19:35 .
  dr-xr-xr-x    7 root     root            0 2003-02-20 19:35 ..
  -rw-r--r--    1 root     root            0 2003-02-20 19:36 chips
  -rw-r--r--    1 root     root            0 2003-02-20 19:36 chips
  dr-xr-xr-x    2 root     root            0 2003-02-20 19:36 
eeprom-i2c-1-51
  dr-xr-xr-x    2 root     root            0 2003-02-20 19:36 
eeprom-i2c-1-52
  dr-xr-xr-x    2 root     root            0 2003-02-20 19:36 
w83782d-i2c-1-2d


ls -Q
"chips"  "chips"  "eeprom-i2c-1-51"  "w83782d-i2c-1-2d"

How can be two files with the identical name?

1. dmesg |egrep -i "i2c|lm" :

i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
i2c-isa.o version 2.7.0 (20021208)
i2c-dev.o: Registered 'ISA main adapter' as minor 0
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-piix4.o version 2.7.0 (20021208)
i2c-piix4.o: Found PIIX4 device
i2c-dev.o: Registered 'SMBus PIIX4 adapter at 5000' as minor 1
i2c-piix4.o: SMBus detected and initialized
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)

2. .config :

#
# Loadable module support
#
# CONFIG_MODULES is not set
...
#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PROC=y

#
# Hardware sensors mainboard support
#
CONFIG_I2C_MAINBOARD=y
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_HYDRA is not set
# CONFIG_I2C_TSUNAMI is not set
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS645 is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VOODOO3 is not set
CONFIG_I2C_ISA=y

#
# Hardware sensors chip support
#
CONFIG_SENSORS=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1024 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_FSCSCY is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_MAXILIFE is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_MTP008 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMARTBATT is not set
# CONFIG_SENSORS_SMBUSARP is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_OTHER=y
# CONFIG_SENSORS_BT869 is not set
CONFIG_SENSORS_DDCMON=y
CONFIG_SENSORS_EEPROM=y
# CONFIG_SENSORS_MATORB is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
...
