From: mgreer@mvista.com (Mark A. Greer)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH 2.6.12-rc1] i2c: i2c-mv64xxx - set adapter owner and class
Message-Id: <424B18D2.1070302@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i2c: Set adapter owner and class fields.

This patch adds the correct values for the 'owner' and 'class' fields of
the adapter structure in the mv64xxx i2c bus driver.  The missing class
field caused some i2c chip drivers to refuse to attempt a probe on the 
mv64xxx i2c bus. 

Signed-off-by: Chris Elston <chris.elston@radstone.co.uk>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--


-------------- next part --------------
diff -Nru a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
--- a/drivers/i2c/busses/i2c-mv64xxx.c	2005-03-30 14:14:59 -07:00
+++ b/drivers/i2c/busses/i2c-mv64xxx.c	2005-03-30 14:14:59 -07:00
@@ -525,6 +525,8 @@
 	drv_data->irq = platform_get_irq(pd, 0);
 	drv_data->adapter.id = I2C_ALGO_MV64XXX | I2C_HW_MV64XXX;
 	drv_data->adapter.algo = &mv64xxx_i2c_algo;
+	drv_data->adapter.owner = THIS_MODULE;
+	drv_data->adapter.class = I2C_CLASS_HWMON;
 	drv_data->adapter.timeout = pdata->timeout;
 	drv_data->adapter.retries = pdata->retries;
 	dev_set_drvdata(dev, drv_data);
