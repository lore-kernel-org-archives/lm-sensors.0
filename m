From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 23:06:47 +0000
Subject: [lm-sensors] [PATCH 09/14] i2c: kzalloc conversion, ixp bus drivers
Message-Id: <20051017230705.1aac3bf2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Deepak Saxena <dsaxena@plexity.net>
Content-Disposition: inline; filename=kzalloc-01-i2c-ixp.patch

Use kzalloc instead of kmalloc+memzero in the ixp2000 and ixp4xx
I2C bus drivers.

Signed-off-by: Deepak Saxena <dsaxena@mvista.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/i2c/busses/i2c-ixp2000.c |    3 +--
 drivers/i2c/busses/i2c-ixp4xx.c  |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-ixp2000.c	2005-10-01 22:32:48.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-ixp2000.c	2005-10-01 22:33:25.000000000 +0200
@@ -106,11 +106,10 @@
 	struct platform_device *plat_dev = to_platform_device(dev);
 	struct ixp2000_i2c_pins *gpio = plat_dev->dev.platform_data;
 	struct ixp2000_i2c_data *drv_data = 
-		kmalloc(sizeof(struct ixp2000_i2c_data), GFP_KERNEL);
+		kzalloc(sizeof(struct ixp2000_i2c_data), GFP_KERNEL);
 
 	if (!drv_data)
 		return -ENOMEM;
-	memzero(drv_data, sizeof(*drv_data));
 	drv_data->gpio_pins = gpio;
 
 	drv_data->algo_data.data = gpio;
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-ixp4xx.c	2005-10-01 22:32:48.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-ixp4xx.c	2005-10-01 22:33:25.000000000 +0200
@@ -107,12 +107,11 @@
 	struct platform_device *plat_dev = to_platform_device(dev);
 	struct ixp4xx_i2c_pins *gpio = plat_dev->dev.platform_data;
 	struct ixp4xx_i2c_data *drv_data = 
-		kmalloc(sizeof(struct ixp4xx_i2c_data), GFP_KERNEL);
+		kzalloc(sizeof(struct ixp4xx_i2c_data), GFP_KERNEL);
 
 	if(!drv_data)
 		return -ENOMEM;
 
-	memzero(drv_data, sizeof(struct ixp4xx_i2c_data));
 	drv_data->gpio_pins = gpio;
 
 	/*

-- 
Jean Delvare
