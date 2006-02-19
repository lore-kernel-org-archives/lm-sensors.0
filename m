From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Sun, 19 Feb 2006 17:02:27 +0000
Subject: [lm-sensors] [PATCH] hwmon class for ixp4xx bus driver
Message-Id: <20060219180227.3a33a4d2@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This patch adds I2C_CLASS_HWMON to the ixp4xx
bus driver.

Signed-off-by: Alessandro Zummo <a.zummo at towertech.it>

--- linux-ixp4xx.orig/drivers/i2c/busses/i2c-ixp4xx.c	2006-02-11 15:18:29.000000000 +0100
+++ linux-ixp4xx/drivers/i2c/busses/i2c-ixp4xx.c	2006-02-18 16:20:12.000000000 +0100
@@ -126,6 +126,7 @@ static int ixp4xx_i2c_probe(struct platf
 	drv_data->algo_data.timeout = 100;
 
 	drv_data->adapter.id = I2C_HW_B_IXP4XX;
+	drv_data->adapter.class = I2C_CLASS_HWMON;
 	strlcpy(drv_data->adapter.name, plat_dev->dev.driver->name,
 		I2C_NAME_SIZE);
 	drv_data->adapter.algo_data = &drv_data->algo_data;


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it


