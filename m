From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 18 Jul 2014 07:56:59 +0000
Subject: [lm-sensors] [PATCH] hwmon: (max6639) Make normal_i2c array const
Message-Id: <1405670219.6632.0.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/max6639.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 70650de..dac6d85 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -35,7 +35,7 @@
 #include <linux/i2c/max6639.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
 
 /* The MAX6639 registers, valid channel numbers: 0, 1 */
 #define MAX6639_REG_TEMP(ch)			(0x00 + (ch))
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
