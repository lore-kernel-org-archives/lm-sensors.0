From: Fabio Baltieri <fabio.baltieri@gmail.com>
Date: Sat, 07 Jun 2014 20:47:01 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ina2xx) Change register cache to signed
Message-Id: <1402174021-25857-1-git-send-email-fabio.baltieri@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>
Cc: Lothar Felten <l-felten@ti.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Fabio Baltieri <fabio.baltieri@gmail.com>

All devices supported by the ina2xx driver are bidirectional and reports
the measured value as a signed 16 bit, but the current driver
implementation caches the number as an u16, leading to an incorrect sign
extension when reporting to the userspace in ina2xx_get_value().

This patch fixes the problem by using a s16 instead, and has been tested
on an INA219.

Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
---
 drivers/hwmon/ina2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 93d26e8..d994280 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -86,7 +86,7 @@ struct ina2xx_data {
 	unsigned long last_updated;
 
 	int kind;
-	u16 regs[INA2XX_MAX_REGISTERS];
+	s16 regs[INA2XX_MAX_REGISTERS];
 };
 
 static const struct ina2xx_config ina2xx_config[] = {
-- 
1.8.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
