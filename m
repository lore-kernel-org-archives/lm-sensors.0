From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 01 Aug 2005 22:47:26 +0000
Subject: [lm-sensors] Re: [pc87360.c 6/23] s/offset/attr->index/ in pwm
Message-Id: <42EE89EE.2080302@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


use attr->index instead of offset in voltage get/set macros

[jimc@harpo pset]$ diffstat 04x-sda-pwm-quell-warns
 pc87360.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


Signed-off-by:  Jim Cromie <jcromie@divsol.com>

-------------- next part --------------
diff -ruNp -X exclude-diffs lxC-6/drivers/hwmon/pc87360.c lxC-7/drivers/hwmon/pc87360.c
--- lxC-6/drivers/hwmon/pc87360.c	2005-07-31 12:11:15.000000000 -0600
+++ lxC-7/drivers/hwmon/pc87360.c	2005-07-31 12:11:59.000000000 -0600
@@ -328,7 +328,7 @@ static ssize_t show_pwm##offset(struct d
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
-		       PWM_FROM_REG(data->pwm[offset-1], \
+		       PWM_FROM_REG(data->pwm[attr->index-1], \
 				    FAN_CONFIG_INVERT(data->fan_conf, \
 						      offset-1))); \
 } \
@@ -341,10 +341,10 @@ static ssize_t set_pwm##offset(struct de
 	long val = simple_strtol(buf, NULL, 10); \
  \
 	down(&data->update_lock); \
-	data->pwm[offset-1] = PWM_TO_REG(val, \
+	data->pwm[attr->index-1] = PWM_TO_REG(val, \
 			      FAN_CONFIG_INVERT(data->fan_conf, offset-1)); \
 	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_PWM(offset-1), \
-			    data->pwm[offset-1]); \
+			    data->pwm[attr->index-1]); \
 	up(&data->update_lock); \
 	return count; \
 } \
