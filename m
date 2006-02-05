From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 05 Feb 2006 22:30:26 +0000
Subject: [lm-sensors] [PATCH 10/11] i2c: Fix i2c-ite name initialization
Message-Id: <20060205233026.58d9fea4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-ite-name-init.patch

Properly set the name member of the i2c_adapter structure of the ite
i2c adapter driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/i2c-ite.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.16-rc1.orig/drivers/i2c/busses/i2c-ite.c	2006-01-21 10:42:40.000000000 +0100
+++ linux-2.6.16-rc1/drivers/i2c/busses/i2c-ite.c	2006-01-21 10:50:37.000000000 +0100
@@ -200,9 +200,7 @@
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_I_IIC,
 	.algo_data	= &iic_ite_data,
-	.dev		= {
-		.name	= "ITE IIC adapter",
-	},
+	.name		= "ITE IIC adapter",
 };
 
 /* Called when the module is loaded.  This function starts the

-- 
Jean Delvare

