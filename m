From: laurent.riffard@free.fr (Laurent riffard)
Date: Mon, 24 Oct 2005 23:30:57 +0000
Subject: [lm-sensors] [patch 9/9] I2C: remove i2c_driver's .owner and .name
Message-Id: <20051024212543.608658000@antares.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_drivers's ones.

This patch updates the matroxfb driver.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 drivers/video/matrox/matroxfb_maven.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6-mm/drivers/video/matrox/matroxfb_maven.c
=================================--- linux-2.6-mm.orig/drivers/video/matrox/matroxfb_maven.c
+++ linux-2.6-mm/drivers/video/matrox/matroxfb_maven.c
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
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= maven_attach_adapter,

--

