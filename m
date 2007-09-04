From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 04 Sep 2007 21:25:33 +0000
Subject: [lm-sensors] [PATCH] hwmon/lm78: Add individual alarm files
Message-Id: <20070904232533.40609f1f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add individual alarm files to the lm78 driver, these are needed by
the next version of libsensors.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/lm78 |   10 ----------
 drivers/hwmon/lm78.c     |   30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 10 deletions(-)

--- linux-2.6.23-rc5.orig/drivers/hwmon/lm78.c	2007-09-04 11:40:51.000000000 +0200
+++ linux-2.6.23-rc5/drivers/hwmon/lm78.c	2007-09-04 20:47:27.000000000 +0200
@@ -438,6 +438,25 @@ static ssize_t show_alarms(struct device
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
+static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
+			  char *buf)
+{
+	struct lm78_data *data = lm78_update_device(dev);
+	int nr = to_sensor_dev_attr(da)->index;
+	return sprintf(buf, "%u\n", (data->alarms >> nr) & 1);
+}
+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
+static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 9);
+static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 10);
+static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 11);
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
+
 /* This function is called when:
      * lm78_driver is inserted (when this module is loaded), for each
        available adapter
@@ -453,36 +472,47 @@ static struct attribute *lm78_attributes
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_min.dev_attr.attr,
 	&sensor_dev_attr_in0_max.dev_attr.attr,
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in1_min.dev_attr.attr,
 	&sensor_dev_attr_in1_max.dev_attr.attr,
+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_in2_min.dev_attr.attr,
 	&sensor_dev_attr_in2_max.dev_attr.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
 	&sensor_dev_attr_in3_input.dev_attr.attr,
 	&sensor_dev_attr_in3_min.dev_attr.attr,
 	&sensor_dev_attr_in3_max.dev_attr.attr,
+	&sensor_dev_attr_in3_alarm.dev_attr.attr,
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 	&sensor_dev_attr_in4_min.dev_attr.attr,
 	&sensor_dev_attr_in4_max.dev_attr.attr,
+	&sensor_dev_attr_in4_alarm.dev_attr.attr,
 	&sensor_dev_attr_in5_input.dev_attr.attr,
 	&sensor_dev_attr_in5_min.dev_attr.attr,
 	&sensor_dev_attr_in5_max.dev_attr.attr,
+	&sensor_dev_attr_in5_alarm.dev_attr.attr,
 	&sensor_dev_attr_in6_input.dev_attr.attr,
 	&sensor_dev_attr_in6_min.dev_attr.attr,
 	&sensor_dev_attr_in6_max.dev_attr.attr,
+	&sensor_dev_attr_in6_alarm.dev_attr.attr,
 	&dev_attr_temp1_input.attr,
 	&dev_attr_temp1_max.attr,
 	&dev_attr_temp1_max_hyst.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
 	&sensor_dev_attr_fan1_div.dev_attr.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan2_input.dev_attr.attr,
 	&sensor_dev_attr_fan2_min.dev_attr.attr,
 	&sensor_dev_attr_fan2_div.dev_attr.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan3_input.dev_attr.attr,
 	&sensor_dev_attr_fan3_min.dev_attr.attr,
 	&sensor_dev_attr_fan3_div.dev_attr.attr,
+	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_cpu0_vid.attr,
 
--- linux-2.6.23-rc5.orig/Documentation/hwmon/lm78	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.23-rc5/Documentation/hwmon/lm78	2007-09-04 23:23:59.000000000 +0200
@@ -56,16 +56,6 @@ should work with. This is hardcoded by t
 It is a value in volts. When it is unconnected, you will often find the
 value 3.50 V here.
 
-In addition to the alarms described above, there are a couple of additional
-ones. There is a BTI alarm, which gets triggered when an external chip has
-crossed its limits. Usually, this is connected to all LM75 chips; if at
-least one crosses its limits, this bit gets set. The CHAS alarm triggers
-if your computer case is open. The FIFO alarms should never trigger; it
-indicates an internal error. The SMI_IN alarm indicates some other chip
-has triggered an SMI interrupt. As we do not use SMI interrupts at all,
-this condition usually indicates there is a problem with some other
-device.
-
 If an alarm triggers, it will remain triggered until the hardware register
 is read at least once. This means that the cause for the alarm may
 already have disappeared! Note that in the current implementation, all

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
