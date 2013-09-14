From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Sep 2013 08:33:27 +0000
Subject: [lm-sensors] [PATCH 04/12] hwmon: (mc13783-adc) Increase size of name string
Message-Id: <1379147615-7703-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

smatch complains about

mc13783_adc_probe() error: snprintf() chops off the last chars of
'id->name': 20 +vs 10

Use PLATFORM_NAME_SIZE instead of '10' as size when declaring
the name variable.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/mc13783-adc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index 982d862..ae00e60 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -37,7 +37,7 @@
 struct mc13783_adc_priv {
 	struct mc13xxx *mc13xxx;
 	struct device *hwmon_dev;
-	char name[10];
+	char name[PLATFORM_NAME_SIZE];
 };
 
 static ssize_t mc13783_adc_show_name(struct device *dev, struct device_attribute
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
