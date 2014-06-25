From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Jun 2014 16:11:37 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm63) Fix smatch warnings
Message-Id: <1403712697-32732-1-git-send-email-linux@roeck-us.net>
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

Fix by typecasting the offending values to s16.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm63.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 848b961..371768f 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -134,12 +134,12 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
 				 (val) >= 255000 ? 255 : \
 				 ((val) + 500) / 1000)
 #define TEMP11_FROM_REG(reg)	((reg) / 32 * 125)
-#define TEMP11_TO_REG(val)	((val) <= -128000 ? 0x8000 : \
+#define TEMP11_TO_REG(val)	((val) <= -128000 ? (s16)0x8000 : \
 				 (val) >= 127875 ? 0x7FE0 : \
 				 (val) < 0 ? ((val) - 62) / 125 * 32 : \
 				 ((val) + 62) / 125 * 32)
 #define TEMP11U_TO_REG(val)	((val) <= 0 ? 0 : \
-				 (val) >= 255875 ? 0xFFE0 : \
+				 (val) >= 255875 ? (s16)0xFFE0 : \
 				 ((val) + 62) / 125 * 32)
 #define HYST_TO_REG(val)	((val) <= 0 ? 0 : \
 				 (val) >= 127000 ? 127 : \
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
