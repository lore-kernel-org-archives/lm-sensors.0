From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 07 Jul 2011 20:42:44 +0000
Subject: [lm-sensors] [PATCH v3 2/3] hwmon: (lm95241) Fix negative
Message-Id: <1310071365-2475-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Negative temperatures were returned in degrees C instead of milli-Degrees C.
Also, negative temperatures were reported for remote temperature sensors even
if the chip was configured for positive-only results.

Fix by detecting temperature modes, and by treating negative temperatures
similar to positive temperatures, with appropriate sign extension.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
Candidate for -stable.

 drivers/hwmon/lm95241.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
index 01c638e..ec02e30 100644
--- a/drivers/hwmon/lm95241.c
+++ b/drivers/hwmon/lm95241.c
@@ -98,11 +98,16 @@ struct lm95241_data {
 };
 
 /* Conversions */
-static int TempFromReg(u8 val_h, u8 val_l)
+static int temp_from_reg_signed(u8 val_h, u8 val_l)
 {
-	if (val_h & 0x80)
-		return val_h - 0x100;
-	return val_h * 1000 + val_l * 1000 / 256;
+	s16 val_hl = (val_h << 8) | val_l;
+	return val_hl * 1000 / 256;
+}
+
+static int temp_from_reg_unsigned(u8 val_h, u8 val_l)
+{
+	u16 val_hl = (val_h << 8) | val_l;
+	return val_hl * 1000 / 256;
 }
 
 static struct lm95241_data *lm95241_update_device(struct device *dev)
@@ -135,10 +140,13 @@ static ssize_t show_input(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct lm95241_data *data = lm95241_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
 
 	return snprintf(buf, PAGE_SIZE - 1, "%d\n",
-		TempFromReg(data->temp[to_sensor_dev_attr(attr)->index],
-			    data->temp[to_sensor_dev_attr(attr)->index + 1]));
+			!index || (data->config & index) ?
+		temp_from_reg_signed(data->temp[index], data->temp[index + 1]) :
+		temp_from_reg_unsigned(data->temp[index],
+				       data->temp[index + 1]));
 }
 
 static ssize_t show_type(struct device *dev, struct device_attribute *attr,
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
