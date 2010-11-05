From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Nov 2010 15:56:29 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm95241) Check validity of input values
Message-Id: <20101105165629.112e6df5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This clears the following build-time warnings I was seeing:

drivers/hwmon/lm95241.c: In function "set_interval":
drivers/hwmon/lm95241.c:132:15: warning: ignoring return value of "strict_strtol", declared with attribute warn_unused_result
drivers/hwmon/lm95241.c: In function "set_max2":
drivers/hwmon/lm95241.c:278:1: warning: ignoring return value of "strict_strtol", declared with attribute warn_unused_result
drivers/hwmon/lm95241.c: In function "set_max1":
drivers/hwmon/lm95241.c:277:1: warning: ignoring return value of "strict_strtol", declared with attribute warn_unused_result
drivers/hwmon/lm95241.c: In function "set_min2":
drivers/hwmon/lm95241.c:249:1: warning: ignoring return value of "strict_strtol", declared with attribute warn_unused_result
drivers/hwmon/lm95241.c: In function "set_min1":
drivers/hwmon/lm95241.c:248:1: warning: ignoring return value of "strict_strtol", declared with attribute warn_unused_result
drivers/hwmon/lm95241.c: In function "set_type2":
drivers/hwmon/lm95241.c:220:1: warning: ignoring return value of "strict_strtol", declared with attribute warn_unused_result
drivers/hwmon/lm95241.c: In function "set_type1":
drivers/hwmon/lm95241.c:219:1: warning: ignoring return value of "strict_strtol", declared with attribute warn_unused_result

This also fixes a small race in set_interval() as a side effect: by
working with a temporary local variable we prevent data->interval from
being accessed at a time it contains the interval value in the wrong
unit.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Davide Rizzo <elpa.rizzo@gmail.com>
---
The sysfs interface part of this driver would deserve a complete
rewrite, macro-generated functions are simply too ugly. But I don't
have the time to do this right now.

 drivers/hwmon/lm95241.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- linux-2.6.37-rc1.orig/drivers/hwmon/lm95241.c	2010-10-21 10:01:12.000000000 +0200
+++ linux-2.6.37-rc1/drivers/hwmon/lm95241.c	2010-11-05 16:25:00.000000000 +0100
@@ -128,9 +128,12 @@ static ssize_t set_interval(struct devic
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm95241_data *data = i2c_get_clientdata(client);
+	unsigned long val;
 
-	strict_strtol(buf, 10, &data->interval);
-	data->interval = data->interval * HZ / 1000;
+	if (strict_strtoul(buf, 10, &val) < 0)
+		return -EINVAL;
+
+	data->interval = val * HZ / 1000;
 
 	return count;
 }
@@ -188,7 +191,9 @@ static ssize_t set_type##flag(struct dev
 	struct lm95241_data *data = i2c_get_clientdata(client); \
 \
 	long val; \
-	strict_strtol(buf, 10, &val); \
+\
+	if (strict_strtol(buf, 10, &val) < 0) \
+		return -EINVAL; \
 \
 	if ((val = 1) || (val = 2)) { \
 \
@@ -227,7 +232,9 @@ static ssize_t set_min##flag(struct devi
 	struct lm95241_data *data = i2c_get_clientdata(client); \
 \
 	long val; \
-	strict_strtol(buf, 10, &val); \
+\
+	if (strict_strtol(buf, 10, &val) < 0) \
+		return -EINVAL;\
 \
 	mutex_lock(&data->update_lock); \
 \
@@ -256,7 +263,9 @@ static ssize_t set_max##flag(struct devi
 	struct lm95241_data *data = i2c_get_clientdata(client); \
 \
 	long val; \
-	strict_strtol(buf, 10, &val); \
+\
+	if (strict_strtol(buf, 10, &val) < 0) \
+		return -EINVAL; \
 \
 	mutex_lock(&data->update_lock); \
 \


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
