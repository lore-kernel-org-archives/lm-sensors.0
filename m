From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:16:15 +0000
Subject: [lm-sensors] [PATCH] i2c: ID redefinition cleanups
Message-Id: <11305336632329@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: ID redefinition cleanups

Fix several redefinitions of i2c IDs. i2c IDs must not be defined
outside of i2c-id.h.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Henk Vergonet <henk@god.dyndns.org>
Acked-by: Mark McClelland <mark@alpha.dyndns.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit cd19cc4732395eb3dbaf49042233b5ac69b1fbd3
tree a904941e7033eac700530cdecdd759f933f6c9f0
parent 6344a8ece0bacccf61817450e8ccf78c973fc0c5
author Jean Delvare <khali@linux-fr.org> Wed, 26 Oct 2005 21:14:16 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:13 -0700

 drivers/i2c/busses/i2c-prosavage.c |    5 -----
 include/media/ovcamchip.h          |   14 --------------
 2 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
index 42f8b5c..42cb1d8 100644
--- a/drivers/i2c/busses/i2c-prosavage.c
+++ b/drivers/i2c/busses/i2c-prosavage.c
@@ -83,11 +83,6 @@ struct s_i2c_chip {
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
 
diff --git a/include/media/ovcamchip.h b/include/media/ovcamchip.h
index cb7c0aa..8138983 100644
--- a/include/media/ovcamchip.h
+++ b/include/media/ovcamchip.h
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

