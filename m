From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 03 Feb 2015 18:53:53 +0000
Subject: [lm-sensors] [PATCH hwmon] hwmon: tmp102_dev_pm_ops can be static
Message-Id: <20150203185353.GA36414@snb>
List-Id: <lm-sensors.vger.kernel.org>
References: <201502040243.7wsydeCr%fengguang.wu@intel.com>
In-Reply-To: <201502040243.7wsydeCr%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grygorii Strashko <Grygorii.Strashko@linaro.org>
Cc: kbuild-all@01.org, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

drivers/hwmon/tmp102.c:284:1: sparse: symbol 'tmp102_dev_pm_ops' was not declared. Should it be static?

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 tmp102.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 565df47..9da2735 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -281,7 +281,7 @@ static int tmp102_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
-SIMPLE_DEV_PM_OPS(tmp102_dev_pm_ops, tmp102_suspend, tmp102_resume);
+static SIMPLE_DEV_PM_OPS(tmp102_dev_pm_ops, tmp102_suspend, tmp102_resume);
 
 static const struct i2c_device_id tmp102_id[] = {
 	{ "tmp102", 0 },

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
