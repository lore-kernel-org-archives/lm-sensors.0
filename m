From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Sep 2013 08:33:35 +0000
Subject: [lm-sensors] [PATCH 12/12] hwmon: (f71882fg) Remove extra return statement
Message-Id: <1379147615-7703-13-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Leftover from commit 33cd66e3 (hwmon: (f71882fg) Convert to use
devm_ functions).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/f71882fg.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 31b221e..03d8592 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -2420,7 +2420,6 @@ static int f71882fg_probe(struct platform_device *pdev)
 exit_unregister_sysfs:
 	f71882fg_remove(pdev); /* Will unregister the sysfs files for us */
 	return err; /* f71882fg_remove() also frees our data */
-	return err;
 }
 
 static int f71882fg_remove(struct platform_device *pdev)
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
