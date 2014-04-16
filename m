From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 16 Apr 2014 02:28:50 +0000
Subject: [lm-sensors] [PATCH 2/6] hwmon: (lm80) Normalize all temperature values to 16 bit
Message-Id: <1397615334-30317-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Normalize all stored temperature values to 16 bit to simplify
temperature calculations.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm80.c |   32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 8e9a0b1..fe980d6 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -86,13 +86,9 @@ static inline unsigned char FAN_TO_REG(unsigned rpm, unsigned div)
 #define FAN_FROM_REG(val, div)	((val) = 0 ? -1 : \
 				(val) = 255 ? 0 : 1350000/((div) * (val)))
 
-#define TEMP_FROM_REG(temp) ((temp) * 125 / 32)
-
-#define TEMP_LIMIT_FROM_REG(val)	(((val) > 0x80 ? \
-	(val) - 0x100 : (val)) * 1000)
-
-#define TEMP_LIMIT_TO_REG(val)		clamp_val((val) < 0 ? \
-	((val) - 500) / 1000 : ((val) + 500) / 1000, 0, 255)
+#define TEMP_FROM_REG(reg)	((reg) * 125 / 32)
+#define TEMP_TO_REG(temp)	(DIV_ROUND_CLOSEST(clamp_val((temp), \
+					-128000, 127000), 1000) << 8)
 
 #define DIV_FROM_REG(val)		(1 << (val))
 
@@ -114,10 +110,10 @@ struct lm80_data {
 	u8 fan_min[2];		/* Register value */
 	u8 fan_div[2];		/* Register encoding, shifted right */
 	s16 temp;		/* Register values */
-	u8 temp_hot_max;	/* Register value */
-	u8 temp_hot_hyst;	/* Register value */
-	u8 temp_os_max;		/* Register value */
-	u8 temp_os_hyst;	/* Register value */
+	s16 temp_hot_max;	/* Register value, left shifted */
+	s16 temp_hot_hyst;	/* Register value, left shifted */
+	s16 temp_os_max;	/* Register value, left shifted */
+	s16 temp_os_hyst;	/* Register value, left shifted */
 	u16 alarms;		/* Register encoding, combined */
 };
 
@@ -308,7 +304,7 @@ static ssize_t show_temp_##suffix(struct device *dev, \
 	struct lm80_data *data = lm80_update_device(dev); \
 	if (IS_ERR(data)) \
 		return PTR_ERR(data); \
-	return sprintf(buf, "%d\n", TEMP_LIMIT_FROM_REG(data->value)); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value)); \
 }
 show_temp(hot_max, temp_hot_max);
 show_temp(hot_hyst, temp_hot_hyst);
@@ -327,8 +323,8 @@ static ssize_t set_temp_##suffix(struct device *dev, \
 		return err; \
 \
 	mutex_lock(&data->update_lock); \
-	data->value = TEMP_LIMIT_TO_REG(val); \
-	lm80_write_value(client, reg, data->value); \
+	data->value = TEMP_TO_REG(val); \
+	lm80_write_value(client, reg, data->value >> 8); \
 	mutex_unlock(&data->update_lock); \
 	return count; \
 }
@@ -639,22 +635,22 @@ static struct lm80_data *lm80_update_device(struct device *dev)
 		rv = lm80_read_value(client, LM80_REG_TEMP_OS_MAX);
 		if (rv < 0)
 			goto abort;
-		data->temp_os_max = rv;
+		data->temp_os_max = rv << 8;
 
 		rv = lm80_read_value(client, LM80_REG_TEMP_OS_HYST);
 		if (rv < 0)
 			goto abort;
-		data->temp_os_hyst = rv;
+		data->temp_os_hyst = rv << 8;
 
 		rv = lm80_read_value(client, LM80_REG_TEMP_HOT_MAX);
 		if (rv < 0)
 			goto abort;
-		data->temp_hot_max = rv;
+		data->temp_hot_max = rv << 8;
 
 		rv = lm80_read_value(client, LM80_REG_TEMP_HOT_HYST);
 		if (rv < 0)
 			goto abort;
-		data->temp_hot_hyst = rv;
+		data->temp_hot_hyst = rv << 8;
 
 		rv = lm80_read_value(client, LM80_REG_FANDIV);
 		if (rv < 0)
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
