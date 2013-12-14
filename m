From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Dec 2013 17:30:11 +0000
Subject: [lm-sensors] [PATCH 04/14] i8k: Support additional temperature sensors
Message-Id: <1387042221-3671-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1387042221-3671-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1387042221-3671-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>

The SMM API suggests that more than one temperature sensor is supported,
so add support for them. Currently only supported for hwmon interface.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/char/i8k.c |   64 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
index d2acbb8..ef56bb0 100644
--- a/drivers/char/i8k.c
+++ b/drivers/char/i8k.c
@@ -69,8 +69,11 @@ static struct device *i8k_hwmon_dev;
 static u32 i8k_hwmon_flags;
 
 #define I8K_HWMON_HAVE_TEMP1	(1 << 0)
-#define I8K_HWMON_HAVE_FAN1	(1 << 1)
-#define I8K_HWMON_HAVE_FAN2	(1 << 2)
+#define I8K_HWMON_HAVE_TEMP2	(1 << 1)
+#define I8K_HWMON_HAVE_TEMP3	(1 << 2)
+#define I8K_HWMON_HAVE_TEMP4	(1 << 3)
+#define I8K_HWMON_HAVE_FAN1	(1 << 4)
+#define I8K_HWMON_HAVE_FAN2	(1 << 5)
 
 MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
 MODULE_DESCRIPTION("Driver for accessing SMM BIOS on Dell laptops");
@@ -286,7 +289,7 @@ static int i8k_get_temp(int sensor)
 	int temp;
 
 #ifdef I8K_TEMPERATURE_BUG
-	static int prev;
+	static int prev[4];
 #endif
 	regs.ebx = sensor & 0xff;
 	rc = i8k_smm(&regs);
@@ -304,10 +307,10 @@ static int i8k_get_temp(int sensor)
 	 # 1003655139 00000054 00005c52
 	 */
 	if (temp > I8K_MAX_TEMP) {
-		temp = prev;
-		prev = I8K_MAX_TEMP;
+		temp = prev[sensor];
+		prev[sensor] = I8K_MAX_TEMP;
 	} else {
-		prev = temp;
+		prev[sensor] = temp;
 	}
 #endif
 
@@ -482,12 +485,13 @@ static ssize_t i8k_hwmon_show_temp(struct device *dev,
 				   struct device_attribute *devattr,
 				   char *buf)
 {
-	int cpu_temp;
+	int index = to_sensor_dev_attr(devattr)->index;
+	int temp;
 
-	cpu_temp = i8k_get_temp(0);
-	if (cpu_temp < 0)
-		return cpu_temp;
-	return sprintf(buf, "%d\n", cpu_temp * 1000);
+	temp = i8k_get_temp(index);
+	if (temp < 0)
+		return temp;
+	return sprintf(buf, "%d\n", temp * 1000);
 }
 
 static ssize_t i8k_hwmon_show_fan(struct device *dev,
@@ -517,7 +521,10 @@ static ssize_t i8k_hwmon_show_label(struct device *dev,
 	return sprintf(buf, "%s\n", labels[index]);
 }
 
-static DEVICE_ATTR(temp1_input, S_IRUGO, i8k_hwmon_show_temp, NULL);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, i8k_hwmon_show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, i8k_hwmon_show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, i8k_hwmon_show_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, i8k_hwmon_show_temp, NULL, 3);
 static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, i8k_hwmon_show_fan, NULL,
 			  I8K_FAN_LEFT);
 static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, i8k_hwmon_show_fan, NULL,
@@ -527,12 +534,15 @@ static SENSOR_DEVICE_ATTR(fan1_label, S_IRUGO, i8k_hwmon_show_label, NULL, 1);
 static SENSOR_DEVICE_ATTR(fan2_label, S_IRUGO, i8k_hwmon_show_label, NULL, 2);
 
 static struct attribute *i8k_attrs[] = {
-	&dev_attr_temp1_input.attr,			/* 0 */
+	&sensor_dev_attr_temp1_input.dev_attr.attr,	/* 0 */
 	&sensor_dev_attr_temp1_label.dev_attr.attr,	/* 1 */
-	&sensor_dev_attr_fan1_input.dev_attr.attr,	/* 2 */
-	&sensor_dev_attr_fan1_label.dev_attr.attr,	/* 3 */
-	&sensor_dev_attr_fan2_input.dev_attr.attr,	/* 4 */
-	&sensor_dev_attr_fan2_label.dev_attr.attr,	/* 5 */
+	&sensor_dev_attr_temp2_input.dev_attr.attr,	/* 2 */
+	&sensor_dev_attr_temp3_input.dev_attr.attr,	/* 3 */
+	&sensor_dev_attr_temp4_input.dev_attr.attr,	/* 4 */
+	&sensor_dev_attr_fan1_input.dev_attr.attr,	/* 5 */
+	&sensor_dev_attr_fan1_label.dev_attr.attr,	/* 6 */
+	&sensor_dev_attr_fan2_input.dev_attr.attr,	/* 7 */
+	&sensor_dev_attr_fan2_label.dev_attr.attr,	/* 8 */
 	NULL
 };
 
@@ -542,10 +552,16 @@ static umode_t i8k_is_visible(struct kobject *kobj, struct attribute *attr,
 	if ((index = 0 || index = 1) &&
 	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_TEMP1))
 		return 0;
-	if ((index = 2 || index = 3) &&
+	if (index = 2 && !(i8k_hwmon_flags & I8K_HWMON_HAVE_TEMP2))
+		return 0;
+	if (index = 3 && !(i8k_hwmon_flags & I8K_HWMON_HAVE_TEMP3))
+		return 0;
+	if (index = 4 && !(i8k_hwmon_flags & I8K_HWMON_HAVE_TEMP4))
+		return 0;
+	if ((index = 5 || index = 6) &&
 	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN1))
 		return 0;
-	if ((index = 4 || index = 5) &&
+	if ((index = 7 || index = 8) &&
 	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN2))
 		return 0;
 
@@ -568,6 +584,16 @@ static int __init i8k_init_hwmon(void)
 	err = i8k_get_temp(0);
 	if (err >= 0)
 		i8k_hwmon_flags |= I8K_HWMON_HAVE_TEMP1;
+	/* check for additional temperature sensors */
+	err = i8k_get_temp(1);
+	if (err >= 0)
+		i8k_hwmon_flags |= I8K_HWMON_HAVE_TEMP2;
+	err = i8k_get_temp(2);
+	if (err >= 0)
+		i8k_hwmon_flags |= I8K_HWMON_HAVE_TEMP3;
+	err = i8k_get_temp(3);
+	if (err >= 0)
+		i8k_hwmon_flags |= I8K_HWMON_HAVE_TEMP4;
 
 	/* Left fan attributes, if left fan is present */
 	err = i8k_get_fan_status(I8K_FAN_LEFT);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
