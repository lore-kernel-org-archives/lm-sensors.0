From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH 2.6] I2C: Fixes to the i2c-amd756-s4882 driver
Message-Id: <20041113195029.5c18c716.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

While working on the 2.4 version of the i2c-amd756-s4882 driver, I
noticed a few quirks on the 2.6 version I sent to you. The following
patch attempts to fix them.

These are not critical fixes, so they can be delayed until after 2.6.10
is released.

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc1-bk19/drivers/i2c/busses/i2c-amd756-s4882.c.orig	2004-11-09 19:33:36.000000000 +0100
+++ linux-2.6.10-rc1-bk19/drivers/i2c/busses/i2c-amd756-s4882.c	2004-11-13 10:23:32.000000000 +0100
@@ -35,6 +35,7 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 
@@ -156,7 +157,9 @@
 	/* Unregister physical bus */
 	error = i2c_del_adapter(&amd756_smbus);
 	if (error) {
-		if (error != -EINVAL)
+		if (error = -EINVAL)
+			error = -ENODEV;
+		else
 			dev_err(&amd756_smbus.dev, "Physical bus removal "
 				"failed\n");
 		goto ERROR0;
@@ -200,7 +203,7 @@
 					      I2C_SMBUS_WRITE, 0x03,
 					      I2C_SMBUS_BYTE_DATA, &ioconfig);
 	if (error) {
-		dev_dbg(&amd756_smbus.dev, "PCA9556 configuration failed\n");
+		dev_err(&amd756_smbus.dev, "PCA9556 configuration failed\n");
 		error = -EIO;
 		goto ERROR3;
 	}


-- 
Jean Delvare
http://khali.linux-fr.org/
