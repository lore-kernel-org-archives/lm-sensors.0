From: Lukasz Majewski <l.majewski@samsung.com>
Date: Fri, 06 Feb 2015 16:59:07 +0000
Subject: [lm-sensors] [PATCH v3 7/8] hwmon: pwm-fan: Read PWM FAN configuration from device tree
Message-Id: <1423241948-31981-8-git-send-email-l.majewski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1423241948-31981-1-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1423241948-31981-1-git-send-email-l.majewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

This patch provides code for reading PWM FAN configuration data via
device tree. The pwm-fan can work with full speed when configuration
is not provided. However, errors are propagated when wrong DT bindings
are found.
Additionally the struct pwm_fan_ctx has been extended.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- Rename pwm_fan_max_states to pwm_fan_cooling_levels
- Moving pwm_fan_of_get_cooling_data() call after setting end enabling PWM FAN
- pwm_fan_of_get_cooling_data() now can fail - preserving old behaviour
- Remove unnecessary dev_err() call
Changes for v3:
- Patch's headline has been reedited
- pwm_fan_of_get_cooling_data() return code is now being checked.
- of_property_count_elems_of_size() is now used instead of_find_property()
- More verbose patch description added
---
 drivers/hwmon/pwm-fan.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 870e100..f3f5843 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -30,7 +30,10 @@
 struct pwm_fan_ctx {
 	struct mutex lock;
 	struct pwm_device *pwm;
-	unsigned char pwm_value;
+	unsigned int pwm_value;
+	unsigned int pwm_fan_state;
+	unsigned int pwm_fan_max_state;
+	unsigned int *pwm_fan_cooling_levels;
 };
 
 static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
@@ -100,6 +103,50 @@ static struct attribute *pwm_fan_attrs[] = {
 
 ATTRIBUTE_GROUPS(pwm_fan);
 
+int pwm_fan_of_get_cooling_data(struct device *dev, struct pwm_fan_ctx *ctx)
+{
+	struct device_node *np = dev->of_node;
+	int num, i, ret;
+
+	ret = of_property_count_elems_of_size(np, "cooling-levels",
+					      sizeof(u32));
+
+	if (ret = -EINVAL) {
+		dev_err(dev, "Property 'cooling-levels' not found\n");
+		return 0;
+	}
+
+	if (ret <= 0) {
+		dev_err(dev, "Wrong data!\n");
+		return ret;
+	}
+
+	num = ret;
+	ctx->pwm_fan_cooling_levels = devm_kzalloc(dev, num * sizeof(u32),
+						   GFP_KERNEL);
+	if (!ctx->pwm_fan_cooling_levels)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, "cooling-levels",
+					 ctx->pwm_fan_cooling_levels, num);
+	if (ret) {
+		dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
+		return ret;
+	}
+
+	for (i = 0; i < num; i++) {
+		if (ctx->pwm_fan_cooling_levels[i] > MAX_PWM) {
+			dev_err(dev, "PWM fan state[%d]:%d > %d\n", i,
+				ctx->pwm_fan_cooling_levels[i], MAX_PWM);
+			return -EINVAL;
+		}
+	}
+
+	ctx->pwm_fan_max_state = num - 1;
+
+	return 0;
+}
+
 static int pwm_fan_probe(struct platform_device *pdev)
 {
 	struct device *hwmon;
@@ -145,6 +192,11 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		pwm_disable(ctx->pwm);
 		return PTR_ERR(hwmon);
 	}
+
+	ret = pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.0.0.rc2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
