From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: [PATCH] Yet more i2c driver changes for 2.5.65
Message-Id: <20030323081445.GG26145@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030323080719.GD26145@kroah.com> <20030323081431.GF26145@kroah.com>
In-Reply-To: <20030323081431.GF26145@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

ChangeSet 1.889.354.15, 2003/03/22 23:26:58-08:00, greg@kroah.com

i2c: fix up drivers/acorn/char/i2c.c due to previous i2c changes

I'm not going to touch the other driver in this directory, as it will
need more than just minor fixups to get correct.


diff -Nru a/drivers/acorn/char/i2c.c b/drivers/acorn/char/i2c.c
--- a/drivers/acorn/char/i2c.c	Sun Mar 23 00:10:55 2003
+++ b/drivers/acorn/char/i2c.c	Sun Mar 23 00:10:55 2003
@@ -303,11 +303,13 @@
 }
 
 static struct i2c_adapter ioc_ops = {
-	.name			= "IOC/IOMD",
 	.id			= I2C_HW_B_IOC,
 	.algo_data		= &ioc_data,
 	.client_register	= ioc_client_reg,
 	.client_unregister	= ioc_client_unreg
+	.dev			= {
+		.name		= "IOC/IOMD",
+	},
 };
 
 static int __init i2c_ioc_init(void)
