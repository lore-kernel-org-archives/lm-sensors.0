From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: [PATCH] I2C fixes for 2.6.10-rc2
Message-Id: <20041119220015.GC15956@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041119215935.GA15956@kroah.com> <20041119220001.GB15956@kroah.com>
In-Reply-To: <20041119220001.GB15956@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

ChangeSet 1.2165, 2004/11/19 09:13:08-08:00, khali@linux-fr.org

[PATCH] I2C: Fixes to the i2c-amd756-s4882 driver

While working on the 2.4 version of the i2c-amd756-s4882 driver, I
noticed a few quirks on the 2.6 version I sent to you. The following
patch attempts to fix them.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-amd756-s4882.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-amd756-s4882.c b/drivers/i2c/busses/i2c-amd756-s4882.c
--- a/drivers/i2c/busses/i2c-amd756-s4882.c	2004-11-19 11:40:48 -08:00
+++ b/drivers/i2c/busses/i2c-amd756-s4882.c	2004-11-19 11:40:48 -08:00
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
