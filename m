From: mgreer@mvista.com (Mark A. Greer)
Date: Wed, 07 Dec 2005 01:44:49 +0000
Subject: [lm-sensors] [PATCH 2.6.15-rc5-mm1] i2c: i2c-mv64xxx - Compilation
Message-Id: <20051207014449.GA21553@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The busses/i2c-mv64xxx.c driver doesn't currently compile because of an
incorrect argument to dev_err().  This patch fixes that.

[Since it currently doesn't compile, I'm hoping this can get in ASAP.]

Signed-off-by: Mark A. Greer <mgreer at mvista.com>
--

diff -Nur linux-2.6.15-rc5-mm1.orig/drivers/i2c/busses/i2c-mv64xxx.c linux-2.6.15-rc5-mm1-p1/drivers/i2c/busses/i2c-mv64xxx.c
--- linux-2.6.15-rc5-mm1.orig/drivers/i2c/busses/i2c-mv64xxx.c	2005-12-03 22:10:42.000000000 -0700
+++ linux-2.6.15-rc5-mm1-p1/drivers/i2c/busses/i2c-mv64xxx.c	2005-12-06 18:08:59.000000000 -0700
@@ -529,14 +529,15 @@
 	i2c_set_adapdata(&drv_data->adapter, drv_data);
 
 	if (request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
-		MV64XXX_I2C_CTLR_NAME, drv_data)) {
-
-		dev_err(dev, "mv64xxx: Can't register intr handler "
-			"irq: %d\n", drv_data->irq);
+			MV64XXX_I2C_CTLR_NAME, drv_data)) {
+		dev_err(&drv_data->adapter.dev,
+			"mv64xxx: Can't register intr handler irq: %d\n",
+			drv_data->irq);
 		rc = -EINVAL;
 		goto exit_unmap_regs;
 	} else if ((rc = i2c_add_adapter(&drv_data->adapter)) != 0) {
-		dev_err(dev, "mv64xxx: Can't add i2c adapter, rc: %d\n", -rc);
+		dev_err(&drv_data->adapter.dev,
+			"mv64xxx: Can't add i2c adapter, rc: %d\n", -rc);
 		goto exit_free_irq;
 	}
 

