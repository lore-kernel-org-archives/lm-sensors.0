From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 16:18:01 +0000
Subject: [lm-sensors] [PATCH 09/11] i2c: i2c-ibm_iic add I2C_CLASS_HWMON
Message-Id: <20051218171801.1b0c3fd7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Martin Hicks <mort at bork.org>
Content-Disposition: inline; filename=i2c-ibm_iic-hwmon-class.patch

Add the ibm_iic driver to the HWMON class so it will scan the
bus for connected hardware monitor sensors.

Signed-off-by: Martin Hicks <mort at bork.org>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/i2c-ibm_iic.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.15-rc5.orig/drivers/i2c/busses/i2c-ibm_iic.c	2005-11-12 15:49:51.000000000 +0100
+++ linux-2.6.15-rc5/drivers/i2c/busses/i2c-ibm_iic.c	2005-12-08 21:06:59.000000000 +0100
@@ -725,6 +725,7 @@
 	strcpy(adap->name, "IBM IIC");
 	i2c_set_adapdata(adap, dev);
 	adap->id = I2C_HW_OCP;
+	adap->class = I2C_CLASS_HWMON;
 	adap->algo = &iic_algo;
 	adap->client_register = NULL;
 	adap->client_unregister = NULL;

-- 
Jean Delvare

