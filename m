From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Aug 2007 12:33:37 +0000
Subject: [lm-sensors] [PATCH] hwmon/smsc47m1: No confusing debugging messages
Message-Id: <20070816143337.5f3486d1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It's confusing to display debugging messages for fan3 and pwm3 for
chips which don't have them.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/smsc47m1.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.23-rc2.orig/drivers/hwmon/smsc47m1.c	2007-08-08 16:53:14.000000000 +0200
+++ linux-2.6.23-rc2/drivers/hwmon/smsc47m1.c	2007-08-10 20:22:26.000000000 +0200
@@ -553,7 +553,7 @@ static int __devinit smsc47m1_probe(stru
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_fan3_div.dev_attr)))
 			goto error_remove_files;
-	} else
+	} else if (data->type = smsc47m2)
 		dev_dbg(dev, "Fan 3 not enabled by hardware, skipping\n");
 
 	if (pwm1) {
@@ -580,7 +580,7 @@ static int __devinit smsc47m1_probe(stru
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_pwm3_enable.dev_attr)))
 			goto error_remove_files;
-	} else
+	} else if (data->type = smsc47m2)
 		dev_dbg(dev, "PWM 3 not enabled by hardware, skipping\n");
 
 	if ((err = device_create_file(dev, &dev_attr_alarms)))


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
