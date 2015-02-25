From: Simon Guinot <simon.guinot@sequanux.org>
Date: Wed, 25 Feb 2015 17:58:19 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (gpio-fan) allow to use alarm support alone from DT
Message-Id: <1424887099-26551-1-git-send-email-simon.guinot@sequanux.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On some boards, such as the LaCie 2Big Network v2 or 2Big NAS (based on
Marvell Kirkwood SoCs), an I2C fan controller is used but the alarm
signal is wired to a separate GPIO. Unfortunately, the gpio-fan driver
can't be used to handle GPIO alarm alone from DT: an error is returned
if the "gpios" DT property is missing.

This patch allows to use the gpio-fan driver even if the "alarm-gpios"
DT property is defined alone.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 .../devicetree/bindings/gpio/gpio-fan.txt          |  6 ++-
 drivers/hwmon/gpio-fan.c                           | 44 +++++++++++-----------
 2 files changed, 27 insertions(+), 23 deletions(-)

v2 change:
- Fix sentence in binding document about having at least one of the
  "gpios" or "alarm-gpios" properties set.

diff --git a/Documentation/devicetree/bindings/gpio/gpio-fan.txt b/Documentation/devicetree/bindings/gpio/gpio-fan.txt
index 2dd457a3469a..f996d428f132 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-fan.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-fan.txt
@@ -2,16 +2,18 @@ Bindings for fan connected to GPIO lines
 
 Required properties:
 - compatible : "gpio-fan"
+
+Optional properties:
 - gpios: Specifies the pins that map to bits in the control value,
   ordered MSB-->LSB.
 - gpio-fan,speed-map: A mapping of possible fan RPM speeds and the
   control value that should be set to achieve them. This array
   must have the RPM values in ascending order.
-
-Optional properties:
 - alarm-gpios: This pin going active indicates something is wrong with
   the fan, and a udev event will be fired.
 
+Note: At least one the "gpios" or "alarm-gpios" properties must be set.
+
 Examples:
 
 	gpio_fan {
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 36abf814b8c7..c241f5b0b7cf 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -404,10 +404,32 @@ static int gpio_fan_get_of_pdata(struct device *dev,
 
 	node = dev->of_node;
 
+	/* Alarm GPIO if one exists */
+	if (of_gpio_named_count(node, "alarm-gpios") > 0) {
+		struct gpio_fan_alarm *alarm;
+		int val;
+		enum of_gpio_flags flags;
+
+		alarm = devm_kzalloc(dev, sizeof(struct gpio_fan_alarm),
+					GFP_KERNEL);
+		if (!alarm)
+			return -ENOMEM;
+
+		val = of_get_named_gpio_flags(node, "alarm-gpios", 0, &flags);
+		if (val < 0)
+			return val;
+		alarm->gpio = val;
+		alarm->active_low = flags & OF_GPIO_ACTIVE_LOW;
+
+		pdata->alarm = alarm;
+	}
+
 	/* Fill GPIO pin array */
 	pdata->num_ctrl = of_gpio_count(node);
 	if (pdata->num_ctrl <= 0) {
-		dev_err(dev, "gpios DT property empty / missing");
+		if (pdata->alarm)
+			return 0;
+		dev_err(dev, "DT properties empty / missing");
 		return -ENODEV;
 	}
 	ctrl = devm_kzalloc(dev, pdata->num_ctrl * sizeof(unsigned),
@@ -460,26 +482,6 @@ static int gpio_fan_get_of_pdata(struct device *dev,
 	}
 	pdata->speed = speed;
 
-	/* Alarm GPIO if one exists */
-	if (of_gpio_named_count(node, "alarm-gpios") > 0) {
-		struct gpio_fan_alarm *alarm;
-		int val;
-		enum of_gpio_flags flags;
-
-		alarm = devm_kzalloc(dev, sizeof(struct gpio_fan_alarm),
-					GFP_KERNEL);
-		if (!alarm)
-			return -ENOMEM;
-
-		val = of_get_named_gpio_flags(node, "alarm-gpios", 0, &flags);
-		if (val < 0)
-			return val;
-		alarm->gpio = val;
-		alarm->active_low = flags & OF_GPIO_ACTIVE_LOW;
-
-		pdata->alarm = alarm;
-	}
-
 	return 0;
 }
 
-- 
2.1.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
