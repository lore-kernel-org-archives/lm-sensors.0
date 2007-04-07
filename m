From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Apr 2007 19:04:00 +0000
Subject: [lm-sensors] [PATCH 5/5] w83781d: Deprecate W83627HF support
Message-Id: <20070407210400.91b57bc2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83781d.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.21-rc6.orig/drivers/hwmon/w83781d.c	2007-04-07 15:29:18.000000000 +0200
+++ linux-2.6.21-rc6/drivers/hwmon/w83781d.c	2007-04-07 15:29:21.000000000 +0200
@@ -1440,6 +1440,11 @@ w83781d_init_device(struct device *dev)
 	int type = data->type;
 	u8 tmp;
 
+	if (type = w83627hf)
+		dev_info(dev, "The W83627HF chip is better supported by the "
+			 "w83627hf driver, support will be dropped from the "
+			 "w83781d driver soon\n");
+
 	if (reset && type != as99127f) { /* this resets registers we don't have
 					   documentation for on the as99127f */
 		/* Resetting the chip has been the default for a long time,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
