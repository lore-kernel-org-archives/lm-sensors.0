From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 25 Jun 2014 01:02:32 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83l786ng) Report correct minimum fan speed
Message-Id: <1403658152.18417.0.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Current code is buggy, it shows the current fan speed as minimum fan speed.
Fix up show_fan_reg macro to correctly report fan and fan_min speed.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/w83l786ng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
index 6ed76ce..32487c1 100644
--- a/drivers/hwmon/w83l786ng.c
+++ b/drivers/hwmon/w83l786ng.c
@@ -249,7 +249,7 @@ static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct w83l786ng_data *data = w83l786ng_update_device(dev); \
 	return sprintf(buf, "%d\n", \
-		FAN_FROM_REG(data->fan[nr], DIV_FROM_REG(data->fan_div[nr]))); \
+		FAN_FROM_REG(data->reg[nr], DIV_FROM_REG(data->fan_div[nr]))); \
 }
 
 show_fan_reg(fan);
-- 
1.8.3.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
