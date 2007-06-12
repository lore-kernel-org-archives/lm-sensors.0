From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 12 Jun 2007 05:26:27 +0000
Subject: [lm-sensors] [patch 2.6.23-pre] s/SENSORS_/HWMON_/  in Kconfig,
Message-Id: <466E2E83.4010203@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090104050607080503020303"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090104050607080503020303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


(patch attached, with this stuff at the top - hope thats ok)

This changes SENSORS to HWMON in Kconfig and Makefile,
which makes it agree with 'menuconfig HWMON' at the top of Kconfig,
and with the dir-name itself.  ISTM that theres no reason
(save legacy) to keep this arbitrary difference.

Signed-off-by:  Jim Cromie  <jim.cromie@gmail.com>
---
[jimc@harpo hwmon-stuff]$ diffstat diff.conf-sensors-2-hwmon
 Kconfig  |  110 
+++++++++++++++++++++++++++++++--------------------------------
 Makefile |  102 +++++++++++++++++++++++++++++-----------------------------
 2 files changed, 106 insertions(+), 106 deletions(-)



--------------090104050607080503020303
Content-Type: text/plain;
 name="diff.conf-sensors-2-hwmon"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff.conf-sensors-2-hwmon"


This changes SENSORS to HWMON in Kconfig and Makefile,
which makes it agree with 'menuconfig HWMON' at the top of Kconfig,
and with the dir-name itself.  ISTM that theres no reason
(save legacy) to keep this arbitrary difference.

Signed-off-by:  Jim Cromie  <jim.cromie@gmail.com>
---
 Kconfig  |  110 +++++++++++++++++++++++++++++++--------------------------------
 Makefile |  102 +++++++++++++++++++++++++++++-----------------------------
 2 files changed, 106 insertions(+), 106 deletions(-)

---

diff -ruNp -X dontdiff -X exclude-diffs locks-0/drivers/hwmon/Kconfig cf-hwmon/drivers/hwmon/Kconfig
--- locks-0/drivers/hwmon/Kconfig	2007-06-08 21:04:04.000000000 -0600
+++ cf-hwmon/drivers/hwmon/Kconfig	2007-06-11 21:24:00.000000000 -0600
@@ -28,7 +28,7 @@ config HWMON_VID
 	tristate
 	default n
 
-config SENSORS_ABITUGURU
+config HWMON_ABITUGURU
 	tristate "Abit uGuru"
 	depends on EXPERIMENTAL
 	help
@@ -40,7 +40,7 @@ config SENSORS_ABITUGURU
 	  This driver can also be built as a module.  If so, the module
 	  will be called abituguru.
 
-config SENSORS_AD7418
+config HWMON_AD7418
 	tristate "Analog Devices AD7416, AD7417 and AD7418"
 	depends on I2C && EXPERIMENTAL
 	help
@@ -50,7 +50,7 @@ config SENSORS_AD7418
 	  This driver can also be built as a module. If so, the module
 	  will be called ad7418.
 
-config SENSORS_ADM1021
+config HWMON_ADM1021
 	tristate "Analog Devices ADM1021 and compatibles"
 	depends on I2C
 	help
@@ -62,7 +62,7 @@ config SENSORS_ADM1021
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1021.
 
-config SENSORS_ADM1025
+config HWMON_ADM1025
 	tristate "Analog Devices ADM1025 and compatibles"
 	depends on I2C
 	select HWMON_VID
@@ -73,7 +73,7 @@ config SENSORS_ADM1025
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1025.
 
-config SENSORS_ADM1026
+config HWMON_ADM1026
 	tristate "Analog Devices ADM1026 and compatibles"
 	depends on I2C && EXPERIMENTAL
 	select HWMON_VID
@@ -84,7 +84,7 @@ config SENSORS_ADM1026
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1026.
 
-config SENSORS_ADM1029
+config HWMON_ADM1029
 	tristate "Analog Devices ADM1029"
 	depends on I2C && EXPERIMENTAL
 	help
@@ -95,7 +95,7 @@ config SENSORS_ADM1029
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1029.
 
-config SENSORS_ADM1031
+config HWMON_ADM1031
 	tristate "Analog Devices ADM1031 and compatibles"
 	depends on I2C && EXPERIMENTAL
 	help
@@ -105,7 +105,7 @@ config SENSORS_ADM1031
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1031.
 
-config SENSORS_ADM9240
+config HWMON_ADM9240
 	tristate "Analog Devices ADM9240 and compatibles"
 	depends on I2C && EXPERIMENTAL
 	select HWMON_VID
@@ -116,7 +116,7 @@ config SENSORS_ADM9240
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm9240.
 
-config SENSORS_K8TEMP
+config HWMON_K8TEMP
 	tristate "AMD Athlon64/FX or Opteron temperature sensor"
 	depends on X86 && PCI && EXPERIMENTAL
 	help
@@ -128,7 +128,7 @@ config SENSORS_K8TEMP
 	  This driver can also be built as a module.  If so, the module
 	  will be called k8temp.
 
-config SENSORS_AMS
+config HWMON_AMS
 	tristate "Apple Motion Sensor driver"
 	depends on PPC_PMAC && !PPC64 && INPUT && ((ADB_PMU && I2C = y) || (ADB_PMU && !I2C) || I2C) && EXPERIMENTAL
 	help
@@ -138,22 +138,22 @@ config SENSORS_AMS
 	  This driver can also be built as a module. If so, the module
 	  will be called ams.
 
-config SENSORS_AMS_PMU
+config HWMON_AMS_PMU
 	bool "PMU variant"
-	depends on SENSORS_AMS && ADB_PMU
+	depends on HWMON_AMS && ADB_PMU
 	default y
 	help
 	  PMU variant of motion sensor, found in late 2005 PowerBooks.
 
-config SENSORS_AMS_I2C
+config HWMON_AMS_I2C
 	bool "I2C variant"
-	depends on SENSORS_AMS && I2C
+	depends on HWMON_AMS && I2C
 	default y
 	help
 	  I2C variant of motion sensor, found in early 2005 PowerBooks and
 	  iBooks.
 
-config SENSORS_ASB100
+config HWMON_ASB100
 	tristate "Asus ASB100 Bach"
 	depends on I2C && EXPERIMENTAL
 	select HWMON_VID
@@ -164,7 +164,7 @@ config SENSORS_ASB100
 	  This driver can also be built as a module.  If so, the module
 	  will be called asb100.
 
-config SENSORS_ATXP1
+config HWMON_ATXP1
 	tristate "Attansic ATXP1 VID controller"
 	depends on I2C && EXPERIMENTAL
 	select HWMON_VID
@@ -178,7 +178,7 @@ config SENSORS_ATXP1
 	  This driver can also be built as a module.  If so, the module
 	  will be called atxp1.
 
-config SENSORS_DS1621
+config HWMON_DS1621
 	tristate "Dallas Semiconductor DS1621 and DS1625"
 	depends on I2C
 	help
@@ -188,7 +188,7 @@ config SENSORS_DS1621
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1621.
 
-config SENSORS_F71805F
+config HWMON_F71805F
 	tristate "Fintek F71805F/FG and F71872F/FG"
 	depends on EXPERIMENTAL
 	help
@@ -199,7 +199,7 @@ config SENSORS_F71805F
 	  This driver can also be built as a module.  If so, the module
 	  will be called f71805f.
 
-config SENSORS_FSCHER
+config HWMON_FSCHER
 	tristate "FSC Hermes"
 	depends on I2C
 	help
@@ -209,7 +209,7 @@ config SENSORS_FSCHER
 	  This driver can also be built as a module.  If so, the module
 	  will be called fscher.
 
-config SENSORS_FSCPOS
+config HWMON_FSCPOS
 	tristate "FSC Poseidon"
 	depends on I2C
 	help
@@ -219,7 +219,7 @@ config SENSORS_FSCPOS
 	  This driver can also be built as a module.  If so, the module
 	  will be called fscpos.
 
-config SENSORS_GL518SM
+config HWMON_GL518SM
 	tristate "Genesys Logic GL518SM"
 	depends on I2C
 	help
@@ -229,7 +229,7 @@ config SENSORS_GL518SM
 	  This driver can also be built as a module.  If so, the module
 	  will be called gl518sm.
 
-config SENSORS_GL520SM
+config HWMON_GL520SM
 	tristate "Genesys Logic GL520SM"
 	depends on I2C
 	select HWMON_VID
@@ -240,7 +240,7 @@ config SENSORS_GL520SM
 	  This driver can also be built as a module.  If so, the module
 	  will be called gl520sm.
 
-config SENSORS_CORETEMP
+config HWMON_CORETEMP
 	tristate "Intel Core (2) Duo/Solo temperature sensor"
 	depends on X86 && EXPERIMENTAL
 	help
@@ -248,7 +248,7 @@ config SENSORS_CORETEMP
 	  sensor inside your CPU. Supported all are all known variants
 	  of Intel Core family.
 
-config SENSORS_IT87
+config HWMON_IT87
 	tristate "ITE IT87xx and compatibles"
 	depends on I2C
 	select I2C_ISA
@@ -260,7 +260,7 @@ config SENSORS_IT87
 	  This driver can also be built as a module.  If so, the module
 	  will be called it87.
 
-config SENSORS_LM63
+config HWMON_LM63
 	tristate "National Semiconductor LM63"
 	depends on I2C
 	help
@@ -272,7 +272,7 @@ config SENSORS_LM63
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm63.
 
-config SENSORS_LM70
+config HWMON_LM70
 	tristate "National Semiconductor LM70"
 	depends on SPI_MASTER && EXPERIMENTAL
 	help
@@ -282,7 +282,7 @@ config SENSORS_LM70
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm70.
 
-config SENSORS_LM75
+config HWMON_LM75
 	tristate "National Semiconductor LM75 and compatibles"
 	depends on I2C
 	help
@@ -297,7 +297,7 @@ config SENSORS_LM75
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm75.
 
-config SENSORS_LM77
+config HWMON_LM77
 	tristate "National Semiconductor LM77"
 	depends on I2C
 	help
@@ -307,7 +307,7 @@ config SENSORS_LM77
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm77.
 
-config SENSORS_LM78
+config HWMON_LM78
 	tristate "National Semiconductor LM78 and compatibles"
 	depends on I2C
 	select HWMON_VID
@@ -318,7 +318,7 @@ config SENSORS_LM78
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm78.
 
-config SENSORS_LM80
+config HWMON_LM80
 	tristate "National Semiconductor LM80"
 	depends on I2C && EXPERIMENTAL
 	help
@@ -328,7 +328,7 @@ config SENSORS_LM80
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm80.
 
-config SENSORS_LM83
+config HWMON_LM83
 	tristate "National Semiconductor LM83 and compatibles"
 	depends on I2C
 	help
@@ -338,7 +338,7 @@ config SENSORS_LM83
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm83.
 
-config SENSORS_LM85
+config HWMON_LM85
 	tristate "National Semiconductor LM85 and compatibles"
 	depends on I2C && EXPERIMENTAL
 	select HWMON_VID
@@ -349,7 +349,7 @@ config SENSORS_LM85
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm85.
 
-config SENSORS_LM87
+config HWMON_LM87
 	tristate "National Semiconductor LM87"
 	depends on I2C
 	select HWMON_VID
@@ -360,7 +360,7 @@ config SENSORS_LM87
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm87.
 
-config SENSORS_LM90
+config HWMON_LM90
 	tristate "National Semiconductor LM90 and compatibles"
 	depends on I2C
 	help
@@ -374,7 +374,7 @@ config SENSORS_LM90
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm90.
 
-config SENSORS_LM92
+config HWMON_LM92
 	tristate "National Semiconductor LM92 and compatibles"
 	depends on I2C
 	help
@@ -384,7 +384,7 @@ config SENSORS_LM92
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm92.
 
-config SENSORS_MAX1619
+config HWMON_MAX1619
 	tristate "Maxim MAX1619 sensor chip"
 	depends on I2C
 	help
@@ -393,7 +393,7 @@ config SENSORS_MAX1619
 	  This driver can also be built as a module.  If so, the module
 	  will be called max1619.
 
-config SENSORS_MAX6650
+config HWMON_MAX6650
 	tristate "Maxim MAX6650 sensor chip"
 	depends on I2C && EXPERIMENTAL
 	help
@@ -403,7 +403,7 @@ config SENSORS_MAX6650
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6650.
 
-config SENSORS_PC87360
+config HWMON_PC87360
 	tristate "National Semiconductor PC87360 family"
 	depends on I2C && EXPERIMENTAL
 	select I2C_ISA
@@ -418,7 +418,7 @@ config SENSORS_PC87360
 	  This driver can also be built as a module.  If so, the module
 	  will be called pc87360.
 
-config SENSORS_PC87427
+config HWMON_PC87427
 	tristate "National Semiconductor PC87427"
 	depends on EXPERIMENTAL
 	help
@@ -431,7 +431,7 @@ config SENSORS_PC87427
 	  This driver can also be built as a module.  If so, the module
 	  will be called pc87427.
 
-config SENSORS_SIS5595
+config HWMON_SIS5595
 	tristate "Silicon Integrated Systems Corp. SiS5595"
 	depends on I2C && PCI && EXPERIMENTAL
 	select I2C_ISA
@@ -442,7 +442,7 @@ config SENSORS_SIS5595
 	  This driver can also be built as a module.  If so, the module
 	  will be called sis5595.
 
-config SENSORS_SMSC47M1
+config HWMON_SMSC47M1
 	tristate "SMSC LPC47M10x and compatibles"
 	help
 	  If you say yes here you get support for the integrated fan
@@ -458,7 +458,7 @@ config SENSORS_SMSC47M1
 	  This driver can also be built as a module.  If so, the module
 	  will be called smsc47m1.
 
-config SENSORS_SMSC47M192
+config HWMON_SMSC47M192
 	tristate "SMSC LPC47M192 and compatibles"
 	depends on I2C && EXPERIMENTAL
 	select HWMON_VID
@@ -475,7 +475,7 @@ config SENSORS_SMSC47M192
 	  This driver can also be built as a module.  If so, the module
 	  will be called smsc47m192.
 
-config SENSORS_SMSC47B397
+config HWMON_SMSC47B397
 	tristate "SMSC LPC47B397-NC"
 	depends on EXPERIMENTAL
 	help
@@ -485,7 +485,7 @@ config SENSORS_SMSC47B397
 	  This driver can also be built as a module.  If so, the module
 	  will be called smsc47b397.
 
-config SENSORS_VIA686A
+config HWMON_VIA686A
 	tristate "VIA686A"
 	depends on I2C && PCI
 	select I2C_ISA
@@ -496,7 +496,7 @@ config SENSORS_VIA686A
 	  This driver can also be built as a module.  If so, the module
 	  will be called via686a.
 
-config SENSORS_VT1211
+config HWMON_VT1211
 	tristate "VIA VT1211"
 	depends on EXPERIMENTAL
 	select HWMON_VID
@@ -507,7 +507,7 @@ config SENSORS_VT1211
 	  This driver can also be built as a module.  If so, the module
 	  will be called vt1211.
 
-config SENSORS_VT8231
+config HWMON_VT8231
 	tristate "VIA VT8231"
 	depends on I2C && PCI && EXPERIMENTAL
 	select HWMON_VID
@@ -519,7 +519,7 @@ config SENSORS_VT8231
 	  This driver can also be built as a module.  If so, the module
 	  will be called vt8231.
 
-config SENSORS_W83781D
+config HWMON_W83781D
 	tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
 	depends on I2C
 	select HWMON_VID
@@ -531,7 +531,7 @@ config SENSORS_W83781D
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83781d.
 
-config SENSORS_W83791D
+config HWMON_W83791D
 	tristate "Winbond W83791D"
 	depends on I2C && EXPERIMENTAL
 	select HWMON_VID
@@ -541,7 +541,7 @@ config SENSORS_W83791D
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83791d.
 
-config SENSORS_W83792D
+config HWMON_W83792D
 	tristate "Winbond W83792D"
 	depends on I2C && EXPERIMENTAL
 	help
@@ -550,7 +550,7 @@ config SENSORS_W83792D
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83792d.
 
-config SENSORS_W83793
+config HWMON_W83793
 	tristate "Winbond W83793"
 	depends on I2C && EXPERIMENTAL
 	select HWMON_VID
@@ -561,7 +561,7 @@ config SENSORS_W83793
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83793.
 
-config SENSORS_W83L785TS
+config HWMON_W83L785TS
 	tristate "Winbond W83L785TS-S"
 	depends on I2C && EXPERIMENTAL
 	help
@@ -572,7 +572,7 @@ config SENSORS_W83L785TS
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83l785ts.
 
-config SENSORS_W83627HF
+config HWMON_W83627HF
 	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
 	select HWMON_VID
 	help
@@ -583,7 +583,7 @@ config SENSORS_W83627HF
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83627hf.
 
-config SENSORS_W83627EHF
+config HWMON_W83627EHF
 	tristate "Winbond W83627EHF"
 	depends on I2C && EXPERIMENTAL
 	select I2C_ISA
@@ -599,7 +599,7 @@ config SENSORS_W83627EHF
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83627ehf.
 
-config SENSORS_HDAPS
+config HWMON_HDAPS
 	tristate "IBM Hard Drive Active Protection System (hdaps)"
 	depends on INPUT && X86
 	default n
@@ -618,7 +618,7 @@ config SENSORS_HDAPS
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of hdaps.
 
-config SENSORS_APPLESMC
+config HWMON_APPLESMC
 	tristate "Apple SMC (Motion sensor, light sensor, keyboard backlight)"
 	depends on INPUT && X86
 	select NEW_LEDS
diff -ruNp -X dontdiff -X exclude-diffs locks-0/drivers/hwmon/Makefile cf-hwmon/drivers/hwmon/Makefile
--- locks-0/drivers/hwmon/Makefile	2007-06-08 21:04:04.000000000 -0600
+++ cf-hwmon/drivers/hwmon/Makefile	2007-06-11 21:24:32.000000000 -0600
@@ -6,58 +6,58 @@ obj-$(CONFIG_HWMON)		+= hwmon.o
 obj-$(CONFIG_HWMON_VID)		+= hwmon-vid.o
 
 # asb100, then w83781d go first, as they can override other drivers' addresses.
-obj-$(CONFIG_SENSORS_ASB100)	+= asb100.o
-obj-$(CONFIG_SENSORS_W83627HF)	+= w83627hf.o
-obj-$(CONFIG_SENSORS_W83792D)	+= w83792d.o
-obj-$(CONFIG_SENSORS_W83793)	+= w83793.o
-obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
-obj-$(CONFIG_SENSORS_W83791D)	+= w83791d.o
+obj-$(CONFIG_HWMON_ASB100)	+= asb100.o
+obj-$(CONFIG_HWMON_W83627HF)	+= w83627hf.o
+obj-$(CONFIG_HWMON_W83792D)	+= w83792d.o
+obj-$(CONFIG_HWMON_W83793)	+= w83793.o
+obj-$(CONFIG_HWMON_W83781D)	+= w83781d.o
+obj-$(CONFIG_HWMON_W83791D)	+= w83791d.o
 
-obj-$(CONFIG_SENSORS_ABITUGURU)	+= abituguru.o
-obj-$(CONFIG_SENSORS_AD7418)	+= ad7418.o
-obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
-obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
-obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
-obj-$(CONFIG_SENSORS_ADM1029)	+= adm1029.o
-obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
-obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
-obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
-obj-$(CONFIG_SENSORS_AMS)	+= ams/
-obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
-obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
-obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
-obj-$(CONFIG_SENSORS_F71805F)	+= f71805f.o
-obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
-obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o
-obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
-obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
-obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
-obj-$(CONFIG_SENSORS_IT87)	+= it87.o
-obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
-obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
-obj-$(CONFIG_SENSORS_LM70)	+= lm70.o
-obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
-obj-$(CONFIG_SENSORS_LM77)	+= lm77.o
-obj-$(CONFIG_SENSORS_LM78)	+= lm78.o
-obj-$(CONFIG_SENSORS_LM80)	+= lm80.o
-obj-$(CONFIG_SENSORS_LM83)	+= lm83.o
-obj-$(CONFIG_SENSORS_LM85)	+= lm85.o
-obj-$(CONFIG_SENSORS_LM87)	+= lm87.o
-obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
-obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
-obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
-obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
-obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
-obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
-obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
-obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
-obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
-obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
-obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
-obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
-obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
-obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
-obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
+obj-$(CONFIG_HWMON_ABITUGURU)	+= abituguru.o
+obj-$(CONFIG_HWMON_AD7418)	+= ad7418.o
+obj-$(CONFIG_HWMON_ADM1021)	+= adm1021.o
+obj-$(CONFIG_HWMON_ADM1025)	+= adm1025.o
+obj-$(CONFIG_HWMON_ADM1026)	+= adm1026.o
+obj-$(CONFIG_HWMON_ADM1029)	+= adm1029.o
+obj-$(CONFIG_HWMON_ADM1031)	+= adm1031.o
+obj-$(CONFIG_HWMON_ADM9240)	+= adm9240.o
+obj-$(CONFIG_HWMON_APPLESMC)	+= applesmc.o
+obj-$(CONFIG_HWMON_AMS)	+= ams/
+obj-$(CONFIG_HWMON_ATXP1)	+= atxp1.o
+obj-$(CONFIG_HWMON_CORETEMP)	+= coretemp.o
+obj-$(CONFIG_HWMON_DS1621)	+= ds1621.o
+obj-$(CONFIG_HWMON_F71805F)	+= f71805f.o
+obj-$(CONFIG_HWMON_FSCHER)	+= fscher.o
+obj-$(CONFIG_HWMON_FSCPOS)	+= fscpos.o
+obj-$(CONFIG_HWMON_GL518SM)	+= gl518sm.o
+obj-$(CONFIG_HWMON_GL520SM)	+= gl520sm.o
+obj-$(CONFIG_HWMON_HDAPS)	+= hdaps.o
+obj-$(CONFIG_HWMON_IT87)	+= it87.o
+obj-$(CONFIG_HWMON_K8TEMP)	+= k8temp.o
+obj-$(CONFIG_HWMON_LM63)	+= lm63.o
+obj-$(CONFIG_HWMON_LM70)	+= lm70.o
+obj-$(CONFIG_HWMON_LM75)	+= lm75.o
+obj-$(CONFIG_HWMON_LM77)	+= lm77.o
+obj-$(CONFIG_HWMON_LM78)	+= lm78.o
+obj-$(CONFIG_HWMON_LM80)	+= lm80.o
+obj-$(CONFIG_HWMON_LM83)	+= lm83.o
+obj-$(CONFIG_HWMON_LM85)	+= lm85.o
+obj-$(CONFIG_HWMON_LM87)	+= lm87.o
+obj-$(CONFIG_HWMON_LM90)	+= lm90.o
+obj-$(CONFIG_HWMON_LM92)	+= lm92.o
+obj-$(CONFIG_HWMON_MAX1619)	+= max1619.o
+obj-$(CONFIG_HWMON_MAX6650)	+= max6650.o
+obj-$(CONFIG_HWMON_PC87360)	+= pc87360.o
+obj-$(CONFIG_HWMON_PC87427)	+= pc87427.o
+obj-$(CONFIG_HWMON_SIS5595)	+= sis5595.o
+obj-$(CONFIG_HWMON_SMSC47B397)+= smsc47b397.o
+obj-$(CONFIG_HWMON_SMSC47M1)	+= smsc47m1.o
+obj-$(CONFIG_HWMON_SMSC47M192)+= smsc47m192.o
+obj-$(CONFIG_HWMON_VIA686A)	+= via686a.o
+obj-$(CONFIG_HWMON_VT1211)	+= vt1211.o
+obj-$(CONFIG_HWMON_VT8231)	+= vt8231.o
+obj-$(CONFIG_HWMON_W83627EHF)	+= w83627ehf.o
+obj-$(CONFIG_HWMON_W83L785TS)	+= w83l785ts.o
 
 ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG

--------------090104050607080503020303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090104050607080503020303--
