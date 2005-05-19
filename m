From: szakats.istvan@gmail.com (Szakats Istvan)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: "Can't access procfs/sysfs file", but all seems ok ??
Message-Id: <5799c4e904122605035c3fde7a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LM Sensors Group:

I compiled and installed the the latest lm_sensors, enabled i2c in my
kernel an compiled it but it doesn't work. I have i2c 2.8.8 and sysfs
and procfs support compiled in my kernel. The only thing i see wrong i
when i boot intro linux (Mandrake 9.1) the first thing i see are i2c
error messages.
Here's the code:

[szakats@nitro lm_sensors-2.8.8]$ sensors
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and done
'modprobe i2c_sensor'!
For older kernels, make sure you have done 'modprobe i2c-proc'!


[root@nitro lm_sensors-2.8.8]# ls /proc/sys
debug/  dev/  fs/  kernel/  net/  proc/  sunrpc/  vm/
[root@nitro lm_sensors-2.8.8]# grep 'SYSFS' /usr/src/linux/.config
CONFIG_SYSFS=y
[root@nitro lm_sensors-2.8.8]# ls /sys
ls: /sys: No such file or directory   (in the faq it says this
directory should exist ???)


[root@nitro lm_sensors-2.8.8]# i2cdetect -V
i2cdetect version 2.8.8
[root@nitro lm_sensors-2.8.8]# i2cdetect -l  (no output)
[root@nitro lm_sensors-2.8.8]# modprobe i2c_sensor
FATAL: Module i2c_sensor not found.       (it's compiled into the kernel)
[root@nitro lm_sensors-2.8.8]# grep 'I2C' /usr/src/linux/.config
# I2C support
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
# I2C Algorithms
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=y
# I2C Hardware Bus support
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_I801=y
CONFIG_I2C_I810=y
CONFIG_I2C_ISA=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_PARPORT=y
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_PIIX4=m
CONFIG_I2C_PROSAVAGE=y
CONFIG_I2C_SAVAGE4=y
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y
CONFIG_I2C_VOODOO3=m
CONFIG_I2C_PCA_ISA=y
CONFIG_I2C_SENSOR=y
# Other I2C Chip support
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set
# CONFIG_FB_RIVA_I2C is not set
CONFIG_FB_RADEON_I2C=y
[root@nitro lm_sensors-2.8.8]# grep 'SENSOR' /usr/src/linux/.config
CONFIG_I2C_SENSOR=y
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_FSCHER=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_EEPROM=y
CONFIG_SENSORS_PCF8574=y
CONFIG_SENSORS_PCF8591=y
CONFIG_SENSORS_RTC8564=y
[root@nitro lm_sensors-2.8.8]# vi /boot/log/messages
"Dec 26 13:43:46 nitro kernel: i2c /dev entries driver
Dec 26 13:43:46 nitro kernel: i2c-parport: using default base 0x378
Dec 26 13:43:46 nitro kernel: i2c-pca-isa: i/o base 0x000330. irq 10
Dec 26 13:43:46 nitro kernel: i2c-algo-pca: bus is not idle. status is 0xff
Dec 26 13:43:46 nitro last message repeated 11 times" (this is the
first thing i see when booting)


[root@nitro lm_sensors-2.8.8]# cat /proc/version
Linux version 2.6.9-nitro4 (root@nitro) (gcc version 3.4.2) #1 Sat Dec
25 16:25:24 EET 2004
[root@nitro lm_sensors-2.8.8]# lspcidrake
unknown         : VIA Technologies Inc|VT8377 CPU to PCI Bridge
unknown         : VIA Technologies Inc|PCI-to-PCI Bridge (AGP 2.0/3.0)
saa7134         : Philips Semiconductors|SAA7134
unknown         : VIA Technologies Inc|VT8233A PCI to ISA Bridge
unknown         : VIA Technologies|VT82C586 IDE [Apollo]
snd-via82xx     : VIA Technologies|VT8233 [AC97 Audio Controller]
via-rhine       : VIA Technologies|VT6102 [Rhine II 10/100]
Card:NVIDIA GeForce4 (generic): NVidia|0x326

I hope i included everything relevant.

Best wishes
Steven
