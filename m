From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Sep 2013 08:33:26 +0000
Subject: [lm-sensors] [PATCH 03/12] hwmon: (nct6775) Check array index when accessing temp_offset
Message-Id: <1379147615-7703-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

smatch complains about a potential out-of-bounds access to the
temp_offset array. That doesn't happen in practice, but it doesn't
hurt to add an explicit check either. This prevents potential problems
in the future (for example if the number of 'fixed' temperature
sensors is increased to add support for another chip).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index de57e0d..b82fad4 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1457,7 +1457,8 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 					  = nct6775_read_temp(data,
 						data->reg_temp[j][i]);
 			}
-			if (!(data->have_temp_fixed & (1 << i)))
+			if (i >= NUM_TEMP_FIXED ||
+			    !(data->have_temp_fixed & (1 << i)))
 				continue;
 			data->temp_offset[i]
 			  = nct6775_read_value(data, data->REG_TEMP_OFFSET[i]);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
