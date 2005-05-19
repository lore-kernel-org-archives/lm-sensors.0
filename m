From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <10819814513668@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10819814511233@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.17, 2004/04/08 14:12:22-07:00, mochel@digitalimplant.org

[PATCH] I2C: class fixup for the ali1563 driver


 drivers/i2c/busses/i2c-ali1563.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	Wed Apr 14 15:13:33 2004
+++ b/drivers/i2c/busses/i2c-ali1563.c	Wed Apr 14 15:13:33 2004
@@ -357,6 +357,7 @@
 
 static struct i2c_adapter ali1563_adapter = {
 	.owner	= THIS_MODULE,
+	.class	= I2C_ADAP_CLASS_SMBUS,
 	.algo	= &ali1563_algorithm,
 };
 

