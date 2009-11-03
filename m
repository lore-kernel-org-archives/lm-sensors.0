From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Tue, 03 Nov 2009 12:09:39 +0000
Subject: [lm-sensors] [RFC PATCH 04/10] lis3: fix show rate for 8 bits chips
Message-Id: <1257250185-7929-5-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

From: Éric Piel <eric.piel@tremplin-utc.net>

lis3: fix with 8 bits sensors

Signed-off-by: Éric Piel <eric.piel@tremplin-utc.net>
---
 drivers/hwmon/lis3lv02d.c |   24 ++++++++++++++++--------
 drivers/hwmon/lis3lv02d.h |    1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 1c8f108..b12ee35 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -127,12 +127,14 @@ void lis3lv02d_poweron(struct lis3lv02d *lis3)
 
 	/*
 	 * Common configuration
-	 * BDU: LSB and MSB values are not updated until both have been read.
-	 *      So the value read will always be correct.
+	 * BDU: (12 bits sensors only) LSB and MSB values are not updated until
+	 *      both have been read. So the value read will always be correct.
 	 */
-	lis3->read(lis3, CTRL_REG2, &reg);
-	reg |= CTRL2_BDU;
-	lis3->write(lis3, CTRL_REG2, reg);
+	if (lis3->whoami =  WAI_12B) {
+		lis3->read(lis3, CTRL_REG2, &reg);
+		reg |= CTRL2_BDU;
+		lis3->write(lis3, CTRL_REG2, reg);
+	}
 }
 EXPORT_SYMBOL_GPL(lis3lv02d_poweron);
 
@@ -363,7 +365,8 @@ static ssize_t lis3lv02d_calibrate_store(struct device *dev,
 }
 
 /* conversion btw sampling rate and the register values */
-static int lis3lv02dl_df_val[4] = {40, 160, 640, 2560};
+static int lis3_12_rates[4] = {40, 160, 640, 2560};
+static int lis3_8_rates[2] = {100, 400};
 static ssize_t lis3lv02d_rate_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
@@ -371,8 +374,13 @@ static ssize_t lis3lv02d_rate_show(struct device *dev,
 	int val;
 
 	lis3_dev.read(&lis3_dev, CTRL_REG1, &ctrl);
-	val = (ctrl & (CTRL1_DF0 | CTRL1_DF1)) >> 4;
-	return sprintf(buf, "%d\n", lis3lv02dl_df_val[val]);
+
+	if (lis3_dev.whoami = WAI_12B)
+		val = lis3_12_rates[(ctrl & (CTRL1_DF0 | CTRL1_DF1)) >> 4];
+	else
+		val = lis3_8_rates[(ctrl & CTRL1_DR) >> 7];
+
+	return sprintf(buf, "%d\n", val);
 }
 
 static DEVICE_ATTR(position, S_IRUGO, lis3lv02d_position_show, NULL);
diff --git a/drivers/hwmon/lis3lv02d.h b/drivers/hwmon/lis3lv02d.h
index 2431c51..c6ae507 100644
--- a/drivers/hwmon/lis3lv02d.h
+++ b/drivers/hwmon/lis3lv02d.h
@@ -107,6 +107,7 @@ enum lis3lv02d_ctrl1 {
 	CTRL1_DF1	= 0x20,
 	CTRL1_PD0	= 0x40,
 	CTRL1_PD1	= 0x80,
+	CTRL1_DR	= 0x80, /* Data rate on 8 bits */
 };
 enum lis3lv02d_ctrl2 {
 	CTRL2_DAS	= 0x01,
-- 
1.5.6.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
