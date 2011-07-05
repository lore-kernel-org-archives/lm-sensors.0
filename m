From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 05 Jul 2011 23:04:14 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (pmbus) Add ADP4000,
Message-Id: <1309907054-4254-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add ADP4000, NCP4200 and NCP4208 to the list of devices supported by the generic
PMBus driver, and add device IDs to enable explicit instantiation.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/pmbus |    7 +++++++
 drivers/hwmon/Kconfig     |    4 ++--
 drivers/hwmon/pmbus.c     |    3 +++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
index 5e462fc..c36c1c1 100644
--- a/Documentation/hwmon/pmbus
+++ b/Documentation/hwmon/pmbus
@@ -13,6 +13,13 @@ Supported chips:
     Prefix: 'ltc2978'
     Addresses scanned: -
     Datasheet: http://cds.linear.com/docs/Datasheet/2978fa.pdf
+  * ON Semiconductor ADP4000, NCP4200, NCP4208
+    Prefixes: 'adp4000', 'ncp4200', 'ncp4208'
+    Addresses scanned: -
+    Datasheets:
+	http://www.onsemi.com/pub_link/Collateral/ADP4000-D.PDF
+	http://www.onsemi.com/pub_link/Collateral/NCP4200-D.PDF
+	http://www.onsemi.com/pub_link/Collateral/JUNE%202009-%20REV.%200.PDF
   * Generic PMBus devices
     Prefix: 'pmbus'
     Addresses scanned: -
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5f888f7..c911b01 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -824,8 +824,8 @@ config SENSORS_PMBUS
 	default n
 	help
 	  If you say yes here you get hardware monitoring support for generic
-	  PMBus devices, including but not limited to BMR450, BMR451, BMR453,
-	  BMR454, and LTC2978.
+	  PMBus devices, including but not limited to ADP4000, BMR450, BMR451,
+	  BMR453, BMR454, LTC2978, NCP4200, and NCP4208.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
diff --git a/drivers/hwmon/pmbus.c b/drivers/hwmon/pmbus.c
index 4d8e31b..73de9f1 100644
--- a/drivers/hwmon/pmbus.c
+++ b/drivers/hwmon/pmbus.c
@@ -200,11 +200,14 @@ static int pmbus_remove(struct i2c_client *client)
  * Use driver_data to set the number of pages supported by the chip.
  */
 static const struct i2c_device_id pmbus_id[] = {
+	{"adp4000", 1},
 	{"bmr450", 1},
 	{"bmr451", 1},
 	{"bmr453", 1},
 	{"bmr454", 1},
 	{"ltc2978", 8},
+	{"ncp4200", 1},
+	{"ncp4208", 1},
 	{"pmbus", 0},
 	{}
 };
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
