From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 13 Jul 2012 09:18:28 +0000
Subject: [lm-sensors] [PATCH] hwmon: s3c-hwmon: Use devm_kzalloc instead of kzalloc
Message-Id: <1342170388-5682-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This makes the code simpler as explicit freeing is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/hwmon/s3c-hwmon.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index f6c26d1..b7975f8 100644
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
@@ -363,8 +362,6 @@ static int __devinit s3c_hwmon_probe(struct platform_device *dev)
  err_registered:
 	s3c_adc_release(hwmon->client);
 
- err_mem:
-	kfree(hwmon);
 	return ret;
 }
 
-- 
1.7.4.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
