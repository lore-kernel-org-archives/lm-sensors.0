From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 15:49:30 +0000
Subject: [lm-sensors] [PATCH 06/11] i2c: drop empty i2c_driver.command
Message-Id: <20051218164930.658747df.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Laurent Riffard <laurent.riffard at free.fr>
Content-Disposition: inline; filename=i2c-drop-useless-command-callbacks.patch

Given that implementing i2c_driver.command is optional, there is no
point in an empty implementation thereof.

Signed-off-by: Laurent Riffard <laurent.riffard at free.fr>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Michael Geng <linux at MichaelGeng.de>
Cc: Petr Vandrovec <vandrove at vc.cvut.cz>
---
 drivers/i2c/i2c-dev.c                 |    7 -------
 drivers/media/video/saa5246a.c        |    7 -------
 drivers/media/video/saa5249.c         |    7 -------
 drivers/video/matrox/matroxfb_maven.c |    5 -----
 4 files changed, 26 deletions(-)

--- linux-2.6.15-rc5.orig/drivers/i2c/i2c-dev.c	2005-12-14 21:04:29.000000000 +0100
+++ linux-2.6.15-rc5/drivers/i2c/i2c-dev.c	2005-12-14 21:05:34.000000000 +0100
@@ -464,12 +464,6 @@
 	return 0;
 }
 
-static int i2cdev_command(struct i2c_client *client, unsigned int cmd,
-                           void *arg)
-{
-	return -1;
-}
-
 static struct i2c_driver i2cdev_driver = {
 	.driver = {
 		.name	= "dev_driver",
@@ -478,7 +472,6 @@
 	.attach_adapter	= i2cdev_attach_adapter,
 	.detach_adapter	= i2cdev_detach_adapter,
 	.detach_client	= i2cdev_detach_client,
-	.command	= i2cdev_command,
 };
 
 static struct i2c_client i2cdev_client_template = {
--- linux-2.6.15-rc5.orig/drivers/media/video/saa5246a.c	2005-12-14 21:03:06.000000000 +0100
+++ linux-2.6.15-rc5/drivers/media/video/saa5246a.c	2005-12-14 21:06:11.000000000 +0100
@@ -151,12 +151,6 @@
 	return 0;
 }
 
-static int saa5246a_command(struct i2c_client *device, unsigned int cmd,
-	void *arg)
-{
-	return -EINVAL;
-}
-
 /*
  *	I2C interfaces
  */
@@ -169,7 +163,6 @@
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
 	.attach_adapter = saa5246a_probe,
 	.detach_client  = saa5246a_detach,
-	.command 	= saa5246a_command
 };
 
 static struct i2c_client client_template = {
--- linux-2.6.15-rc5.orig/drivers/media/video/saa5249.c	2005-12-14 21:03:06.000000000 +0100
+++ linux-2.6.15-rc5/drivers/media/video/saa5249.c	2005-12-14 21:06:11.000000000 +0100
@@ -226,12 +226,6 @@
 	return 0;
 }
 
-static int saa5249_command(struct i2c_client *device,
-			     unsigned int cmd, void *arg)
-{
-	return -EINVAL;
-}
-
 /* new I2C driver support */
 
 static struct i2c_driver i2c_driver_videotext = 
@@ -242,7 +236,6 @@
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
 	.attach_adapter = saa5249_probe,
 	.detach_client  = saa5249_detach,
-	.command 	= saa5249_command
 };
 
 static struct i2c_client client_template = {
--- linux-2.6.15-rc5.orig/drivers/video/matrox/matroxfb_maven.c	2005-12-14 21:03:06.000000000 +0100
+++ linux-2.6.15-rc5/drivers/video/matrox/matroxfb_maven.c	2005-12-14 21:06:21.000000000 +0100
@@ -1288,10 +1288,6 @@
 	return 0;
 }
 
-static int maven_command(struct i2c_client* client, unsigned int cmd, void* arg) {
-	return -ENOIOCTLCMD;	/* or -EINVAL, depends on who will call this */
-}
-
 static struct i2c_driver maven_driver={
 	.driver = {
 		.name	= "maven",
@@ -1299,7 +1295,6 @@
 	.id		= I2C_DRIVERID_MGATVO,
 	.attach_adapter	= maven_attach_adapter,
 	.detach_client	= maven_detach_client,
-	.command	= maven_command,
 };
 
 /* ************************** */

-- 
Jean Delvare

