From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Nov 2009 15:34:06 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (adt7475) Implement
Message-Id: <20091114163406.7270ac14@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Implement the non-standard pwm_use_point2_pwm_at_crit sysfs attribute
as the adt7473 driver did.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
---
 drivers/hwmon/adt7475.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

--- linux-2.6.32-rc7.orig/drivers/hwmon/adt7475.c	2009-11-14 13:15:14.000000000 +0100
+++ linux-2.6.32-rc7/drivers/hwmon/adt7475.c	2009-11-14 14:33:53.000000000 +0100
@@ -76,6 +76,9 @@
 #define REG_EXTEND1		0x76
 #define REG_EXTEND2		0x77
 #define REG_CONFIG5		0x7C
+#define REG_CONFIG4		0x7D
+
+#define CONFIG4_MAXDUTY		0x08
 
 #define CONFIG5_TWOSCOMP	0x01
 #define CONFIG5_TEMPOFFSET	0x02
@@ -132,6 +135,7 @@ struct adt7475_data {
 	unsigned long limits_updated;
 	char valid;
 
+	u8 config4;
 	u8 config5;
 	u16 alarms;
 	u16 voltage[3][3];
@@ -779,6 +783,38 @@ static ssize_t set_pwmfreq(struct device
 	return count;
 }
 
+static ssize_t show_pwm_at_crit(struct device *dev,
+				struct device_attribute *devattr, char *buf)
+{
+	struct adt7475_data *data = adt7475_update_device(dev);
+	return sprintf(buf, "%d\n", !!(data->config4 & CONFIG4_MAXDUTY));
+}
+
+static ssize_t set_pwm_at_crit(struct device *dev,
+			       struct device_attribute *devattr,
+			       const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7475_data *data = i2c_get_clientdata(client);
+	long val;
+
+	if (strict_strtol(buf, 10, &val))
+		return -EINVAL;
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	data->config4 = i2c_smbus_read_byte_data(client, REG_CONFIG4);
+	if (val)
+		data->config4 |= CONFIG4_MAXDUTY;
+	else
+		data->config4 &= ~CONFIG4_MAXDUTY;
+	i2c_smbus_write_byte_data(client, REG_CONFIG4, data->config4);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
 static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_voltage, NULL, INPUT, 0);
 static SENSOR_DEVICE_ATTR_2(in1_max, S_IRUGO | S_IWUSR, show_voltage,
 			    set_voltage, MAX, 0);
@@ -894,6 +930,10 @@ static SENSOR_DEVICE_ATTR_2(pwm3_auto_po
 static SENSOR_DEVICE_ATTR_2(pwm3_auto_point2_pwm, S_IRUGO | S_IWUSR, show_pwm,
 			    set_pwm, MAX, 2);
 
+/* Non-standard name, might need revisiting */
+static DEVICE_ATTR(pwm_use_point2_pwm_at_crit, S_IWUSR | S_IRUGO,
+		   show_pwm_at_crit, set_pwm_at_crit);
+
 static struct attribute *adt7475_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in1_max.dev_attr.attr,
@@ -962,6 +1002,7 @@ static struct attribute *adt7475_attrs[]
 	&sensor_dev_attr_pwm3_auto_channels_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
+	&dev_attr_pwm_use_point2_pwm_at_crit.attr,
 	NULL,
 };
 
@@ -1160,6 +1201,7 @@ static struct adt7475_data *adt7475_upda
 	/* Limits and settings, should never change update every 60 seconds */
 	if (time_after(jiffies, data->limits_updated + HZ * 60) ||
 	    !data->valid) {
+		data->config4 = adt7475_read(REG_CONFIG4);
 		data->config5 = adt7475_read(REG_CONFIG5);
 
 		for (i = 0; i < ADT7475_VOLTAGE_COUNT; i++) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
