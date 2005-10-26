From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Oct 2005 21:13:32 +0000
Subject: [lm-sensors] [PATCH 05/16] i2c: ID redefinition cleanups, 1 of 2
Message-Id: <20051026211416.293d8e42.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-id-clean-redefinitions-1.patch

Fix several redefinitions of i2c IDs. i2c IDs must not be defined
outside of i2c-id.h.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Henk Vergonet <henk@god.dyndns.org>
Acked-by: Mark McClelland <mark@alpha.dyndns.org>

---
 drivers/i2c/busses/i2c-prosavage.c |    5 -----
 include/media/ovcamchip.h          |   14 --------------
 2 files changed, 19 deletions(-)

--- linux-2.6.14-rc5.orig/drivers/i2c/busses/i2c-prosavage.c	2005-10-23 17:35:36.000000000 +0200
+++ linux-2.6.14-rc5/drivers/i2c/busses/i2c-prosavage.c	2005-10-23 17:35:46.000000000 +0200
@@ -83,11 +83,6 @@
 /*
  * i2c configuration
  */
-#ifndef I2C_HW_B_S3VIA
-#define I2C_HW_B_S3VIA	0x18	/* S3VIA ProSavage adapter		*/
-#endif
-
-/* delays */
 #define CYCLE_DELAY	10
 #define TIMEOUT		(HZ / 2)
 
--- linux-2.6.14-rc5.orig/include/media/ovcamchip.h	2005-10-23 17:35:21.000000000 +0200
+++ linux-2.6.14-rc5/include/media/ovcamchip.h	2005-10-23 17:35:46.000000000 +0200
@@ -17,20 +17,6 @@
 #include <linux/videodev.h>
 #include <linux/i2c.h>
 
-/* Remove these once they are officially defined */
-#ifndef I2C_DRIVERID_OVCAMCHIP
-	#define I2C_DRIVERID_OVCAMCHIP	0xf00f
-#endif
-#ifndef I2C_HW_SMBUS_OV511
-	#define I2C_HW_SMBUS_OV511	0xfe
-#endif
-#ifndef I2C_HW_SMBUS_OV518
-	#define I2C_HW_SMBUS_OV518	0xff
-#endif
-#ifndef I2C_HW_SMBUS_OVFX2
-	#define I2C_HW_SMBUS_OVFX2	0xfd
-#endif
-
 /* --------------------------------- */
 /*           ENUMERATIONS            */
 /* --------------------------------- */

-- 
Jean Delvare
