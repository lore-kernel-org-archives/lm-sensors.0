From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:45:31 +0000
Subject: [lm-sensors] [PATCH 15/25] i2c: Drop i2c_driver.{owner, name},
Message-Id: <20051126204632.23576e62.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Laurent Riffard <laurent.riffard@free.fr>
Content-Disposition: inline; filename=i2c-drop-driver-owner-and-name-06-oss.patch

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the OSS drivers.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 sound/oss/dmasound/dac3550a.c   |    6 ++++--
 sound/oss/dmasound/tas_common.c |    6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

--- linux-2.6.15-rc1.orig/sound/oss/dmasound/dac3550a.c	2005-11-15 23:05:48.000000000 +0100
+++ linux-2.6.15-rc1/sound/oss/dmasound/dac3550a.c	2005-11-15 23:06:18.000000000 +0100
@@ -41,8 +41,10 @@
 static int daca_detach_client(struct i2c_client *client);
 
 struct i2c_driver daca_driver = {  
-	.owner			= THIS_MODULE,
-	.name			= "DAC3550A driver  V " DACA_VERSION,
+	.driver = {
+		.owner		= THIS_MODULE,
+		.name		= "DAC3550A driver  V " DACA_VERSION,
+	},
 	.id			= I2C_DRIVERID_DACA,
 	.attach_adapter		= daca_attach_adapter,
 	.detach_client		= daca_detach_client,
--- linux-2.6.15-rc1.orig/sound/oss/dmasound/tas_common.c	2005-11-15 23:05:48.000000000 +0100
+++ linux-2.6.15-rc1/sound/oss/dmasound/tas_common.c	2005-11-15 23:06:18.000000000 +0100
@@ -47,8 +47,10 @@
 static int tas_detach_client(struct i2c_client *);
 
 struct i2c_driver tas_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "tas",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "tas",
+	},
 	.attach_adapter	= tas_attach_adapter,
 	.detach_client	= tas_detach_client,
 };

-- 
Jean Delvare
