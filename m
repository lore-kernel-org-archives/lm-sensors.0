From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 14 Feb 2014 09:45:37 +0000
Subject: [lm-sensors] [PATCH] hwmon: Sort Kconfig entries alphabetically
Message-Id: <20140214104537.3a29a531@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Entries have been added at more or less random positions over time, so
it becomes difficult to find what you are looking for or figure out
where to insert new entries.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
Guenter, can you take this in your tree, or is it too intrusive to your
taste?

 drivers/hwmon/Kconfig |  714 +++++++++++++++++++++++++-------------------------
 1 file changed, 357 insertions(+), 357 deletions(-)

--- linux-3.14-rc2.orig/drivers/hwmon/Kconfig	2014-02-14 10:25:00.100563213 +0100
+++ linux-3.14-rc2/drivers/hwmon/Kconfig	2014-02-14 10:38:27.299165984 +0100
@@ -111,22 +111,6 @@ config SENSORS_AD7418
 	  This driver can also be built as a module. If so, the module
 	  will be called ad7418.
 
-config SENSORS_ADCXX
-	tristate "National Semiconductor ADCxxxSxxx"
-	depends on SPI_MASTER
-	help
-	  If you say yes here you get support for the National Semiconductor
-	  ADC<bb><c>S<sss> chip family, where
-	  * bb  is the resolution in number of bits (8, 10, 12)
-	  * c   is the number of channels (1, 2, 4, 8)
-	  * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500
-	    kSPS and 101 for 1 MSPS)
-
-	  Examples : ADC081S101, ADC124S501, ...
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called adcxx.
-
 config SENSORS_ADM1021
 	tristate "Analog Devices ADM1021 and compatibles"
 	depends on I2C
@@ -312,6 +296,31 @@ config SENSORS_FAM15H_POWER
 	  This driver can also be built as a module.  If so, the module
 	  will be called fam15h_power.
 
+config SENSORS_APPLESMC
+	tristate "Apple SMC (Motion sensor, light sensor, keyboard backlight)"
+	depends on INPUT && X86
+	select NEW_LEDS
+	select LEDS_CLASS
+	select INPUT_POLLDEV
+	default n
+	help
+	  This driver provides support for the Apple System Management
+	  Controller, which provides an accelerometer (Apple Sudden Motion
+	  Sensor), light sensors, temperature sensors, keyboard backlight
+	  control and fan control.
+
+	  Only Intel-based Apple's computers are supported (MacBook Pro,
+	  MacBook, MacMini).
+
+	  Data from the different sensors, keyboard backlight control and fan
+	  control are accessible via sysfs.
+
+	  This driver also provides an absolute input class device, allowing
+	  the laptop to act as a pinball machine-esque joystick.
+
+	  Say Y here if you have an applicable laptop and want to experience
+	  the awesome power of applesmc.
+
 config SENSORS_ASB100
 	tristate "Asus ASB100 Bach"
 	depends on X86 && I2C
@@ -435,6 +444,12 @@ config SENSORS_F75375S
 	  This driver can also be built as a module.  If so, the module
 	  will be called f75375s.
 
+config SENSORS_MC13783_ADC
+        tristate "Freescale MC13783/MC13892 ADC"
+        depends on MFD_MC13XXX
+        help
+          Support for the A/D converter on MC13783 and MC13892 PMIC.
+
 config SENSORS_FSCHMD
 	tristate "Fujitsu Siemens Computers sensor chips"
 	depends on X86 && I2C
@@ -451,26 +466,6 @@ config SENSORS_FSCHMD
 	  This driver can also be built as a module.  If so, the module
 	  will be called fschmd.
 
-config SENSORS_G760A
-	tristate "GMT G760A"
-	depends on I2C
-	help
-	  If you say yes here you get support for Global Mixed-mode
-	  Technology Inc G760A fan speed PWM controller chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called g760a.
-
-config SENSORS_G762
-	tristate "GMT G762 and G763"
-	depends on I2C
-	help
-	  If you say yes here you get support for Global Mixed-mode
-	  Technology Inc G762 and G763 fan speed PWM controller chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called g762.
-
 config SENSORS_GL518SM
 	tristate "Genesys Logic GL518SM"
 	depends on I2C
@@ -492,6 +487,26 @@ config SENSORS_GL520SM
 	  This driver can also be built as a module.  If so, the module
 	  will be called gl520sm.
 
+config SENSORS_G760A
+	tristate "GMT G760A"
+	depends on I2C
+	help
+	  If you say yes here you get support for Global Mixed-mode
+	  Technology Inc G760A fan speed PWM controller chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called g760a.
+
+config SENSORS_G762
+	tristate "GMT G762 and G763"
+	depends on I2C
+	help
+	  If you say yes here you get support for Global Mixed-mode
+	  Technology Inc G762 and G763 fan speed PWM controller chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called g762.
+
 config SENSORS_GPIO_FAN
 	tristate "GPIO fan"
 	depends on GPIOLIB
@@ -511,24 +526,6 @@ config SENSORS_HIH6130
 	  This driver can also be built as a module.  If so, the module
 	  will be called hih6130.
 
-config SENSORS_HTU21
-	tristate "Measurement Specialties HTU21D humidity/temperature sensors"
-	depends on I2C
-	help
-	  If you say yes here you get support for the Measurement Specialties
-	  HTU21D humidity and temperature sensors.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called htu21.
-
-config SENSORS_CORETEMP
-	tristate "Intel Core/Core2/Atom temperature sensor"
-	depends on X86
-	help
-	  If you say yes here you get support for the temperature
-	  sensor inside your CPU. Most of the family 6 CPUs
-	  are supported. Check Documentation/hwmon/coretemp for details.
-
 config SENSORS_IBMAEM
 	tristate "IBM Active Energy Manager temperature/power sensors and control"
 	select IPMI_SI
@@ -566,6 +563,14 @@ config SENSORS_IIO_HWMON
 	  for those channels specified in the map.  This map can be provided
 	  either via platform data or the device tree bindings.
 
+config SENSORS_CORETEMP
+	tristate "Intel Core/Core2/Atom temperature sensor"
+	depends on X86
+	help
+	  If you say yes here you get support for the temperature
+	  sensor inside your CPU. Most of the family 6 CPUs
+	  are supported. Check Documentation/hwmon/coretemp for details.
+
 config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
 	depends on !PPC
@@ -614,410 +619,409 @@ config SENSORS_LINEAGE
 	  This driver can also be built as a module.  If so, the module
 	  will be called lineage-pem.
 
-config SENSORS_LM63
-	tristate "National Semiconductor LM63 and compatibles"
+config SENSORS_LTC2945
+	tristate "Linear Technology LTC2945"
 	depends on I2C
+	select REGMAP_I2C
+	default n
 	help
-	  If you say yes here you get support for the National
-	  Semiconductor LM63, LM64, and LM96163 remote diode digital temperature
-	  sensors with integrated fan control.  Such chips are found
-	  on the Tyan S4882 (Thunder K8QS Pro) motherboard, among
-	  others.
+	  If you say yes here you get support for Linear Technology LTC2945
+	  I2C System Monitor.
 
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm63.
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc2945.
 
-config SENSORS_LM70
-	tristate "National Semiconductor LM70 and compatibles"
-	depends on SPI_MASTER
+config SENSORS_LTC4151
+	tristate "Linear Technology LTC4151"
+	depends on I2C
+	default n
 	help
-	  If you say yes here you get support for the National Semiconductor
-	  LM70, LM71, LM74 and Texas Instruments TMP121/TMP123 digital tempera-
-	  ture sensor chips.
+	  If you say yes here you get support for Linear Technology LTC4151
+	  High Voltage I2C Current and Voltage Monitor interface.
 
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm70.
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc4151.
 
-config SENSORS_LM73
-	tristate "National Semiconductor LM73"
+config SENSORS_LTC4215
+	tristate "Linear Technology LTC4215"
 	depends on I2C
+	default n
 	help
-	  If you say yes here you get support for National Semiconductor LM73
-	  sensor chips.
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm73.
+	  If you say yes here you get support for Linear Technology LTC4215
+	  Hot Swap Controller I2C interface.
 
-config SENSORS_LM75
-	tristate "National Semiconductor LM75 and compatibles"
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc4215.
+
+config SENSORS_LTC4222
+	tristate "Linear Technology LTC4222"
 	depends on I2C
-	depends on THERMAL || !THERMAL_OF
+	select REGMAP_I2C
+	default n
 	help
-	  If you say yes here you get support for one common type of
-	  temperature sensor chip, with models including:
-
-		- Analog Devices ADT75
-		- Dallas Semiconductor DS75, DS1775 and DS7505
-		- Global Mixed-mode Technology (GMT) G751
-		- Maxim MAX6625 and MAX6626
-		- Microchip MCP980x
-		- National Semiconductor LM75, LM75A
-		- NXP's LM75A
-		- ST Microelectronics STDS75
-		- TelCom (now Microchip) TCN75
-		- Texas Instruments TMP100, TMP101, TMP105, TMP75, TMP175,
-		  TMP275
+	  If you say yes here you get support for Linear Technology LTC4222
+	  Dual Hot Swap Controller I2C interface.
 
-	  This driver supports driver model based binding through board
-	  specific I2C device tables.
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc4222.
 
-	  It also supports the "legacy" style of driver binding.  To use
-	  that with some chips which don't replicate LM75 quirks exactly,
-	  you may need the "force" module parameter.
+config SENSORS_LTC4245
+	tristate "Linear Technology LTC4245"
+	depends on I2C
+	default n
+	help
+	  If you say yes here you get support for Linear Technology LTC4245
+	  Multiple Supply Hot Swap Controller I2C interface.
 
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm75.
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc4245.
 
-config SENSORS_LM77
-	tristate "National Semiconductor LM77"
+config SENSORS_LTC4260
+	tristate "Linear Technology LTC4260"
 	depends on I2C
+	select REGMAP_I2C
+	default n
 	help
-	  If you say yes here you get support for National Semiconductor LM77
-	  sensor chips.
+	  If you say yes here you get support for Linear Technology LTC4260
+	  Positive Voltage Hot Swap Controller I2C interface.
 
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm77.
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc4260.
 
-config SENSORS_LM78
-	tristate "National Semiconductor LM78 and compatibles"
+config SENSORS_LTC4261
+	tristate "Linear Technology LTC4261"
 	depends on I2C
-	select HWMON_VID
+	default n
 	help
-	  If you say yes here you get support for National Semiconductor LM78,
-	  LM78-J and LM79.
+	  If you say yes here you get support for Linear Technology LTC4261
+	  Negative Voltage Hot Swap Controller I2C interface.
 
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm78.
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc4261.
 
-config SENSORS_LM80
-	tristate "National Semiconductor LM80 and LM96080"
-	depends on I2C
+config SENSORS_MAX1111
+	tristate "Maxim MAX1111 Serial 8-bit ADC chip and compatibles"
+	depends on SPI_MASTER
 	help
-	  If you say yes here you get support for National Semiconductor
-	  LM80 and LM96080 sensor chips.
+	  Say y here to support Maxim's MAX1110, MAX1111, MAX1112, and MAX1113
+	  ADC chips.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called lm80.
+	  will be called max1111.
 
-config SENSORS_LM83
-	tristate "National Semiconductor LM83 and compatibles"
+config SENSORS_MAX16065
+	tristate "Maxim MAX16065 System Manager and compatibles"
 	depends on I2C
 	help
-	  If you say yes here you get support for National Semiconductor
-	  LM82 and LM83 sensor chips.
+	  If you say yes here you get support for hardware monitoring
+	  capabilities of the following Maxim System Manager chips.
+	    MAX16065
+	    MAX16066
+	    MAX16067
+	    MAX16068
+	    MAX16070
+	    MAX16071
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called lm83.
+	  will be called max16065.
 
-config SENSORS_LM85
-	tristate "National Semiconductor LM85 and compatibles"
+config SENSORS_MAX1619
+	tristate "Maxim MAX1619 sensor chip"
 	depends on I2C
-	select HWMON_VID
 	help
-	  If you say yes here you get support for National Semiconductor LM85
-	  sensor chips and clones: ADM1027, ADT7463, ADT7468, EMC6D100,
-	  EMC6D101, EMC6D102, and EMC6D103.
+	  If you say yes here you get support for MAX1619 sensor chip.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called lm85.
+	  will be called max1619.
 
-config SENSORS_LM87
-	tristate "National Semiconductor LM87 and compatibles"
+config SENSORS_MAX1668
+	tristate "Maxim MAX1668 and compatibles"
 	depends on I2C
-	select HWMON_VID
 	help
-	  If you say yes here you get support for National Semiconductor LM87
-	  and Analog Devices ADM1024 sensor chips.
+	  If you say yes here you get support for MAX1668, MAX1989 and
+	  MAX1805 chips.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called lm87.
+	  will be called max1668.
 
-config SENSORS_LM90
-	tristate "National Semiconductor LM90 and compatibles"
+config SENSORS_MAX197
+	tristate "Maxim MAX197 and compatibles"
+	help
+	  Support for the Maxim MAX197 A/D converter.
+	  Support will include, but not be limited to, MAX197, and MAX199.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called max197.
+
+config SENSORS_MAX6639
+	tristate "Maxim MAX6639 sensor chip"
 	depends on I2C
 	help
-	  If you say yes here you get support for National Semiconductor LM90,
-	  LM86, LM89 and LM99, Analog Devices ADM1032, ADT7461, and ADT7461A,
-	  Maxim MAX6646, MAX6647, MAX6648, MAX6649, MAX6657, MAX6658, MAX6659,
-	  MAX6680, MAX6681, MAX6692, MAX6695, MAX6696, ON Semiconductor NCT1008,
-	  Winbond/Nuvoton W83L771W/G/AWG/ASG, Philips SA56004, and GMT G781
+	  If you say yes here you get support for the MAX6639
 	  sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called lm90.
+	  will be called max6639.
 
-config SENSORS_LM92
-	tristate "National Semiconductor LM92 and compatibles"
+config SENSORS_MAX6642
+	tristate "Maxim MAX6642 sensor chip"
 	depends on I2C
 	help
-	  If you say yes here you get support for National Semiconductor LM92
-	  and Maxim MAX6635 sensor chips.
+	  If you say yes here you get support for MAX6642 sensor chip.
+	  MAX6642 is a SMBus-Compatible Remote/Local Temperature Sensor
+	  with Overtemperature Alarm from Maxim.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called lm92.
+	  will be called max6642.
 
-config SENSORS_LM93
-	tristate "National Semiconductor LM93 and compatibles"
+config SENSORS_MAX6650
+	tristate "Maxim MAX6650 sensor chip"
 	depends on I2C
-	select HWMON_VID
 	help
-	  If you say yes here you get support for National Semiconductor LM93,
-	  LM94, and compatible sensor chips.
+	  If you say yes here you get support for the MAX6650 / MAX6651
+	  sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called lm93.
+	  will be called max6650.
 
-config SENSORS_LTC2945
-	tristate "Linear Technology LTC2945"
+config SENSORS_MAX6697
+	tristate "Maxim MAX6697 and compatibles"
 	depends on I2C
-	select REGMAP_I2C
-	default n
 	help
-	  If you say yes here you get support for Linear Technology LTC2945
-	  I2C System Monitor.
+	  If you say yes here you get support for MAX6581, MAX6602, MAX6622,
+	  MAX6636, MAX6689, MAX6693, MAX6694, MAX6697, MAX6698, and MAX6699
+	  temperature sensor chips.
 
-	  This driver can also be built as a module. If so, the module will
-	  be called ltc2945.
+	  This driver can also be built as a module.  If so, the module
+	  will be called max6697.
 
-config SENSORS_LTC4151
-	tristate "Linear Technology LTC4151"
+config SENSORS_HTU21
+	tristate "Measurement Specialties HTU21D humidity/temperature sensors"
 	depends on I2C
-	default n
 	help
-	  If you say yes here you get support for Linear Technology LTC4151
-	  High Voltage I2C Current and Voltage Monitor interface.
+	  If you say yes here you get support for the Measurement Specialties
+	  HTU21D humidity and temperature sensors.
 
-	  This driver can also be built as a module. If so, the module will
-	  be called ltc4151.
+	  This driver can also be built as a module.  If so, the module
+	  will be called htu21.
 
-config SENSORS_LTC4215
-	tristate "Linear Technology LTC4215"
+config SENSORS_MCP3021
+	tristate "Microchip MCP3021 and compatibles"
 	depends on I2C
-	default n
 	help
-	  If you say yes here you get support for Linear Technology LTC4215
-	  Hot Swap Controller I2C interface.
+	  If you say yes here you get support for MCP3021 and MCP3221.
+	  The MCP3021 is a A/D converter (ADC) with 10-bit and the MCP3221
+	  with 12-bit resolution.
 
-	  This driver can also be built as a module. If so, the module will
-	  be called ltc4215.
+	  This driver can also be built as a module.  If so, the module
+	  will be called mcp3021.
 
-config SENSORS_LTC4222
-	tristate "Linear Technology LTC4222"
-	depends on I2C
-	select REGMAP_I2C
-	default n
+config SENSORS_ADCXX
+	tristate "National Semiconductor ADCxxxSxxx"
+	depends on SPI_MASTER
 	help
-	  If you say yes here you get support for Linear Technology LTC4222
-	  Dual Hot Swap Controller I2C interface.
+	  If you say yes here you get support for the National Semiconductor
+	  ADC<bb><c>S<sss> chip family, where
+	  * bb  is the resolution in number of bits (8, 10, 12)
+	  * c   is the number of channels (1, 2, 4, 8)
+	  * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500
+	    kSPS and 101 for 1 MSPS)
 
-	  This driver can also be built as a module. If so, the module will
-	  be called ltc4222.
+	  Examples : ADC081S101, ADC124S501, ...
 
-config SENSORS_LTC4245
-	tristate "Linear Technology LTC4245"
+	  This driver can also be built as a module.  If so, the module
+	  will be called adcxx.
+
+config SENSORS_LM63
+	tristate "National Semiconductor LM63 and compatibles"
 	depends on I2C
-	default n
 	help
-	  If you say yes here you get support for Linear Technology LTC4245
-	  Multiple Supply Hot Swap Controller I2C interface.
+	  If you say yes here you get support for the National
+	  Semiconductor LM63, LM64, and LM96163 remote diode digital temperature
+	  sensors with integrated fan control.  Such chips are found
+	  on the Tyan S4882 (Thunder K8QS Pro) motherboard, among
+	  others.
 
-	  This driver can also be built as a module. If so, the module will
-	  be called ltc4245.
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm63.
 
-config SENSORS_LTC4260
-	tristate "Linear Technology LTC4260"
-	depends on I2C
-	select REGMAP_I2C
-	default n
+config SENSORS_LM70
+	tristate "National Semiconductor LM70 and compatibles"
+	depends on SPI_MASTER
 	help
-	  If you say yes here you get support for Linear Technology LTC4260
-	  Positive Voltage Hot Swap Controller I2C interface.
+	  If you say yes here you get support for the National Semiconductor
+	  LM70, LM71, LM74 and Texas Instruments TMP121/TMP123 digital tempera-
+	  ture sensor chips.
 
-	  This driver can also be built as a module. If so, the module will
-	  be called ltc4260.
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm70.
 
-config SENSORS_LTC4261
-	tristate "Linear Technology LTC4261"
+config SENSORS_LM73
+	tristate "National Semiconductor LM73"
 	depends on I2C
-	default n
 	help
-	  If you say yes here you get support for Linear Technology LTC4261
-	  Negative Voltage Hot Swap Controller I2C interface.
-
-	  This driver can also be built as a module. If so, the module will
-	  be called ltc4261.
+	  If you say yes here you get support for National Semiconductor LM73
+	  sensor chips.
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm73.
 
-config SENSORS_LM95234
-	tristate "National Semiconductor LM95234"
+config SENSORS_LM75
+	tristate "National Semiconductor LM75 and compatibles"
 	depends on I2C
+	depends on THERMAL || !THERMAL_OF
 	help
-	  If you say yes here you get support for the LM95234 temperature
-	  sensor.
+	  If you say yes here you get support for one common type of
+	  temperature sensor chip, with models including:
+
+		- Analog Devices ADT75
+		- Dallas Semiconductor DS75, DS1775 and DS7505
+		- Global Mixed-mode Technology (GMT) G751
+		- Maxim MAX6625 and MAX6626
+		- Microchip MCP980x
+		- National Semiconductor LM75, LM75A
+		- NXP's LM75A
+		- ST Microelectronics STDS75
+		- TelCom (now Microchip) TCN75
+		- Texas Instruments TMP100, TMP101, TMP105, TMP75, TMP175,
+		  TMP275
+
+	  This driver supports driver model based binding through board
+	  specific I2C device tables.
+
+	  It also supports the "legacy" style of driver binding.  To use
+	  that with some chips which don't replicate LM75 quirks exactly,
+	  you may need the "force" module parameter.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called lm95234.
+	  will be called lm75.
 
-config SENSORS_LM95241
-	tristate "National Semiconductor LM95241 and compatibles"
+config SENSORS_LM77
+	tristate "National Semiconductor LM77"
 	depends on I2C
 	help
-	  If you say yes here you get support for LM95231 and LM95241 sensor
-	  chips.
+	  If you say yes here you get support for National Semiconductor LM77
+	  sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called lm95241.
+	  will be called lm77.
 
-config SENSORS_LM95245
-	tristate "National Semiconductor LM95245 sensor chip"
+config SENSORS_LM78
+	tristate "National Semiconductor LM78 and compatibles"
 	depends on I2C
+	select HWMON_VID
 	help
-	  If you say yes here you get support for LM95245 sensor chip.
+	  If you say yes here you get support for National Semiconductor LM78,
+	  LM78-J and LM79.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called lm95245.
+	  will be called lm78.
 
-config SENSORS_MAX1111
-	tristate "Maxim MAX1111 Serial 8-bit ADC chip and compatibles"
-	depends on SPI_MASTER
+config SENSORS_LM80
+	tristate "National Semiconductor LM80 and LM96080"
+	depends on I2C
 	help
-	  Say y here to support Maxim's MAX1110, MAX1111, MAX1112, and MAX1113
-	  ADC chips.
+	  If you say yes here you get support for National Semiconductor
+	  LM80 and LM96080 sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called max1111.
+	  will be called lm80.
 
-config SENSORS_MAX16065
-	tristate "Maxim MAX16065 System Manager and compatibles"
+config SENSORS_LM83
+	tristate "National Semiconductor LM83 and compatibles"
 	depends on I2C
 	help
-	  If you say yes here you get support for hardware monitoring
-	  capabilities of the following Maxim System Manager chips.
-	    MAX16065
-	    MAX16066
-	    MAX16067
-	    MAX16068
-	    MAX16070
-	    MAX16071
+	  If you say yes here you get support for National Semiconductor
+	  LM82 and LM83 sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called max16065.
+	  will be called lm83.
 
-config SENSORS_MAX1619
-	tristate "Maxim MAX1619 sensor chip"
+config SENSORS_LM85
+	tristate "National Semiconductor LM85 and compatibles"
 	depends on I2C
+	select HWMON_VID
 	help
-	  If you say yes here you get support for MAX1619 sensor chip.
+	  If you say yes here you get support for National Semiconductor LM85
+	  sensor chips and clones: ADM1027, ADT7463, ADT7468, EMC6D100,
+	  EMC6D101, EMC6D102, and EMC6D103.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called max1619.
+	  will be called lm85.
 
-config SENSORS_MAX1668
-	tristate "Maxim MAX1668 and compatibles"
+config SENSORS_LM87
+	tristate "National Semiconductor LM87 and compatibles"
 	depends on I2C
+	select HWMON_VID
 	help
-	  If you say yes here you get support for MAX1668, MAX1989 and
-	  MAX1805 chips.
+	  If you say yes here you get support for National Semiconductor LM87
+	  and Analog Devices ADM1024 sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called max1668.
-
-config SENSORS_MAX197
-	tristate "Maxim MAX197 and compatibles"
-	help
-	  Support for the Maxim MAX197 A/D converter.
-	  Support will include, but not be limited to, MAX197, and MAX199.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called max197.
+	  will be called lm87.
 
-config SENSORS_MAX6639
-	tristate "Maxim MAX6639 sensor chip"
+config SENSORS_LM90
+	tristate "National Semiconductor LM90 and compatibles"
 	depends on I2C
 	help
-	  If you say yes here you get support for the MAX6639
+	  If you say yes here you get support for National Semiconductor LM90,
+	  LM86, LM89 and LM99, Analog Devices ADM1032, ADT7461, and ADT7461A,
+	  Maxim MAX6646, MAX6647, MAX6648, MAX6649, MAX6657, MAX6658, MAX6659,
+	  MAX6680, MAX6681, MAX6692, MAX6695, MAX6696, ON Semiconductor NCT1008,
+	  Winbond/Nuvoton W83L771W/G/AWG/ASG, Philips SA56004, and GMT G781
 	  sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called max6639.
+	  will be called lm90.
 
-config SENSORS_MAX6642
-	tristate "Maxim MAX6642 sensor chip"
+config SENSORS_LM92
+	tristate "National Semiconductor LM92 and compatibles"
 	depends on I2C
 	help
-	  If you say yes here you get support for MAX6642 sensor chip.
-	  MAX6642 is a SMBus-Compatible Remote/Local Temperature Sensor
-	  with Overtemperature Alarm from Maxim.
+	  If you say yes here you get support for National Semiconductor LM92
+	  and Maxim MAX6635 sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called max6642.
+	  will be called lm92.
 
-config SENSORS_MAX6650
-	tristate "Maxim MAX6650 sensor chip"
+config SENSORS_LM93
+	tristate "National Semiconductor LM93 and compatibles"
 	depends on I2C
+	select HWMON_VID
 	help
-	  If you say yes here you get support for the MAX6650 / MAX6651
-	  sensor chips.
+	  If you say yes here you get support for National Semiconductor LM93,
+	  LM94, and compatible sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called max6650.
+	  will be called lm93.
 
-config SENSORS_MAX6697
-	tristate "Maxim MAX6697 and compatibles"
+config SENSORS_LM95234
+	tristate "National Semiconductor LM95234"
 	depends on I2C
 	help
-	  If you say yes here you get support for MAX6581, MAX6602, MAX6622,
-	  MAX6636, MAX6689, MAX6693, MAX6694, MAX6697, MAX6698, and MAX6699
-	  temperature sensor chips.
+	  If you say yes here you get support for the LM95234 temperature
+	  sensor.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called max6697.
+	  will be called lm95234.
 
-config SENSORS_MCP3021
-	tristate "Microchip MCP3021 and compatibles"
+config SENSORS_LM95241
+	tristate "National Semiconductor LM95241 and compatibles"
 	depends on I2C
 	help
-	  If you say yes here you get support for MCP3021 and MCP3221.
-	  The MCP3021 is a A/D converter (ADC) with 10-bit and the MCP3221
-	  with 12-bit resolution.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called mcp3021.
-
-config SENSORS_NCT6775
-	tristate "Nuvoton NCT6775F and compatibles"
-	depends on !PPC
-	select HWMON_VID
-	help
-	  If you say yes here you get support for the hardware monitoring
-	  functionality of the Nuvoton NCT6775F, NCT6776F, NCT6779D
-	  and compatible Super-I/O chips. This driver replaces the
-	  w83627ehf driver for NCT6775F and NCT6776F.
+	  If you say yes here you get support for LM95231 and LM95241 sensor
+	  chips.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called nct6775.
+	  will be called lm95241.
 
-config SENSORS_NTC_THERMISTOR
-	tristate "NTC thermistor support"
-	depends on (!OF && !IIO) || (OF && IIO)
+config SENSORS_LM95245
+	tristate "National Semiconductor LM95245 sensor chip"
+	depends on I2C
 	help
-	  This driver supports NTC thermistors sensor reading and its
-	  interpretation. The driver can also monitor the temperature and
-	  send notifications about the temperature.
-
-	  Currently, this driver supports
-	  NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, and NCP15WL333.
+	  If you say yes here you get support for LM95245 sensor chip.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called ntc-thermistor.
+	  will be called lm95245.
 
 config SENSORS_PC87360
 	tristate "National Semiconductor PC87360 family"
@@ -1047,6 +1051,33 @@ config SENSORS_PC87427
 	  This driver can also be built as a module.  If so, the module
 	  will be called pc87427.
 
+config SENSORS_NTC_THERMISTOR
+	tristate "NTC thermistor support"
+	depends on (!OF && !IIO) || (OF && IIO)
+	help
+	  This driver supports NTC thermistors sensor reading and its
+	  interpretation. The driver can also monitor the temperature and
+	  send notifications about the temperature.
+
+	  Currently, this driver supports
+	  NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, and NCP15WL333.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ntc-thermistor.
+
+config SENSORS_NCT6775
+	tristate "Nuvoton NCT6775F and compatibles"
+	depends on !PPC
+	select HWMON_VID
+	help
+	  If you say yes here you get support for the hardware monitoring
+	  functionality of the Nuvoton NCT6775F, NCT6776F, NCT6779D
+	  and compatible Super-I/O chips. This driver replaces the
+	  w83627ehf driver for NCT6775F and NCT6776F.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called nct6775.
+
 config SENSORS_PCF8591
 	tristate "Philips PCF8591 ADC/DAC"
 	depends on I2C
@@ -1110,21 +1141,6 @@ config SENSORS_SIS5595
 	  This driver can also be built as a module.  If so, the module
 	  will be called sis5595.
 
-config SENSORS_SMM665
-	tristate "Summit Microelectronics SMM665"
-	depends on I2C
-	default n
-	help
-	  If you say yes here you get support for the hardware monitoring
-	  features of the Summit Microelectronics SMM665/SMM665B Six-Channel
-	  Active DC Output Controller / Monitor.
-
-	  Other supported chips are SMM465, SMM665C, SMM764, and SMM766.
-	  Support for those chips is untested.
-
-	  This driver can also be built as a module. If so, the module will
-	  be called smm665.
-
 config SENSORS_DME1737
 	tristate "SMSC DME1737, SCH311x and compatibles"
 	depends on I2C && !PPC
@@ -1246,6 +1262,21 @@ config SENSORS_SCH5636
 	  This driver can also be built as a module.  If so, the module
 	  will be called sch5636.
 
+config SENSORS_SMM665
+	tristate "Summit Microelectronics SMM665"
+	depends on I2C
+	default n
+	help
+	  If you say yes here you get support for the hardware monitoring
+	  features of the Summit Microelectronics SMM665/SMM665B Six-Channel
+	  Active DC Output Controller / Monitor.
+
+	  Other supported chips are SMM465, SMM665C, SMM764, and SMM766.
+	  Support for those chips is untested.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called smm665.
+
 config SENSORS_ADS1015
 	tristate "Texas Instruments ADS1015"
 	depends on I2C
@@ -1561,37 +1592,6 @@ config SENSORS_ULTRA45
 	  This driver provides support for the Ultra45 workstation environmental
 	  sensors.
 
-config SENSORS_APPLESMC
-	tristate "Apple SMC (Motion sensor, light sensor, keyboard backlight)"
-	depends on INPUT && X86
-	select NEW_LEDS
-	select LEDS_CLASS
-	select INPUT_POLLDEV
-	default n
-	help
-	  This driver provides support for the Apple System Management
-	  Controller, which provides an accelerometer (Apple Sudden Motion
-	  Sensor), light sensors, temperature sensors, keyboard backlight
-	  control and fan control.
-
-	  Only Intel-based Apple's computers are supported (MacBook Pro,
-	  MacBook, MacMini).
-
-	  Data from the different sensors, keyboard backlight control and fan
-	  control are accessible via sysfs.
-
-	  This driver also provides an absolute input class device, allowing
-	  the laptop to act as a pinball machine-esque joystick.
-
-	  Say Y here if you have an applicable laptop and want to experience
-	  the awesome power of applesmc.
-
-config SENSORS_MC13783_ADC
-        tristate "Freescale MC13783/MC13892 ADC"
-        depends on MFD_MC13XXX
-        help
-          Support for the A/D converter on MC13783 and MC13892 PMIC.
-
 if ACPI
 
 comment "ACPI drivers"


-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
