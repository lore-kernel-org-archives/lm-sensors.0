From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 27 Feb 2006 22:12:58 +0000
Subject: [lm-sensors] [PATCH 4/6] i2c-ixp4xx: Add hwmon class
Message-Id: <20060227231258.cebdda2f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Alessandro Zummo <a.zummo at towertech.it>
Content-Disposition: inline; filename=i2c-ixp4xx-hwmon-class.patch

This patch adds I2C_CLASS_HWMON to the ixp4xx bus driver.

Signed-off-by: Alessandro Zummo <a.zummo at towertech.it>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/i2c-ixp4xx.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.16-rc4.orig/drivers/i2c/busses/i2c-ixp4xx.c	2006-02-19 09:40:51.000000000 +0100
+++ linux-2.6.16-rc4/drivers/i2c/busses/i2c-ixp4xx.c	2006-02-19 20:41:14.000000000 +0100
@@ -126,6 +126,7 @@
 	drv_data->algo_data.timeout = 100;
 
 	drv_data->adapter.id = I2C_HW_B_IXP4XX;
+	drv_data->adapter.class = I2C_CLASS_HWMON;
 	strlcpy(drv_data->adapter.name, plat_dev->dev.driver->name,
 		I2C_NAME_SIZE);
 	drv_data->adapter.algo_data = &drv_data->algo_data;

-- 
Jean Delvare

