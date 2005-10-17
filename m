From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 23:01:28 +0000
Subject: [lm-sensors] [PATCH 06/14] hwmon: New device ID for the smsc47b397
Message-Id: <20051017230145.4a7fdf44.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Content-Disposition: inline; filename=hwmon-smsc47b397-new-id.patch

This patch adds a new ID to the SMSC LPC47B397-NC hardware
monitoring driver - for a chip that is claimed to be 100%
compatible otherwise.

Signed-off-by: Bryan Young (Utilitek Systems, Inc.)
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 Documentation/hwmon/smsc47b397 |    8 ++++++--
 drivers/hwmon/smsc47b397.c     |    7 ++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

--- linux-2.6.14-rc4.orig/drivers/hwmon/smsc47b397.c	2005-09-13 21:21:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/smsc47b397.c	2005-10-12 20:09:13.000000000 +0200
@@ -299,7 +299,7 @@
 	superio_enter();
 	id = superio_inb(SUPERIO_REG_DEVID);
 
-	if (id != 0x6f) {
+	if ((id != 0x6f) && (id != 0x81)) {
 		superio_exit();
 		return -ENODEV;
 	}
@@ -310,8 +310,9 @@
 	*addr = (superio_inb(SUPERIO_REG_BASE_MSB) << 8)
 		 |  superio_inb(SUPERIO_REG_BASE_LSB);
 
-	printk(KERN_INFO "smsc47b397: found SMSC LPC47B397-NC "
-		"(base address 0x%04x, revision %u)\n", *addr, rev);
+	printk(KERN_INFO "smsc47b397: found SMSC %s "
+		"(base address 0x%04x, revision %u)\n",
+		id = 0x81 ? "SCH5307-NS" : "LPC47B397-NC", *addr, rev);
 
 	superio_exit();
 	return 0;
--- linux-2.6.14-rc4.orig/Documentation/hwmon/smsc47b397	2005-08-29 20:34:46.000000000 +0200
+++ linux-2.6.14-rc4/Documentation/hwmon/smsc47b397	2005-10-12 20:09:13.000000000 +0200
@@ -3,6 +3,7 @@
 
 Supported chips:
   * SMSC LPC47B397-NC
+  * SMSC SCH5307-NS
     Prefix: 'smsc47b397'
     Addresses scanned: none, address read from Super I/O config space
     Datasheet: In this file
@@ -12,11 +13,14 @@
 
 November 23, 2004
 
-The following specification describes the SMSC LPC47B397-NC sensor chip
+The following specification describes the SMSC LPC47B397-NC[1] sensor chip
 (for which there is no public datasheet available). This document was
 provided by Craig Kelly (In-Store Broadcast Network) and edited/corrected
 by Mark M. Hoffman <mhoffman@lightlink.com>.
 
+[1] And SMSC SCH5307-NS, which has a different device ID but is otherwise
+compatible.
+
 * * * * *
 
 Methods for detecting the HP SIO and reading the thermal data on a dc7100.
@@ -127,7 +131,7 @@
 The registers of interest for identifying the SIO on the dc7100 are Device ID
 (0x20) and Device Rev  (0x21).
 
-The Device ID will read 0X6F
+The Device ID will read 0x6F (for SCH5307-NS, 0x81)
 The Device Rev currently reads 0x01
 
 Obtaining the HWM Base Address.

-- 
Jean Delvare
