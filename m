From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Nov 2010 12:58:41 +0000
Subject: [lm-sensors] [PATCH 3/4 v2] hwmon: (w83793) Implement the standard
Message-Id: <20101103135841.61397961@endymion.delvare>
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
Changes in v2:
* Invalidate the cache instead of claiming the intrusion alarm flag is
  0 when the user attempts to clear the intrusion flag.

Sven, would you by any chance be able to test this patch?

 Documentation/hwmon/w83793 |    2 +-
 drivers/hwmon/w83793.c     |   33 ++++++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 4 deletions(-)

--- linux-2.6.37-rc1.orig/Documentation/hwmon/w83793	2010-11-02 17:39:18.000000000 +0100
+++ linux-2.6.37-rc1/Documentation/hwmon/w83793	2010-11-02 20:08:17.000000000 +0100
@@ -92,7 +92,7 @@ This driver implements support for Winbo
 
 * Chassis
   If the case open alarm triggers, it will stay in this state unless cleared
-  by any write to the sysfs file "chassis".
+  by writing 0 to the sysfs file "intrusion0_alarm".
 
 * VID and VRM
   The VRM version is detected automatically, don't modify the it unless you
--- linux-2.6.37-rc1.orig/drivers/hwmon/w83793.c	2010-11-02 17:39:18.000000000 +0100
+++ linux-2.6.37-rc1/drivers/hwmon/w83793.c	2010-11-03 11:36:01.000000000 +0100
@@ -421,14 +421,17 @@ store_beep_enable(struct device *dev, st
 
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
 
+	dev_warn(dev, "Attribute chassis is deprecated, "
+		 "use intrusion0_alarm instead\n");
+
 	mutex_lock(&data->update_lock);
 	val = w83793_read_value(client, W83793_REG_CLR_CHASSIS);
 	val |= 0x80;
@@ -437,6 +440,28 @@ store_chassis_clear(struct device *dev,
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
+	data->valid = 0;		/* Force cache refresh */
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
 #define FAN_INPUT			0
 #define FAN_MIN				1
 static ssize_t
@@ -1102,6 +1127,8 @@ static DEVICE_ATTR(vrm, S_IWUSR | S_IRUG
 
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
