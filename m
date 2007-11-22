From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Date: Thu, 22 Nov 2007 15:50:26 +0000
Subject: Re: [lm-sensors] switching from at91 to gpio driver
Message-Id: <20071123.005026.15242182.anemo@mba.ocn.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20071115T225659-359@post.gmane.org>
In-Reply-To: <loom.20071115T225659-359@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 20 Nov 2007 21:07:08 +0100, Jean Delvare <khali@linux-fr.org> wrote:
> I wouldn't recommend setting I2C_CLASS_ALL in i2c-gpio, as it pretty
> much voids the idea of i2c classes. But on second thought,
> I2C_CLASS_HWMON should work fine. That's what almost all
> general-purpose i2c bus drivers do after all.
> 
> So, if someone sends me a patch adding class I2C_CLASS_HWMON to
> i2c-gpio, I'll take that.

OK, done.  Please review ;-)

------------------------------------------------------
Subject: i2c: initialize adapter class for i2c-gpio driver.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 44e1cd2..3ca19fc 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -140,6 +140,7 @@ static int __init i2c_gpio_probe(struct platform_device *pdev)
 	adap->owner = THIS_MODULE;
 	snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);
 	adap->algo_data = bit_data;
+	adap->class = I2C_CLASS_HWMON;
 	adap->dev.parent = &pdev->dev;
 
 	/*

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
