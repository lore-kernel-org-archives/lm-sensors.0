From: jcromie@divsol.com (Jim Cromie)
Date: Tue, 02 Aug 2005 01:04:51 +0000
Subject: [lm-sensors] [patchset 19/23] pc87360 convert voltage dev-attrs
Message-Id: <42EEAA6F.6070109@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


convert voltage dev-attrs from macro-initialization to array initialization,
and call device_create_file() in loop on array

[jimc@harpo pset]$ diffstat 16-vin-arrys-loop
 pc87360.c |  128 
++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 63 insertions(+), 65 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>

-------------- next part --------------
diff -ruNp -X exclude-diffs lxF-1/drivers/hwmon/pc87360.c lxF-2/drivers/hwmon/pc87360.c
--- lxF-1/drivers/hwmon/pc87360.c	2005-07-31 22:05:06.000000000 -0600
+++ lxF-2/drivers/hwmon/pc87360.c	2005-08-01 10:24:04.000000000 -0600
@@ -415,26 +415,63 @@ static ssize_t set_in_max(struct device 
 	up(&data->update_lock);
 	return count;
 }
-#define show_and_set_in(offset) \
-static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, \
-	show_in_input, NULL, offset); \
-static SENSOR_DEVICE_ATTR(in##offset##_min, S_IWUSR | S_IRUGO, \
-	show_in_min, set_in_min, offset); \
-static SENSOR_DEVICE_ATTR(in##offset##_max, S_IWUSR | S_IRUGO, \
-	show_in_max, set_in_max, offset); \
-static SENSOR_DEVICE_ATTR(in##offset##_status, S_IRUGO, \
-	show_in_status, NULL, offset);
-show_and_set_in(0)
-show_and_set_in(1)
-show_and_set_in(2)
-show_and_set_in(3)
-show_and_set_in(4)
-show_and_set_in(5)
-show_and_set_in(6)
-show_and_set_in(7)
-show_and_set_in(8)
-show_and_set_in(9)
-show_and_set_in(10)
+
+static struct sensor_device_attribute sda_in_input[] +  {
+    __SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in_input, NULL, 0),
+    __SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in_input, NULL, 1),
+    __SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in_input, NULL, 2),
+    __SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in_input, NULL, 3),
+    __SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_in_input, NULL, 4),
+    __SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_in_input, NULL, 5),
+    __SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_in_input, NULL, 6),
+    __SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_in_input, NULL, 7),
+    __SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, show_in_input, NULL, 8),
+    __SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, show_in_input, NULL, 9),
+    __SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, show_in_input, NULL, 10),
+  };
+static struct sensor_device_attribute sda_in_status[] +  {
+    __SENSOR_DEVICE_ATTR(in0_status, S_IRUGO, show_in_status, NULL, 0),
+    __SENSOR_DEVICE_ATTR(in1_status, S_IRUGO, show_in_status, NULL, 1),
+    __SENSOR_DEVICE_ATTR(in2_status, S_IRUGO, show_in_status, NULL, 2),
+    __SENSOR_DEVICE_ATTR(in3_status, S_IRUGO, show_in_status, NULL, 3),
+    __SENSOR_DEVICE_ATTR(in4_status, S_IRUGO, show_in_status, NULL, 4),
+    __SENSOR_DEVICE_ATTR(in5_status, S_IRUGO, show_in_status, NULL, 5),
+    __SENSOR_DEVICE_ATTR(in6_status, S_IRUGO, show_in_status, NULL, 6),
+    __SENSOR_DEVICE_ATTR(in7_status, S_IRUGO, show_in_status, NULL, 7),
+    __SENSOR_DEVICE_ATTR(in8_status, S_IRUGO, show_in_status, NULL, 8),
+    __SENSOR_DEVICE_ATTR(in9_status, S_IRUGO, show_in_status, NULL, 9),
+    __SENSOR_DEVICE_ATTR(in10_status, S_IRUGO, show_in_status, NULL, 10),
+  };
+static struct sensor_device_attribute sda_in_min[] +  {
+    __SENSOR_DEVICE_ATTR(in0_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 0),
+    __SENSOR_DEVICE_ATTR(in1_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 1),
+    __SENSOR_DEVICE_ATTR(in2_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 2),
+    __SENSOR_DEVICE_ATTR(in3_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 3),
+    __SENSOR_DEVICE_ATTR(in4_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 4),
+    __SENSOR_DEVICE_ATTR(in5_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 5),
+    __SENSOR_DEVICE_ATTR(in6_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 6),
+    __SENSOR_DEVICE_ATTR(in7_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 7),
+    __SENSOR_DEVICE_ATTR(in8_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 8),
+    __SENSOR_DEVICE_ATTR(in9_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 9),
+    __SENSOR_DEVICE_ATTR(in10_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 10),
+  };
+static struct sensor_device_attribute sda_in_max[] +  {
+    __SENSOR_DEVICE_ATTR(in0_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 0),
+    __SENSOR_DEVICE_ATTR(in1_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 1),
+    __SENSOR_DEVICE_ATTR(in2_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 2),
+    __SENSOR_DEVICE_ATTR(in3_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 3),
+    __SENSOR_DEVICE_ATTR(in4_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 4),
+    __SENSOR_DEVICE_ATTR(in5_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 5),
+    __SENSOR_DEVICE_ATTR(in6_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 6),
+    __SENSOR_DEVICE_ATTR(in7_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 7),
+    __SENSOR_DEVICE_ATTR(in8_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 8),
+    __SENSOR_DEVICE_ATTR(in9_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 9),
+    __SENSOR_DEVICE_ATTR(in10_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 10),
+  };
 
 static ssize_t show_therm_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
@@ -867,51 +904,12 @@ static int pc87360_detect(struct i2c_ada
 	}
 
 	if (data->innr) {
-		device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in1_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in2_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in3_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in4_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in5_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in6_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in7_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in8_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in9_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in10_input.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in0_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in1_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in2_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in3_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in4_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in5_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in6_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in7_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in8_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in9_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in10_min.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in0_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in1_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in2_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in3_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in4_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in5_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in6_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in7_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in8_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in9_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in10_max.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in0_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in1_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in2_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in3_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in4_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in5_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in6_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in7_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in8_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in9_status.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_in10_status.dev_attr);
-
+		for (i=0; i<11; i++) { 
+			device_create_file(&new_client->dev, &sda_in_input[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_in_min[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_in_max[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_in_status[i].dev_attr);
+		}
 		device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 		device_create_file(&new_client->dev, &dev_attr_vrm);
 		device_create_file(&new_client->dev, &dev_attr_alarms_in);
