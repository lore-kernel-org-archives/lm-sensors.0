From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 16 Apr 2014 02:28:49 +0000
Subject: [lm-sensors] [PATCH 1/6] hwmon: (lm80) Simplify TEMP_FROM_REG
Message-Id: <1397615334-30317-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

TEMP_FROM_REG gets 12 bits of temperature data in the upper 12 bit
of a signed 16 bit parameter, with the integer part (including sign)
in the upper 8 bit and the remainder in bit 4..7. The lower 4 bit of
the 16 bit data is always 0. We can use that information to convert
the temperature directly into display data (1/1000th of degree C).

Note that the stored temperature data is not shifted right as the
comment claimed, so remove that misleading comment.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm80.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index bd0a1eb..8e9a0b1 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -86,18 +86,7 @@ static inline unsigned char FAN_TO_REG(unsigned rpm, unsigned div)
 #define FAN_FROM_REG(val, div)	((val) = 0 ? -1 : \
 				(val) = 255 ? 0 : 1350000/((div) * (val)))
 
-static inline long TEMP_FROM_REG(u16 temp)
-{
-	long res;
-
-	temp >>= 4;
-	if (temp < 0x0800)
-		res = 625 * (long) temp;
-	else
-		res = ((long) temp - 0x01000) * 625;
-
-	return res / 10;
-}
+#define TEMP_FROM_REG(temp) ((temp) * 125 / 32)
 
 #define TEMP_LIMIT_FROM_REG(val)	(((val) > 0x80 ? \
 	(val) - 0x100 : (val)) * 1000)
@@ -124,7 +113,7 @@ struct lm80_data {
 	u8 fan[2];		/* Register value */
 	u8 fan_min[2];		/* Register value */
 	u8 fan_div[2];		/* Register encoding, shifted right */
-	u16 temp;		/* Register values, shifted right */
+	s16 temp;		/* Register values */
 	u8 temp_hot_max;	/* Register value */
 	u8 temp_hot_hyst;	/* Register value */
 	u8 temp_os_max;		/* Register value */
@@ -309,7 +298,7 @@ static ssize_t show_temp_input1(struct device *dev,
 	struct lm80_data *data = lm80_update_device(dev);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
-	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
 }
 
 #define show_temp(suffix, value) \
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
