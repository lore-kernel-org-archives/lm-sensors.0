From: Denis Carikli <denis@eukrea.com>
Date: Wed, 22 Jul 2015 16:30:18 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: lm92: Add devicetree support
Message-Id: <1437582620-2294-1-git-send-email-denis@eukrea.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 drivers/hwmon/lm92.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index cfaf70b..a1e10cd 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -44,6 +44,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/jiffies.h>
 
 /*
@@ -386,6 +387,13 @@ static int lm92_probe(struct i2c_client *new_client,
  * Module and driver stuff
  */
 
+#ifdef CONFIG_OF
+static const struct of_device_id lm92_of_match[] = {
+	{ .compatible = "national,lm92", },
+};
+MODULE_DEVICE_TABLE(of, lm92_of_match);
+#endif
+
 static const struct i2c_device_id lm92_id[] = {
 	{ "lm92", 0 },
 	/* max6635 could be added here */
@@ -397,6 +405,7 @@ static struct i2c_driver lm92_driver = {
 	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "lm92",
+		.of_match_table = of_match_ptr(lm92_of_match),
 	},
 	.probe		= lm92_probe,
 	.id_table	= lm92_id,
-- 
2.4.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
