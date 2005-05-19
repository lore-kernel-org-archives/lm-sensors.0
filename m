From: c479wy002@sneakemail.com (Geoffrey Hausheer)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: Issue getting sis630 i2c smbus driver to work
Message-Id: <14164-38866@sneakemail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a laptop with a sis630 chipset
When I modprobe i2c-sis630, nothing happens.  The module seems to load
fine, but there are no messages in dmesg (I have all debuggng options
for I2C enabled), and 'i2cdetect -l' returns nothing.  Just  to check,
I loaded the i2c-isa module, which works ok (i2cdetect -l shows the
isa driver) but there are no isa sensors (not surprising)

sensors-detect  (obviously) doesn't detect  anything either.

This is a 2.6.7 kernel with lm-sensors 2.8.7

ACPI is enabled if it is important
please let me know if there is anything else I can do to help debug further.

lspci:
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 31)
0000:00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
0000:00:01.0 ISA bridge: Silicon Integrated Systems [SiS]
SiS85C503/5513 (LPC Bridge)
0000:00:01.1 Ethernet controller: Silicon Integrated Systems [SiS]
SiS900 PCI Fast Ethernet (rev 82)
0000:00:01.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07)
0000:00:01.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07)
0000:00:01.4 Multimedia audio controller: Silicon Integrated Systems
[SiS] SiS PCI Audio Accelerator (rev 02)
0000:00:01.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem
Controller (rev a0)
0000:00:02.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual
PCI-to-PCI bridge (AGP)
0000:00:03.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
0000:00:09.0 Network controller: Intersil Corporation Prism 2.5
Wavelan chipset (rev 01)
0000:00:0a.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 04)
0000:01:00.0 VGA compatible controller: Silicon Integrated Systems
[SiS] 630/730 PCI/AGP VGA Display Adapter (rev 31)

lspci -n
0000:00:00.0 Class 0600: 1039:0630 (rev 31)
0000:00:00.1 Class 0101: 1039:5513 (rev d0)
0000:00:01.0 Class 0601: 1039:0018
0000:00:01.1 Class 0200: 1039:0900 (rev 82)
0000:00:01.2 Class 0c03: 1039:7001 (rev 07)
0000:00:01.3 Class 0c03: 1039:7001 (rev 07)
0000:00:01.4 Class 0401: 1039:7018 (rev 02)
0000:00:01.6 Class 0703: 1039:7013 (rev a0)
0000:00:02.0 Class 0604: 1039:0001
0000:00:03.0 Class 0607: 1217:6972
0000:00:09.0 Class 0280: 1260:3873 (rev 01)
0000:00:0a.0 Class 0c00: 11c1:5811 (rev 04)
0000:01:00.0 Class 0300: 1039:6300 (rev 31)

lsmod:
Module                  Size  Used by
i2c_sis630              8044  0
i2c_core               21652  1 i2c_sis630
sis                    54176  2

grep 'I2C.*=' .config
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ISA=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SENSOR=m
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
CONFIG_I2C_DEBUG_CHIP=y

(all sensor chips are  built as modules)

.Geoff
