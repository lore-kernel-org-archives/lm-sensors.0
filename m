From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:50 +0000
Subject: [lm-sensors] [PATCH 69/95] hwmon: (s3c-hwmon) Convert to use devm_ functions
Message-Id: <1339773856-3443-70-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/s3c-hwmon.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index f6c26d1..717f809 100644
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -288,7 +288,7 @@ static int __devinit s3c_hwmon_probe(struct platform_device *dev)
 		return -EINVAL;
 	}
 
-	hwmon = kzalloc(sizeof(struct s3c_hwmon), GFP_KERNEL);
+	hwmon = devm_kzalloc(&dev->dev, sizeof(struct s3c_hwmon), GFP_KERNEL);
 	if (hwmon = NULL) {
 		dev_err(&dev->dev, "no memory\n");
 		return -ENOMEM;
@@ -303,8 +303,7 @@ static int __devinit s3c_hwmon_probe(struct platform_device *dev)
 	hwmon->client = s3c_adc_register(dev, NULL, NULL, 0);
 	if (IS_ERR(hwmon->client)) {
 		dev_err(&dev->dev, "cannot register adc\n");
-		ret = PTR_ERR(hwmon->client);
-		goto err_mem;
+		return PTR_ERR(hwmon->client);
 	}
 
 	/* add attributes for our adc devices. */
@@ -362,9 +361,6 @@ static int __devinit s3c_hwmon_probe(struct platform_device *dev)
 
  err_registered:
 	s3c_adc_release(hwmon->client);
-
- err_mem:
-	kfree(hwmon);
 	return ret;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
