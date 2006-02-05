From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 05 Feb 2006 22:31:25 +0000
Subject: [lm-sensors] [PATCH 11/11] i2c: Cleanup isp1301_omap
Message-Id: <20060205233125.5e98e21f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-isp1301_omap-driver-cleanups.patch

Drop unused rogue i2c driver ID and nonsensical i2c class.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/chips/isp1301_omap.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.16-rc1.orig/drivers/i2c/chips/isp1301_omap.c	2006-01-18 18:28:57.000000000 +0100
+++ linux-2.6.16-rc1/drivers/i2c/chips/isp1301_omap.c	2006-01-23 20:58:58.000000000 +0100
@@ -1635,8 +1635,6 @@
 	.driver = {
 		.name	= "isp1301_omap",
 	},
-	.id		= 1301,		/* FIXME "official", i2c-ids.h */
-	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= isp1301_scan_bus,
 	.detach_client	= isp1301_detach_client,
 };

-- 
Jean Delvare

