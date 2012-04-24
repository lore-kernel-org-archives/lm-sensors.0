From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Apr 2012 03:36:59 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (ntc_thermistor) Return error code from hwmon_device_register
Message-Id: <1335238619-25745-4-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hwmon_device_register() never returns a NULL pointer in case of errors, but
an error value. Use it.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Donggeun Kim <dg77.kim@samsung.com>
---
 drivers/hwmon/ntc_thermistor.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 09a1b26..6da9696 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -378,9 +378,9 @@ static int __devinit ntc_thermistor_probe(struct platform_device *pdev)
 	}
 
 	data->hwmon_dev = hwmon_device_register(data->dev);
-	if (IS_ERR_OR_NULL(data->hwmon_dev)) {
+	if (IS_ERR(data->hwmon_dev)) {
 		dev_err(data->dev, "unable to register as hwmon device.\n");
-		ret = -EINVAL;
+		ret = PTR_ERR(data->hwmon_dev);
 		goto err_after_sysfs;
 	}
 
-- 
1.7.9.48.g85da4d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
