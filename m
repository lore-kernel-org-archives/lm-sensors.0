From: Ben Gardner <gardner.ben@gmail.com>
Date: Thu, 08 Oct 2015 02:55:20 +0000
Subject: [lm-sensors] [PATCH] lm75: Add support for the TMP75C
Message-Id: <1444272920-5852-1-git-send-email-gardner.ben@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The TMP75C has a different control register layout and only supports
12-bit temperature samples (0.0625 deg C).
The continuous sample rate is ~12 Hz.

Signed-off-by: Ben Gardner <gardner.ben@gmail.com>
---
 Documentation/hwmon/lm75 | 5 +++--
 drivers/hwmon/lm75.c     | 7 +++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/lm75 b/Documentation/hwmon/lm75
index 67691a0..ac95edf 100644
--- a/Documentation/hwmon/lm75
+++ b/Documentation/hwmon/lm75
@@ -42,8 +42,8 @@ Supported chips:
     Addresses scanned: none
     Datasheet: Publicly available at the ST website
                http://www.st.com/internet/analog/product/121769.jsp
-  * Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75, TMP175, TMP275
-    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp112', 'tmp175', 'tmp75', 'tmp275'
+  * Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75, TMP75C, TMP175, TMP275
+    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp112', 'tmp175', 'tmp75', 'tmp75c', 'tmp275'
     Addresses scanned: none
     Datasheet: Publicly available at the Texas Instruments website
                http://www.ti.com/product/tmp100
@@ -51,6 +51,7 @@ Supported chips:
                http://www.ti.com/product/tmp105
                http://www.ti.com/product/tmp112
                http://www.ti.com/product/tmp75
+               http://www.ti.com/product/tmp75c
                http://www.ti.com/product/tmp175
                http://www.ti.com/product/tmp275
   * NXP LM75B
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index fe41d5a..84b6ccc 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -57,6 +57,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
 	tmp175,
 	tmp275,
 	tmp75,
+	tmp75c,
 };
 
 /* Addresses scanned */
@@ -280,6 +281,11 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		data->resolution = 12;
 		data->sample_time = HZ / 2;
 		break;
+	case tmp75c:
+		clr_mask |= 1 << 5;		/* not one-shot mode */
+		data->resolution = 12;
+		data->sample_time = HZ / 4;
+		break;
 	}
 
 	/* configure as specified */
@@ -343,6 +349,7 @@ static const struct i2c_device_id lm75_ids[] = {
 	{ "tmp175", tmp175, },
 	{ "tmp275", tmp275, },
 	{ "tmp75", tmp75, },
+	{ "tmp75c", tmp75c, },
 	{ /* LIST END */ }
 };
 MODULE_DEVICE_TABLE(i2c, lm75_ids);
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
