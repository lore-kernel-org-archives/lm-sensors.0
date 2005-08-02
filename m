From: jcromie@divsol.com (Jim Cromie)
Date: Tue, 02 Aug 2005 01:29:11 +0000
Subject: [lm-sensors] [patchset 22/23 - resend] pc87360 convert thermistor
Message-Id: <42EEB02B.70307@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

resend with attachment

convert thermistor dev-attrs from macro-initialization to array 
initialization,
and call device_create_file() in loop on array

$ diffstat 19-therm-arrys-loop
pc87360.c |   74 
+++++++++++++++++++++++++++++++++++---------------------------
1 files changed, 42 insertions(+), 32 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>


-------------- next part --------------
diff -ruNp -X exclude-diffs lxF-4/drivers/hwmon/pc87360.c lxF-5/drivers/hwmon/pc87360.c
--- lxF-4/drivers/hwmon/pc87360.c	2005-08-01 11:03:39.000000000 -0600
+++ lxF-5/drivers/hwmon/pc87360.c	2005-08-01 11:14:19.000000000 -0600
@@ -511,7 +511,7 @@ static ssize_t show_therm_crit(struct de
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[attr->index-4],
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[attr->index],
 		       data->in_vref));
 }
 static ssize_t show_therm_status(struct device *dev, struct device_attribute *devattr, char *buf)
@@ -559,27 +559,44 @@ static ssize_t set_therm_crit(struct dev
 	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->in_crit[attr->index-4] = IN_TO_REG(val, data->in_vref);
+	data->in_crit[attr->index] = IN_TO_REG(val, data->in_vref);
 	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_CRIT,
-			    data->in_crit[attr->index-4]);
+			    data->in_crit[attr->index]);
 	up(&data->update_lock);
 	return count;
 }
 
-#define show_and_set_therm(offset) \
-static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
-	show_therm_input, NULL, offset); \
-static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
-	show_therm_min, set_therm_min, offset); \
-static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
-	show_therm_max, set_therm_max, offset); \
-static SENSOR_DEVICE_ATTR(temp##offset##_crit, S_IWUSR | S_IRUGO, \
-	show_therm_crit, set_therm_crit, offset); \
-static SENSOR_DEVICE_ATTR(temp##offset##_status, S_IRUGO, \
-	show_therm_status, NULL, offset);
-show_and_set_therm(4)
-show_and_set_therm(5)
-show_and_set_therm(6)
+static struct sensor_device_attribute sda_therm_input[] +  {
+    __SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_therm_input, NULL, 0),
+    __SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_therm_input, NULL, 1),
+    __SENSOR_DEVICE_ATTR(temp6_input, S_IRUGO, show_therm_input, NULL, 2),
+  };
+static struct sensor_device_attribute sda_therm_status[] +  {
+    __SENSOR_DEVICE_ATTR(temp4_status, S_IRUGO, show_therm_status, NULL, 0),
+    __SENSOR_DEVICE_ATTR(temp5_status, S_IRUGO, show_therm_status, NULL, 1),
+    __SENSOR_DEVICE_ATTR(temp6_status, S_IRUGO, show_therm_status, NULL, 2),
+  };
+static struct sensor_device_attribute sda_therm_min[] +  {
+    __SENSOR_DEVICE_ATTR(temp4_min, S_IRUGO | S_IWUSR, show_therm_min, set_therm_min, 0),
+    __SENSOR_DEVICE_ATTR(temp5_min, S_IRUGO | S_IWUSR, show_therm_min, set_therm_min, 1),
+    __SENSOR_DEVICE_ATTR(temp6_min, S_IRUGO | S_IWUSR, show_therm_min, set_therm_min, 2),
+  };
+static struct sensor_device_attribute sda_therm_max[] +  {
+    __SENSOR_DEVICE_ATTR(temp4_max, S_IRUGO | S_IWUSR, show_therm_max, set_therm_max, 0),
+    __SENSOR_DEVICE_ATTR(temp5_max, S_IRUGO | S_IWUSR, show_therm_max, set_therm_max, 1),
+    __SENSOR_DEVICE_ATTR(temp6_max, S_IRUGO | S_IWUSR, show_therm_max, set_therm_max, 2),
+  };
+static struct sensor_device_attribute sda_therm_crit[] +  {
+    __SENSOR_DEVICE_ATTR(temp4_crit, S_IRUGO | S_IWUSR, show_therm_crit, set_therm_crit, 0),
+    __SENSOR_DEVICE_ATTR(temp5_crit, S_IRUGO | S_IWUSR, show_therm_crit, set_therm_crit, 1),
+    __SENSOR_DEVICE_ATTR(temp6_crit, S_IRUGO | S_IWUSR, show_therm_crit, set_therm_crit, 2),
+  };
+
 
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -953,22 +970,15 @@ static int pc87360_detect(struct i2c_ada
 		}
 		device_create_file(&new_client->dev, &dev_attr_alarms_temp);
 	}
+
 	if (data->innr = 14) {
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_crit.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_crit.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_crit.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_status.dev_attr);
+		for (i=0; i<3; i++) {
+			device_create_file(&new_client->dev, &sda_therm_input[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_therm_min[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_therm_max[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_therm_crit[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_therm_status[i].dev_attr);
+		}
 	}
 
 	for (i=0; i<data->fannr; i++) {
