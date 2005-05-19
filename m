From: horol@developers.sk (Martin Kyrc)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: i2c-proc and kernel 2.6.0-test11 HOWTO
Message-Id: <1071508087.2621.13.camel@ta3>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
(my english is not excelent, but I hope, that's OK)
I am student from Slovakia. I will test lm_sensors with linux kernel
2.6.0-test11, but I have problem. My system is Debian. I have
lm-sensors-source.deb (version 2.8.1) install.

In README writes:
<README> 
!!! This package is ONLY for 2.6, 2.5, and 2.4 kernels (2.4.9 or later)
!!! 
!!! THIS PACKAGE REQUIRES i2c-2.8.1 or later!!! 

FOR 2.6/2.5 KERNELS, Use only the userspace tools in this package! 
Build and install them with 'make user' and 'make user_install'. 
The kernel modules in this package will not compile for 2.6/2.5; 
use the drivers already in the 2.5 kernel development tree. 
</README> 

So:
1. My kernel configuration (make menuconfig):

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=y
# CONFIG_I2C_VOODOO3 is not set

#
# I2C Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=y
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_EEPROM=m
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM78=m
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_W83781D is not set

2. make-kpkg kernel-image
.. OK
I have modules (via686a, i2c-isa, i2c-viapro, i2c-dev, i2c-sensors,...,
but I have not i2c-proc!

3. when I run sensors:

ta3:~# sensors
Can't access /proc file
/proc/sys/dev/sensors/chips or /proc/bus/i2c unreadable;
Make sure you have done 'modprobe i2c-proc'!

I have not i2c-proc :(.

################################################################

lm_sensors+i2c with my kernel 2.4.22.. I have no problems.

Where is problem? I do some bad? 
Can you write me how I compile this modul - 'i2c-proc'.

Thanks!
-- 
                                                         \ /
                                                       /\ o -
                                                    /\/  \ \ 
+-[ horol ]----------------------------------------/ /    \---+
| e-mail ........................... horol (at) developers.sk |
| ICQ number ....................................... 95090557 |
| IRC nick/channel ..................... horol/ #ta3, #kosice |
+-------------------------------------------------------------+
| Please do not send me any attachments in proprietary        |
| formats (*.doc,*.xls, *.pps,...). Read more at              |       
| http://www.gnu.org/philosophy/no-word-attachments.html      |
+-------------------------------------------------------------+
  Message Of The Day:
Don't put too fine a point to your wit for fear it should get blunted.
		-- Miguel de Cervantes
