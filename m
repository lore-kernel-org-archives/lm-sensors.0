From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Sep 2008 09:41:30 +0000
Subject: [lm-sensors] [PATCH] eeepc-laptop: add missing name attribute
Message-Id: <20080924114130.18441e70@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Creates a name file in the sysfs directory, that
is needed for the libsensors library to work.

This fixes bug #11520:
http://bugzilla.kernel.org/show_bug.cgi?id520

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
I am adding this patch to my personal hwmon tree and will be sending it
to Linus soon. Testers welcome.

 drivers/misc/eeepc-laptop.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.27-rc7.orig/drivers/misc/eeepc-laptop.c	2008-09-23 17:18:33.000000000 +0200
+++ linux-2.6.27-rc7/drivers/misc/eeepc-laptop.c	2008-09-24 10:26:35.000000000 +0200
@@ -525,10 +525,18 @@ EEEPC_CREATE_SENSOR_ATTR(fan1_pwm, S_IRU
 EEEPC_CREATE_SENSOR_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
 			 eeepc_get_fan_ctrl, eeepc_set_fan_ctrl);
 
+static ssize_t
+show_name(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "eeepc\n");
+}
+static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);
+
 static struct attribute *hwmon_attributes[] = {
 	&sensor_dev_attr_fan1_pwm.dev_attr.attr,
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	&sensor_dev_attr_name.dev_attr.attr,
 	NULL
 };
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
