From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:23:57 +0000
Subject: [lm-sensors] [PATCH 07/25] i2c: Drop i2c_driver.flags, 1 of 3
Message-Id: <20051126202459.080d3091.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-drop-driver-flags-01-df-dummy.patch

The I2C_DF_DUMMY flag is gone since 2.5.70, it's about time to
drop all ifdef'd out references thereto.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/tvmixer.c |    4 ----
 include/linux/i2c.h           |    5 -----
 2 files changed, 9 deletions(-)

--- linux-2.6.15-rc1.orig/drivers/media/video/tvmixer.c	2005-11-14 22:31:06.000000000 +0100
+++ linux-2.6.15-rc1/drivers/media/video/tvmixer.c	2005-11-15 23:05:41.000000000 +0100
@@ -232,12 +232,8 @@
 #endif
 	.name            = "tv card mixer driver",
 	.id              = I2C_DRIVERID_TVMIXER,
-#ifdef I2C_DF_DUMMY
-	.flags           = I2C_DF_DUMMY,
-#else
 	.flags           = I2C_DF_NOTIFY,
 	.detach_adapter  = tvmixer_adapters,
-#endif
 	.attach_adapter  = tvmixer_adapters,
 	.detach_client   = tvmixer_clients,
 };
--- linux-2.6.15-rc1.orig/include/linux/i2c.h	2005-11-14 22:31:06.000000000 +0100
+++ linux-2.6.15-rc1/include/linux/i2c.h	2005-11-15 23:05:41.000000000 +0100
@@ -252,11 +252,6 @@
 
 /*flags for the driver struct: */
 #define I2C_DF_NOTIFY	0x01		/* notify on bus (de/a)ttaches 	*/
-#if 0
-/* this flag is gone -- there is a (optional) driver->detach_adapter
- * callback now which can be used instead */
-# define I2C_DF_DUMMY	0x02
-#endif
 
 /*flags for the client struct: */
 #define I2C_CLIENT_ALLOW_USE		0x01	/* Client allows access */

-- 
Jean Delvare
