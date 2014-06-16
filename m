From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 16 Jun 2014 18:24:28 +0000
Subject: [lm-sensors] [PATCH 1/2] touchscreen: sun4i-ts: A10 (sun4i) has double the temperature precision
Message-Id: <1402943069-19420-2-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1402943069-19420-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1402943069-19420-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Tong Zhang <lovewilliam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Testing has revealed that the temperature in the rtp controller of the A10
(sun4i) SoC has a resolution of 50 milli degrees / step, where as the
A13 (sun5i) and later models have 100 milli degrees / step.

Add a new sun5i-a13-ts compatible to differentiate the newer models and
set the resolution based on the compatible string.

This fixes the temperature reported on the A10 being twice as high as expected.

Reported-by: Tong Zhang <lovewilliam@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/input/touchscreen/sun4i.txt | 2 +-
 drivers/input/touchscreen/sun4i-ts.c                          | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
index aef5779..5106709 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
@@ -2,7 +2,7 @@ sun4i resistive touchscreen controller
 --------------------------------------
 
 Required properties:
- - compatible: "allwinner,sun4i-a10-ts"
+ - compatible: "allwinner,sun4i-a10-ts" or "allwinner,sun5i-a13-ts"
  - reg: mmio address range of the chip
  - interrupts: interrupt to which the chip is connected
 
diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index 2ba8260..5661be0 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -111,6 +111,7 @@ struct sun4i_ts_data {
 	unsigned int irq;
 	bool ignore_fifo_data;
 	int temp_data;
+	int temp_step;
 };
 
 static void sun4i_ts_irq_handle_input(struct sun4i_ts_data *ts, u32 reg_val)
@@ -189,7 +190,7 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
 	if (ts->temp_data = -1)
 		return -EAGAIN;
 
-	return sprintf(buf, "%d\n", (ts->temp_data - 1447) * 100);
+	return sprintf(buf, "%d\n", (ts->temp_data - 1447) * ts->temp_step);
 }
 
 static ssize_t show_temp_label(struct device *dev,
@@ -224,6 +225,10 @@ static int sun4i_ts_probe(struct platform_device *pdev)
 	ts->dev = dev;
 	ts->ignore_fifo_data = true;
 	ts->temp_data = -1;
+	if (of_device_is_compatible(np, "allwinner,sun4i-a10-ts"))
+		ts->temp_step = 50;
+	else
+		ts->temp_step = 100;
 
 	ts_attached = of_property_read_bool(np, "allwinner,ts-attached");
 	if (ts_attached) {
@@ -318,6 +323,7 @@ static int sun4i_ts_remove(struct platform_device *pdev)
 
 static const struct of_device_id sun4i_ts_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-ts", },
+	{ .compatible = "allwinner,sun5i-a13-ts", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_ts_of_match);
-- 
2.0.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
