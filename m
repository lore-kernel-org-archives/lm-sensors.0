From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: [PATCH] Yet more i2c driver changes for 2.5.65
Message-Id: <20030323081456.GH26145@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030323080719.GD26145@kroah.com> <20030323081431.GF26145@kroah.com> <20030323081445.GG26145@kroah.com>
In-Reply-To: <20030323081445.GG26145@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

ChangeSet 1.889.354.16, 2003/03/22 23:29:40-08:00, greg@kroah.com

i2c: fix up drivers/ieee1394/pcilynx.c due to previous i2c changes.


diff -Nru a/drivers/ieee1394/pcilynx.c b/drivers/ieee1394/pcilynx.c
--- a/drivers/ieee1394/pcilynx.c	Sun Mar 23 00:10:49 2003
+++ b/drivers/ieee1394/pcilynx.c	Sun Mar 23 00:10:49 2003
@@ -138,10 +138,12 @@
 }; 
 
 static struct i2c_adapter bit_ops = {
-	.name			= "PCILynx I2C adapter",
 	.id 			= 0xAA, //FIXME: probably we should get an id in i2c-id.h
 	.client_register	= bit_reg,
 	.client_unregister	= bit_unreg,
+	.dev			= {
+		.name		= "PCILynx I2C",
+	},
 };
 
 
