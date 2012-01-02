From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Mon, 02 Jan 2012 11:03:23 +0000
Subject: [lm-sensors] [PATCH 4/4] drivers/hwmon/lm80: fix line exceeds
Message-Id: <1325502203-10525-4-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

as reported by cleanfile

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
patch is against the hwmon staging tree
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
as retrieved on jan 2, 2012

 drivers/hwmon/lm80.c |   65 ++++++++++++++++++++++++++++++--------------------
 1 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 5283b27..496bb30 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -32,8 +32,8 @@
 #include <linux/mutex.h>
 
 /* Addresses to scan */
-static const unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
-						0x2e, 0x2f, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c,
+					0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
 
 /* Many LM80 constants specified below */
 
@@ -93,12 +93,12 @@ static inline long TEMP_FROM_REG(u16 temp)
 	return res / 10;
 }
 
-#define TEMP_LIMIT_FROM_REG(val)	(((val)>0x80?(val)-0x100:(val))*1000)
+#define TEMP_LIMIT_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*1000)
 
-#define TEMP_LIMIT_TO_REG(val)		SENSORS_LIMIT((val)<0?\
-					((val)-500)/1000:((val)+500)/1000,0,255)
+#define TEMP_LIMIT_TO_REG(val)	SENSORS_LIMIT((val)<0?\
+				((val)-500)/1000:((val)+500)/1000,0,255)
 
-#define DIV_FROM_REG(val)		(1 << (val))
+#define DIV_FROM_REG(val)	(1 << (val))
 
 /*
  * Client data (each client gets its own)
@@ -164,7 +164,8 @@ static struct i2c_driver lm80_driver = {
  */
 
 #define show_in(suffix, value) \
-static ssize_t show_in_##suffix(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_in_##suffix(struct device *dev, \
+	struct device_attribute *attr, char *buf) \
 { \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct lm80_data *data = lm80_update_device(dev); \
@@ -177,8 +178,8 @@ show_in(max, in_max)
 show_in(input, in)
 
 #define set_in(suffix, value, reg) \
-static ssize_t set_in_##suffix(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
+static ssize_t set_in_##suffix(struct device *dev, \
+	struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -195,7 +196,8 @@ set_in(min, in_min, LM80_REG_IN_MIN)
 set_in(max, in_max, LM80_REG_IN_MAX)
 
 #define show_fan(suffix, value) \
-static ssize_t show_fan_##suffix(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_fan_##suffix(struct device *dev, \
+	struct device_attribute *attr, char *buf) \
 { \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct lm80_data *data = lm80_update_device(dev); \
@@ -262,7 +264,7 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
-	reg = (lm80_read_value(client, LM80_REG_FANDIV) & ~(3 << (2 * (nr + 1))))
+	reg = (lm80_read_value(client, LM80_REG_FANDIV) & ~(3 << (2 * (nr+1))))
 	    | (data->fan_div[nr] << (2 * (nr + 1)));
 	lm80_write_value(client, LM80_REG_FANDIV, reg);
 
@@ -274,7 +276,8 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static ssize_t show_temp_input1(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp_input1(struct device *dev,
+	struct device_attribute *attr, char *buf)
 {
 	struct lm80_data *data = lm80_update_device(dev);
 	if (IS_ERR(data))
@@ -283,7 +286,8 @@ static ssize_t show_temp_input1(struct device *dev, struct device_attribute *att
 }
 
 #define show_temp(suffix, value) \
-static ssize_t show_temp_##suffix(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp_##suffix(struct device *dev, \
+	struct device_attribute *attr, char *buf) \
 { \
 	struct lm80_data *data = lm80_update_device(dev); \
 	if (IS_ERR(data)) \
@@ -296,8 +300,8 @@ show_temp(os_max, temp_os_max);
 show_temp(os_hyst, temp_os_hyst);
 
 #define set_temp(suffix, value, reg) \
-static ssize_t set_temp_##suffix(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
+static ssize_t set_temp_##suffix(struct device *dev, \
+	struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm80_data *data = i2c_get_clientdata(client); \
@@ -570,7 +574,7 @@ static void lm80_init_client(struct i2c_client *client)
 		status = lm80_read_value(client, reg); \
 		if (unlikely(status < 0)) { \
 			dev_dbg(dev, \
-				"LM80: Failed to read value: reg %d, error %d\n", \
+				"LM80: read failure: reg %d, error %d\n", \
 				reg, status); \
 			ret = ERR_PTR(status); \
 			data->valid = 0; \
@@ -578,7 +582,7 @@ static void lm80_init_client(struct i2c_client *client)
 		} \
 		else \
 			var = status; \
-	} 
+	}
 
 static struct lm80_data *lm80_update_device(struct device *dev)
 {
@@ -599,23 +603,32 @@ static struct lm80_data *lm80_update_device(struct device *dev)
 	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 		dev_dbg(&client->dev, "Starting lm80 update\n");
 		for (i = 0; i <= 6; i++) {
-			safe_lm80_read_value(data->in[i], client, LM80_REG_IN(i));
-			safe_lm80_read_value(data->in_min[i], client, LM80_REG_IN_MIN(i));
-			safe_lm80_read_value(data->in_max[i], client, LM80_REG_IN_MAX(i));
+			safe_lm80_read_value(data->in[i], client,
+				LM80_REG_IN(i));
+			safe_lm80_read_value(data->in_min[i], client,
+				LM80_REG_IN_MIN(i));
+			safe_lm80_read_value(data->in_max[i], client,
+				LM80_REG_IN_MAX(i));
 		}
 		safe_lm80_read_value(data->fan[0], client, LM80_REG_FAN1);
-		safe_lm80_read_value(data->fan_min[0], client, LM80_REG_FAN_MIN(1));
+		safe_lm80_read_value(data->fan_min[0], client,
+			LM80_REG_FAN_MIN(1));
 		safe_lm80_read_value(data->fan[1], client, LM80_REG_FAN2);
-		safe_lm80_read_value(data->fan_min[1], client, LM80_REG_FAN_MIN(2));
+		safe_lm80_read_value(data->fan_min[1], client,
+			LM80_REG_FAN_MIN(2));
 
 		safe_lm80_read_value(tmp1, client, LM80_REG_TEMP);
 		safe_lm80_read_value(tmp2, client, LM80_REG_RES);
 		data->temp = (tmp1 << 8) | (tmp2 ^ 0xf0);
 
-		safe_lm80_read_value(data->temp_os_max, client, LM80_REG_TEMP_OS_MAX);
-		safe_lm80_read_value(data->temp_os_hyst, client, LM80_REG_TEMP_OS_HYST);
-		safe_lm80_read_value(data->temp_hot_max, client, LM80_REG_TEMP_HOT_MAX);
-		safe_lm80_read_value(data->temp_hot_hyst, client, LM80_REG_TEMP_HOT_HYST);
+		safe_lm80_read_value(data->temp_os_max, client,
+			LM80_REG_TEMP_OS_MAX);
+		safe_lm80_read_value(data->temp_os_hyst, client,
+			LM80_REG_TEMP_OS_HYST);
+		safe_lm80_read_value(data->temp_hot_max, client,
+			LM80_REG_TEMP_HOT_MAX);
+		safe_lm80_read_value(data->temp_hot_hyst, client,
+			LM80_REG_TEMP_HOT_HYST);
 
 		safe_lm80_read_value(i, client, LM80_REG_FANDIV);
 		data->fan_div[0] = (i >> 2) & 0x03;
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
