From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 04 Jun 2009 07:30:41 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix more __devexit_p glitches
Message-Id: <20090604093041.442ad394@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make sure __devexit and devexit_p() match in all hwmon drivers.
Suggested by a similar fix from Mike Frysinger.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/hwmon/f71882fg.c |    2 +-
 drivers/hwmon/sht15.c    |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.30-rc8.orig/drivers/hwmon/f71882fg.c	2009-06-03 10:55:43.000000000 +0200
+++ linux-2.6.30-rc8/drivers/hwmon/f71882fg.c	2009-06-04 09:02:47.000000000 +0200
@@ -253,7 +253,7 @@ static struct platform_driver f71882fg_d
 		.name	= DRVNAME,
 	},
 	.probe		= f71882fg_probe,
-	.remove		= __devexit_p(f71882fg_remove),
+	.remove		= f71882fg_remove,
 };
 
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
--- linux-2.6.30-rc8.orig/drivers/hwmon/sht15.c	2009-04-15 08:40:49.000000000 +0200
+++ linux-2.6.30-rc8/drivers/hwmon/sht15.c	2009-06-04 09:25:30.000000000 +0200
@@ -627,35 +627,35 @@ static struct platform_driver sht_driver
 			.owner = THIS_MODULE,
 		},
 		.probe = sht15_probe,
-		.remove = sht15_remove,
+		.remove = __devexit_p(sht15_remove),
 	}, {
 		.driver = {
 			.name = "sht11",
 			.owner = THIS_MODULE,
 		},
 		.probe = sht15_probe,
-		.remove = sht15_remove,
+		.remove = __devexit_p(sht15_remove),
 	}, {
 		.driver = {
 			.name = "sht15",
 			.owner = THIS_MODULE,
 		},
 		.probe = sht15_probe,
-		.remove = sht15_remove,
+		.remove = __devexit_p(sht15_remove),
 	}, {
 		.driver = {
 			.name = "sht71",
 			.owner = THIS_MODULE,
 		},
 		.probe = sht15_probe,
-		.remove = sht15_remove,
+		.remove = __devexit_p(sht15_remove),
 	}, {
 		.driver = {
 			.name = "sht75",
 			.owner = THIS_MODULE,
 		},
 		.probe = sht15_probe,
-		.remove = sht15_remove,
+		.remove = __devexit_p(sht15_remove),
 	},
 };
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
