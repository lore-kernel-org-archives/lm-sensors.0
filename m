From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:39 +0000
Subject: [lm-sensors] [PATCH 45/82] hwmon: (ltc4215) Fix multi-line comments
Message-Id: <1327017376-20466-46-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc4215.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/ltc4215.c b/drivers/hwmon/ltc4215.c
index c7e6d8e..b66d1dc 100644
--- a/drivers/hwmon/ltc4215.c
+++ b/drivers/hwmon/ltc4215.c
@@ -91,8 +91,10 @@ static int ltc4215_get_voltage(struct device *dev, u8 reg)
 		voltage = regval * 605 / 10;
 		break;
 	case LTC4215_ADIN:
-		/* The ADIN input is divided by 12.5, and has 4.82 mV
-		 * per increment, so we have the additional multiply */
+		/*
+		 * The ADIN input is divided by 12.5, and has 4.82 mV
+		 * per increment, so we have the additional multiply
+		 */
 		voltage = regval * 482 * 125 / 1000;
 		break;
 	default:
@@ -109,7 +111,8 @@ static unsigned int ltc4215_get_current(struct device *dev)
 {
 	struct ltc4215_data *data = ltc4215_update_device(dev);
 
-	/* The strange looking conversions that follow are fixed-point
+	/*
+	 * The strange looking conversions that follow are fixed-point
 	 * math, since we cannot do floating point in the kernel.
 	 *
 	 * Step 1: convert sense register to microVolts
@@ -176,7 +179,8 @@ static ssize_t ltc4215_show_alarm(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%u\n", (reg & mask) ? 1 : 0);
 }
 
-/* These macros are used below in constructing device attribute objects
+/*
+ * These macros are used below in constructing device attribute objects
  * for use with sysfs_create_group() to make a sysfs device file
  * for each register.
  */
@@ -215,7 +219,8 @@ LTC4215_ALARM(in1_min_alarm,	(1 << 1),	LTC4215_STATUS);
 LTC4215_VOLTAGE(in2_input,			LTC4215_SOURCE);
 LTC4215_ALARM(in2_min_alarm,	(1 << 3),	LTC4215_STATUS);
 
-/* Finally, construct an array of pointers to members of the above objects,
+/*
+ * Finally, construct an array of pointers to members of the above objects,
  * as required for sysfs_create_group()
  */
 static struct attribute *ltc4215_attributes[] = {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
