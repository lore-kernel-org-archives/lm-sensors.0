From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 May 2013 20:37:44 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct6775) Do not create non-existing attributes
Message-Id: <1368131864-32011-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Overtemperature and hysteresis registers only exist for primary
temperature registers, not for alternates, so do not assign
those registers when initializing alternates.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 137c8ce..a27e625 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -3427,8 +3427,10 @@ static int nct6775_probe(struct platform_device *pdev)
 			data->have_temp |= 1 << i;
 			data->have_temp_fixed |= 1 << i;
 			data->reg_temp[0][i] = reg_temp_alternate[i];
-			data->reg_temp[1][i] = reg_temp_over[i];
-			data->reg_temp[2][i] = reg_temp_hyst[i];
+			if (i < num_reg_temp) {
+				data->reg_temp[1][i] = reg_temp_over[i];
+				data->reg_temp[2][i] = reg_temp_hyst[i];
+			}
 			data->temp_src[i] = i + 1;
 			continue;
 		}
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
