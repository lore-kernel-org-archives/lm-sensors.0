From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:40 +0000
Subject: [lm-sensors] [PATCH 46/82] hwmon: (ltc4245) Fix multi-line comments
Message-Id: <1327017376-20466-47-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc4245.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index 6593083..2a1e808 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -214,7 +214,8 @@ static unsigned int ltc4245_get_current(struct device *dev, u8 reg)
 	unsigned int voltage;
 	unsigned int curr;
 
-	/* The strange looking conversions that follow are fixed-point
+	/*
+	 * The strange looking conversions that follow are fixed-point
 	 * math, since we cannot do floating point in the kernel.
 	 *
 	 * Step 1: convert sense register to microVolts
@@ -317,7 +318,8 @@ static ssize_t ltc4245_show_gpio(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%u\n", val * 10);
 }
 
-/* These macros are used below in constructing device attribute objects
+/*
+ * These macros are used below in constructing device attribute objects
  * for use with sysfs_create_group() to make a sysfs device file
  * for each register.
  */
@@ -391,7 +393,8 @@ LTC4245_POWER(power2_input,			LTC4245_5VSENSE);
 LTC4245_POWER(power3_input,			LTC4245_3VSENSE);
 LTC4245_POWER(power4_input,			LTC4245_VEESENSE);
 
-/* Finally, construct an array of pointers to members of the above objects,
+/*
+ * Finally, construct an array of pointers to members of the above objects,
  * as required for sysfs_create_group()
  */
 static struct attribute *ltc4245_std_attributes[] = {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
