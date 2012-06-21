From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 21 Jun 2012 13:56:55 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (w83627ehf) Add missing break statement
Message-Id: <1340287015-14008-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

A case statement in nct6775_write_fan_div() is missing a break. Fix it.

This patch addresses Coverity #141439: Missing break in switch.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627ehf.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 54922ed..1821b74 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -599,6 +599,7 @@ static void nct6775_write_fan_div(struct w83627ehf_data *data, int nr)
 		reg = (w83627ehf_read_value(data, NCT6775_REG_FANDIV1) & 0x7)
 		    | ((data->fan_div[1] << 4) & 0x70);
 		w83627ehf_write_value(data, NCT6775_REG_FANDIV1, reg);
+		break;
 	case 2:
 		reg = (w83627ehf_read_value(data, NCT6775_REG_FANDIV2) & 0x70)
 		    | (data->fan_div[2] & 0x7);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
