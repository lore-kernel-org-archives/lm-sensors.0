From: Denis Carikli <denis@eukrea.com>
Date: Wed, 22 Jul 2015 16:30:19 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: ads7828: Add devicetree support
Message-Id: <1437582620-2294-2-git-send-email-denis@eukrea.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1437582620-2294-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1437582620-2294-1-git-send-email-denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 drivers/hwmon/ads7828.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index 6c99ee7..a2d297f 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -31,6 +31,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_data/ads7828.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -160,6 +161,15 @@ static int ads7828_probe(struct i2c_client *client,
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id ads7828_of_match[] = {
+	{ .compatible = "ti,ads7828", .data = (void *) ads7828, },
+	{ .compatible = "ti,ads7830", .data = (void *) ads7830, },
+
+};
+MODULE_DEVICE_TABLE(of, ads7828_of_match);
+#endif
+
 static const struct i2c_device_id ads7828_device_ids[] = {
 	{ "ads7828", ads7828 },
 	{ "ads7830", ads7830 },
@@ -170,6 +180,7 @@ MODULE_DEVICE_TABLE(i2c, ads7828_device_ids);
 static struct i2c_driver ads7828_driver = {
 	.driver = {
 		.name = "ads7828",
+		.of_match_table = of_match_ptr(ads7828_of_match),
 	},
 
 	.id_table = ads7828_device_ids,
-- 
2.4.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
