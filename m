From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Nov 2009 10:39:12 +0000
Subject: [lm-sensors] hwmon: (adt7475) Fix sysfs file names
Message-Id: <20091109113912.66628c84@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The adt7475 driver creates pwm#_auto_channel_temp attributes instead
of the standard pwm#_auto_channels_temp. Fix it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
---
 drivers/hwmon/adt7475.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.32-rc6.orig/drivers/hwmon/adt7475.c	2009-11-09 10:28:59.000000000 +0100
+++ linux-2.6.32-rc6/drivers/hwmon/adt7475.c	2009-11-09 11:08:21.000000000 +0100
@@ -862,7 +862,7 @@ static SENSOR_DEVICE_ATTR_2(pwm1_freq, S
 			    set_pwmfreq, INPUT, 0);
 static SENSOR_DEVICE_ATTR_2(pwm1_enable, S_IRUGO | S_IWUSR, show_pwmctrl,
 			    set_pwmctrl, INPUT, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_channel_temp, S_IRUGO | S_IWUSR,
+static SENSOR_DEVICE_ATTR_2(pwm1_auto_channels_temp, S_IRUGO | S_IWUSR,
 			    show_pwmchan, set_pwmchan, INPUT, 0);
 static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO | S_IWUSR, show_pwm,
 			    set_pwm, MIN, 0);
@@ -874,7 +874,7 @@ static SENSOR_DEVICE_ATTR_2(pwm2_freq, S
 			    set_pwmfreq, INPUT, 1);
 static SENSOR_DEVICE_ATTR_2(pwm2_enable, S_IRUGO | S_IWUSR, show_pwmctrl,
 			    set_pwmctrl, INPUT, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_channel_temp, S_IRUGO | S_IWUSR,
+static SENSOR_DEVICE_ATTR_2(pwm2_auto_channels_temp, S_IRUGO | S_IWUSR,
 			    show_pwmchan, set_pwmchan, INPUT, 1);
 static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_pwm, S_IRUGO | S_IWUSR, show_pwm,
 			    set_pwm, MIN, 1);
@@ -886,7 +886,7 @@ static SENSOR_DEVICE_ATTR_2(pwm3_freq, S
 			    set_pwmfreq, INPUT, 2);
 static SENSOR_DEVICE_ATTR_2(pwm3_enable, S_IRUGO | S_IWUSR, show_pwmctrl,
 			    set_pwmctrl, INPUT, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_channel_temp, S_IRUGO | S_IWUSR,
+static SENSOR_DEVICE_ATTR_2(pwm3_auto_channels_temp, S_IRUGO | S_IWUSR,
 			    show_pwmchan, set_pwmchan, INPUT, 2);
 static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO | S_IWUSR, show_pwm,
 			    set_pwm, MIN, 2);
@@ -946,19 +946,19 @@ static struct attribute *adt7475_attrs[]
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
-	&sensor_dev_attr_pwm1_auto_channel_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm2.dev_attr.attr,
 	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
-	&sensor_dev_attr_pwm2_auto_channel_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_channels_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm3.dev_attr.attr,
 	&sensor_dev_attr_pwm3_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
-	&sensor_dev_attr_pwm3_auto_channel_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_channels_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
 	NULL,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
