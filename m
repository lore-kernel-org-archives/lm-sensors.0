From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:36 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop i2c_driver.{owner,name}, 9 of 11
Message-Id: <1136585256704@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11365852541748@kroah.com>
In-Reply-To: <11365852541748@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop i2c_driver.{owner,name}, 9 of 11

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the matroxfb driver.

Signed-off-by: Laurent Riffard <laurent.riffard at free.fr>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Petr Vandrovec <petr at vandrovec.name>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 1a7edcdca618d25564690c2df27c2c5c6e9f6316
tree a890b90b5eed7041090a495cfa89e5610c1bc243
parent e533449d291b5a28ce9527539750a0cb88146f6e
author Laurent Riffard <laurent.riffard at free.fr> Sat, 26 Nov 2005 20:52:34 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:24 -0800

 drivers/video/matrox/matroxfb_maven.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
index 78994c5..f6fdb69 100644
--- a/drivers/video/matrox/matroxfb_maven.c
+++ b/drivers/video/matrox/matroxfb_maven.c
@@ -1293,8 +1293,10 @@ static int maven_command(struct i2c_clie
 }
 
 static struct i2c_driver maven_driver={
-	.owner		= THIS_MODULE,
-	.name		= "maven",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "maven",
+	},
 	.id		= I2C_DRIVERID_MGATVO,
 	.attach_adapter	= maven_attach_adapter,
 	.detach_client	= maven_detach_client,


