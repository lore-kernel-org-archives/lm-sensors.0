From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:53:09 +0000
Subject: [lm-sensors] [PATCH 19/25] i2c: Drop i2c_driver.{owner, name},
Message-Id: <20051126205410.4305279b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-drop-driver-owner-and-name-10-arm.patch

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the drivers for arm arch.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
CC: Laurent Riffard <laurent.riffard@free.fr>
---
 arch/arm/mach-pxa/akita-ioexp.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc2.orig/arch/arm/mach-pxa/akita-ioexp.c	2005-11-26 14:05:30.000000000 +0100
+++ linux-2.6.15-rc2/arch/arm/mach-pxa/akita-ioexp.c	2005-11-26 14:12:20.000000000 +0100
@@ -124,8 +124,10 @@
 }
 
 static struct i2c_driver max7310_i2c_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "akita-max7310",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "akita-max7310",
+	},
 	.id		= I2C_DRIVERID_AKITAIOEXP,
 	.attach_adapter	= max7310_attach_adapter,
 	.detach_client	= max7310_detach_client,

-- 
Jean Delvare
