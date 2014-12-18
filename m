From: Lukasz Majewski <l.majewski@samsung.com>
Date: Thu, 18 Dec 2014 10:13:09 +0000
Subject: [lm-sensors] [PATCH 7/9] hwmon: thermal: Code for using PWM FAN as a cooling device
Message-Id: <1418897591-18332-8-git-send-email-l.majewski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

The PWM FAN device can now be used as a thermal cooling device. Necessary
infrastructure has been added in this commit.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/hwmon/pwm-fan.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 5854bb3..97b77e9 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/sysfs.h>
+#include <linux/thermal.h>
 
 #define MAX_PWM 255
 
@@ -68,6 +69,17 @@ exit_set_pwm_err:
 	return ret;
 }
 
+static void pwm_fan_update_state(struct pwm_fan_ctx *ctx, unsigned long pwm)
+{
+	int i;
+
+	for (i = 0; i < ctx->pwm_fan_max_state; ++i)
+		if (pwm < ctx->pwm_fan_cooling_states[i + 1])
+			break;
+
+	ctx->pwm_fan_state = i;
+}
+
 static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		       const char *buf, size_t count)
 {
@@ -82,6 +94,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
+	pwm_fan_update_state(ctx, pwm);
 	return count;
 }
 
@@ -103,6 +116,59 @@ static struct attribute *pwm_fan_attrs[] = {
 
 ATTRIBUTE_GROUPS(pwm_fan);
 
+/* thermal cooling device callbacks */
+static int pwm_fan_get_max_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct pwm_fan_ctx *ctx = cdev->devdata;
+
+	*state = ctx->pwm_fan_max_state;
+
+	return 0;
+}
+
+static int pwm_fan_get_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct pwm_fan_ctx *ctx = cdev->devdata;
+
+	if (!ctx)
+		return -EINVAL;
+
+	*state = ctx->pwm_fan_state;
+
+	return 0;
+}
+
+static int
+pwm_fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
+{
+	struct pwm_fan_ctx *ctx = cdev->devdata;
+	int ret;
+
+	if (!ctx || (state > ctx->pwm_fan_max_state))
+		return -EINVAL;
+
+	if (state = ctx->pwm_fan_state)
+		return 0;
+
+	ret = __set_pwm(ctx, ctx->pwm_fan_cooling_states[state]);
+	if (ret) {
+		dev_err(&cdev->device, "Cannot set pwm!\n");
+		return ret;
+	}
+
+	ctx->pwm_fan_state = state;
+
+	return ret;
+}
+
+static const struct thermal_cooling_device_ops pwm_fan_cooling_ops = {
+	.get_max_state = pwm_fan_get_max_state,
+	.get_cur_state = pwm_fan_get_cur_state,
+	.set_cur_state = pwm_fan_set_cur_state,
+};
+
 int pwm_fan_of_get_cooling_data(struct device *dev, struct pwm_fan_ctx *ctx)
 {
 	struct device_node *np = dev->of_node;
@@ -148,8 +214,9 @@ int pwm_fan_of_get_cooling_data(struct device *dev, struct pwm_fan_ctx *ctx)
 
 static int pwm_fan_probe(struct platform_device *pdev)
 {
-	struct device *hwmon;
+	struct thermal_cooling_device *cdev;
 	struct pwm_fan_ctx *ctx;
+	struct device *hwmon;
 	int duty_cycle;
 	int ret;
 
@@ -194,6 +261,16 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		pwm_disable(ctx->pwm);
 		return PTR_ERR(hwmon);
 	}
+
+	cdev = thermal_of_cooling_device_register(pdev->dev.of_node, "pwm-fan",
+						  ctx, &pwm_fan_cooling_ops);
+	if (IS_ERR(cdev)) {
+		dev_err(&pdev->dev,
+			"Failed to register pwm-fan as thermal cooling device");
+		pwm_disable(ctx->pwm);
+		return PTR_ERR(cdev);
+	}
+
 	return 0;
 }
 
-- 
2.0.0.rc2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
