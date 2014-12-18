From: Lukasz Majewski <l.majewski@samsung.com>
Date: Thu, 18 Dec 2014 10:13:08 +0000
Subject: [lm-sensors] [PATCH 6/9] hwmon: thermal: Read PWM FAN configuration from device tree
Message-Id: <1418897591-18332-7-git-send-email-l.majewski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Code for reading PWM FAN configuration data via device tree has been added.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/hwmon/pwm-fan.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 870e100..5854bb3 100644
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
+	unsigned int *pwm_fan_cooling_states;
 };
 
 static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
@@ -100,6 +103,49 @@ static struct attribute *pwm_fan_attrs[] = {
 
 ATTRIBUTE_GROUPS(pwm_fan);
 
+int pwm_fan_of_get_cooling_data(struct device *dev, struct pwm_fan_ctx *ctx)
+{
+	struct device_node *np = dev->of_node;
+	struct property *pp;
+	int len, num, i;
+
+	pp = of_find_property(np, "cooling-pwm-values", &len);
+	if (!pp) {
+		dev_err(dev, "Property: 'cooling-pwm-values' not found\n");
+		return -EINVAL;
+	}
+
+	if (len = 0) {
+		dev_err(dev, "Length wrong value!\n");
+		return -EINVAL;
+	}
+
+	ctx->pwm_fan_cooling_states = devm_kzalloc(dev, len, GFP_KERNEL);
+	if (!ctx->pwm_fan_cooling_states) {
+		dev_err(dev, "Allocation failed for pwm dan cooling states\n");
+		return -ENOMEM;
+	}
+
+	num = len / sizeof(u32);
+	if (of_property_read_u32_array(np, pp->name,
+				       ctx->pwm_fan_cooling_states, num)) {
+		dev_err(dev, "Property: %s cannot be read!\n", pp->name);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num; i++) {
+		if (ctx->pwm_fan_cooling_states[i] > MAX_PWM) {
+			dev_err(dev, "PWM fan state[%d]:%d > %d\n", i,
+				ctx->pwm_fan_cooling_states[i], MAX_PWM);
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
@@ -120,6 +166,9 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, ctx);
+	ret = pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
+	if (ret)
+		return ret;
 
 	/* Set duty cycle to maximum allowed */
 	duty_cycle = ctx->pwm->period - 1;
-- 
2.0.0.rc2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
