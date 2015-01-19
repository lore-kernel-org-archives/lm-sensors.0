From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 19 Jan 2015 17:19:52 +0000
Subject: [lm-sensors] [PATCH] hwmon: (jc42) Fix integer overflow when writing hysteresis value
Message-Id: <1421687992-12168-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Subtracting an unsigned long from a signed value causes an overflow with large
values. Use clamp_val() to reduce the number range prior to subtracting it
from the temperature limit.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/jc42.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index f8e3bbb..a46cb65 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -312,7 +312,9 @@ static ssize_t set_temp_crit_hyst(struct device *dev,
 	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
+	val = clamp_val(val, 0, JC42_TEMP_MAX);
 	diff = jc42_temp_from_reg(data->temp[t_crit]) - val;
+
 	hyst = 0;
 	if (diff > 0) {
 		if (diff < 2250)
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
