From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: [PATCH] i2c driver changes for 2.5.67
Message-Id: <10499274991425@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10499274992999@kroah.com>
References: <10499274993464@kroah.com>
In-Reply-To: <10499274993464@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1033.5.2, 2003/04/07 15:56:32-07:00, greg@kroah.com

i2c: fix up compile error in scx200_i2c driver.


 drivers/i2c/scx200_i2c.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/scx200_i2c.c b/drivers/i2c/scx200_i2c.c
--- a/drivers/i2c/scx200_i2c.c	Wed Apr  9 15:16:24 2003
+++ b/drivers/i2c/scx200_i2c.c	Wed Apr  9 15:16:24 2003
@@ -82,9 +82,11 @@
 
 static struct i2c_adapter scx200_i2c_ops = {
 	.owner		   = THIS_MODULE,
-	.name              = "NatSemi SCx200 I2C",
 	.id		   = I2C_HW_B_VELLE,
 	.algo_data	   = &scx200_i2c_data,
+	.dev		= {
+		.name	= "NatSemi SCx200 I2C",
+	},
 };
 
 int scx200_i2c_init(void)
@@ -110,7 +112,7 @@
 
 	if (i2c_bit_add_bus(&scx200_i2c_ops) < 0) {
 		printk(KERN_ERR NAME ": adapter %s registration failed\n", 
-		       scx200_i2c_ops.name);
+		       scx200_i2c_ops.dev.name);
 		return -ENODEV;
 	}
 	

