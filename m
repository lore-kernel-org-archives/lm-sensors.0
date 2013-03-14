From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:44:17 +0000
Subject: [lm-sensors] [PATCH 2/9] hwmon: Fix 'Macros with complex values' checkpatch errors
Message-Id: <1363221864-15284-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix:

ERROR: Macros with complex values should be enclosed in parenthesis

when it is seen due to complex code and not due to multi-line variable
declarations.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Alistair John Strachan <alistair@devzero.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/abituguru.c  |   11 +++++++----
 drivers/hwmon/abituguru3.c |   10 ++++++----
 drivers/hwmon/gpio-fan.c   |    2 +-
 drivers/hwmon/s3c-hwmon.c  |   19 ++++++++-----------
 4 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index b84f180..df0b699 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -96,9 +96,12 @@
 #define ABIT_UGURU_MAX_TIMEOUTS			2
 /* utility macros */
 #define ABIT_UGURU_NAME				"abituguru"
-#define ABIT_UGURU_DEBUG(level, format, arg...)				\
-	if (level <= verbose)						\
-		pr_debug(format , ## arg)
+#define ABIT_UGURU_DEBUG(level, format, arg...)		\
+	do {						\
+		if (level <= verbose)			\
+			pr_debug(format , ## arg);	\
+	} while (0)
+
 /* Macros to help calculate the sysfs_names array length */
 /*
  * sum of strlen of: in??_input\0, in??_{min,max}\0, in??_{min,max}_alarm\0,
@@ -1533,7 +1536,7 @@ static int abituguru_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(abituguru_pm, abituguru_suspend, abituguru_resume);
-#define ABIT_UGURU_PM	&abituguru_pm
+#define ABIT_UGURU_PM	(&abituguru_pm)
 #else
 #define ABIT_UGURU_PM	NULL
 #endif /* CONFIG_PM */
diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index dcce352..1d2da31 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -76,9 +76,11 @@
 #define ABIT_UGURU3_SYNCHRONIZE_TIMEOUT		5
 /* utility macros */
 #define ABIT_UGURU3_NAME			"abituguru3"
-#define ABIT_UGURU3_DEBUG(format, arg...)	\
-	if (verbose)				\
-		pr_debug(format , ## arg)
+#define ABIT_UGURU3_DEBUG(format, arg...)		\
+	do {						\
+		if (verbose)				\
+			pr_debug(format , ## arg);	\
+	} while (0)
 
 /* Macros to help calculate the sysfs_names array length */
 #define ABIT_UGURU3_MAX_NO_SENSORS 26
@@ -1159,7 +1161,7 @@ static int abituguru3_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(abituguru3_pm, abituguru3_suspend, abituguru3_resume);
-#define ABIT_UGURU3_PM	&abituguru3_pm
+#define ABIT_UGURU3_PM	(&abituguru3_pm)
 #else
 #define ABIT_UGURU3_PM	NULL
 #endif /* CONFIG_PM */
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 3978194..4e02480 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -619,7 +619,7 @@ static int gpio_fan_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(gpio_fan_pm, gpio_fan_suspend, gpio_fan_resume);
-#define GPIO_FAN_PM	&gpio_fan_pm
+#define GPIO_FAN_PM	(&gpio_fan_pm)
 #else
 #define GPIO_FAN_PM	NULL
 #endif
diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index ff2ae02..a9f7e80 100644
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -107,17 +107,14 @@ static ssize_t s3c_hwmon_show_raw(struct device *dev,
 	return  (ret < 0) ? ret : snprintf(buf, PAGE_SIZE, "%d\n", ret);
 }
 
-#define DEF_ADC_ATTR(x)	\
-	static SENSOR_DEVICE_ATTR(adc##x##_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, x)
-
-DEF_ADC_ATTR(0);
-DEF_ADC_ATTR(1);
-DEF_ADC_ATTR(2);
-DEF_ADC_ATTR(3);
-DEF_ADC_ATTR(4);
-DEF_ADC_ATTR(5);
-DEF_ADC_ATTR(6);
-DEF_ADC_ATTR(7);
+static SENSOR_DEVICE_ATTR(adc0_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 0);
+static SENSOR_DEVICE_ATTR(adc1_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 1);
+static SENSOR_DEVICE_ATTR(adc2_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 2);
+static SENSOR_DEVICE_ATTR(adc3_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 3);
+static SENSOR_DEVICE_ATTR(adc4_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 4);
+static SENSOR_DEVICE_ATTR(adc5_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 5);
+static SENSOR_DEVICE_ATTR(adc6_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 6);
+static SENSOR_DEVICE_ATTR(adc7_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 7);
 
 static struct attribute *s3c_hwmon_attrs[9] = {
 	&sensor_dev_attr_adc0_raw.dev_attr.attr,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
