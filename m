From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:56 +0000
Subject: [lm-sensors] [PATCH 30/44] [PATCH] i2c-ocores: Minor cleanups
Message-Id: <11510010163681-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Peter Korsgaard <jacmet at sunsite.dk>

Minor cleanup to the i2c-ocores driver.

Peter Korsgaard will maintain the i2c-ocores driver.

Signed-off-by: Peter Korsgaard <jacmet at sunsite.dk>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 MAINTAINERS                     |    6 ++++++
 drivers/i2c/busses/i2c-ocores.c |    6 ++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e3a38e..f4cf014 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2063,6 +2063,12 @@ M:      adaplas at pol.net
 L:      linux-fbdev-devel at lists.sourceforge.net
 S:      Maintained
 
+OPENCORES I2C BUS DRIVER
+P:	Peter Korsgaard
+M:	jacmet at sunsite.dk
+L:	lm-sensors at lm-sensors.org
+S:	Maintained
+
 ORACLE CLUSTER FILESYSTEM 2 (OCFS2)
 P:	Mark Fasheh
 M:	mark.fasheh at oracle.com
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index d5c0610..5928240 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -38,8 +38,8 @@ #define OCI2C_PRELOW		0
 #define OCI2C_PREHIGH		1
 #define OCI2C_CONTROL		2
 #define OCI2C_DATA		3
-#define OCI2C_CMD		4
-#define OCI2C_STATUS		4
+#define OCI2C_CMD		4 /* write only */
+#define OCI2C_STATUS		4 /* read only, same address as OCI2C_CMD */
 
 #define OCI2C_CTRL_IEN		0x40
 #define OCI2C_CTRL_EN		0x80
@@ -209,8 +209,6 @@ static struct i2c_adapter ocores_adapter
 	.name		= "i2c-ocores",
 	.class		= I2C_CLASS_HWMON,
 	.algo		= &ocores_algorithm,
-	.timeout	= 2,
-	.retries	= 1,
 };
 
 
-- 
1.4.0


