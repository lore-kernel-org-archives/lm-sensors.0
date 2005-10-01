From: dsaxena@plexity.net (Deepak Saxena)
Date: Sat, 01 Oct 2005 07:02:45 +0000
Subject: [lm-sensors] [PATCH] [I2C] kmalloc + memzero -> kzalloc conversion
Message-Id: <20051001050202.GE11137@plexity.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


Signed-off-by: Deepak Saxena <dsaxena@mvista.com>

diff --git a/drivers/i2c/busses/i2c-ixp2000.c b/drivers/i2c/busses/i2c-ixp2000.c
--- a/drivers/i2c/busses/i2c-ixp2000.c
+++ b/drivers/i2c/busses/i2c-ixp2000.c
@@ -104,11 +104,10 @@ static int ixp2000_i2c_probe(struct devi
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
diff --git a/drivers/i2c/busses/i2c-ixp4xx.c b/drivers/i2c/busses/i2c-ixp4xx.c
--- a/drivers/i2c/busses/i2c-ixp4xx.c
+++ b/drivers/i2c/busses/i2c-ixp4xx.c
@@ -105,12 +105,11 @@ static int ixp4xx_i2c_probe(struct devic
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
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
