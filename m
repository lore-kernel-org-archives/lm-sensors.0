From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Dec 2012 16:01:48 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (emc6w201) Fix DIV_ROUND_CLOSEST problem with unsigned divisors
Message-Id: <1355932908-22131-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Result of DIV_ROUND_CLOSEST is undefined for negative dividends if the divisor
variable type is unsigned. Fix by declaring divisor as signed variable.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Fix by changing divisor variable type instead of dividend variable type

 drivers/hwmon/emc6w201.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
index a98c917..789bd4f 100644
--- a/drivers/hwmon/emc6w201.c
+++ b/drivers/hwmon/emc6w201.c
@@ -187,7 +187,7 @@ static struct emc6w201_data *emc6w201_update_device(struct device *dev)
  * Sysfs callback functions
  */
 
-static const u16 nominal_mv[6] = { 2500, 1500, 3300, 5000, 1500, 1500 };
+static const s16 nominal_mv[6] = { 2500, 1500, 3300, 5000, 1500, 1500 };
 
 static ssize_t show_in(struct device *dev, struct device_attribute *devattr,
 	char *buf)
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
