From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 Nov 2007 22:45:41 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (gl520sm) Add individual alarm and
Message-Id: <20071104234541.2c5c98a2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

libsensors 3.0 needs these.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/gl520sm.c |   91 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 2 deletions(-)

--- linux-2.6.24-rc1.orig/drivers/hwmon/gl520sm.c	2007-11-04 22:17:57.000000000 +0100
+++ linux-2.6.24-rc1/drivers/hwmon/gl520sm.c	2007-11-04 22:34:24.000000000 +0100
@@ -532,33 +532,108 @@ static DEVICE_ATTR(beep_enable, S_IRUGO 
 static DEVICE_ATTR(beep_mask, S_IRUGO | S_IWUSR,
 		get_beep_mask, set_beep_mask);
 
+static ssize_t get_alarm(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	int bit_nr = to_sensor_dev_attr(attr)->index;
+	struct gl520_data *data = gl520_update_device(dev);
+
+	return sprintf(buf, "%d\n", (data->alarms >> bit_nr) & 1);
+}
+
+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, get_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, get_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, get_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, get_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, get_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, get_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, get_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, get_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, get_alarm, NULL, 7);
+
+static ssize_t get_beep(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	struct gl520_data *data = gl520_update_device(dev);
+
+	return sprintf(buf, "%d\n", (data->beep_mask >> bitnr) & 1);
+}
+
+static ssize_t set_beep(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl520_data *data = i2c_get_clientdata(client);
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	unsigned long bit;
+
+	bit = simple_strtoul(buf, NULL, 10);
+	if (bit & ~1)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->beep_mask = gl520_read_value(client, GL520_REG_BEEP_MASK);
+	if (bit)
+		data->beep_mask |= (1 << bitnr);
+	else
+		data->beep_mask &= ~(1 << bitnr);
+	gl520_write_value(client, GL520_REG_BEEP_MASK, data->beep_mask);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(in0_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 0);
+static SENSOR_DEVICE_ATTR(in1_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 1);
+static SENSOR_DEVICE_ATTR(in2_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 2);
+static SENSOR_DEVICE_ATTR(in3_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 3);
+static SENSOR_DEVICE_ATTR(temp1_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 4);
+static SENSOR_DEVICE_ATTR(fan1_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 5);
+static SENSOR_DEVICE_ATTR(fan2_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 6);
+static SENSOR_DEVICE_ATTR(temp2_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 7);
+static SENSOR_DEVICE_ATTR(in4_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 7);
+
 static struct attribute *gl520_attributes[] = {
 	&dev_attr_cpu0_vid.attr,
 
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_min.dev_attr.attr,
 	&sensor_dev_attr_in0_max.dev_attr.attr,
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
+	&sensor_dev_attr_in0_beep.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in1_min.dev_attr.attr,
 	&sensor_dev_attr_in1_max.dev_attr.attr,
+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
+	&sensor_dev_attr_in1_beep.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_in2_min.dev_attr.attr,
 	&sensor_dev_attr_in2_max.dev_attr.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
+	&sensor_dev_attr_in2_beep.dev_attr.attr,
 	&sensor_dev_attr_in3_input.dev_attr.attr,
 	&sensor_dev_attr_in3_min.dev_attr.attr,
 	&sensor_dev_attr_in3_max.dev_attr.attr,
+	&sensor_dev_attr_in3_alarm.dev_attr.attr,
+	&sensor_dev_attr_in3_beep.dev_attr.attr,
 
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
 	&sensor_dev_attr_fan1_div.dev_attr.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan1_beep.dev_attr.attr,
 	&dev_attr_fan1_off.attr,
 	&sensor_dev_attr_fan2_input.dev_attr.attr,
 	&sensor_dev_attr_fan2_min.dev_attr.attr,
 	&sensor_dev_attr_fan2_div.dev_attr.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan2_beep.dev_attr.attr,
 
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_beep.dev_attr.attr,
 
 	&dev_attr_alarms.attr,
 	&dev_attr_beep_enable.attr,
@@ -574,10 +649,14 @@ static struct attribute *gl520_attribute
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 	&sensor_dev_attr_in4_min.dev_attr.attr,
 	&sensor_dev_attr_in4_max.dev_attr.attr,
+	&sensor_dev_attr_in4_alarm.dev_attr.attr,
+	&sensor_dev_attr_in4_beep.dev_attr.attr,
 
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_beep.dev_attr.attr,
 	NULL
 };
 
@@ -653,7 +732,11 @@ static int gl520_detect(struct i2c_adapt
 		 || (err = device_create_file(&client->dev,
 				&sensor_dev_attr_temp2_max.dev_attr))
 		 || (err = device_create_file(&client->dev,
-				&sensor_dev_attr_temp2_max_hyst.dev_attr)))
+				&sensor_dev_attr_temp2_max_hyst.dev_attr))
+		 || (err = device_create_file(&client->dev,
+				&sensor_dev_attr_temp2_alarm.dev_attr))
+		 || (err = device_create_file(&client->dev,
+				&sensor_dev_attr_temp2_beep.dev_attr)))
 			goto exit_remove_files;
 	} else {
 		if ((err = device_create_file(&client->dev,
@@ -661,7 +744,11 @@ static int gl520_detect(struct i2c_adapt
 		 || (err = device_create_file(&client->dev,
 				&sensor_dev_attr_in4_min.dev_attr))
 		 || (err = device_create_file(&client->dev,
-				&sensor_dev_attr_in4_max.dev_attr)))
+				&sensor_dev_attr_in4_max.dev_attr))
+		 || (err = device_create_file(&client->dev,
+				&sensor_dev_attr_in4_alarm.dev_attr))
+		 || (err = device_create_file(&client->dev,
+				&sensor_dev_attr_in4_beep.dev_attr)))
 			goto exit_remove_files;
 	}
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
