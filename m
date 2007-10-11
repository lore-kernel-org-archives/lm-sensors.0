From: Pinkel <pinkel@gmail.com>
Date: Thu, 11 Oct 2007 17:59:48 +0000
Subject: [lm-sensors] [PATCH] hwmon/sis5595: Add individual alarm files
Message-Id: <470E6494.7000408@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add individual alarm files needed by the new libsensors.

Signed-off-by: Ivo Manca <pinkel@gmail.com>

---
 drivers/hwmon/sis5595.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

--- linux-2.6.22.9.orig/drivers/hwmon/sis5595.c    2007-10-11 
19:38:11.000000000 +0200
+++ linux-2.6.22.9/drivers/hwmon/sis5595.c    2007-10-11 
19:41:56.000000000 +0200
@@ -62,6 +62,7 @@
 #include <linux/jiffies.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/hwmon-sysfs.h>
 #include <asm/io.h>
 
 
@@ -473,26 +474,47 @@
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
+static ssize_t show_alarm(struct device *dev, struct device_attribute 
*da, char *buf)
+{
+    struct sis5595_data *data = sis5595_update_device(dev);
+    int nr = to_sensor_dev_attr(da)->index;
+    return sprintf(buf, "%u\n", (data->alarms >> nr) & 1);
+}
+    static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
+    static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
+    static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
+    static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
+    static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 15);
+    static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
+    static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
+    static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 15);
+
 static struct attribute *sis5595_attributes[] = {
     &dev_attr_in0_input.attr,
     &dev_attr_in0_min.attr,
     &dev_attr_in0_max.attr,
+    &sensor_dev_attr_in0_alarm.dev_attr.attr,
     &dev_attr_in1_input.attr,
     &dev_attr_in1_min.attr,
     &dev_attr_in1_max.attr,
+    &sensor_dev_attr_in1_alarm.dev_attr.attr,
     &dev_attr_in2_input.attr,
     &dev_attr_in2_min.attr,
     &dev_attr_in2_max.attr,
+    &sensor_dev_attr_in2_alarm.dev_attr.attr,
     &dev_attr_in3_input.attr,
     &dev_attr_in3_min.attr,
     &dev_attr_in3_max.attr,
+    &sensor_dev_attr_in3_alarm.dev_attr.attr,
 
     &dev_attr_fan1_input.attr,
     &dev_attr_fan1_min.attr,
     &dev_attr_fan1_div.attr,
+    &sensor_dev_attr_fan1_alarm.dev_attr.attr,
     &dev_attr_fan2_input.attr,
     &dev_attr_fan2_min.attr,
     &dev_attr_fan2_div.attr,
+    &sensor_dev_attr_fan2_alarm.dev_attr.attr,
 
     &dev_attr_alarms.attr,
     NULL
@@ -506,10 +528,12 @@
     &dev_attr_in4_input.attr,
     &dev_attr_in4_min.attr,
     &dev_attr_in4_max.attr,
+    &sensor_dev_attr_in4_alarm.dev_attr.attr,
 
     &dev_attr_temp1_input.attr,
     &dev_attr_temp1_max.attr,
     &dev_attr_temp1_max_hyst.attr,
+    &sensor_dev_attr_temp1_alarm.dev_attr.attr,
     NULL
 };
 
@@ -617,7 +641,9 @@
          || (err = device_create_file(&new_client->dev,
                           &dev_attr_in4_min))
          || (err = device_create_file(&new_client->dev,
-                          &dev_attr_in4_max)))
+                          &dev_attr_in4_max))
+         || (err = device_create_file(&new_client->dev,
+                          &sensor_dev_attr_in4_alarm.dev_attr)))
             goto exit_remove_files;
     } else {
         if ((err = device_create_file(&new_client->dev,
@@ -625,7 +651,9 @@
          || (err = device_create_file(&new_client->dev,
                           &dev_attr_temp1_max))
          || (err = device_create_file(&new_client->dev,
-                          &dev_attr_temp1_max_hyst)))
+                          &dev_attr_temp1_max_hyst))
+         || (err = device_create_file(&new_client->dev,
+                          &sensor_dev_attr_temp1_alarm.dev_attr)))
             goto exit_remove_files;
     }
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
