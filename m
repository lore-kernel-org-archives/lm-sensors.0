From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Sep 2009 15:47:27 +0000
Subject: [lm-sensors] [PATCH] hwmon: Clearly mark ACPI drivers as such
Message-Id: <20090907174727.4d4abd90@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Now that we have ACPI-based hardware monitoring drivers, and we will
start telling users to use them instead of native drivers when I/O
resources conflict, I think it would be good to clearly mark ACPI
drivers as such in Kconfig.

Also, in the case of monolithic kernels, I think the ACPI drivers
should take precedence over native drivers, so they should be listed
first in Makefile.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>
---
 drivers/hwmon/Kconfig  |  100 +++++++++++++++++++++++++-----------------------
 drivers/hwmon/Makefile |    6 +-
 2 files changed, 58 insertions(+), 48 deletions(-)

--- linux-2.6.31-rc9.orig/drivers/hwmon/Kconfig	2009-09-03 18:18:30.000000000 +0200
+++ linux-2.6.31-rc9/drivers/hwmon/Kconfig	2009-09-07 17:26:31.000000000 +0200
@@ -28,6 +28,17 @@ config HWMON_VID
 	tristate
 	default n
 
+config HWMON_DEBUG_CHIP
+	bool "Hardware Monitoring Chip debugging messages"
+	default n
+	help
+	  Say Y here if you want the I2C chip drivers to produce a bunch of
+	  debug messages to the system log.  Select this if you are having
+	  a problem with I2C support and want to see more of what is going
+	  on.
+
+comment "Native drivers"
+
 config SENSORS_ABITUGURU
 	tristate "Abit uGuru (rev 1 & 2)"
 	depends on X86 && EXPERIMENTAL
@@ -248,18 +259,6 @@ config SENSORS_ASB100
 	  This driver can also be built as a module.  If so, the module
 	  will be called asb100.
 
-config SENSORS_ATK0110
-	tristate "ASUS ATK0110 ACPI hwmon"
-	depends on X86 && ACPI && EXPERIMENTAL
-	help
-	  If you say yes here you get support for the ACPI hardware
-	  monitoring interface found in many ASUS motherboards. This
-	  driver will provide readings of fans, voltages and temperatures
-	  through the system firmware.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called asus_atk0110.
-
 config SENSORS_ATXP1
 	tristate "Attansic ATXP1 VID controller"
 	depends on I2C && EXPERIMENTAL
@@ -947,34 +946,6 @@ config SENSORS_HDAPS
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of hdaps.
 
-config SENSORS_LIS3LV02D
-	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer"
-	depends on ACPI && INPUT
-	select INPUT_POLLDEV
-	select NEW_LEDS
-	select LEDS_CLASS
-	default n
-	help
-	  This driver provides support for the LIS3LV02Dx accelerometer. In
-	  particular, it can be found in a number of HP laptops, which have the
-	  "Mobile Data Protection System 3D" or "3D DriveGuard" feature. On such
-	  systems the driver should load automatically (via ACPI). The
-	  accelerometer might also be found in other systems, connected via SPI
-	  or I2C.  The accelerometer data is readable via
-	  /sys/devices/platform/lis3lv02d.
-
-	  This driver also provides an absolute input class device, allowing
-	  the laptop to act as a pinball machine-esque joystick. On HP laptops,
-	  if the led infrastructure is activated, support for a led indicating
-	  disk protection will be provided as hp:red:hddprotection.
-
-	  This driver can also be built as modules.  If so, the core module
-	  will be called lis3lv02d and a specific module for HP laptops will be
-	  called hp_accel.
-
-	  Say Y here if you have an applicable laptop and want to experience
-	  the awesome power of lis3lv02d.
-
 config SENSORS_LIS3_SPI
 	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (SPI)"
 	depends on !ACPI && SPI_MASTER && INPUT
@@ -1017,13 +988,50 @@ config SENSORS_APPLESMC
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of applesmc.
 
-config HWMON_DEBUG_CHIP
-	bool "Hardware Monitoring Chip debugging messages"
+if ACPI
+
+comment "ACPI drivers"
+
+config SENSORS_ATK0110
+	tristate "ASUS ATK0110"
+	depends on X86 && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the ACPI hardware
+	  monitoring interface found in many ASUS motherboards. This
+	  driver will provide readings of fans, voltages and temperatures
+	  through the system firmware.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called asus_atk0110.
+
+config SENSORS_LIS3LV02D
+	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer"
+	depends on INPUT
+	select INPUT_POLLDEV
+	select NEW_LEDS
+	select LEDS_CLASS
 	default n
 	help
-	  Say Y here if you want the I2C chip drivers to produce a bunch of
-	  debug messages to the system log.  Select this if you are having
-	  a problem with I2C support and want to see more of what is going
-	  on.
+	  This driver provides support for the LIS3LV02Dx accelerometer. In
+	  particular, it can be found in a number of HP laptops, which have the
+	  "Mobile Data Protection System 3D" or "3D DriveGuard" feature. On such
+	  systems the driver should load automatically (via ACPI). The
+	  accelerometer might also be found in other systems, connected via SPI
+	  or I2C.  The accelerometer data is readable via
+	  /sys/devices/platform/lis3lv02d.
+
+	  This driver also provides an absolute input class device, allowing
+	  the laptop to act as a pinball machine-esque joystick. On HP laptops,
+	  if the led infrastructure is activated, support for a led indicating
+	  disk protection will be provided as hp:red:hddprotection.
+
+	  This driver can also be built as modules.  If so, the core module
+	  will be called lis3lv02d and a specific module for HP laptops will be
+	  called hp_accel.
+
+	  Say Y here if you have an applicable laptop and want to experience
+	  the awesome power of lis3lv02d.
+
+endif # ACPI
 
 endif # HWMON
--- linux-2.6.31-rc9.orig/drivers/hwmon/Makefile	2009-09-03 18:18:30.000000000 +0200
+++ linux-2.6.31-rc9/drivers/hwmon/Makefile	2009-09-07 17:22:10.000000000 +0200
@@ -5,6 +5,10 @@
 obj-$(CONFIG_HWMON)		+= hwmon.o
 obj-$(CONFIG_HWMON_VID)		+= hwmon-vid.o
 
+# APCI drivers
+obj-$(CONFIG_SENSORS_ATK0110)	+= asus_atk0110.o
+
+# Native drivers
 # asb100, then w83781d go first, as they can override other drivers' addresses.
 obj-$(CONFIG_SENSORS_ASB100)	+= asb100.o
 obj-$(CONFIG_SENSORS_W83627HF)	+= w83627hf.o
@@ -29,10 +33,8 @@ obj-$(CONFIG_SENSORS_ADT7462)	+= adt7462
 obj-$(CONFIG_SENSORS_ADT7470)	+= adt7470.o
 obj-$(CONFIG_SENSORS_ADT7473)	+= adt7473.o
 obj-$(CONFIG_SENSORS_ADT7475)	+= adt7475.o
-
 obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
 obj-$(CONFIG_SENSORS_AMS)	+= ams/
-obj-$(CONFIG_SENSORS_ATK0110)	+= asus_atk0110.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
 obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
