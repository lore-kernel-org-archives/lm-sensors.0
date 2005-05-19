From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <10745567592337@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567584195@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.5, 2004/01/14 11:12:07-08:00, ebs@ebshome.net

[PATCH] I2C: IBM IIC compile fix

please apply this trivial one-liner. It fixes compilation of IBM IIC
driver.


 drivers/i2c/busses/i2c-ibm_iic.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	Mon Jan 19 15:32:37 2004
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	Mon Jan 19 15:32:37 2004
@@ -601,7 +601,7 @@
 	
 	/* Register it with i2c layer */
 	adap = &dev->adap;
-	strcpy(adap->dev.name, "IBM IIC");
+	strcpy(adap->name, "IBM IIC");
 	i2c_set_adapdata(adap, dev);
 	adap->id = I2C_HW_OCP | iic_algo.id;
 	adap->algo = &iic_algo;

