From: Fabio Baltieri <fabio.baltieri@gmail.com>
Date: Sun, 08 Jun 2014 21:06:24 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (ina2xx) Cast to s16 on shunt and current regs
Message-Id: <1402261584-5301-1-git-send-email-fabio.baltieri@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Fabio Baltieri <fabio.baltieri@gmail.com>

All devices supported by ina2xx are bidirectional and reports the
measured shunt voltage and power values as a signed 16 bit, but the
current driver implementation caches all registers as u16, leading to an
incorrect sign extension when reporting to the userspace in
ina2xx_get_value().

This patch fixes the problem by casting the signed registers to s16.
Tested on an INA219.

Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
---
 drivers/hwmon/ina2xx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 93d26e8..bfd3f3e 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -148,7 +148,8 @@ static int ina2xx_get_value(struct ina2xx_data *data, u8 reg)
 
 	switch (reg) {
 	case INA2XX_SHUNT_VOLTAGE:
-		val = DIV_ROUND_CLOSEST(data->regs[reg],
+		/* signed register */
+		val = DIV_ROUND_CLOSEST((s16)data->regs[reg],
 					data->config->shunt_div);
 		break;
 	case INA2XX_BUS_VOLTAGE:
@@ -160,8 +161,8 @@ static int ina2xx_get_value(struct ina2xx_data *data, u8 reg)
 		val = data->regs[reg] * data->config->power_lsb;
 		break;
 	case INA2XX_CURRENT:
-		/* LSB=1mA (selected). Is in mA */
-		val = data->regs[reg];
+		/* signed register, LSB=1mA (selected), in mA */
+		val = (s16)data->regs[reg];
 		break;
 	default:
 		/* programmer goofed */
-- 
1.8.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
