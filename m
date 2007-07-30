From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 30 Jul 2007 18:40:17 +0000
Subject: [lm-sensors] [PATCH 1/2] adt7470: Miscellaneous cleanups
Message-Id: <20070730184017.GA2795@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder Kconfig/Makefile and don't ask i2c for features that aren't
required.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/Kconfig   |   20 ++++++++++----------
 drivers/hwmon/Makefile  |    2 +-
 drivers/hwmon/adt7470.c |    3 +--
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 50b84aa..0fe3c52 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -57,16 +57,6 @@ config SENSORS_ABITUGURU3
 	  This driver can also be built as a module.  If so, the module
 	  will be called abituguru3.
 
-config SENSORS_ADT7470
-	tristate "Analog Devices ADT7470"
-	depends on I2C && EXPERIMENTAL
-	help
-	  If you say yes here you get support for the Analog Devices
-	  ADT7470 temperature monitoring chips.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called adt7470.
-
 config SENSORS_AD7418
 	tristate "Analog Devices AD7416, AD7417 and AD7418"
 	depends on I2C && EXPERIMENTAL
@@ -143,6 +133,16 @@ config SENSORS_ADM9240
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm9240.
 
+config SENSORS_ADT7470
+	tristate "Analog Devices ADT7470"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Analog Devices
+	  ADT7470 temperature monitoring chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called adt7470.
+
 config SENSORS_K8TEMP
 	tristate "AMD Athlon64/FX or Opteron temperature sensor"
 	depends on X86 && PCI && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 55c5289..bd75b44 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -15,7 +15,6 @@ obj-$(CONFIG_SENSORS_W83791D)	+= w83791d.o
 
 obj-$(CONFIG_SENSORS_ABITUGURU)	+= abituguru.o
 obj-$(CONFIG_SENSORS_ABITUGURU3)+= abituguru3.o
-obj-$(CONFIG_SENSORS_ADT7470)	+= adt7470.o
 obj-$(CONFIG_SENSORS_AD7418)	+= ad7418.o
 obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
 obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
@@ -23,6 +22,7 @@ obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
 obj-$(CONFIG_SENSORS_ADM1029)	+= adm1029.o
 obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
 obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
+obj-$(CONFIG_SENSORS_ADT7470)	+= adt7470.o
 obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
 obj-$(CONFIG_SENSORS_AMS)	+= ams/
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 75aee3b..dc0b35c 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -847,8 +847,7 @@ static int adt7470_detect(struct i2c_adapter *adapter, int address, int kind)
 	int err = 0;
 	int i;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
-				     I2C_FUNC_SMBUS_WORD_DATA))
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
 	if (!(data = kzalloc(sizeof(struct adt7470_data), GFP_KERNEL))) {

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
