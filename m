From: jcromie@divsol.com (Jim Cromie)
Date: Tue, 02 Aug 2005 01:10:14 +0000
Subject: [lm-sensors] [patchset 20/23] pc87360 convert fan & pwm dev-attrs
Message-Id: <42EEABB2.8070700@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


convert fan & pwm dev-attrs from macro-initialization to array 
initialization,
and call device_create_file() in loop on array.

theyre done together cuz they fit together in a single loop


[jimc@harpo pset]$ diffstat 17-fan-pwm-arrys-loop
 pc87360.c |  100 
++++++++++++++++++++++++--------------------------------------
 1 files changed, 40 insertions(+), 60 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>
-------------- next part --------------
diff -ruNp -X exclude-diffs lxF-2/drivers/hwmon/pc87360.c lxF-3/drivers/hwmon/pc87360.c
--- lxF-2/drivers/hwmon/pc87360.c	2005-08-01 10:24:04.000000000 -0600
+++ lxF-3/drivers/hwmon/pc87360.c	2005-08-01 10:30:22.000000000 -0600
@@ -310,18 +310,31 @@ static ssize_t set_fan_min(struct device
 	return _set_fan_min(dev, buf, count, attr->index-1);
 }
 
-#define show_and_set_fan(offset) \
-static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
-	show_fan_input, NULL, offset); \
-static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IWUSR | S_IRUGO, \
-	show_fan_min, set_fan_min, offset); \
-static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO, \
-	show_fan_div, NULL, offset); \
-static SENSOR_DEVICE_ATTR(fan##offset##_status, S_IRUGO, \
-	show_fan_status, NULL, offset);
-show_and_set_fan(1)
-show_and_set_fan(2)
-show_and_set_fan(3)
+static struct sensor_device_attribute sda_fan_input[] +  {
+    __SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input, NULL, 0),
+    __SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input, NULL, 1),
+    __SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan_input, NULL, 2),
+  };
+static struct sensor_device_attribute sda_fan_status[] +  {
+    __SENSOR_DEVICE_ATTR(fan1_status, S_IRUGO, show_fan_status, NULL, 0),
+    __SENSOR_DEVICE_ATTR(fan2_status, S_IRUGO, show_fan_status, NULL, 1),
+    __SENSOR_DEVICE_ATTR(fan3_status, S_IRUGO, show_fan_status, NULL, 2),
+  };
+static struct sensor_device_attribute sda_fan_div[] +  {
+    __SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO, show_fan_div, NULL, 0),
+    __SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO, show_fan_div, NULL, 1),
+    __SENSOR_DEVICE_ATTR(fan3_div, S_IRUGO, show_fan_div, NULL, 2),
+  };
+static struct sensor_device_attribute sda_fan_min[] +  {
+    __SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 0),
+    __SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 1),
+    __SENSOR_DEVICE_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 2),
+  };
+
 
 static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr, char *buf)
 {
@@ -349,13 +362,13 @@ static ssize_t set_pwm(struct device *de
 	return count;
 }
 
-#define declare_pwm_sdas(offset) \
-static SENSOR_DEVICE_ATTR(pwm##offset, S_IWUSR | S_IRUGO, \
-	show_pwm, set_pwm, offset)
-
-declare_pwm_sdas(1);
-declare_pwm_sdas(2);
-declare_pwm_sdas(3);
+static struct sensor_device_attribute sda_pwm[] +  {
+    __SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 0),
+    __SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 1),
+    __SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2),
+  };
+
 
 static ssize_t show_in_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
@@ -954,48 +967,15 @@ static int pc87360_detect(struct i2c_ada
 		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_status.dev_attr);
 	}
 
-	if (data->fannr) {
-		if (FAN_CONFIG_MONITOR(data->fan_conf, 0)) {
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan1_input.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan1_min.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan1_div.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan1_status.dev_attr);
-		}
-
-		if (FAN_CONFIG_MONITOR(data->fan_conf, 1)) {
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan2_input.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan2_min.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan2_div.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan2_status.dev_attr);
-		}
-
-		if (FAN_CONFIG_CONTROL(data->fan_conf, 0))
-			device_create_file(&new_client->dev, &sensor_dev_attr_pwm1.dev_attr);
-		if (FAN_CONFIG_CONTROL(data->fan_conf, 1))
-			device_create_file(&new_client->dev, &sensor_dev_attr_pwm2.dev_attr);
-	}
-	if (data->fannr = 3) {
-		if (FAN_CONFIG_MONITOR(data->fan_conf, 2)) {
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan3_input.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan3_min.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan3_div.dev_attr);
-			device_create_file(&new_client->dev,
-					   &sensor_dev_attr_fan3_status.dev_attr);
+	for (i=0; i<data->fannr; i++) {
+		if (FAN_CONFIG_MONITOR(data->fan_conf, i)) {
+			device_create_file(&new_client->dev, &sda_fan_input[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_fan_min[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_fan_div[i].dev_attr);
+			device_create_file(&new_client->dev, &sda_fan_status[i].dev_attr);
 		}
-
-		if (FAN_CONFIG_CONTROL(data->fan_conf, 2))
-			device_create_file(&new_client->dev, &sensor_dev_attr_pwm3.dev_attr);
+		if (FAN_CONFIG_CONTROL(data->fan_conf, i))
+			device_create_file(&new_client->dev, &sda_pwm[i].dev_attr);
 	}
 
 	return 0;
