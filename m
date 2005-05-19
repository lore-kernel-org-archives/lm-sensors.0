From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:54 +0000
Subject: [PATCH] i2c driver changes for 2.5.68
Message-Id: <10512287463226@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10512287462983@kroah.com>
References: <10512287461373@kroah.com>
In-Reply-To: <10512287461373@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1179.3.3, 2003/04/23 11:33:28-07:00, hch@lst.de

[PATCH] i2c: remove dead init code from i2c-sensors.c


 drivers/i2c/i2c-sensor.c |   12 ------------
 1 files changed, 12 deletions(-)


diff -Nru a/drivers/i2c/i2c-sensor.c b/drivers/i2c/i2c-sensor.c
--- a/drivers/i2c/i2c-sensor.c	Thu Apr 24 16:47:26 2003
+++ b/drivers/i2c/i2c-sensor.c	Thu Apr 24 16:47:26 2003
@@ -163,20 +163,8 @@
 	return 0;
 }
 
-static int __init i2c_sensor_init(void)
-{
-	return 0;
-}
-
-static void __exit i2c_sensor_exit(void)
-{
-}
-
 EXPORT_SYMBOL(i2c_detect);
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
 MODULE_DESCRIPTION("i2c-sensor driver");
 MODULE_LICENSE("GPL");
-
-module_init(i2c_sensor_init);
-module_exit(i2c_sensor_exit);

