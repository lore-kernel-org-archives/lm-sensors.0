From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 12 Oct 2005 18:46:09 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.14-rc2-mm2] hwmon: add a new ID to SMSC
Message-Id: <20051012164446.GA1936@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012032205.GA20051@jupiter.solarsys.private>
In-Reply-To: <20051012032205.GA20051@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds a new ID to the SMSC LPC47B397-NC hardware
monitoring driver - for a chip that is claimed to be 100%
compatible otherwise.

Signed-off-by: Bryan Young (Utilitek Systems, Inc.)
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

---

Hi Jean:
This is updated to address your comments.  Please queue for 2.6.15.

--- linux-2.6.14-rc2-mm2.orig/drivers/hwmon/smsc47b397.c
+++ linux-2.6.14-rc2-mm2/drivers/hwmon/smsc47b397.c
@@ -299,7 +299,7 @@ static int __init smsc47b397_find(unsign
 	superio_enter();
 	id = superio_inb(SUPERIO_REG_DEVID);
 
-	if (id != 0x6f) {
+	if ((id != 0x6f) && (id != 0x81)) {
 		superio_exit();
 		return -ENODEV;
 	}
@@ -310,8 +310,9 @@ static int __init smsc47b397_find(unsign
 	*addr = (superio_inb(SUPERIO_REG_BASE_MSB) << 8)
 		 |  superio_inb(SUPERIO_REG_BASE_LSB);
 
-	printk(KERN_INFO "smsc47b397: found SMSC LPC47B397-NC "
-		"(base address 0x%04x, revision %u)\n", *addr, rev);
+	printk(KERN_INFO "smsc47b397: found SMSC %s "
+		"(base address 0x%04x, revision %u)\n",
+		id = 0x81 ? "SCH5307-NS" : "LPC47B397-NC", *addr, rev);
 
 	superio_exit();
 	return 0;
--- linux-2.6.14-rc2-mm2.orig/Documentation/hwmon/smsc47b397
+++ linux-2.6.14-rc2-mm2/Documentation/hwmon/smsc47b397
@@ -3,6 +3,7 @@ Kernel driver smsc47b397
 
 Supported chips:
   * SMSC LPC47B397-NC
+  * SMSC SCH5307-NS
     Prefix: 'smsc47b397'
     Addresses scanned: none, address read from Super I/O config space
     Datasheet: In this file
@@ -12,11 +13,14 @@ Authors: Mark M. Hoffman <mhoffman@light
 
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
@@ -127,7 +131,7 @@ OUT	DX,AL
 The registers of interest for identifying the SIO on the dc7100 are Device ID
 (0x20) and Device Rev  (0x21).
 
-The Device ID will read 0X6F
+The Device ID will read 0x6F (for SCH5307-NS, 0x81)
 The Device Rev currently reads 0x01
 
 Obtaining the HWM Base Address.
-- 
Mark M. Hoffman
mhoffman@lightlink.com

