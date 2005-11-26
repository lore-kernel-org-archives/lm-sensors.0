From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:51:32 +0000
Subject: [lm-sensors] [PATCH 18/25] i2c: Drop i2c_driver.{owner, name},
Message-Id: <20051126205234.70e635ef.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Laurent Riffard <laurent.riffard@free.fr>
Content-Disposition: inline; filename=i2c-drop-driver-owner-and-name-09-video.patch

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the matroxfb driver.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/video/matrox/matroxfb_maven.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.14-rc5.orig/drivers/video/matrox/matroxfb_maven.c	2005-10-25 20:45:03.000000000 +0200
+++ linux-2.6.14-rc5/drivers/video/matrox/matroxfb_maven.c	2005-10-25 21:02:39.000000000 +0200
@@ -1293,8 +1293,10 @@
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

-- 
Jean Delvare
