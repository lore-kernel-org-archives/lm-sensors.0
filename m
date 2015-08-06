From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 06 Aug 2015 23:24:27 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (pmbus) Add support for VR12
Message-Id: <1438903468-5998-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Newer chips such as MAX20751 support VR12. Add support for it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus.c      |  1 +
 drivers/hwmon/pmbus/pmbus.h      |  2 ++
 drivers/hwmon/pmbus/pmbus_core.c | 16 ++++++++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index 554d0249dcde..bbfa35d82e42 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -129,6 +129,7 @@ static int pmbus_identify(struct i2c_client *client,
 				break;
 			case 1:
 				info->format[PSC_VOLTAGE_OUT] = vid;
+				info->vrm_version = vr11;
 				break;
 			case 2:
 				info->format[PSC_VOLTAGE_OUT] = direct;
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 2427f6e7c641..eece5f5e2282 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -338,10 +338,12 @@ enum pmbus_sensor_classes {
 #define PMBUS_HAVE_STATUS_VMON	(1 << 19)
 
 enum pmbus_data_format { linear = 0, direct, vid };
+enum vrm_version { vr11 = 0, vr12 };
 
 struct pmbus_driver_info {
 	int pages;		/* Total number of pages */
 	enum pmbus_data_format format[PSC_NUM_CLASSES];
+	enum vrm_version vrm_version;
 	/*
 	 * Support one set of coefficients for each sensor type
 	 * Used for chips providing data in direct mode.
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 306a1b175557..398198140b81 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -515,16 +515,24 @@ static long pmbus_reg2data_direct(struct pmbus_data *data,
 /*
  * Convert VID sensor values to milli- or micro-units
  * depending on sensor type.
- * We currently only support VR11.
  */
 static long pmbus_reg2data_vid(struct pmbus_data *data,
 			       struct pmbus_sensor *sensor)
 {
 	long val = sensor->data;
+	long rv = 0;
 
-	if (val < 0x02 || val > 0xb2)
-		return 0;
-	return DIV_ROUND_CLOSEST(160000 - (val - 2) * 625, 100);
+	switch (data->info->vrm_version) {
+	case vr11:
+		if (val >= 0x02 && val <= 0xb2)
+			rv = DIV_ROUND_CLOSEST(160000 - (val - 2) * 625, 100);
+		break;
+	case vr12:
+		if (val >= 0x01)
+			rv = 250 + (val - 1) * 5;
+		break;
+	}
+	return rv;
 }
 
 static long pmbus_reg2data(struct pmbus_data *data, struct pmbus_sensor *sensor)
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
