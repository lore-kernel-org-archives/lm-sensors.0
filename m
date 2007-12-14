From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 14 Dec 2007 13:41:53 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Delete pwmN_freq files on driver
Message-Id: <20071214144153.222cd653@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In commit f8d0c19a93cea3a26a90f2462295e1e01a4cd250 I forgot to delete
the pwmN_freq files on driver removal, here's the fix.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.24-rc5.orig/drivers/hwmon/it87.c	2007-12-13 16:30:59.000000000 +0100
+++ linux-2.6.24-rc5/drivers/hwmon/it87.c	2007-12-14 14:00:40.000000000 +0100
@@ -919,6 +919,9 @@ static struct attribute *it87_attributes
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm2.dev_attr.attr,
 	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&dev_attr_pwm1_freq.attr,
+	&dev_attr_pwm2_freq.attr,
+	&dev_attr_pwm3_freq.attr,
 
 	&dev_attr_vrm.attr,
 	&dev_attr_cpu0_vid.attr,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
