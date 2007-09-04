From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 04 Sep 2007 12:03:43 +0000
Subject: [lm-sensors] [PATCH] hwmon/lm93: Use standard names for vid files
Message-Id: <20070904140343.0c66b5a3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The lm93 driver doesn't follow the standard naming convention for its
vid files. Fix this so that libsensors will pick them.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm93.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.23-rc5.orig/drivers/hwmon/lm93.c	2007-09-04 11:40:50.000000000 +0200
+++ linux-2.6.23-rc5/drivers/hwmon/lm93.c	2007-09-04 13:56:17.000000000 +0200
@@ -2078,8 +2078,8 @@ static ssize_t show_vid(struct device *d
 	return sprintf(buf,"%d\n",LM93_VID_FROM_REG(data->vid[nr]));
 }
 
-static SENSOR_DEVICE_ATTR(vid1, S_IRUGO, show_vid, NULL, 0);
-static SENSOR_DEVICE_ATTR(vid2, S_IRUGO, show_vid, NULL, 1);
+static SENSOR_DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL, 0);
+static SENSOR_DEVICE_ATTR(cpu1_vid, S_IRUGO, show_vid, NULL, 1);
 
 static ssize_t show_prochot(struct device *dev, struct device_attribute *attr,
 				char *buf)
@@ -2431,8 +2431,8 @@ static struct attribute *lm93_attrs[] = 
 	&sensor_dev_attr_pwm2_auto_spinup_time.dev_attr.attr,
 	&dev_attr_pwm_auto_prochot_ramp.attr,
 	&dev_attr_pwm_auto_vrdhot_ramp.attr,
-	&sensor_dev_attr_vid1.dev_attr.attr,
-	&sensor_dev_attr_vid2.dev_attr.attr,
+	&sensor_dev_attr_cpu0_vid.dev_attr.attr,
+	&sensor_dev_attr_cpu1_vid.dev_attr.attr,
 	&sensor_dev_attr_prochot1.dev_attr.attr,
 	&sensor_dev_attr_prochot2.dev_attr.attr,
 	&sensor_dev_attr_prochot1_avg.dev_attr.attr,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
