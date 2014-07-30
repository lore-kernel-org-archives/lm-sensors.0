From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 30 Jul 2014 05:40:21 +0000
Subject: [lm-sensors] [PATCH] hwmon: lm85: Fix various errors on attribute writes
Message-Id: <1406698821-4276-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Temperature limit register writes did not account for negative numbers.
As a result, writing -127000 resulted in -126000 written into the
temperature limit register. This problem affected temp[1-3]_min,
temp[1-3]_max, temp[1-3]_auto_temp_crit, and temp[1-3]_auto_temp_min.

When writing pwm[1-3]_freq, a long variable was auto-converted into an int
without range check. Wiring values larger than MAXINT resulted in unexpected
register values.

When writing temp[1-3]_auto_temp_max, an unsigned long variable was
auto-converted into an int without range check. Writing values larger than
MAXINT resulted in unexpected register values.

vrm is an u8, so the written value needs to be limited to [0, 255].

Cc: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm85.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index b0129a5..ef627ea 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -155,7 +155,7 @@ static inline u16 FAN_TO_REG(unsigned long val)
 
 /* Temperature is reported in .001 degC increments */
 #define TEMP_TO_REG(val)	\
-		clamp_val(SCALE(val, 1000, 1), -127, 127)
+		DIV_ROUND_CLOSEST(clamp_val((val), -127000, 127000), 1000)
 #define TEMPEXT_FROM_REG(val, ext)	\
 		SCALE(((val) << 4) + (ext), 16, 1000)
 #define TEMP_FROM_REG(val)	((val) * 1000)
@@ -189,7 +189,7 @@ static const int lm85_range_map[] = {
 	13300, 16000, 20000, 26600, 32000, 40000, 53300, 80000
 };
 
-static int RANGE_TO_REG(int range)
+static int RANGE_TO_REG(long range)
 {
 	int i;
 
@@ -211,7 +211,7 @@ static const int adm1027_freq_map[8] = { /* 1 Hz */
 	11, 15, 22, 29, 35, 44, 59, 88
 };
 
-static int FREQ_TO_REG(const int *map, int freq)
+static int FREQ_TO_REG(const int *map, unsigned long freq)
 {
 	int i;
 
@@ -460,6 +460,9 @@ static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
 	if (err)
 		return err;
 
+	if (val > 255)
+		return -EINVAL;
+
 	data->vrm = val;
 	return count;
 }
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
