From: ben@fluff.org.uk (Ben Dooks)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [PATCH] s3c2410 i2c build fix
Message-Id: <20041031154945.GA29973@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the attach patch seems to have gotten lost somewhere
down the line, it fixes an include error, as well as
the removal of the I2C_ALGO_S3C2410 which seems to have
crept back in. 

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
-------------- next part --------------
--- linux-2.6.9-bk4-orig/drivers/i2c/busses/i2c-s3c2410.c	2004-10-20 15:50:29.000000000 +0100
+++ linux-2.6.9-bk4/drivers/i2c/busses/i2c-s3c2410.c	2004-10-20 16:29:03.000000000 +0100
@@ -36,6 +36,7 @@
 
 #include <asm/hardware.h>
 #include <asm/irq.h>
+#include <asm/io.h>
 
 #include <asm/hardware/clock.h>
 #include <asm/arch/regs-gpio.h>
@@ -534,7 +535,6 @@
 
 static struct i2c_algorithm s3c24xx_i2c_algorithm = {
 	.name			= "S3C2410-I2C-Algorithm",
-	.id			= I2C_ALGO_S3C2410,
 	.master_xfer		= s3c24xx_i2c_xfer,
 };
 
@@ -543,7 +543,6 @@
 	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER(s3c24xx_i2c.wait),
 	.adap	= {
 		.name			= "s3c2410-i2c",
-		.id			= I2C_ALGO_S3C2410,
 		.algo			= &s3c24xx_i2c_algorithm,
 		.retries		= 2,
 	},
