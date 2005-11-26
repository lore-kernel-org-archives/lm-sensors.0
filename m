From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:50:05 +0000
Subject: [lm-sensors] [PATCH 17/25] i2c: Drop i2c_driver.{owner, name},
Message-Id: <20051126205106.154b3d4d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Laurent Riffard <laurent.riffard@free.fr>
Content-Disposition: inline; filename=i2c-drop-driver-owner-and-name-08-acorn.patch

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the drivers for acorn arch.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/acorn/char/pcf8583.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.15-rc1.orig/drivers/acorn/char/pcf8583.c	2005-11-13 10:51:02.000000000 +0100
+++ linux-2.6.15-rc1/drivers/acorn/char/pcf8583.c	2005-11-13 12:26:38.000000000 +0100
@@ -257,7 +257,10 @@
 }
 
 static struct i2c_driver pcf8583_driver = {
-	.name		= "PCF8583",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "PCF8583",
+	},
 	.id		= I2C_DRIVERID_PCF8583,
 	.attach_adapter	= pcf8583_probe,
 	.detach_client	= pcf8583_detach,

-- 
Jean Delvare
