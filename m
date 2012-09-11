From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Sep 2012 04:09:23 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (twl4030-madc-hwmon) Initialize uninitialized structure elements
Message-Id: <1347336566-32662-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

twl4030_madc_conversion uses do_avg and type structure elements of
twl4030_madc_request. Initialize to avoid random operation.

Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/twl4030-madc-hwmon.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-madc-hwmon.c
index 0018c7d..f8ba8b0 100644
--- a/drivers/hwmon/twl4030-madc-hwmon.c
+++ b/drivers/hwmon/twl4030-madc-hwmon.c
@@ -50,6 +50,8 @@ static ssize_t madc_read(struct device *dev,
 	req.channels = (1 << attr->index);
 	req.method = TWL4030_MADC_SW2;
 	req.func_cb = NULL;
+	req.do_avg = 0;
+	req.type = TWL4030_MADC_WAIT;
 	val = twl4030_madc_conversion(&req);
 	if (val < 0)
 		return val;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
