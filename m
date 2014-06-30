From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Jun 2014 19:08:29 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83791d) Fix smatch warning
Message-Id: <1404155309-22582-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

smatch complains as follows when checking w83791d.c.

drivers/hwmon/w83791d.c:996 store_temp23() warn:
	'32768' 32768 can't fit into 32767 'data->temp_add[nr][index]'

Fix by using DIV_ROUND_CLOSEST and clamp_val to convert the values.
While we are at it, modify other macros as well for consistency and
to make the code easier to understand.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83791d.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index bdcf2dc..cb3765f 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -249,19 +249,16 @@ static u8 fan_to_reg(long rpm, int div)
  * the bottom 7 bits will always be zero
  */
 #define TEMP23_FROM_REG(val)	((val) / 128 * 500)
-#define TEMP23_TO_REG(val)	((val) <= -128000 ? 0x8000 : \
-				 (val) >= 127500 ? 0x7F80 : \
-				 (val) < 0 ? ((val) - 250) / 500 * 128 : \
-				 ((val) + 250) / 500 * 128)
+#define TEMP23_TO_REG(val)	(DIV_ROUND_CLOSEST(clamp_val((val), -128000, \
+						   127500), 500) * 128)
 
 /* for thermal cruise target temp, 7-bits, LSB = 1 degree Celsius */
-#define TARGET_TEMP_TO_REG(val)		((val) < 0 ? 0 : \
-					(val) >= 127000 ? 127 : \
-					((val) + 500) / 1000)
+#define TARGET_TEMP_TO_REG(val)	DIV_ROUND_CLOSEST(clamp_val((val), 0, 127000), \
+						  1000)
 
 /* for thermal cruise temp tolerance, 4-bits, LSB = 1 degree Celsius */
-#define TOL_TEMP_TO_REG(val)		((val) >= 15000 ? 15 : \
-					((val) + 500) / 1000)
+#define TOL_TEMP_TO_REG(val)	DIV_ROUND_CLOSEST(clamp_val((val), 0, 15000), \
+						  1000)
 
 #define BEEP_MASK_TO_REG(val)		((val) & 0xffffff)
 #define BEEP_MASK_FROM_REG(val)		((val) & 0xffffff)
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
