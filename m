From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 15 Sep 2012 15:05:25 +0000
Subject: [lm-sensors] [PATCH] hwmon: Drop dependencies on EXPERIMENTAL
Message-Id: <1347721525-22792-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

CONFIG_EXPERIMENTAL is expected to be removed, so drop dependencies on it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/Kconfig |   81 ++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 41 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 6cf51cb..6bc49cf 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -41,7 +41,7 @@ comment "Native drivers"
 
 config SENSORS_ABITUGURU
 	tristate "Abit uGuru (rev 1 & 2)"
-	depends on X86 && DMI && EXPERIMENTAL
+	depends on X86 && DMI
 	help
 	  If you say yes here you get support for the sensor part of the first
 	  and second revision of the Abit uGuru chip. The voltage and frequency
@@ -56,7 +56,7 @@ config SENSORS_ABITUGURU
 
 config SENSORS_ABITUGURU3
 	tristate "Abit uGuru (rev 3)"
-	depends on X86 && DMI && EXPERIMENTAL
+	depends on X86 && DMI
 	help
 	  If you say yes here you get support for the sensor part of the
 	  third revision of the Abit uGuru chip. Only reading the sensors
@@ -70,7 +70,7 @@ config SENSORS_ABITUGURU3
 
 config SENSORS_AD7314
 	tristate "Analog Devices AD7314 and compatibles"
-	depends on SPI && EXPERIMENTAL
+	depends on SPI
 	help
 	  If you say yes here you get support for the Analog Devices
 	  AD7314, ADT7301 and ADT7302 temperature sensors.
@@ -80,7 +80,7 @@ config SENSORS_AD7314
 
 config SENSORS_AD7414
 	tristate "Analog Devices AD7414"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for the Analog Devices
 	  AD7414 temperature monitoring chip.
@@ -90,7 +90,7 @@ config SENSORS_AD7414
 
 config SENSORS_AD7418
 	tristate "Analog Devices AD7416, AD7417 and AD7418"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for the Analog Devices
 	  AD7416, AD7417 and AD7418 temperature monitoring chips.
@@ -100,7 +100,7 @@ config SENSORS_AD7418
 
 config SENSORS_ADCXX
 	tristate "National Semiconductor ADCxxxSxxx"
-	depends on SPI_MASTER && EXPERIMENTAL
+	depends on SPI_MASTER
 	help
 	  If you say yes here you get support for the National Semiconductor
 	  ADC<bb><c>S<sss> chip family, where
@@ -181,7 +181,7 @@ config SENSORS_ADM9240
 
 config SENSORS_ADT7410
 	tristate "Analog Devices ADT7410"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for the Analog Devices
 	  ADT7410 temperature monitoring chip.
@@ -191,7 +191,7 @@ config SENSORS_ADT7410
 
 config SENSORS_ADT7411
 	tristate "Analog Devices ADT7411"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for the Analog Devices
 	  ADT7411 voltage and temperature monitoring chip.
@@ -201,7 +201,7 @@ config SENSORS_ADT7411
 
 config SENSORS_ADT7462
 	tristate "Analog Devices ADT7462"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for the Analog Devices
 	  ADT7462 temperature monitoring chips.
@@ -211,7 +211,7 @@ config SENSORS_ADT7462
 
 config SENSORS_ADT7470
 	tristate "Analog Devices ADT7470"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for the Analog Devices
 	  ADT7470 temperature monitoring chips.
@@ -246,7 +246,7 @@ config SENSORS_ASC7621
 
 config SENSORS_K8TEMP
 	tristate "AMD Athlon64/FX or Opteron temperature sensor"
-	depends on X86 && PCI && EXPERIMENTAL
+	depends on X86 && PCI
 	help
 	  If you say yes here you get support for the temperature
 	  sensor(s) inside your CPU. Supported is whole AMD K8
@@ -281,7 +281,7 @@ config SENSORS_FAM15H_POWER
 
 config SENSORS_ASB100
 	tristate "Asus ASB100 Bach"
-	depends on X86 && I2C && EXPERIMENTAL
+	depends on X86 && I2C
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the ASB100 Bach sensor
@@ -292,7 +292,7 @@ config SENSORS_ASB100
 
 config SENSORS_ATXP1
 	tristate "Attansic ATXP1 VID controller"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the Attansic ATXP1 VID
@@ -346,7 +346,7 @@ config SENSORS_EXYNOS4_TMU
 
 config SENSORS_I5K_AMB
 	tristate "FB-DIMM AMB temperature sensor on Intel 5000 series chipsets"
-	depends on PCI && EXPERIMENTAL
+	depends on PCI
 	help
 	  If you say yes here you get support for FB-DIMM AMB temperature
 	  monitoring chips on systems with the Intel 5000 series chipset.
@@ -455,7 +455,7 @@ config SENSORS_GPIO_FAN
 
 config SENSORS_HIH6130
 	tristate "Honeywell Humidicon HIH-6130 humidity/temperature sensor"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for Honeywell Humidicon
 	  HIH-6130 and HIH-6131 Humidicon humidity sensors.
@@ -465,7 +465,7 @@ config SENSORS_HIH6130
 
 config SENSORS_CORETEMP
 	tristate "Intel Core/Core2/Atom temperature sensor"
-	depends on X86 && PCI && EXPERIMENTAL
+	depends on X86 && PCI
 	help
 	  If you say yes here you get support for the temperature
 	  sensor inside your CPU. Most of the family 6 CPUs
@@ -537,7 +537,7 @@ config SENSORS_JC42
 
 config SENSORS_LINEAGE
 	tristate "Lineage Compact Power Line Power Entry Module"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for the Lineage Compact Power Line
 	  series of DC/DC and AC/DC converters such as CP1800, CP2000AC,
@@ -719,7 +719,7 @@ config SENSORS_LTC4151
 
 config SENSORS_LTC4215
 	tristate "Linear Technology LTC4215"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	default n
 	help
 	  If you say yes here you get support for Linear Technology LTC4215
@@ -730,7 +730,7 @@ config SENSORS_LTC4215
 
 config SENSORS_LTC4245
 	tristate "Linear Technology LTC4245"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	default n
 	help
 	  If you say yes here you get support for Linear Technology LTC4245
@@ -741,7 +741,7 @@ config SENSORS_LTC4245
 
 config SENSORS_LTC4261
 	tristate "Linear Technology LTC4261"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	default n
 	help
 	  If you say yes here you get support for Linear Technology LTC4261
@@ -762,7 +762,7 @@ config SENSORS_LM95241
 
 config SENSORS_LM95245
 	tristate "National Semiconductor LM95245 sensor chip"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for LM95245 sensor chip.
 
@@ -806,7 +806,7 @@ config SENSORS_MAX1619
 
 config SENSORS_MAX1668
 	tristate "Maxim MAX1668 and compatibles"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for MAX1668, MAX1989 and
 	  MAX1805 chips.
@@ -825,7 +825,7 @@ config SENSORS_MAX197
 
 config SENSORS_MAX6639
 	tristate "Maxim MAX6639 sensor chip"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for the MAX6639
 	  sensor chips.
@@ -835,7 +835,7 @@ config SENSORS_MAX6639
 
 config SENSORS_MAX6642
 	tristate "Maxim MAX6642 sensor chip"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for MAX6642 sensor chip.
 	  MAX6642 is a SMBus-Compatible Remote/Local Temperature Sensor
@@ -846,7 +846,7 @@ config SENSORS_MAX6642
 
 config SENSORS_MAX6650
 	tristate "Maxim MAX6650 sensor chip"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for the MAX6650 / MAX6651
 	  sensor chips.
@@ -856,7 +856,7 @@ config SENSORS_MAX6650
 
 config SENSORS_MCP3021
 	tristate "Microchip MCP3021"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for the MCP3021 chip
 	  that is a A/D converter (ADC) with 10-bit resolution.
@@ -866,7 +866,6 @@ config SENSORS_MCP3021
 
 config SENSORS_NTC_THERMISTOR
 	tristate "NTC thermistor support"
-	depends on EXPERIMENTAL
 	help
 	  This driver supports NTC thermistors sensor reading and its
 	  interpretation. The driver can also monitor the temperature and
@@ -971,7 +970,7 @@ config SENSORS_SIS5595
 
 config SENSORS_SMM665
 	tristate "Summit Microelectronics SMM665"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	default n
 	help
 	  If you say yes here you get support for the hardware monitoring
@@ -986,7 +985,7 @@ config SENSORS_SMM665
 
 config SENSORS_DME1737
 	tristate "SMSC DME1737, SCH311x and compatibles"
-	depends on I2C && EXPERIMENTAL && !PPC
+	depends on I2C && !PPC
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the hardware monitoring
@@ -1062,7 +1061,7 @@ config SENSORS_SMSC47M192
 
 config SENSORS_SMSC47B397
 	tristate "SMSC LPC47B397-NC"
-	depends on EXPERIMENTAL && !PPC
+	depends on !PPC
 	help
 	  If you say yes here you get support for the SMSC LPC47B397-NC
 	  sensor chip.
@@ -1136,7 +1135,7 @@ config SENSORS_ADS7871
 
 config SENSORS_AMC6821
 	tristate "Texas Instruments AMC6821"
-	depends on I2C  && EXPERIMENTAL
+	depends on I2C 
 	help
 	  If you say yes here you get support for the Texas Instruments
 	  AMC6821 hardware monitoring chips.
@@ -1146,7 +1145,7 @@ config SENSORS_AMC6821
 
 config SENSORS_INA2XX
 	tristate "Texas Instruments INA219 and compatibles"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for INA219, INA220, INA226, and
 	  INA230 power monitor chips.
@@ -1169,7 +1168,7 @@ config SENSORS_THMC50
 
 config SENSORS_TMP102
 	tristate "Texas Instruments TMP102"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for Texas Instruments TMP102
 	  sensor chips.
@@ -1179,7 +1178,7 @@ config SENSORS_TMP102
 
 config SENSORS_TMP401
 	tristate "Texas Instruments TMP401 and compatibles"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for Texas Instruments TMP401 and
 	  TMP411 temperature sensor chips.
@@ -1189,7 +1188,7 @@ config SENSORS_TMP401
 
 config SENSORS_TMP421
 	tristate "Texas Instruments TMP421 and compatible"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for Texas Instruments TMP421,
 	  TMP422 and TMP423 temperature sensor chips.
@@ -1281,7 +1280,7 @@ config SENSORS_W83792D
 
 config SENSORS_W83793
 	tristate "Winbond W83793"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the Winbond W83793
@@ -1293,7 +1292,7 @@ config SENSORS_W83793
 
 config SENSORS_W83795
 	tristate "Winbond/Nuvoton W83795G/ADG"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for the Winbond W83795G and
 	  W83795ADG hardware monitoring chip, including manual fan speed
@@ -1304,7 +1303,7 @@ config SENSORS_W83795
 
 config SENSORS_W83795_FANCTRL
 	boolean "Include automatic fan control support (DANGEROUS)"
-	depends on SENSORS_W83795 && EXPERIMENTAL
+	depends on SENSORS_W83795
 	default n
 	help
 	  If you say yes here, support for automatic fan speed control
@@ -1321,7 +1320,7 @@ config SENSORS_W83795_FANCTRL
 
 config SENSORS_W83L785TS
 	tristate "Winbond W83L785TS-S"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for the Winbond W83L785TS-S
 	  sensor chip, which is used on the Asus A7N8X, among other
@@ -1332,7 +1331,7 @@ config SENSORS_W83L785TS
 
 config SENSORS_W83L786NG
 	tristate "Winbond W83L786NG, W83L786NR"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for the Winbond W83L786NG
 	  and W83L786NR sensor chips.
@@ -1447,7 +1446,7 @@ config SENSORS_ACPI_POWER
 
 config SENSORS_ATK0110
 	tristate "ASUS ATK0110"
-	depends on X86 && EXPERIMENTAL
+	depends on X86
 	help
 	  If you say yes here you get support for the ACPI hardware
 	  monitoring interface found in many ASUS motherboards. This
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
