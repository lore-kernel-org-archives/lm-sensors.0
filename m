From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 23 Jan 2012 16:26:29 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (lm90) Add support for G781
Message-Id: <1327335989-10214-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

GMT G781 is a ADM1032-compatible temperature sensor chip.
Add support to the LM90 driver.

Cc: Mike Gorchak <lestat@i.com.ua>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Drop device ID 0x03, since its existence is not confirmed.
  Instead, accept device ID 0x01 on both 0x4c and 0x4d.
- Drop referring to G781-1; we don't do that for other chips either,
  and it is not clear if it is even possible to distinguish G781 from G781-1.
- Add G781 information to Kconfig, lm90 documentation
- Mention G781 support in lm90.c file comments
- Modify formatting to better match file formatting

 Documentation/hwmon/lm90 |    5 +++++
 drivers/hwmon/Kconfig    |    3 ++-
 drivers/hwmon/lm90.c     |   19 ++++++++++++++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/lm90 b/Documentation/hwmon/lm90
index 9cd14cfe..d8f1e66 100644
--- a/Documentation/hwmon/lm90
+++ b/Documentation/hwmon/lm90
@@ -118,6 +118,11 @@ Supported chips:
     Addresses scanned: I2C 0x48 through 0x4F
     Datasheet: Publicly available at NXP website
                http://ics.nxp.com/products/interface/datasheet/sa56004x.pdf
+  * GMT G781
+    Prefix: 'g781'
+    Addresses scanned: I2C 0x4c, 0x4d
+    Datasheet: Publicly available, for example from
+    		http://www.datasheetarchive.com/G781-datasheet.html
 
 Author: Jean Delvare <khali@linux-fr.org>
 
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 0226040..930428c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -647,7 +647,8 @@ config SENSORS_LM90
 	  LM86, LM89 and LM99, Analog Devices ADM1032, ADT7461, and ADT7461A,
 	  Maxim MAX6646, MAX6647, MAX6648, MAX6649, MAX6657, MAX6658, MAX6659,
 	  MAX6680, MAX6681, MAX6692, MAX6695, MAX6696, ON Semiconductor NCT1008,
-	  Winbond/Nuvoton W83L771W/G/AWG/ASG and Philips SA56004 sensor chips.
+	  Winbond/Nuvoton W83L771W/G/AWG/ASG, Philips SA56004, and GMT G781
+	  sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm90.
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 2e207de..0af8f8f 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -57,6 +57,9 @@
  * This driver also supports the SA56004 from Philips. This device is
  * pin-compatible with the LM86, the ED/EDP parts are also address-compatible.
  *
+ * This driver also supports the G781 from GMT. This device is compatible
+ * with the ADM1032.
+ *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and
  * concern all supported chipsets, unless mentioned otherwise.
@@ -107,7 +110,7 @@ static const unsigned short normal_i2c[] = {
 	0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
-	max6646, w83l771, max6696, sa56004 };
+	max6646, w83l771, max6696, sa56004, g781 };
 
 /*
  * The LM90 registers
@@ -184,6 +187,7 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "adm1032", adm1032 },
 	{ "adt7461", adt7461 },
 	{ "adt7461a", adt7461 },
+	{ "g781", g781 },
 	{ "lm90", lm90 },
 	{ "lm86", lm86 },
 	{ "lm89", lm86 },
@@ -229,6 +233,12 @@ static const struct lm90_params lm90_params[] = {
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
+	[g781] = {
+		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
+		  | LM90_HAVE_BROKEN_ALERT,
+		.alert_alarms = 0x7c,
+		.max_convrate = 8,
+	},
 	[lm86] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
 		.alert_alarms = 0x7b,
@@ -1291,6 +1301,13 @@ static int lm90_detect(struct i2c_client *client,
 		 && convrate <= 0x09) {
 			name = "sa56004";
 		}
+	} else
+	if ((address = 0x4C || address = 0x4D)
+	 && man_id = 0x47) { /* GMT */
+		if (chip_id = 0x01 /* G781 */
+		 && (config1 & 0x3F) = 0x00
+		 && convrate <= 0x08)
+			name = "g781";
 	}
 
 	if (!name) { /* identification failed */
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
