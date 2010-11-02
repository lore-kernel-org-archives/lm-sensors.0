From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 02 Nov 2010 16:41:44 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (w83793) Implement the standard
Message-Id: <20101102174144.4c3d4ac5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We have a standard intrusion detection interface now, drivers should
implement it. I've left the old interface in place for the time being,
with a deprecation warning, it will be removed later.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/w83793 |    2 +-
 drivers/hwmon/w83793.c     |   32 +++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

--- linux-2.6.37-rc1.orig/Documentation/hwmon/w83793	2010-11-02 16:55:58.000000000 +0100
+++ linux-2.6.37-rc1/Documentation/hwmon/w83793	2010-11-02 17:15:32.000000000 +0100
@@ -92,7 +92,7 @@ This driver implements support for Winbo
 
 * Chassis
   If the case open alarm triggers, it will stay in this state unless cleared
-  by any write to the sysfs file "chassis".
+  by writing 0 to the sysfs file "intrusion0_alarm".
 
 * VID and VRM
   The VRM version is detected automatically, don't modify the it unless you
--- linux-2.6.37-rc1.orig/drivers/hwmon/w83793.c	2010-11-02 16:55:58.000000000 +0100
+++ linux-2.6.37-rc1/drivers/hwmon/w83793.c	2010-11-02 17:16:45.000000000 +0100
@@ -421,14 +421,16 @@ store_beep_enable(struct device *dev, st
 
 /* Write any value to clear chassis alarm */
 static ssize_t
-store_chassis_clear(struct device *dev,
-		    struct device_attribute *attr, const char *buf,
-		    size_t count)
+store_chassis_clear_legacy(struct device *dev,
+			   struct device_attribute *attr, const char *buf,
+			   size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83793_data *data = i2c_get_clientdata(client);
 	u8 val;
 
+	dev_warn(&client->dev, "Attribute chassis is deprecated, "
+		 "use intrusion0_alarm instead\n");
 	mutex_lock(&data->update_lock);
 	val = w83793_read_value(client, W83793_REG_CLR_CHASSIS);
 	val |= 0x80;
@@ -437,6 +439,28 @@ store_chassis_clear(struct device *dev,
 	return count;
 }
 
+/* Write 0 to clear chassis alarm */
+static ssize_t
+store_chassis_clear(struct device *dev,
+		    struct device_attribute *attr, const char *buf,
+		    size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83793_data *data = i2c_get_clientdata(client);
+	unsigned long val;
+	u8 reg;
+
+	if (strict_strtoul(buf, 10, &val) || val != 0)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	reg = w83793_read_value(client, W83793_REG_CLR_CHASSIS);
+	w83793_write_value(client, W83793_REG_CLR_CHASSIS, reg | 0x80);
+	data->alarms[3] &= ~(1 << 6);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
 #define FAN_INPUT			0
 #define FAN_MIN				1
 static ssize_t
@@ -1102,6 +1126,8 @@ static DEVICE_ATTR(vrm, S_IWUSR | S_IRUG
 
 static struct sensor_device_attribute_2 sda_single_files[] = {
 	SENSOR_ATTR_2(chassis, S_IWUSR | S_IRUGO, show_alarm_beep,
+		      store_chassis_clear_legacy, ALARM_STATUS, 30),
+	SENSOR_ATTR_2(intrusion0_alarm, S_IWUSR | S_IRUGO, show_alarm_beep,
 		      store_chassis_clear, ALARM_STATUS, 30),
 	SENSOR_ATTR_2(beep_enable, S_IWUSR | S_IRUGO, show_beep_enable,
 		      store_beep_enable, NOT_USED, NOT_USED),


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
