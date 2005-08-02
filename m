From: jcromie@divsol.com (Jim Cromie)
Date: Tue, 02 Aug 2005 01:24:04 +0000
Subject: [lm-sensors] [patchset 21/23] convert temp dev-attrs from
Message-Id: <42EEAEFE.2040903@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


convert temp dev-attrs from macro-initialization to array initialization,
and call device_create_file() in loop on array

$ diffstat 18-temp-arrys-loop
pc87360.c |   70 
++++++++++++++++++++++++++++++++------------------------------
1 files changed, 37 insertions(+), 33 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>

-------------- next part --------------
diff -ruNp -X exclude-diffs lxF-3/drivers/hwmon/pc87360.c lxF-4/drivers/hwmon/pc87360.c
--- lxF-3/drivers/hwmon/pc87360.c	2005-08-01 10:48:52.000000000 -0600
+++ lxF-4/drivers/hwmon/pc87360.c	2005-08-01 11:03:39.000000000 -0600
@@ -686,21 +686,36 @@ static ssize_t set_temp_crit(struct devi
 	return count;
 }
 
-#define declare_temp_sdas(offset) \
-static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
-	show_temp_input, NULL, offset); \
-static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
-	show_temp_min, set_temp_min, offset); \
-static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
-	show_temp_max, set_temp_max, offset); \
-static SENSOR_DEVICE_ATTR(temp##offset##_crit, S_IWUSR | S_IRUGO, \
-	show_temp_crit, set_temp_crit, offset); \
-static SENSOR_DEVICE_ATTR(temp##offset##_status, S_IRUGO, \
-	show_temp_status, NULL, offset)
-
-declare_temp_sdas(1);
-declare_temp_sdas(2);
-declare_temp_sdas(3);
+static struct sensor_device_attribute sda_temp_input[] +  {
+    __SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL, 0),
+    __SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input, NULL, 1),
+    __SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp_input, NULL, 2),
+  };
+static struct sensor_device_attribute sda_temp_status[] +  {
+    __SENSOR_DEVICE_ATTR(temp1_status, S_IRUGO, show_temp_status, NULL, 0),
+    __SENSOR_DEVICE_ATTR(temp2_status, S_IRUGO, show_temp_status, NULL, 1),
+    __SENSOR_DEVICE_ATTR(temp3_status, S_IRUGO, show_temp_status, NULL, 2),
+  };
+static struct sensor_device_attribute sda_temp_min[] +  {
+    __SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO | S_IWUSR, show_temp_min, set_temp_min, 0),
+    __SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO | S_IWUSR, show_temp_min, set_temp_min, 1),
+    __SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO | S_IWUSR, show_temp_min, set_temp_min, 2),
+  };
+static struct sensor_device_attribute sda_temp_max[] +  {
+    __SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR, show_temp_max, set_temp_max, 0),
+    __SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO | S_IWUSR, show_temp_max, set_temp_max, 1),
+    __SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO | S_IWUSR, show_temp_max, set_temp_max, 2),
+  };
+static struct sensor_device_attribute sda_temp_crit[] +  {
+    __SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO | S_IWUSR, show_temp_crit, set_temp_crit, 0),
+    __SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO | S_IWUSR, show_temp_crit, set_temp_crit, 1),
+    __SENSOR_DEVICE_ATTR(temp3_crit, S_IRUGO | S_IWUSR, show_temp_crit, set_temp_crit, 2),
+  };
 
 
 static ssize_t show_temp_alarms(struct device *dev, struct device_attribute *attr, char *buf)
@@ -929,26 +944,15 @@ static int pc87360_detect(struct i2c_ada
 	}
 
 	if (data->tempnr) {
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_crit.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_crit.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_status.dev_attr);
-
+		for (i=0; i<data->tempnr; i++) {
+			device_create_file(&new_client->dev, &sda_temp_input[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_temp_min[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_temp_max[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_temp_crit[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_temp_status[i].dev_attr);
+		}
 		device_create_file(&new_client->dev, &dev_attr_alarms_temp);
 	}
-	if (data->tempnr = 3) {
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_crit.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_status.dev_attr);
-	}
 	if (data->innr = 14) {
 		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_input.dev_attr);
 		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_input.dev_attr);
