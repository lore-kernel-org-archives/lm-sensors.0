From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: [PATCH] i2c driver changes for 2.5.66
Message-Id: <10485563161165@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10485563141404@kroah.com>
References: <10485563223599@kroah.com>
In-Reply-To: <10485563223599@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.889.355.15, 2003/03/22 23:26:58-08:00, greg@kroah.com

i2c: fix up drivers/acorn/char/i2c.c due to previous i2c changes

I'm not going to touch the other driver in this directory, as it will
need more than just minor fixups to get correct.


 drivers/acorn/char/i2c.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/acorn/char/i2c.c b/drivers/acorn/char/i2c.c
--- a/drivers/acorn/char/i2c.c	Mon Mar 24 17:27:25 2003
+++ b/drivers/acorn/char/i2c.c	Mon Mar 24 17:27:25 2003
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
