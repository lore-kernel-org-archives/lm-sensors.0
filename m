From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Apr 2011 08:23:38 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (lm85) Add missing list terminators
Message-Id: <20110429102338.7d814f85@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixes kernel bug #34072:
https://bugzilla.kernel.org/show_bug.cgi?id4072

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm85.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.39-rc5.orig/drivers/hwmon/lm85.c	2011-04-12 11:05:32.000000000 +0200
+++ linux-2.6.39-rc5/drivers/hwmon/lm85.c	2011-04-29 09:50:12.000000000 +0200
@@ -1094,6 +1094,7 @@ static struct attribute *lm85_attributes
 	&sensor_dev_attr_pwm1_auto_pwm_minctl.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_pwm_minctl.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_pwm_minctl.dev_attr.attr,
+	NULL
 };
 
 static const struct attribute_group lm85_group_minctl = {
@@ -1104,6 +1105,7 @@ static struct attribute *lm85_attributes
 	&sensor_dev_attr_temp1_auto_temp_off.dev_attr.attr,
 	&sensor_dev_attr_temp2_auto_temp_off.dev_attr.attr,
 	&sensor_dev_attr_temp3_auto_temp_off.dev_attr.attr,
+	NULL
 };
 
 static const struct attribute_group lm85_group_temp_off = {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
