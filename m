From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:31 +0000
Subject: [lm-sensors] [PATCH 37/82] hwmon: (lm80) Fix multi-line comments
Message-Id: <1327017376-20466-38-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm80.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index dc6df4e..46a4bab 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -1,8 +1,8 @@
 /*
  * lm80.c - From lm_sensors, Linux kernel modules for hardware
- * monitoring
+ *	    monitoring
  * Copyright (C) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
- * and Philip Edelbrock <phil@netroedge.com>
+ *			     and Philip Edelbrock <phil@netroedge.com>
  *
  * Ported to Linux 2.6 by Tiago Sousa <mirage@kaotik.org>
  *
@@ -61,10 +61,12 @@ static const unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
 #define LM80_REG_RES			0x06
 
 
-/* Conversions. Rounding and limit checking is only done on the TO_REG
-   variants. Note that you should be a bit careful with which arguments
-   these macros are called: arguments may be evaluated more than once.
-   Fixing this is just not worth it. */
+/*
+ * Conversions. Rounding and limit checking is only done on the TO_REG
+ * variants. Note that you should be a bit careful with which arguments
+ * these macros are called: arguments may be evaluated more than once.
+ * Fixing this is just not worth it.
+ */
 
 #define IN_TO_REG(val)		(SENSORS_LIMIT(((val) + 5) / 10, 0, 255))
 #define IN_FROM_REG(val)	((val) * 10)
@@ -242,10 +244,12 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-/* Note: we save and restore the fan minimum here, because its value is
-   determined in part by the fan divisor.  This follows the principle of
-   least surprise; the user doesn't expect the fan minimum to change just
-   because the divisor changed. */
+/*
+ * Note: we save and restore the fan minimum here, because its value is
+ * determined in part by the fan divisor.  This follows the principle of
+ * least surprise; the user doesn't expect the fan minimum to change just
+ * because the divisor changed.
+ */
 static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	const char *buf, size_t count)
 {
@@ -574,9 +578,11 @@ static int lm80_write_value(struct i2c_client *client, u8 reg, u8 value)
 /* Called when we have found a new LM80. */
 static void lm80_init_client(struct i2c_client *client)
 {
-	/* Reset all except Watchdog values and last conversion values
-	   This sets fan-divs to 2, among others. This makes most other
-	   initializations unnecessary */
+	/*
+	 * Reset all except Watchdog values and last conversion values
+	 * This sets fan-divs to 2, among others. This makes most other
+	 * initializations unnecessary
+	 */
 	lm80_write_value(client, LM80_REG_CONFIG, 0x80);
 	/* Set 11-bit temperature resolution */
 	lm80_write_value(client, LM80_REG_RES, 0x08);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
