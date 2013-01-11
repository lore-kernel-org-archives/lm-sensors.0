From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 11 Jan 2013 14:46:09 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (lm73) Fix lower and upper temperature limits
Message-Id: <1357915569-6669-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

While the LM73 is only specified for temperatures from -40 to +150 degrees C,
its power-up minimum and maximum temperature limits are -256 and +255.75
degrees C. For better consistency and to avoid confusion, clamp limits to
the power-up limits and not to -40 / +150 degrees C.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm73.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 6f0134e..9bde964 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -37,8 +37,8 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
 
 #define LM73_ID			0x9001	/* 0x0190, byte-swapped */
 #define DRVNAME			"lm73"
-#define LM73_TEMP_MIN		(-40)
-#define LM73_TEMP_MAX		150
+#define LM73_TEMP_MIN		(-256000 / 250)
+#define LM73_TEMP_MAX		(255750 / 250)
 
 #define LM73_CTRL_RES_SHIFT	5
 #define LM73_CTRL_RES_MASK	(BIT(5) | BIT(6))
@@ -76,8 +76,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 		return status;
 
 	/* Write value */
-	value = (short) clamp_val(temp / 250, LM73_TEMP_MIN * 4,
-				  LM73_TEMP_MAX * 4) << 5;
+	value = clamp_val(temp / 250, LM73_TEMP_MIN, LM73_TEMP_MAX) << 5;
 	err = i2c_smbus_write_word_swapped(client, attr->index, value);
 	return (err < 0) ? err : count;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
