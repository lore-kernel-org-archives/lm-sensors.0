From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:38 +0000
Subject: [lm-sensors] [PATCH] i2c: drop empty i2c_driver.command
Message-Id: <11365852583972@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: drop empty i2c_driver.command implementations

Given that implementing i2c_driver.command is optional, there is no
point in an empty implementation thereof.

Signed-off-by: Laurent Riffard <laurent.riffard at free.fr>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Michael Geng <linux at MichaelGeng.de>
Cc: Petr Vandrovec <vandrove at vc.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit d564baee2984098c73fd0e55bc5c8a890878ef3b
tree 0f92136763fbe9f614c72f9e5581a2f091ebf118
parent 04b4b8434a92b9ef127985113c0bd961957778b7
author Laurent Riffard <laurent.riffard at free.fr> Sun, 18 Dec 2005 16:49:30 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:26 -0800

 drivers/i2c/i2c-dev.c                 |    7 -------
 drivers/media/video/saa5246a.c        |    7 -------
 drivers/media/video/saa5249.c         |    7 -------
 drivers/video/matrox/matroxfb_maven.c |    5 -----
 4 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index ad6e04f..ed7eed3 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -464,12 +464,6 @@ static int i2cdev_detach_client(struct i
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
@@ -478,7 +472,6 @@ static struct i2c_driver i2cdev_driver  	.attach_adapter	= i2cdev_attach_adapter,
 	.detach_adapter	= i2cdev_detach_adapter,
 	.detach_client	= i2cdev_detach_client,
-	.command	= i2cdev_command,
 };
 
 static struct i2c_client i2cdev_client_template = {
diff --git a/drivers/media/video/saa5246a.c b/drivers/media/video/saa5246a.c
index 135c214..0aa9e72 100644
--- a/drivers/media/video/saa5246a.c
+++ b/drivers/media/video/saa5246a.c
@@ -151,12 +151,6 @@ static int saa5246a_detach(struct i2c_cl
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
@@ -169,7 +163,6 @@ static struct i2c_driver i2c_driver_vide
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
 	.attach_adapter = saa5246a_probe,
 	.detach_client  = saa5246a_detach,
-	.command 	= saa5246a_command
 };
 
 static struct i2c_client client_template = {
diff --git a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
index d7c4e33..a51c7bd 100644
--- a/drivers/media/video/saa5249.c
+++ b/drivers/media/video/saa5249.c
@@ -226,12 +226,6 @@ static int saa5249_detach(struct i2c_cli
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
@@ -242,7 +236,6 @@ static struct i2c_driver i2c_driver_vide
 	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
 	.attach_adapter = saa5249_probe,
 	.detach_client  = saa5249_detach,
-	.command 	= saa5249_command
 };
 
 static struct i2c_client client_template = {
diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
index 2558753..a1f2c5e 100644
--- a/drivers/video/matrox/matroxfb_maven.c
+++ b/drivers/video/matrox/matroxfb_maven.c
@@ -1288,10 +1288,6 @@ static int maven_detach_client(struct i2
 	return 0;
 }
 
-static int maven_command(struct i2c_client* client, unsigned int cmd, void* arg) {
-	return -ENOIOCTLCMD;	/* or -EINVAL, depends on who will call this */
-}
-
 static struct i2c_driver maven_driver={
 	.driver = {
 		.name	= "maven",
@@ -1299,7 +1295,6 @@ static struct i2c_driver maven_driver={
 	.id		= I2C_DRIVERID_MGATVO,
 	.attach_adapter	= maven_attach_adapter,
 	.detach_client	= maven_detach_client,
-	.command	= maven_command,
 };
 
 /* ************************** */


