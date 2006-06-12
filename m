From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Jun 2006 19:40:53 +0000
Subject: [lm-sensors] [PATCH 01/14] i2c-ocores: Minor cleanups
Message-Id: <20060612214053.4c7ebc0c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Peter Korsgaard <jacmet at sunsite.dk>
Content-Disposition: inline; filename=i2c-opencores-cleanup.patch

Minor cleanup to the i2c-ocores driver.

Peter Korsgaard will maintain the i2c-ocores driver.

Signed-off-by: Peter Korsgaard <jacmet at sunsite.dk>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 MAINTAINERS                     |    6 ++++++
 drivers/i2c/busses/i2c-ocores.c |    6 ++----
 2 files changed, 8 insertions(+), 4 deletions(-)

--- linux-2.6.17-rc6.orig/MAINTAINERS	2006-06-07 07:27:05.000000000 +0200
+++ linux-2.6.17-rc6/MAINTAINERS	2006-06-07 07:27:05.000000000 +0200
@@ -2051,6 +2051,12 @@
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
--- linux-2.6.17-rc6.orig/drivers/i2c/busses/i2c-ocores.c	2006-06-07 07:27:04.000000000 +0200
+++ linux-2.6.17-rc6/drivers/i2c/busses/i2c-ocores.c	2006-06-07 07:27:05.000000000 +0200
@@ -38,8 +38,8 @@
 #define OCI2C_PREHIGH		1
 #define OCI2C_CONTROL		2
 #define OCI2C_DATA		3
-#define OCI2C_CMD		4
-#define OCI2C_STATUS		4
+#define OCI2C_CMD		4 /* write only */
+#define OCI2C_STATUS		4 /* read only, same address as OCI2C_CMD */
 
 #define OCI2C_CTRL_IEN		0x40
 #define OCI2C_CTRL_EN		0x80
@@ -209,8 +209,6 @@
 	.name		= "i2c-ocores",
 	.class		= I2C_CLASS_HWMON,
 	.algo		= &ocores_algorithm,
-	.timeout	= 2,
-	.retries	= 1,
 };
 
 

-- 
Jean Delvare

