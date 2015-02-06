From: Lukasz Majewski <l.majewski@samsung.com>
Date: Fri, 06 Feb 2015 16:59:08 +0000
Subject: [lm-sensors] [PATCH v3 8/8] hwmon: pwm-fan: Code for using PWM FAN as a cooling device
Message-Id: <1423241948-31981-9-git-send-email-l.majewski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1423241948-31981-1-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1423241948-31981-1-git-send-email-l.majewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

The PWM FAN device can now be used as a thermal cooling device. Necessary
infrastructure has been added in this commit.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- Replace pwm_fan_cooling_states with pwm_fan_cooling_levels
- Update ctx->pwm_fan_state when correct data from device tree is available
- Using therma_cdev_update() when thermal is ready for controlling the fan
Changes for v3:
- Rename patch heading
- pwm_fan_of_get_cooling_data() now returns -EINVAL when no "cooling-levels"
  property defined
- register of cooling device only when proper cooling data is present
---
 drivers/hwmon/pwm-fan.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index f3f5843..79fe24e 100644
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
+		if (pwm < ctx->pwm_fan_cooling_levels[i + 1])
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
+	ret = __set_pwm(ctx, ctx->pwm_fan_cooling_levels[state]);
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
@@ -113,7 +179,7 @@ int pwm_fan_of_get_cooling_data(struct device *dev, struct pwm_fan_ctx *ctx)
 
 	if (ret = -EINVAL) {
 		dev_err(dev, "Property 'cooling-levels' not found\n");
-		return 0;
+		return ret;
 	}
 
 	if (ret <= 0) {
@@ -149,8 +215,9 @@ int pwm_fan_of_get_cooling_data(struct device *dev, struct pwm_fan_ctx *ctx)
 
 static int pwm_fan_probe(struct platform_device *pdev)
 {
-	struct device *hwmon;
+	struct thermal_cooling_device *cdev;
 	struct pwm_fan_ctx *ctx;
+	struct device *hwmon;
 	int duty_cycle;
 	int ret;
 
@@ -194,8 +261,21 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	}
 
 	ret = pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
-	if (ret)
+	if (!ret) {
+		ctx->pwm_fan_state = ctx->pwm_fan_max_state;
+		cdev = thermal_of_cooling_device_register(pdev->dev.of_node,
+							  "pwm-fan", ctx,
+							  &pwm_fan_cooling_ops);
+		if (IS_ERR(cdev)) {
+			dev_err(&pdev->dev,
+				"Failed to register pwm-fan as cooling device");
+			pwm_disable(ctx->pwm);
+			return PTR_ERR(cdev);
+		}
+		thermal_cdev_update(cdev);
+	} else if (ret != -EINVAL) {
 		return ret;
+	}
 
 	return 0;
 }
-- 
2.0.0.rc2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
