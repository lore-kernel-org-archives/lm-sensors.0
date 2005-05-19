From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: [PATCH] i2c driver changes for 2.5.67
Message-Id: <10499275002316@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10499275003618@kroah.com>
References: <10499274993464@kroah.com>
In-Reply-To: <10499274993464@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1133.1.5, 2003/04/09 11:04:03-07:00, schlicht@uni-mannheim.de

[PATCH] i2c: fix compilation error for various i2c-devices

Changed the i2c_adapter name definition to match the current interface.


 drivers/i2c/i2c-adap-ite.c |    4 +++-
 drivers/i2c/i2c-frodo.c    |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/i2c-adap-ite.c b/drivers/i2c/i2c-adap-ite.c
--- a/drivers/i2c/i2c-adap-ite.c	Wed Apr  9 15:15:46 2003
+++ b/drivers/i2c/i2c-adap-ite.c	Wed Apr  9 15:15:46 2003
@@ -196,9 +196,11 @@
 
 static struct i2c_adapter iic_ite_ops = {
 	.owner		= THIS_MODULE,
-	.name		= "ITE IIC adapter",
 	.id		= I2C_HW_I_IIC,
 	.algo_data	= &iic_ite_data,
+	.dev		= {
+		.name	= "ITE IIC adapter",
+	},
 };
 
 /* Called when the module is loaded.  This function starts the
diff -Nru a/drivers/i2c/i2c-frodo.c b/drivers/i2c/i2c-frodo.c
--- a/drivers/i2c/i2c-frodo.c	Wed Apr  9 15:15:46 2003
+++ b/drivers/i2c/i2c-frodo.c	Wed Apr  9 15:15:46 2003
@@ -59,9 +59,11 @@
 
 static struct i2c_adapter frodo_ops = {
 	.owner			= THIS_MODULE,
-	.name			= "Frodo adapter driver",
 	.id			= I2C_HW_B_FRODO,
 	.algo_data		= &bit_frodo_data,
+	.dev			= {
+		.name		= "Frodo adapter driver",
+	},
 };
 
 static int __init i2c_frodo_init (void)

