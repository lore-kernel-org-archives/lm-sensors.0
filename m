From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 31 Jan 2010 21:51:19 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm78) Request I/O ports individually
Message-Id: <20100131225119.4029fd47@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Different motherboards have different PNP declarations for LM78/LM79
chips. Some declare the whole range of I/O ports (8 ports), some
declare only the useful ports (2 ports at offset 5) and some declare
fancy ranges, for example 4 ports at offset 4. To properly handle all
cases, request all ports individually for probing. After we have
determined that we really have an LM78 or LM79 chip, the useful port
range will be requested again, as a single block.

This fixes the driver on the Olivetti M3000 DT 540, at least.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: stable@kernel.org
---
 drivers/hwmon/lm78.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

--- linux-2.6.33-rc4.orig/drivers/hwmon/lm78.c	2010-01-17 17:36:29.000000000 +0100
+++ linux-2.6.33-rc4/drivers/hwmon/lm78.c	2010-01-17 19:59:02.000000000 +0100
@@ -851,17 +851,16 @@ static struct lm78_data *lm78_update_dev
 static int __init lm78_isa_found(unsigned short address)
 {
 	int val, save, found = 0;
+	int port;
 
-	/* We have to request the region in two parts because some
-	   boards declare base+4 to base+7 as a PNP device */
-	if (!request_region(address, 4, "lm78")) {
-		pr_debug("lm78: Failed to request low part of region\n");
-		return 0;
-	}
-	if (!request_region(address + 4, 4, "lm78")) {
-		pr_debug("lm78: Failed to request high part of region\n");
-		release_region(address, 4);
-		return 0;
+	/* Some boards declare base+0 to base+7 as a PNP device, some base+4
+	 * to base+7 and some base+5 to base+6. So we better request each port
+	 * individually for the probing phase. */
+	for (port = address; port < address + LM78_EXTENT; port++) {
+		if (!request_region(port, 1, "lm78")) {
+			pr_debug("lm78: Failed to request port 0x%x\n", port);
+			goto release;
+		}
 	}
 
 #define REALLY_SLOW_IO
@@ -925,8 +924,8 @@ static int __init lm78_isa_found(unsigne
 			val & 0x80 ? "LM79" : "LM78", (int)address);
 
  release:
-	release_region(address + 4, 4);
-	release_region(address, 4);
+	for (port--; port >= address; port--)
+		release_region(port, 1);
 	return found;
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
