From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 22 Apr 2012 04:22:00 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ad7314) Removed unused defines, and rename OFFSET to SHIFT
Message-Id: <1335068520-15559-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Remove unused defines AD7314_PD, AD7314_TEMP_SIGN, and ADT7301_TEMP_SIGN.
Rename AD7314_TEMP_OFFSET to the more appropriate AD7314_TEMP_SHIFT.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/hwmon/ad7314.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index f85ce70..cfec802 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -18,21 +18,14 @@
 #include <linux/hwmon-sysfs.h>
 
 /*
- * AD7314 power mode
- */
-#define AD7314_PD		0x2000
-
-/*
  * AD7314 temperature masks
  */
-#define AD7314_TEMP_SIGN		0x200
 #define AD7314_TEMP_MASK		0x7FE0
-#define AD7314_TEMP_OFFSET		5
+#define AD7314_TEMP_SHIFT		5
 
 /*
  * ADT7301 and ADT7302 temperature masks
  */
-#define ADT7301_TEMP_SIGN		0x2000
 #define ADT7301_TEMP_MASK		0x3FFF
 
 enum ad7314_variant {
@@ -73,7 +66,7 @@ static ssize_t ad7314_show_temperature(struct device *dev,
 		return ret;
 	switch (spi_get_device_id(chip->spi_dev)->driver_data) {
 	case ad7314:
-		data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_OFFSET;
+		data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_SHIFT;
 		data = (data << 6) >> 6;
 
 		return sprintf(buf, "%d\n", 250 * data);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
