From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Jun 2014 14:29:10 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (lm63) Fix smatch warnings
Message-Id: <1404138550-24798-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

smatch complains as follows when checking lm63.c.

drivers/hwmon/lm63.c:594 set_temp11() warn:
		'65504' 65504 can't fit into 32767 'data->temp11[nr]'
drivers/hwmon/lm63.c:596 set_temp11() warn:
		'32768' 32768 can't fit into 32767 'data->temp11[nr]'

Fix by using DIV_ROUND_CLOSEST and clamp_val to convert the values.
While we are at it, modify other macros as well for consistency and
to make the code easier to understand.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Turns out v1 didn't really fix the warnings; they came back with the latest
    version of smatch. Try it another way, and make the code easier to read
    along the way.

 drivers/hwmon/lm63.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 848b961..33bfdb4 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -126,24 +126,17 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
 #define FAN_TO_REG(val)		((val) <= 82 ? 0xFFFC : \
 				 (5400000 / (val)) & 0xFFFC)
 #define TEMP8_FROM_REG(reg)	((reg) * 1000)
-#define TEMP8_TO_REG(val)	((val) <= -128000 ? -128 : \
-				 (val) >= 127000 ? 127 : \
-				 (val) < 0 ? ((val) - 500) / 1000 : \
-				 ((val) + 500) / 1000)
-#define TEMP8U_TO_REG(val)	((val) <= 0 ? 0 : \
-				 (val) >= 255000 ? 255 : \
-				 ((val) + 500) / 1000)
+#define TEMP8_TO_REG(val)	DIV_ROUND_CLOSEST(clamp_val((val), -128000, \
+							    127000), 1000)
+#define TEMP8U_TO_REG(val)	DIV_ROUND_CLOSEST(clamp_val((val), 0, \
+							    255000), 1000)
 #define TEMP11_FROM_REG(reg)	((reg) / 32 * 125)
-#define TEMP11_TO_REG(val)	((val) <= -128000 ? 0x8000 : \
-				 (val) >= 127875 ? 0x7FE0 : \
-				 (val) < 0 ? ((val) - 62) / 125 * 32 : \
-				 ((val) + 62) / 125 * 32)
-#define TEMP11U_TO_REG(val)	((val) <= 0 ? 0 : \
-				 (val) >= 255875 ? 0xFFE0 : \
-				 ((val) + 62) / 125 * 32)
-#define HYST_TO_REG(val)	((val) <= 0 ? 0 : \
-				 (val) >= 127000 ? 127 : \
-				 ((val) + 500) / 1000)
+#define TEMP11_TO_REG(val)	(DIV_ROUND_CLOSEST(clamp_val((val), -128000, \
+							     127875), 125) * 32)
+#define TEMP11U_TO_REG(val)	(DIV_ROUND_CLOSEST(clamp_val((val), 0, \
+							     255875), 125) * 32)
+#define HYST_TO_REG(val)	DIV_ROUND_CLOSEST(clamp_val((val), 0, 127000), \
+						  1000)
 
 #define UPDATE_INTERVAL(max, rate) \
 			((1000 << (LM63_MAX_CONVRATE - (rate))) / (max))
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
