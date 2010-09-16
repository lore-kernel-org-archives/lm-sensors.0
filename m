From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 16 Sep 2010 01:52:28 +0000
Subject: [lm-sensors] [PATCH v3 5/7] hwmon: (lm90) Add explicit support for
Message-Id: <1284601950-7381-6-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/lm90 |    4 ++--
 drivers/hwmon/lm90.c     |   32 +++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/Documentation/hwmon/lm90 b/Documentation/hwmon/lm90
index 6a03dd4..d5ce9f4 100644
--- a/Documentation/hwmon/lm90
+++ b/Documentation/hwmon/lm90
@@ -63,8 +63,8 @@ Supported chips:
     Datasheet: Publicly available at the Maxim website
                http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
   * Maxim MAX6659
-    Prefix: 'max6657'
-    Addresses scanned: I2C 0x4c, 0x4d (unsupported 0x4e)
+    Prefix: 'max6659'
+    Addresses scanned: I2C 0x4c, 0x4d, 0x4e
     Datasheet: Publicly available at the Maxim website
                http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
   * Maxim MAX6680
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index e7ef965..68ee8f7 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -85,7 +85,7 @@
  * and MAX6658 have address 0x4c.
  * ADM1032-2, ADT7461-2, LM89-1, LM99-1 and MAX6646 have address 0x4d.
  * MAX6647 has address 0x4e.
- * MAX6659 can have address 0x4c, 0x4d or 0x4e (unsupported).
+ * MAX6659 can have address 0x4c, 0x4d or 0x4e.
  * MAX6680 and MAX6681 can have address 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b,
  * 0x4c, 0x4d or 0x4e.
  */
@@ -93,8 +93,8 @@
 static const unsigned short normal_i2c[] = {
 	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
 
-enum chips { lm90, adm1032, lm99, lm86, max6657, adt7461, max6680, max6646,
-	w83l771 };
+enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
+	max6646, w83l771 };
 
 /*
  * The LM90 registers
@@ -176,7 +176,7 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "max6649", max6646 },
 	{ "max6657", max6657 },
 	{ "max6658", max6657 },
-	{ "max6659", max6657 },
+	{ "max6659", max6659 },
 	{ "max6680", max6680 },
 	{ "max6681", max6680 },
 	{ "w83l771", w83l771 },
@@ -220,7 +220,7 @@ struct lm90_data {
 	s16 temp11[5];	/* 0: remote input
 			   1: remote low limit
 			   2: remote high limit
-			   3: remote offset (except max6646 and max6657)
+			   3: remote offset (except max6646 and max6657/58/59)
 			   4: local input */
 	u8 temp_hyst;
 	u8 alarms; /* bitvector */
@@ -766,12 +766,20 @@ static int lm90_detect(struct i2c_client *new_client,
 		 * register. Likewise, the config1 register seems to lack a
 		 * low nibble, so the value will be those of the previous
 		 * read, so in our case those of the man_id register.
+		 * MAX6659 has a third set of upper temperature limit registers.
+		 * Those registers also return values on MAX6657 and MAX6658,
+		 * thus the only way to detect MAX6659 is by its address.
+		 * For this reason it will be mis-detected as MAX6657 if its
+		 * address is 0x4C.
 		 */
 		if (chip_id = man_id
-		 && (address = 0x4C || address = 0x4D)
+		 && (address = 0x4C || address = 0x4D || address = 0x4E)
 		 && (reg_config1 & 0x1F) = (man_id & 0x0F)
 		 && reg_convrate <= 0x09) {
-			name = "max6657";
+			if (address = 0x4C)
+				name = "max6657";
+			else
+				name = "max6659";
 		} else
 		/*
 		 * The chip_id register of the MAX6680 and MAX6681 holds the
@@ -861,14 +869,16 @@ static int lm90_probe(struct i2c_client *new_client,
 	}
 
 	/* Set chip capabilities */
-	if (data->kind != max6657 && data->kind != max6646)
+	if (data->kind != max6657 && data->kind != max6659
+	    && data->kind != max6646)
 		data->flags |= LM90_HAVE_OFFSET;
 
-	if (data->kind = max6657 || data->kind = max6646)
+	if (data->kind = max6657 || data->kind = max6659
+	    || data->kind = max6646)
 		data->flags |= LM90_HAVE_LOCAL_EXT;
 
-	if (data->kind != max6657 && data->kind != max6646
-	    && data->kind != max6680)
+	if (data->kind != max6657 && data->kind != max6659
+	    && data->kind != max6646 && data->kind != max6680)
 		data->flags |= LM90_HAVE_REM_LIMIT_EXT;
 
 	/* Initialize the LM90 chip */
-- 
1.7.0.87.g0901d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
