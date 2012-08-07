From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:20:09 +0000
Subject: [lm-sensors] [PATCH 20/39] hwmon: (f71882fg) Convert to use devm_ functions
Message-Id: <1344352828-25143-21-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/f71882fg.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index bc1b205..b6304eb 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -2274,7 +2274,8 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 	int err, i;
 	u8 start_reg, reg;
 
-	data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(struct f71882fg_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -2288,13 +2289,11 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 	start_reg = f71882fg_read8(data, F71882FG_REG_START);
 	if (start_reg & 0x04) {
 		dev_warn(&pdev->dev, "Hardware monitor is powered down\n");
-		err = -ENODEV;
-		goto exit_free;
+		return -ENODEV;
 	}
 	if (!(start_reg & 0x03)) {
 		dev_warn(&pdev->dev, "Hardware monitoring not activated\n");
-		err = -ENODEV;
-		goto exit_free;
+		return -ENODEV;
 	}
 
 	/* Register sysfs interface files */
@@ -2422,8 +2421,6 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 exit_unregister_sysfs:
 	f71882fg_remove(pdev); /* Will unregister the sysfs files for us */
 	return err; /* f71882fg_remove() also frees our data */
-exit_free:
-	kfree(data);
 	return err;
 }
 
@@ -2525,10 +2522,6 @@ static int f71882fg_remove(struct platform_device *pdev)
 				ARRAY_SIZE(fxxxx_auto_pwm_attr[0]) * nr_fans);
 		}
 	}
-
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
