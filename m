From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Sep 2012 16:34:15 +0000
Subject: [lm-sensors] [PATCH v2 1/5] hwmon: (twl4030-madc-hwmon) Initialize uninitialized structure elements
Message-Id: <1347381259-14585-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

twl4030_madc_conversion uses do_avg and type structure elements of
twl4030_madc_request. Initialize structure to avoid random operation.

Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: review feedback - initialize twl4030_madc_request structure in declaration.
    With this change, I think this patch is a candidate for 3.6 and -stable.

 drivers/hwmon/twl4030-madc-hwmon.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-madc-hwmon.c
index 0018c7d..1a174f0 100644
--- a/drivers/hwmon/twl4030-madc-hwmon.c
+++ b/drivers/hwmon/twl4030-madc-hwmon.c
@@ -44,12 +44,13 @@ static ssize_t madc_read(struct device *dev,
 			 struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct twl4030_madc_request req;
+	struct twl4030_madc_request req = {
+		.channels = 1 << attr->index,
+		.method = TWL4030_MADC_SW2,
+		.type = TWL4030_MADC_WAIT,
+	};
 	long val;
 
-	req.channels = (1 << attr->index);
-	req.method = TWL4030_MADC_SW2;
-	req.func_cb = NULL;
 	val = twl4030_madc_conversion(&req);
 	if (val < 0)
 		return val;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
