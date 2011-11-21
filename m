From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 21 Nov 2011 16:52:44 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (lm63) Add support for external
Message-Id: <1321894365-24285-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LM63 and compatibles support a temperature offset register for the external
temperature sensor. Add support for it.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm63.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index e02d7f0..313aee1 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -180,9 +180,10 @@ struct lm63_data {
 	s8 temp8[3];	/* 0: local input
 			   1: local high limit
 			   2: remote critical limit */
-	s16 temp11[3];	/* 0: remote input
+	s16 temp11[4];	/* 0: remote input
 			   1: remote low limit
-			   2: remote high limit */
+			   2: remote high limit
+			   3: remote offset */
 	u8 temp2_crit_hyst;
 	u8 alarms;
 };
@@ -318,11 +319,13 @@ static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
 static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
 			  const char *buf, size_t count)
 {
-	static const u8 reg[4] = {
+	static const u8 reg[6] = {
 		LM63_REG_REMOTE_LOW_MSB,
 		LM63_REG_REMOTE_LOW_LSB,
 		LM63_REG_REMOTE_HIGH_MSB,
 		LM63_REG_REMOTE_HIGH_LSB,
+		LM63_REG_REMOTE_OFFSET_MSB,
+		LM63_REG_REMOTE_OFFSET_LSB,
 	};
 
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -418,6 +421,8 @@ static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp11,
 	set_temp11, 1);
 static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp11,
 	set_temp11, 2);
+static SENSOR_DEVICE_ATTR(temp2_offset, S_IWUSR | S_IRUGO, show_temp11,
+	set_temp11, 3);
 /*
  * On LM63, temp2_crit can be set only once, which should be job
  * of the bootloader.
@@ -445,6 +450,7 @@ static struct attribute *lm63_attributes[] = {
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_offset.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit.dev_attr.attr,
 	&dev_attr_temp2_crit_hyst.attr,
 
@@ -668,6 +674,10 @@ static struct lm63_data *lm63_update_device(struct device *dev)
 				  LM63_REG_REMOTE_HIGH_MSB) << 8)
 				| i2c_smbus_read_byte_data(client,
 				  LM63_REG_REMOTE_HIGH_LSB);
+		data->temp11[3] = (i2c_smbus_read_byte_data(client,
+				  LM63_REG_REMOTE_OFFSET_MSB) << 8)
+				| i2c_smbus_read_byte_data(client,
+				  LM63_REG_REMOTE_OFFSET_LSB);
 		data->temp8[2] = i2c_smbus_read_byte_data(client,
 				 LM63_REG_REMOTE_TCRIT);
 		data->temp2_crit_hyst = i2c_smbus_read_byte_data(client,
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
